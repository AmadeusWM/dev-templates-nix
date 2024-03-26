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
        echo "hello"
        # if [ -z "$1" ]; then
        #   echo "missing dev template argument, you can choose from: clojure csharp cue dhall elixir elm gleam go hashi haskell haxe java kotlin latex nickel nim nix node ocaml opa php protobuf pulumi purescript python ruby rust-toolchain rust scala shell zig"
        #   nix flake new -t github:nix-community/nix-direnv .
        # else
        #   nix flake init --template github:the-nix-way/dev-templates#$1
        # fi
        # direnv allow .
        # cat .gitignore | grep ".direnv" || echo ".direnv" >> .gitignore
    '';
    });
    templates = {
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
    };
  };
}
