{
  disko.devices.disk.nvme01 = {
    device = "/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_1TB_S467NX0M920410V";
    type = "disk";
    content = {
      type = "gpt";
      partitions.root = {
        size = "100%";
        label = "M2 SSD 01";
        content = {
          type = "filesystem";
          format = "ext4";
          mountpoint = "/mnt/nvme01";
          mountOptions = [ "nofail" ];
        };
      };
    };
  };
}
