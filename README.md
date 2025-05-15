# nix-config

This repository contains my personal Nix configurations for managing my macOS (Nix-Darwin) and NixOS systems. It uses a Flakes-based approach for modular, reproducible system configurations.

## Disclaimer

This configuration is highly opinionated and tailored to my specific needs. It is not intended as a general-purpose solution and would require significant adaptation for use on other systems.

## Key Features

- **Host-specific Configurations**: Separate setups for Mac mini M4 (macOS/Darwin) and M1 (NixOS)
- **Home Manager Integration**: Unified user environment management across platforms
- **Hardware Support**: NixOS is configured for use on Apple Silicon hardware
- **Custom Utilities**: Includes functions like `scanPaths` for dynamic imports

**Credits**:
- [EmergentMind/nix-config](https://github.com/EmergentMind/nix-config) for library functions
- [nixos-apple-silicon](https://github.com/tpwrules/nixos-apple-silicon) for Apple Silicon support

## Repository Structure

- **`flake.nix`**: Core configuration defining outputs, inputs, and system setups
- **`hosts/`**: Host-specific configurations (m1, m4)
- **`modules/`**: NixOS, Darwin, and Home Manager modules
- **`lib/`**: Utility functions for enhanced modularity
- **`pkgs/`**: Custom package derivations
- **`overlays/`**: Package overlays and overrides

## Notes for Beginners

While tailored for personal use, this repository can serve as a reference for Nix-based configurations, particularly for Home Manager integration and Apple Silicon support.

## License

This project is licensed under the [MIT License](LICENSE).
