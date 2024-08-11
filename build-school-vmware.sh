sudo nixos-rebuild build --flake .#wxt-school-vmware --log-format internal-json -v |& nom --json
sudo nixos-rebuild build --flake .#wxt-school-vmware
nix-store --export $(nix-store --query --requisites ./result) | pigz -c > nix-closure-export.storeobject.gz
