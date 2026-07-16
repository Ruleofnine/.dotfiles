{ ... }:

{
  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/srv/storage" = {
    device = "/dev/disk/by-uuid/8CCEA115CEA0F89A";
    fsType = "ntfs3";

    options = [
      "ro"
      "nofail"
      "x-systemd.device-timeout=5s"
    ];
  };
}
