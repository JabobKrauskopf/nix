# NixOS help

## Commands

- Rebuild from flake: `sudo nixos-rebuild switch --flake .#charon` (`#charon` defines which config to use. Omit to use hostname)
- Run commands through nix shell: `nix shell {registry}#{package}`, e.g. `nix shell nixpkgs#git`. You can also run commands directly, e.g. `nix shell nixpkgs#cowsay -c cowsay lololol`
- Build flake, don't add to grub: `sudo nixos-rebuild test --flake .`
- Build, add to grub but dont switch instantly: `sudo nixos-rebuild boot --flake .`
- Update Lockfile: `nix flake update`
- Check flake with debugger: `nix flake check --debugger`
- NixOS Garbage Collection: `sudo nix-collect-garbage -d && nix-collect-garbage -d` (Don't currently know why both sudo and non-sudo)

## Home Manager Commands

- Rebuild: `home-manager switch --flake .`
- Cleanup: `home-manager expire-generations "-30 days"`

## If problems with NAT-Hairpinning (or Loopback or Reflection)

```nix
# Allow all Docker containers to access external IP (required for Uptime Kuma, Nextcloud, etc).
# Without this, the following command would fail:
# `docker run --rm alpine/curl:latest https://home.alg.to`
# TODO: See if maybe the option `networking.firewall.checkReversePath` is a better way of fixing this?
# networking.firewall.trustedInterfaces = [
#   "docker0"
#   "br-+"
# ];
```

Links:

- Search: <https://search.nixos.org/>
