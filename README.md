# Say - a TTS CLI tool

`say` is a simple command-line tool for converting text to speech
(TTS) using [piper-tts](https://github.com/rhasspy/piper) and the
aplay audio player from [alsa-utils](https://www.alsa-project.org/).

## Installation

### Nix Flake

You can add `say` to your system packages via flake inputs:

``` nix
{
  inputs.say.url = "github:javimerino/say-tts";
  # ...
}
```

Then reference it as `inputs.say.packages.${system}.default`.  See the Setup
section below for how to install voices.

### Home Manager Module

The flake includes a home-manager module that simplifies installation
and voice model management. Add the module to your home-manager
configuration:

``` nix
{
  inputs.say.url = "github:javimerino/say-tts";
  # ...

  outputs = { self, nixpkgs, home-manager, say, ... }: {
    homeConfigurations.yourusername = home-manager.lib.homeManagerConfiguration {
      # ...
      modules = [
        say.homeManagerModules.default
        {
          programs.say-tts = {
            enable = true;
            voices = {
              "en_GB-alan-medium" = {
                model = pkgs.fetchurl {
                  url = "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx";
                  hash = "sha256-CjCWaJMiBedigB8e/Cc2zUsBIDKWIq32K+CeVjOdMzA=";
                };
                config = pkgs.fetchurl {
                  url = "https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx.json";
                  hash = "sha256-wPDRJOWJXADnwDs13MgofzGaaZijZbGC3rXI51LujB4=";
                };
              };
            };
          };
        }
      ];
    };
  };
}
```

The module automatically installs the `say` command and manages voice
models in `$XDG_DATA_HOME/say-tts`.

## Setup

If not using the home-manager module, you need to manually download
the pre-trained speech models.  These models are saved as ONNX files
and require a corresponding JSON file with the same name but with
`.json` appended.

Download the desired models from [`VOICES.md` in the piper
repo](https://github.com/rhasspy/piper/blob/master/VOICES.md) and
place them in `$HOME/.local/share/say-tts`.

The default model is `en_GB-alan-medium`. Download
both the
[`en_GB-alan-medium.onnx`](https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx?download=true)
and
[`en_GB-alan-medium.onnx.json`](https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx.json?download=true)
files and place them in `~/.local/share/say-tts/`.

## Usage

``` bash
say "Hello, this is a test"
```

Useful for proofreading a document, as sometimes listening helps you
catch issues that you may miss when reading the same text silently for the tenth
time:

``` bash
say < README.txt
```

Or piping from other commands:

``` bash
llm "Why is the sky blue?" | say
```

You can use `-m` to change model or language:

``` bash
say -m es_ES-sharvard-medium "Hola, esto es una prueba"
```

## Motivation

There are probably dozens of projects like this.  I like piper, I want
a handy command in the shell to read text and I don't want to remember
all the different parameters to piper or aplay.  This scratches my
particular itch. It's very simple because the magic is done by piper
mainly.
