{
  description = "Flake-based Development Environments";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {self, nixpkgs, ...}@inputs: 
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
          cpp
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
    # TODO: set empty template to the default template
    templates = {
      default = self.templates.empty;
      empty = {
        path = ./empty;
        description = "Empty template for a development environment";
      };
      bevy = {
        path = ./bevy ;
        description = "Bevy development environment";
      };
      cpp = {
        path = ./c-cpp ;
        description = "C or CPP development environment";
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
      python = {
        path = ./python;
        description = "Python development environment";
      };
      latex = {
        path = ./latex;
        description = "Latex local environment";
        welcomeText = ''
          # Simple LaTeX setup
          Simply run `watch.sh` in `src` to listen for updates in `main.tex` and generate a `main.pdf` file within the same directory.
        '';
      };
    };
  };
}
