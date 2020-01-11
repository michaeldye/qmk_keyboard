FROM edasque/qmk_firmware:latest
MAINTAINER m-github@divisive.info

ADD . /qmk_keyboard
ADD bin/mdloader_linux /tmp
ADD bin/applet-flash-samd51j18a.bin /tmp

RUN apt-get update && apt-get install -y avr-libc dfu-programmer dfu-util libusb-dev unzip curl python3 python3-pip
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
WORKDIR /
RUN curl -SsL https://github.com/PaulStoffregen/teensy_loader_cli/archive/eb61aa1a482c2ad98916229e02bb8caae2464f48.zip > teensy.zip
RUN unzip teensy.zip
RUN cd teensy_loader_cli-eb61aa1a482c2ad98916229e02bb8caae2464f48 && make teensy_loader_cli && cp ./teensy_loader_cli /usr/bin

WORKDIR /qmk_keyboard/qmk_firmware
