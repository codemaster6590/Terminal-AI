# Terminal-AI

A small Linux terminal AI client powered by Ollama. It supports one-shot prompts, interactive chats, and persistent local conversation memory. :3

## Requirements

- Linux
- Bash
- `curl`
- Python 3
- Ollama
- An Ollama model

## Install Ollama

Install Ollama using its official Linux installer:

```bash
curl -fsSL https://ollama.com/install.sh | sh
```

Make sure Ollama is running. For a temporary foreground server:

```bash
ollama serve
```

## Easy setup

After Ollama is installed and running, the repository includes a setup script that downloads the default model and installs `ai`:

```bash
git clone https://github.com/codemaster6590/Terminal-AI.git
cd Terminal-AI
./setup.sh
```

The default model is `qwen3:8b`. To use a different model during setup:

```bash
OLLAMA_MODEL=qwen3:4b ./setup.sh
```

By default the command is installed to `/usr/local/bin/ai`. To install it without sudo:

```bash
mkdir -p ~/.local/bin
AI_INSTALL_DIR="$HOME/.local/bin" ./setup.sh
```

Make sure `~/.local/bin` is in your `PATH`.

## Manual install

If you prefer to do the steps yourself:

```bash
ollama pull qwen3:8b
git clone https://github.com/codemaster6590/Terminal-AI.git
cd Terminal-AI
sudo install -m 755 ai /usr/local/bin/ai
```

## Execute

One-shot prompt:

```bash
ai "hello"
```

Choose a model with a flag:

```bash
ai --model qwen3:8b "explain pointers"
```

Thinking is **off by default** for faster responses. Enable it when you actually want deeper reasoning:

```bash
ai --think "solve this carefully: ..."
```

Interactive mode:

```bash
ai
```

Inside interactive mode, `/think` toggles thinking on or off for the current session.

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

Terminal-AI currently targets Linux only. It talks directly to the local Ollama HTTP API, so no API key, payment, or cloud AI account is required. Conversation history is stored locally on your machine.

The current version is a CLI prototype. A full TUI can be added later without changing the persistent chat storage design.
