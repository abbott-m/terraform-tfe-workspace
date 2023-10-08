{
  description = "terraform-tfe-workspace";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }:
        let
          terraform-tfe = pkgs.terraform-providers.tfe.override (old: {
            hash = "sha256-MTPtt87Kq3gOxF85Wwc6SWRy90+kK4BeHivAQTo32f8=";
            rev = "v0.49.2";
            vendorHash = "sha256-PQanCxvb1sT5SSLNH4fKFwF8j5ycU+6Os63GZuyBUSo=";
          });
          terraform = pkgs.terraform.withPlugins (ps: [ terraform-tfe ]);
        in
        {
          packages = {
            default = pkgs.runCommand "default"
              {
                src = ./.;
              } ''
              mkdir -p $out
              cp -R $src/*.tf $out

              ${terraform}/bin/terraform -chdir="$out" init
              ${terraform}/bin/terraform -chdir="$out" validate
            '';
          };

          devShells = {
            default = pkgs.mkShell {
              buildInputs = with pkgs; [
                terraform
                terraform-docs
              ];
            };
          };
        };
    };
}
