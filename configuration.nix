# Edit this configuration file to define what should be installed on
# your system. 
# Help is available in the configuration.nix(5) man page 
# and in the NixOS manual (accessible by running ‘nixos-help’). 
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan. 
      ./hardware-configuration.nix 
       
# #
    ]; 
    
  # Enable graphics driver and stuff 
  hardware.graphics.enable = true; 
  hardware.graphics.enable32Bit = true; 
  #hardware.opengl.enable = true;
  #hardware.opengl.driSupport32Bit = true;
##hardware.graphics = { enable = true; 
      #enable32Bit = true 
      #}; 
      
      # Enable vulkan
  hardware.opengl = {
  enable = true;
 # driSupport = true;
  driSupport32Bit = true;
  extraPackages = with pkgs; [
    intel-media-driver
    vulkan-loader
  ];
};

  # Bootloader. 
  boot.loader.systemd-boot.enable = true; 
  boot.loader.efi.canTouchEfiVariables = true; 

  #Bang & Olufsen sound Fix 
  boot.kernelParams = [ "snd_hda_intel.model=alc285-hp-spectre-xe" ]; 


  networking.hostName = "nixos"; 
  # Define your hostname. 
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant. 
  # Configure network proxy if necessary 
  # networking.proxy.default = "http://user:password@proxy:port/"; 
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain"; 
  # Enable networking 
  networking.networkmanager.enable = true; 

  # Set your time zone. 
  time.timeZone = "Africa/Lagos"; 

  # Select internationalisation properties. 
  i18n.defaultLocale = "en_NG"; 

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NG"; 
    LC_IDENTIFICATION = "en_NG"; 
    LC_MEASUREMENT = "en_NG"; 
    LC_MONETARY = "en_NG"; 
    LC_NAME = "en_NG"; 
    LC_NUMERIC = "en_NG"; 
    LC_PAPER = "en_NG"; 
    LC_TELEPHONE = "en_NG"; 
    LC_TIME = "en_NG"; 
  }; 
  # Enable the X11 windowing system. 
  # You can disable this if you're only using the Wayland session. 
  # Enale the Gnome Desktop Environment 
  # Enable Fractional Scaling 
  services.xserver = {
    enable = true; 

    displayManager.gdm = {
      enable = true; 
      wayland = true; 
    }; 

    desktopManager.gnome = {
      enable = true; 
      # Add this: 
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      ''; 
    }; 

    # Configure keymap in X11 
    xkb = {
      layout = "ng"; 
      variant = ""; 
    }; 
  }; 
  
  # FIX FOR GNOME MUSIC: Enables the Tracker indexer
  #services.gnome.tracker.enable = true; 
  #services.gnome.tracker-miners.enable = true; 
  services.gnome.tinysparql.enable = true;
  services.gnome.localsearch.enable = true;

  # Enable flatpak 
  services.flatpak.enable = true; 
  xdg.portal.enable = true; 
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; 
  
  # Enable libvirtd for virtualisation 
  virtualisation.libvirtd.enable = true; 
  # Enable the virt-manager GUI 
  programs.virt-manager.enable = true; 

  # Enable the KDE Plasma Desktop Environment. 
   #services.displayManager.sddm.enable = true; 
   #services.desktopManager.plasma6.enable = true; 

  #Enale the Cosmic Desktop Environment 
  services.desktopManager.cosmic.enable = true; 
  services.displayManager.cosmic-greeter.enable = true; 
  # Enable CUPS to print documents. 
  services.printing.enable = true; 

  # Enable sound with pipewire. 
  services.pulseaudio.enable = false; 
  security.rtkit.enable = true; 
  services.pipewire = {
    enable = true; 
    alsa.enable = true; 
    alsa.support32Bit = true; 
    pulse.enable = true; 
    # If you want to use JACK applications, uncomment this 
    #jack.enable = true; 
    # use the example session manager (no others are packaged yet so this is enabled by default, 
    # no need to redefine it in your config for now) 
    #media-session.enable = true; 
  }; 

  # Enable touchpad support (enabled default in most desktopManager). 
  # services.xserver.libinput.enable = true; 

  # Define a user account. 
  # Don't forget to set a password with ‘passwd’. 
  users.users.jesam = {
    isNormalUser = true; 
    description = "Jesam Emmanuel"; 
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" ]; 
    packages = with pkgs; 
    [ 
      kdePackages.kate 
    #  thunderbird 
    ]; 
  }; 

  # Install firefox. 
  programs.firefox.enable = true; 

  # Allow unfree packages 
  nixpkgs.config.allowUnfree = true; 
  # Cosmic Binary Cache 
  nix.settings = {
    substituters = [ "https://cosmic.cachix.org" ]; 
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ]; 
  }; 
  
  
  # Enable/Install Docker
  virtualisation.docker.enable = true;


  # List packages installed in system profile. 
  # To search, run: 
  # $ nix search wget 
  environment.systemPackages = with pkgs; 
[ 
  #  vim # Do not forget to add an editor to edit configuration.nix! 
  # The Nano editor is also installed by default. 
  #  wget 
  git 
  google-chrome 
  kdePackages.qtstyleplugin-kvantum  # For Plasma 6 
  libsForQt5.qtstyleplugin-kvantum   # Optional: keep if you use older Qt5 apps 
  libreoffice-qt 
  haruna 
  fastfetch 
  gnome-tweaks 
  gnome-extension-manager 
  tinysparql
  easyeffects # For Windows-like audio tuning
  warp-terminal
  file
  tree
  cmatrix
  zsh
  antigravity
  btop
  htop
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

  # This value determines the NixOS release from which the default 
  # settings for stateful data, like file locations and database versions 
  # on your system were taken. 
  # It‘s perfectly fine and recommended to leave 
  # this value at the release version of the first install of this system. 
  # Before changing this value read the documentation for this option 
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html). 
  system.stateVersion = "25.11"; # Did you read the comment? 

}
