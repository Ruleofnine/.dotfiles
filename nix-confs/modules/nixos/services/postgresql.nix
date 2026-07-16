{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;

    # Pin the database version intentionally rather than allowing it
    # to change implicitly when system.stateVersion changes.
    package = pkgs.postgresql_17;
  };
}
