#!/bin/bash

export keyboard="${keyboard:=1upkeyboards/1up60rgb}"
export keymap="${keymap:=mdye_custom_4}"

cleanup() {
  err=$?
  echo "Removing docker container..."
  docker rm -f qmk_keyboard 2> /dev/null
  exit $err
}

trap cleanup INT EXIT

docker run -d --name qmk_keyboard --privileged -v /dev:/dev -v $PWD:/qmk_keyboard:rw -t mdye/qmk_keyboard /bin/bash
cmd="make ${keyboard}:${keymap}:dfu"
docker exec -t qmk_keyboard bash -c "echo ***$cmd***; eval $cmd"
