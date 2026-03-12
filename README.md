# NixOS Configuration

My personal NixOS 25.11 setup running on an HP EliteBook 840 G7.
Both COSMIC and GNOME desktop environments, ZSH shell — all managed
through a single declarative configuration file.

## System

| Component | Details |
|----------|----------|
| Operating System | NixOS 25.11 |
| Hardware | HP EliteBook 840 G7 |
| Desktop Environments | COSMIC + GNOME |
| System Shell | Bash |
| User Shell | ZSH + Oh My Zsh |
| Package Management | Nix |


## Files

- `configuration.nix` — full system configuration
- `hardware-configuration.nix` — hardware config specific to EliteBook 840 G7

- > ⚠️ If you're replicating this, generate your own
> `hardware-configuration.nix` — don't copy mine directly.
> Run `nixos-generate-config` on your machine first.
