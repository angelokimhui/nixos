# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Nix related entries
   nix.autoOptimiseStore = true ;

  # Boot related entries
  # Bootloader configuration (systemdboot)
   boot = {
     loader = {
       systemd-boot.enable = true;
       efi.canTouchEfiVariables = true;
     };
     kernelPackages = pkgs.linuxPackages_zen;
     kernelParams = [ "mitigations=off" "random.trust_cpu=on" "nowatchdog" "nohibernate" ];
     supportedFilesystems = [ "ntfs" "ext4" "f2fs" ];
   };

   networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Taipei/Asia";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
  #  useXkbConfig = true; # use xkbOptions in tty.
   };

  # Xserver and Display UI settings.
   services.xserver = {
     enable = true;
     displayManager.sddm.enable = true;
     desktopManager.plasma5.enable = true;
  };
  
  # Docker
   virtualisation.docker.enable = true;

  # Flatpak
   services.flatpak.enable = true;
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Configure keymap in X11
   services.xserver.layout = "us";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.maru = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #   ];
   };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    xorg.xhost
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

