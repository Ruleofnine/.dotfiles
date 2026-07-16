{ pkgs, ... }:

{
services.postgresql = {
  enable = true;

  ensureDatabases = [
    "dg"
  ];

  ensureUsers = [
    {
      name = "rule";
      ensureClauses = {
        login = true;
      };
    }
  ];
};

  users.users.achivit = {
    isSystemUser = true;
    group = "achivit";
  };

  users.groups.achivit = { };

systemd.services.achivit = {
  description = "Achivit Discord bot";
  wantedBy = [ "multi-user.target" ];
  after = [ "postgresql.service" ];
  requires = [ "postgresql.service" ];

  serviceConfig = {
    User = "achivit";
    Group = "achivit";
    WorkingDirectory = "/srv/achivit";
    ExecStart = "/srv/achivit/target/release/achivit";
    Restart = "on-failure";
  };

  environment = {
    DATABASE_URL = "postgresql:///dg";
  };
};
}
