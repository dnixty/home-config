{ ... }:

{
  imports = [
    ./base.nix
  ];

  profiles = {
    desktop.exwm.enable = true;
    dev.javascript.enable = true;
    finance.enable = true;
    gfx.enable = true;
    pass.enable = true;
    work.enable = true;
  };
}
