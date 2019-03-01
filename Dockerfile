FROM edasque/qmk_firmware:latest
MAINTAINER m-github@divisive.info

ADD . /qmk_keyboard

RUN apt-get update && apt-get install -y avr-libc dfu-programmer dfu-util libusb-dev unzip curl
WORKDIR /
RUN curl -SsL https://github.com/PaulStoffregen/teensy_loader_cli/archive/eb61aa1a482c2ad98916229e02bb8caae2464f48.zip > teensy.zip
RUN unzip teensy.zip
RUN cd teensy_loader_cli-eb61aa1a482c2ad98916229e02bb8caae2464f48 && make teensy_loader_cli && cp ./teensy_loader_cli /usr/bin

WORKDIR /qmk_keyboard/qmk_firmware
