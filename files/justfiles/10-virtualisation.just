vm-new IMAGE="prompt" NAME="prompt" HOMEDIR="":
    #!/usr/bin/env bash
    source /usr/lib/ujust/ujust.sh
    IMAGES='
      Fedora
      Ubuntu
    '

    if [ "$IMAGE" == "prompt" ]; then
      echo "Select what image to use"
      IMAGE=$(Choose $IMAGES)
    fi
    if [ "$NAME" == "prompt" ]; then
      echo -en "Please enter a name for the VM: "
      read NAME
    fi
