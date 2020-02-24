{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.profiles.emacs;
in
{
  options = {
    profiles.emacs = {
      enable = mkEnableOption "Enable emacs profile";
    };
  };
  config = mkIf cfg.enable (mkMerge [
    {
      services.emacs.enable = !config.profiles.desktop.exwm.enable;
      programs.emacs = {
        enable = true;
        extraPackages = epkgs: with epkgs; [
          add-node-modules-path
          company
          elfeed
          expand-region
          flycheck
          graphql-mode
          color-theme-sanityinc-tomorrow
          haskell-mode
          helm
          helm-exwm
          helm-pass
          helm-projectile
          helpful
          ledger-mode
          magit
          neotree
          nix-mode
          pdf-tools
          pinentry
          prettier-js
          projectile
          pulseaudio-control
          rainbow-delimiters
          restclient
          ledger-mode
          flycheck-ledger
          terraform-mode
          tide
          web-mode
         ];
      };
    }
    (mkIf config.profiles.desktop.exwm.enable {
      programs.emacs = {
        extraPackages = epkgs: with epkgs; [
          exwm
        ];
      };
    })
    (mkIf config.services.gpg-agent.enable {
      services.gpg-agent.extraConfig = ''
        allow-emacs-pinentry
        allow-loopback-pinentry
      '';
    })
  ]);
}
