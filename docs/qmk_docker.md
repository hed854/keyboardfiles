# QMK with Docker

Additional instructions to create a Bootloadhid-compatible environment with the QMK Docker image.

## Build the image with the additional bootloader

1. Add the following lines into the Dockerfile

```
RUN apt-get update &&\
    apt-get install -y libusb-dev binutils-avr gcc-avr avr-libc
```

2. Build the Docker image: `export DOCKER_BUILDKIT=1; docker build -t qmk .`

3. Save the basic Docker container for further executions. Don't forget the volumes and USB devices!

```
docker run -v ~/code/qmk_firmware:/qmk_firmware -v ~/code/keyboardfiles/qmk:/tmp --device /dev/bus/usb:/dev/bus/usb --name qmk --it qmk /bin/bash
```

## Install QMK basic drivers

1. Use the permanent container: `docker start -i qmk`
2. Install basic QMK drivers: `qmk setup`
3. Install and build BootloadHID following the [QMK documentation](https://docs.qmk.fm/#/flashing_bootloadhid). Don't forget to `cp bootloadHID /usr/local/bin`

