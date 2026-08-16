# Terminal-AI

A tiny Bash command for talking to OpenAI directly from a terminal. :3

## Requirements

- Bash
- `curl`
- Python 3
- An OpenAI API key

## Get an OpenAI API key

1. Go to the [OpenAI API keys page](https://platform.openai.com/api-keys).
2. Sign in to your OpenAI account, or create one if you do not have one.
3. Click **Create new secret key**.
4. Give the key a name, then create it.
5. Copy the key immediately. The full secret is only shown when it is created.
6. Keep the key private. Do **not** put it in this repository, commit it to Git, or paste it into public issues/chats.

OpenAI API usage is billed separately from a ChatGPT subscription, so make sure your API account has the required billing/credits before using the command.

## Install

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

## Configure

Set your OpenAI API key:

```bash
export OPENAI_API_KEY='your-api-key'
```

To make the key persistent in Bash, add the export to `~/.bashrc` and start a new shell. Avoid putting the key in shell history or sharing your shell configuration publicly.

To change the model:

```bash
export AI_MODEL='gpt-5.6'
```

## Execute

After installation, run the command directly:

```bash
ai "hello"
```

For example:

```bash
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
