#!/bin/bash

set -eu
source config.sh

rm -rf work
rm -rf result
mkdir -p work
mkdir -p result

INITRD_PATH=$PWD/result/initramfs.img.lz4

# Build the Docker image that we are later creating the initrd from.
touch packages.list || true
docker build -t $IMAGE_NAME --build-arg BRANCH=$BRANCH .

pushd work >/dev/null

# Create an instance of our image.
container_id=$(docker run --rm -it -d $IMAGE_NAME /bin/cat)

# Dump the container root into docker.tar
docker export -o docker.tar $container_id
docker kill $container_id

# Extact and delete the tar archive.
# The current directory now contains the extraced root of our image.
tar -xf docker.tar
rm docker.tar

# Create the initramfs from all files in the current directory.
echo "=> Saving initramfs at $INITRD_PATH"
find . -print0 ! -iname "*initramfs.img.lz4*" |
    cpio --null --create --owner root:root --format=newc |
    lz4c -l > $INITRD_PATH

popd >/dev/null

file -h $INITRD_PATH
du -hs $INITRD_PATH

echo "=> Creating helper script at $PWD/result"
cat > result/qemu-run.sh <<EOF
if [[ -z "$BZ_IMAGE_PATH" ]]; then
    echo "Please export BZ_IMAGE_PATH and set it to the kernel you want to test"
    exit 1
fi

qemu-system-x86_64 -k de -kernel $BZ_IMAGE_PATH -initrd $(readlink -f $INITRD_PATH) -enable-kvm
EOF
chmod +x result/qemu-run.sh