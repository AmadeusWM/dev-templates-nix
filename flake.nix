{
  description = "Flake-based Development Environments";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {nixpkgs, ...}@inputs: 
  let
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
      pkgs = import nixpkgs { inherit system; };
    });
  in {
    packages = forEachSupportedSystem ({pkgs}: {
      default = pkgs.writeShellScriptBin "nixdev" ''
        if [ -z "$1" ]; then
          echo "Missing dev template argument
        Usage: 
          nixdev <template>
        Choose a template from: 
          bevy
          empty 
          node
          rust
          r"
        else
          nix flake init --template github:AmadeusWM/dev-templates-nix#$1
          direnv allow .
          cat .gitignore | grep ".direnv" || echo ".direnv" >> .gitignore # add .direnv to .gitignore if not already in .gitignore
        fi
    '';
    });
    templates = {
      bevy = {
        path = ./bevy ;
        description = "Bevy development environment";
      };
      empty = {
        path = ./empty;
        description = "Empty template for a development environment";
      };
      rust = {
        path = ./rust;
        description = "Rust development environment";
      };
      r = {
        path = ./r;
        description = "R development environment";
      };
      node = {
        path = ./node;
        description = "Node development environment";
      };
      latex = {
        path = ./latex;
        description = "Latex local environment";
      };
    };
  };
}
