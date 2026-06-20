{ config, ... }:

{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    open = false;
  };

  hardware.nvidia-container-toolkit.enable = true;

  environment.sessionVariables.LD_LIBRARY_PATH = [ "/run/opengl-driver/lib" ]; # TODO: find out why
}
