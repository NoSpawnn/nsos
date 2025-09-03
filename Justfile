IGNITION_DIR := "./ignition"
OUT_DIR := "./build"

build-desktop spin="kde":
  #!/usr/bin/env bash
  set -euxo pipefail
  RECIPE=recipes/desktop/{{ spin }}.yml
  just validate-recipe $RECIPE
  bluebuild build -v $RECIPE -B podman -I podman

build-server:
  bluebuild build -v ./recipes/server/recipe.yml -B podman -I podman

build-desktop-iso:
  mkdir -p {{ OUT_DIR }}/iso
  bluebuild generate-iso --iso-name nsos-desktop.iso -o {{ OUT_DIR }}/iso recipe recipes/recipe-desktop.yml -B podman -I podman

download-coreos:
  mkdir -p {{ OUT_DIR }}/iso
  podman run --security-opt label=disable --pull=always --rm -v ./build/iso:/data -w /data \
    quay.io/coreos/coreos-installer:release download -s stable -p metal -f iso

validate-recipe recipe="":
  bluebuild validate {{ recipe }}

validate-justfile file="":
    just --fmt --check --unstable --justfile {{ file }}

ignite: # Badass right?
  mkdir -p {{ OUT_DIR }}
  podman run --interactive --rm --security-opt label=disable \
    --volume "{{ IGNITION_DIR }}:/pwd" --workdir /pwd quay.io/coreos/butane:release \
    --pretty --strict --files-dir . ignition.yml > {{ OUT_DIR }}/ignition.ign

serve-ignition port="8080": (ignite)
  podman run --rm -it --name ignition-server -p {{ port }}:80 -v ./build:/usr/local/apache2/htdocs:Z httpd:2.4

vm disk_size="128G":
  mkdir -p {{ OUT_DIR }}/vm

  # if [ ! -f {{ OUT_DIR }}/vm/disk.qcow2 ]; then qemu-img create -f qcow2 {{ OUT_DIR }}/vm/disk.qcow2 {{ disk_size }} fi

  qemu-kvm -m 2048 -nic user,model=virtio,hostfwd=tcp::2222-:22 \
    -cdrom ./build/iso/nsos-desktop.iso -drive file=build/vm/disk.qcow2,media=disk,if=virtio
