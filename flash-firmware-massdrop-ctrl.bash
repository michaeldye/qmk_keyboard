#!/bin/bash

export keyboard="${keyboard:=massdrop/ctrl}"
export keymap="${keymap:=mdye_custom}"

cleanup() {
  err=$?
  echo "Removing docker container..."
  docker rm -f qmk_keyboard 2> /dev/null
  exit $err
}

trap cleanup INT EXIT

docker run -d --name qmk_keyboard --privileged -v /dev:/dev -v $PWD:/qmk_keyboard:rw -t mdye/qmk_keyboard /bin/bash
docker exec -t qmk_keyboard bash -c "make ${keyboard}:${keymap} && cp ./.build/massdrop_ctrl_mdye_custom.hex /tmp && cd /tmp; ./mdloader_linux --first --download ./massdrop_ctrl_mdye_custom.hex --restart"
