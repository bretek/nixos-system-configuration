{ pkgs, ... }:
let
  unstableSrc = fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/2b7f86f5491a259117d1da71bed7d24c5dfd87fe.tar.gz";
    sha256 = "sha256-SFmrByyK/TLYBsHcnYpGrYbR9Ry22uQ/VqFTTnQVM4w=";
  };

  unstablePkgs = import unstableSrc {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      opencode = unstablePkgs.opencode;
    })
  ];
}
