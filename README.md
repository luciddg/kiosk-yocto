# Lucid Kiosk on the CuBox-i

## How do I use this thing?

This document is a suppliment to the README.md file in the master branch, and is specific to the CuBox-i build.

If you've got an SD card image handy (a file named `core-image-web-kiosk-cubox-i.sdcard`), write it to a microSD card and boot a CuBox with it.

By default, you get a CuBox that will use Ethernet to display Lucid's website.

If you want WiFi, or to show another webpage, read on...

## What files do I care about?

If you're building the image from scratch:
* `Dockerfile`

If you've built an image, and you want to copy it somewhere to write it to SD card:
* `output/deploy/images/cubox-i/core-image-web-kiosk-cubox-i.sdcard`

If you want to change some aspect of the files that are included by default in the SD card image:
* `recipes-bsp/u-boot/u-boot-cubox-i/wifi.conf`
* `recipes-bsp/u-boot/u-boot-cubox-i/browser.conf`
These files live in the [meta-luciddg-kiosk project](https://github.com/luciddg/meta-luciddg-kiosk).

If you want to change either configuration file _after_ you've written the image to an SD card:
* `(boot partition)/wifi.conf`
* `(boot partition)/browser.conf`
(You can edit these files directly using your computer/laptop.)

## Changing the configuration on a microSD card

The microSD card has two partitions: a FAT (read: Windows) partition, and a Linux partition.

You can use any text editor to edit either configuration file. Save your work, eject the SD card, and you're ready to go. See the [meta-luciddg-kiosk project](https://github.com/luciddg/meta-luciddg-kiosk) for information about the contents of these files, and what to put in them.

## Changing the default `browser.conf` and `wifi.conf` files

`browser.conf` is a [Midori](http://midori-browser.org/) configuration file. Documentation of this file is lacking.

`wifi.conf` is a [WPA Supplicant](http://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf) configuration file.

## Writing an SD card image

http://www.google.com

## Building an SD card image from scratch

See the README.md in the master branch.
