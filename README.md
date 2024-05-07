# dev-templates-nix
Install the `nixdev` package to quickly download flakes from this repo.
```
# In your flake.nix
{
  inputs = {
    dev-templates-nix.url = "github:AmadeusWM/dev-templates-nix";
  }
}
...
# configuration.nix
{
  environment.systemPackages = with pkgs; [
    inputs.dev-templates-nix.packages.${pkgs.system}.default
  ];
}
```
# Usage
for e.g. rust: run `nixdev rust` in your project to use the rust template.
