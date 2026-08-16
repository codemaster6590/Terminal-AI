#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MODEL="${OLLAMA_MODEL:-qwen3:8b}"
INSTALL_DIR="${AI_INSTALL_DIR:-/usr/local/bin}"

if [[ "$(uname -s)" != "Linux" ]]; then
    echo "error: Terminal-AI currently supports Linux only." >&2
    exit 1
fi

if [[ "${EUID}" -eq 0 ]]; then
    SUDO=""
elif command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
else
    echo "error: sudo is required to install ai to ${INSTALL_DIR}" >&2
    echo "Or use: AI_INSTALL_DIR=\"$HOME/.local/bin\" bash setup.sh" >&2
    exit 1
fi

install_deps() {
    local missing=()
    command -v curl >/dev/null 2>&1 || missing+=(curl)
    command -v python3 >/dev/null 2>&1 || missing+=(python3)

    ((${#missing[@]} == 0)) && return 0

    echo "Installing required packages: ${missing[*]}"
    if command -v pacman >/dev/null 2>&1; then
        ${SUDO} pacman -Sy --noconfirm "${missing[@]}"
    elif command -v apt-get >/dev/null 2>&1; then
        ${SUDO} apt-get update
        ${SUDO} apt-get install -y "${missing[@]}"
    elif command -v dnf >/dev/null 2>&1; then
        ${SUDO} dnf install -y "${missing[@]}"
    elif command -v zypper >/dev/null 2>&1; then
        ${SUDO} zypper --non-interactive install "${missing[@]}"
    elif command -v apk >/dev/null 2>&1; then
        ${SUDO} apk add "${missing[@]}"
    else
        echo "error: unsupported package manager; install curl and python3 manually." >&2
        exit 1
    fi
}

install_deps

if ! command -v ollama >/dev/null 2>&1; then
    echo "Ollama is not installed. Installing it..."
    curl -fsSL https://ollama.com/install.sh | sh
fi

if ! curl -fsS --max-time 3 http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
    if command -v systemctl >/dev/null 2>&1 && ${SUDO} systemctl start ollama >/dev/null 2>&1; then
        :
    elif command -v ollama >/dev/null 2>&1; then
        echo "Starting Ollama..."
        ollama serve >/tmp/terminal-ai-ollama.log 2>&1 &
        sleep 2
    fi
fi

if ! curl -fsS --max-time 5 http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
    echo "error: Ollama is not running." >&2
    echo "Start it with: ollama serve" >&2
    exit 1
fi

echo "Pulling ${MODEL}..."
ollama pull "${MODEL}"

echo "Installing ai to ${INSTALL_DIR}..."
${SUDO} install -d -m 755 "${INSTALL_DIR}"
${SUDO} install -m 755 "${REPO_DIR}/ai" "${INSTALL_DIR}/ai"

echo
echo "Done."
echo "Thinking is OFF by default for faster responses."
echo "Try: ai \"hi\""
echo "Or:  ai --think \"solve this carefully: ...\""
