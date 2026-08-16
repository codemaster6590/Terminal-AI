# Terminal-AI

A small Linux terminal AI client powered by Ollama. It supports one-shot prompts, interactive chats, and persistent local conversation memory. :3

## Requirements

- Linux
- Bash for `setup.sh` (the installed `ai` command works from Bash, Fish, Zsh, Dash, and other common shells)
- Python 3
- curl
- Ollama

The setup script supports major Linux families using `pacman`, `apt`, `dnf`, `zypper`, or `apk`.

## Easy setup

Install Git with your distro's package manager, then run these three commands:

```bash
git clone https://github.com/codemaster6590/Terminal-AI.git
cd Terminal-AI
bash setup.sh
```

`setup.sh` detects the Linux distribution, installs missing `curl`/Python dependencies, installs Ollama if needed, starts Ollama when possible, downloads `qwen3:8b`, and installs `ai`.

### Arch Linux

```bash
pacman -Sy --noconfirm git
```

### Debian / Ubuntu

```bash
sudo apt update && sudo apt install -y git
```

### Fedora

```bash
sudo dnf install -y git
```

### openSUSE

```bash
sudo zypper install -y git
```

### Alpine

```bash
apk add git
```

Then use the three setup commands above.

If Ollama's installer or your system does not provide a working service, start it manually with:

```bash
ollama serve
```

## Shell support

The installed `ai` program is a Python executable, so it is not tied to Bash syntax. It can be launched from common shells including:

- Bash
- Fish
- Zsh
- Dash
- Ksh
- Nushell

For Fish, for example:

```fish
aI "hello"
```

Use the actual command name `ai` (lowercase):

```fish
ai "hello"
```

The setup script itself should be invoked as `bash setup.sh`, so it works even when your login shell is Fish or another shell.

## Model

The default model is `qwen3:8b`. To use a different model during setup:

```bash
OLLAMA_MODEL=qwen3:4b bash setup.sh
```

You can also select a model per request:

```bash
ai --model qwen3:8b "explain pointers"
```

## Thinking

Thinking is **off by default** for faster responses. Enable it when you actually want deeper reasoning:

```bash
ai --think "solve this carefully: ..."
```

## Execute

One-shot prompt:

```bash
ai "hello"
```

Interactive mode:

```bash
aI
```

Use the actual command name `ai` (lowercase):

```bash
ai
```

## Persistent chats

Conversation history is stored locally in a SQLite database under:

```text
~/.local/share/terminal-ai/terminal-ai.db
```

Start or reopen a named chat:

```bash
ai --chat main
ai --chat coding
```

Create a new named chat:

```bash
ai --new-chat linux
```

List saved chats:

```bash
ai --chats
```

Delete a chat:

```bash
ai --delete-chat linux
```

Clear all saved messages:

```bash
ai --clear-memory
```

Use `--new` to temporarily start without loading the saved history. The existing history remains on disk.

## Interactive commands

Inside `ai`:

```text
/help
/new
/chats
/clear
/think
/exit
```

`/new` starts a fresh context for the current session without deleting saved history.

## Notes

Terminal-AI currently targets Linux. It talks directly to the local Ollama HTTP API, so no API key, payment, or cloud AI account is required. Conversation history is stored locally on your machine.

The current version is a CLI prototype. A full TUI can be added later without changing the persistent chat storage design.
