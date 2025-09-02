# Enable automatic LUKS unlock via TPM
setup-luks-tpm-unlock:
    #!/usr/bin/bash
    sudo /usr/libexec/luks-enable-tpm2-autounlock

# Disable automatic LUKS unlock via TPM
remove-luks-tpm-unlock:
    #!/usr/bin/bash
    sudo /usr/libexec/luks-disable-tpm2-autounlock

# Boot into this device's BIOS/UEFI screen
bios:
    #!/usr/bin/bash
    if [ -d /sys/firmware/efi ]; then
      systemctl reboot --firmware-setup
    else
      echo "Rebooting to legacy BIOS from OS is not supported."
    fi

# Show BIOS info
bios-info:
    #!/usr/bin/bash
    echo "Manufacturer: $(sudo dmidecode -s baseboard-manufacturer)"
    echo "Product Name: $(sudo dmidecode -s baseboard-product-name)"
    echo "Version: $(sudo dmidecode -s bios-version)"
    echo "Release Date: $(sudo dmidecode -s bios-release-date)"
