{ config, ... }:

{
  security.rtkit.enable = true;
  sound.enable = true;
  # We need disable pulseaudio for pipewire
  hardware.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
