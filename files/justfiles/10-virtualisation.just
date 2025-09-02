vm-new DISTRO="prompt" NAME="prompt" HOMEDIR="":
    #!/usr/bin/env bash
    source /usr/lib/ujust/ujust.sh
    IMAGES='
      Fedora (latest)
      Ubuntu (latest)
    '

    IMAGE={{ IMAGE }}
    NAME={{ NAME }}
    HOMEDIR={{ HOMEDIR }}

    if [ "$IMAGE" == "prompt" ]; then
      echo "Select what image to use"
      DISTRO=$(Choose $IMAGES)
    fi
    if [ "$NAME" == "prompt" ]; then
      echo -en "Please enter a name for the container: "
      read NAME
    fi