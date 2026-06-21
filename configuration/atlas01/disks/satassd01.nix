{
  disko.devices.disk.satassd01 = {
    device = "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_2TB_S4X1NJ0NB01384H";
    type = "disk";
    content = {
      type = "gpt";
      partitions.root = {
        size = "100%";
        label = "SATA SSD 01";
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/mnt/satassd01";
          mountOptions = [ "nofail" ];
        };
      };
    };
  };
}
