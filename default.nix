{ piper-tts
, sox
, writeShellApplication
}:

writeShellApplication {
  name = "say";
  runtimeInputs = [
    piper-tts
    sox
  ];
  text = builtins.readFile ./say;
}
