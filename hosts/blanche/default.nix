{
  imports = [
    ../../modules/optional/virby.nix
    # ../../modules/external/detsys
    ./brew.nix
    ./home.nix
    ./nix.nix
    ./system.nix
    ./users.nix
    # ./gitlab-runners.nix
  ];
}
