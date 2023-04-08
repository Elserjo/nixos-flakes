{ cfg, ... }:

{
  # According wiki sound should be disabled
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
