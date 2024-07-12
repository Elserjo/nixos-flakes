{ config, ... }:

# https://discourse.nixos.org/t/problems-adjusting-pipewire-sample-rate-nixos/43346/8
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
    extraConfig.pipewire.allowed-rates = {
      "context.properties" = {
        "default.clock.allowed-rates" =
          [ 48000 88200 96000 192000 ];
      };
      "stream.properties" = {
        "resample.quality" = 10;
      };
    };
  };
}
