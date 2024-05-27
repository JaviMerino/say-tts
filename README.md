Say - a TTS CLI tool
====================

`say` is a simple command-line tool for converting text to speech
(TTS) using [piper-tts](https://github.com/rhasspy/piper) and the
[sox](https://sox.sourceforge.net/) audio player.

Setup
-----

You need to download the pre-trained speech models.  These models are
saved as ONNX files and require a corresponding JSON file with the
same name but with `.json` appended.

Download the desired models from [`VOICES.md` in the piper
repo](https://github.com/rhasspy/piper/blob/master/VOICES.md) and
place them in `$HOME/.local/share/say-tts`.

The default model is `en_GB-alan-medium`. Download
both the
[`en_GB-alan-medium.onnx`](https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx?download=true)
and
[`en_GB-alan-medium.onnx.json`](https://huggingface.co/rhasspy/piper-voices/resolve/v1.0.0/en/en_GB/alan/medium/en_GB-alan-medium.onnx.json?download=true)
files and place them in `~/.local/share/say-tts/`.

Usage
-----

``` bash
say "Hello, this is a test"
```

``` bash
cat README.txt | say
```

``` bash
say -m es_ES-sharvard-medium "Hola, esto es una prueba"
```

Motivation
----------

There are probably dozens of projects like this.  I like piper, I want
a handy command in the shell to read text and I don't want to remember
all the different parameters to piper or sox.  This scratches my
particular itch. It's very simple because the magic is done by
piper mainly.
