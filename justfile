switch:
  sudo nixos-rebuild switch --flake .

boot:
  sudo nixos-rebuild boot --flake .

lint:
  exec env TERM=dumb lefthook run pre-commit

gc:
  sudo nix-collect-garbage -d
