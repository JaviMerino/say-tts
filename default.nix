{
  alsa-utils,
  piper-tts,
  writeShellApplication,
}:
writeShellApplication {
  name = "say";
  runtimeInputs = [
    alsa-utils
    piper-tts
  ];
  text = builtins.readFile ./say;
}
