FROM edasque/qmk_firmware:latest
MAINTAINER m-github@divisive.info

ADD . /qmk_keyboard

RUN apt-get update && apt-get install -y avr-libc dfu-programmer dfu-util

WORKDIR /qmk_keyboard/qmk_firmware
