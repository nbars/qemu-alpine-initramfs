# qemu-alpine-initramfs
This repository contains some scripts to build an initial ramdisk based on an Alpine Linux Docker container. In combination with a kernel (bzImage), this image can be booted in an emulator such as QEMU.

## Configuration
- You can configure the keyboard layout in the `login` script (default is `de-nodeadkeys`)
- Additional packages can be added to `packages.list`. The Alpine Linux package browser can be found at https://pkgs.alpinelinux.org/packages.
- You can change the Alpine Linux branch via `config.sh`

## Usage
1. Apply your desired changes to the configuration (see above).
2. Call `./build.sh` to build the initial ramdisk.
3. Use the `./result/qemu-run.sh` script to boot QEMU with the new ramdisk and the kernel configured via the `BZ_IMAGE_PATH` environment variable.