{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.say-tts;

  voiceDir = "${config.xdg.dataHome}/say-tts";

  # Create symlinks for each voice
  voiceLinks = mapAttrsToList (name: voice: {
    "${voiceDir}/${name}.onnx".source = voice.model;
    "${voiceDir}/${name}.onnx.json".source = voice.config;
  }) cfg.voices;
in {
  options.programs.say-tts = {
    enable = mkEnableOption "say - a TTS CLI tool";

    package = mkOption {
      type = types.package;
      default = pkgs.say;
      defaultText = literalExpression "pkgs.say";
      description = "The say package to use.";
    };

    voices = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          model = mkOption {
            type = types.path;
            description = ''
              Path to the .onnx model file.
              Can be a local path or a derivation (e.g., from fetchurl).
            '';
          };

          config = mkOption {
            type = types.path;
            description = ''
              Path to the .onnx.json configuration file.
              Can be a local path or a derivation (e.g., from fetchurl).
            '';
          };
        };
      });
      default = {};
      example = literalExpression ''
        {
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
        }
      '';
      description = ''
        Voice models to install. Each voice requires both a .onnx model file
        and a .onnx.json configuration file.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    # Create symlinks for all configured voices
    xdg.dataFile = mkMerge voiceLinks;
  };
}
