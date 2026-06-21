{
  disko.devices.disk.satassd02 = {
    device = "/dev/disk/by-id/ata-Samsung_SSD_860_EVO_500GB_S3Z2NB1K317352E";
    type = "disk";
    content = {
      type = "gpt";
      partitions.root = {
        size = "100%";
        label = "SATA SSD 02";
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/mnt/satassd02";
          mountOptions = [ "nofail" ];
        };
      };
    };
  };
}
