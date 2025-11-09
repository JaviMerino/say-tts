# Development guide

This file provides guidance to AI agents when working with code in this repository.

## Project Overview

`say` is a simple TTS (text-to-speech) CLI tool that wraps piper-tts and aplay. It's written as a Bash shell script and packaged using Nix. The core implementation is in the `say` shell script, with Nix handling packaging and dependencies.

## Architecture

- **say** - Main Bash shell script containing all CLI logic and TTS functionality
- **default.nix** - Nix package definition using `writeShellApplication` to create the executable with runtime dependencies (alsa-utils and piper-tts)
- **flake.nix** - Nix flake providing the package and an overlay for integration into other Nix configurations

The tool reads text from command line arguments or stdin, pipes it through piper-tts with the appropriate model, and outputs audio through aplay.

## Building and Testing

Build the project:
```bash
nix build
```

Run the built executable:
```bash
./result/bin/say "Hi, this is a test message"
```

Run directly from the flake:
```bash
nix run . -- "Hi, this is a test message"
```

## Linting and Formatting

The CI workflow (`.github/workflows/check.yml`) runs three checks:

Check shell script with shellcheck:
```bash
nix develop -c shellcheck say
```

Check Nix files formatting with nixfmt:
```bash
nix develop -c nixfmt --check flake.nix default.nix
```

Check README markdown with mdl:
```bash
nix develop -c mdl README.md
```

## Model Configuration

Models must be placed in `$HOME/.local/share/say-tts/` (or `$XDG_DATA_HOME/say-tts/`). Each model requires both an `.onnx` file and a `.onnx.json` file.

The script automatically detects audio rate based on model suffix:
- `-medium` models → 22050 Hz
- `-low` models → 16000 Hz

Default model is `en_GB-alan-medium`.
