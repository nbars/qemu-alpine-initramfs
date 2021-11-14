#!/bin/sh

#
# This is the entrypoint of the initrd that is executed right after init.
#

# Set the keymap.
# Alternatives:
# https://pkgs.alpinelinux.org/contents?branch=edge&name=kbd-bkeymaps&arch=x86_64&repo=main
zcat /usr/share/bkeymaps/de/de-nodeadkeys.bmap.gz | loadkmap

# Drop into shell
exec bash