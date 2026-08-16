# Terminal-AI

A small Linux terminal AI client powered by Ollama. It supports one-shot prompts, interactive chats, and persistent local conversation memory. :3

## Requirements

- Linux
- Bash
- `curl`
- Python 3
- [Ollama](https://ollama.com/)
- An Ollama model

## Install Ollama

Install Ollama using its official Linux installer, then make sure the Ollama service is running.

```bash
curl -fsSL https://ollama.com/install.sh | sh
ollama serve
```

In another terminal, download a model. For a 12 GB GPU, `qwen3:8b` is a reasonable starting point:

```bash
ollama pull qwen3:8b
```

You can choose another model if your hardware is different.

## Install Terminal-AI

Clone the repository and install the command:

```bash
git clone https://github.com/codemaster6590/Terminal-AI.git
cd Terminal-AI
sudo install -m 755 ai /usr/local/bin/ai
```

Or install it just for your user:

```bash
mkdir -p ~/.local/bin
install -m 755 ai ~/.local/bin/ai
```

Make sure `~/.local/bin` is in your `PATH`.

## Execute

One-shot prompt:

```bash
ai "hello"
```

Choose a model with a flag:

```bash
ai --model qwen3:8b "explain pointers"
```

Interactive mode:

```bash
ai
```

Type messages at the `>` prompt. Use `/exit` or `/quit` to leave.

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
/exit
```

`/new` starts a fresh context for the current session without deleting saved history.

## Notes

Terminal-AI currently targets Linux only. It talks directly to the local Ollama HTTP API, so no API key, payment, or cloud AI account is required. Conversation history is stored locally on your machine.

The current version is a CLI prototype. A full TUI can be added later without changing the persistent chat storage design.
