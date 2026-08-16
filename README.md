# Terminal-AI

A tiny Bash command for talking to OpenAI directly from a terminal. :3

## Requirements

- Bash
- `curl`
- Python 3
- An OpenAI API key

## Install

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

## Configure

```bash
export OPENAI_API_KEY='your-api-key'
```

To change the model:

```bash
export AI_MODEL='gpt-5.6'
```

## Usage

One-shot:

```bash
ai "explain TCP in simple terms"
ai "call me pretty :3"
```

Interactive mode:

```bash
ai
> hello
> explain this error
> /exit
```

Because output is plain text, it also works nicely with other terminal tools:

```bash
ai "explain this" | less
ai "explain this" | w3m -T text/plain
```

## Notes

The script talks directly to the OpenAI Responses API. It does not depend on a third-party proxy or AI website.
