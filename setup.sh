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
    echo "Or rerun with AI_INSTALL_DIR=$HOME/.local/bin and put it in PATH." >&2
    exit 1
fi

if ! command -v ollama >/dev/null 2>&1; then
    echo "error: Ollama is not installed." >&2
    echo "Install Ollama first, then rerun this script." >&2
    echo "" >&2
    echo "Official installer:" >&2
    echo "  curl -fsSL https://ollama.com/install.sh | sh" >&2
    exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
    echo "error: curl is required." >&2
    exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
    echo "error: python3 is required." >&2
    exit 1
fi

if ! curl -fsS --max-time 3 http://127.0.0.1:11434/api/tags >/dev/null 2>&1; then
    echo "Ollama is not reachable at http://127.0.0.1:11434." >&2
    echo "Start it with: ollama serve" >&2
    exit 1
fi

echo "Pulling ${MODEL}..."
ollama pull "${MODEL}"

echo "Installing ai to ${INSTALL_DIR}..."
${SUDO} install -d -m 755 "${INSTALL_DIR}"
${SUDO} install -m 755 "${REPO_DIR}/ai" "${INSTALL_DIR}/ai"

echo
echo "Done. Thinking is OFF by default for faster responses."
echo "Try:"
echo "  ai \"hi\""
echo "  ai --think \"solve this carefully: ...\""
echo "  ai --help"
