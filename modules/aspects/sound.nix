{ den, ... }:
{
  den.aspects.sound = {
    nixos = { config, lib, pkgs, ... }: {
      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
      };
    };
  };
}
