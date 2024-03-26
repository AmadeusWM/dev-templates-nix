{
  description = "Flake-based Development Environments";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {
    templates = {
      empty = {
        path = "./empty";
        description = "Empty template for a development environment";
      };
      rust = {
        path = "./rust";
        description = "Rust development environment";
      };
      r = {
        path = "./r";
        description = "R development environment";
      };
      node = {
        path = "./node";
        description = "Node development environment";
      };
    };
  };
}
