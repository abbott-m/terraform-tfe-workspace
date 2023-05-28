{
  description = "terraform-tfe-workspace";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        packages = {
          default = pkgs.stdenv.mkDerivation {
            doCheck = true;
            name = "terraform-tfe-workspace";
            src = ./.;
            version = "0.1.0";

            buildInputs = with pkgs; [
              terraform-docs
            ];

            configurePhase = ''
              ${pkgs.terraform}/bin/terraform init \
                -plugin-dir "${self'.packages.terraform-provider-tfe}/libexec/terraform-providers"
            '';

            checkPhase = ''
              ${pkgs.terraform}/bin/terraform validate
            '';

            installPhase = ''
              mkdir -p $out
              cp README.md $out/.
              cp -R *.tf $out/.
            '';
          };

          terraform-provider-tfe = pkgs.terraform-providers.mkProvider {
            hash = "sha256-aDM6lTxESm9OFAE/p9SbuBe6Uaydprfw0/MxJitLnwY=";
            homepage = "https://registry.terraform.io/providers/hashicorp/tfe";
            owner = "hashicorp";
            repo = "terraform-provider-tfe";
            rev = "v0.45.0";
            spdx = "MPL-2.0";
            vendorHash = "sha256-CWQDFMvx8vMyeiMcMciZbnYpd56h4nA0ysJqNzEtSUo=";
          };
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
