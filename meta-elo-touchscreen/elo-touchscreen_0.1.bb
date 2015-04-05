SUMMARY = "ELO touchscreen driver kernel module layer"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=12f884d2ae1ff87c09e5b7ccc2c4ca7e"

inherit module

PR = "r0"
PV = "0.1"

SRC_URI = "http://www.elotouch.com/files/drivers/Elo_Linux_MT_USB_Driver_v1.0.0_armv7l.tgz"

S = "${WORKDIR}"

# The inherit of module.bbclass will automatically name module packages with
# "kernel-module-" prefix as required by the oe-core build environment.
