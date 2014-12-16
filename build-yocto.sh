#!/bin/bash

# Because volumes aren't first-class citizens in Dockerfiles,
#  n.b. that the build script expects a host mount at
#  /usr/local/share/yocto/

. poky/oe-init-build-env build
bitbake core-image-web-kiosk
