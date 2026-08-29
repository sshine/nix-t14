switch:
  sudo nixos-rebuild switch --flake .

boot:
  sudo nixos-rebuild boot --flake .

lint:
  exec env TERM=dumb lefthook run pre-commit

# pass --dry-run to report what each stage would reclaim, without deleting
gc *ARGS:
  ./scripts/cargo-gc {{ ARGS }}
  nix-collect-garbage -d {{ ARGS }}
  sudo nix-collect-garbage -d {{ ARGS }}
