{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.desktop;
in
{
  options = {
    profiles.desktop = {
      enable = mkOption {
        default = false;
        description = "Enable desktop profile";
        type = types.bool;
      };
    };
  };
  config = mkIf cfg.enable {
    profiles.gpg.enable = true;

    xsession.enable = true;
    xsession.windowManager.command = "{pkgs.dwm}/bin/dwm";
    home.file = {
      ".xsession" = {
        source = ../../assets/xsession;
        executable = true;
      };
      ".xinitrc".source = ../../assets/xinitrc;
      ".xprofile".source = ../../assets/xprofile;
    };
    services = {
      network-manager-applet.enable = true;
      redshift = {
        enable = false;
        latitude = "51.5094";
        longitude = "0.1365";
        brightness = {
          day = "1";
          night = "0.8";
        };
        temperature.night = 3000;
      };
    };
    programs = {
      firefox.enable = true;
    };
    nixpkgs.config.packageOverrides = pkgs: {
      dwm = pkgs.dwm.override {
        patches = [
          ../../assets/dwm/dwm-custom-6.2.diff
        ];
      };
      dmenu = pkgs.dmenu.override {
        patches = [
          ../../assets/dmenu/dmenu-custom-4.9.diff
        ];
      };
      st = pkgs.st.override {
        patches = [
          ../../assets/st/st-custom-0.8.2.diff
        ];
      };
      surf = pkgs.surf.override {
        patches = [
          ../../assets/surf/surf-custom-2.0.diff
        ];
      };
    };
    home.packages = with pkgs; [
      (slstatus.override { conf = builtins.readFile ../../assets/slstatus/config.def.h; })
      dmenu
      dwm
      gimp
      mpv
      pass-otp
      st
      surf
    ];
  };
}