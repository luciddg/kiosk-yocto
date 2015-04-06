
Lucid Kiosk sdcard image builder
================================

tl;dr
-----

Invoke thusly:

```bash
$ docker build -t yoctoprep ./env-prep/
$ docker build -t lucid/kiosk .
$ docker run --rm -d -v $(readlink -f output/):/usr/local/share/yocto/ lucid/kiosk sudo -u yocto -i /usr/local/src/build-yocto.sh
```

Building the entire OS will take a long (multi-hour) time, requires ~40 GB of disk space, ~4 GB of RAM and as much processor and disk as you can provide. While it builds, go get some coffee or a soda.

The resultant disk image for the generic x86-64 target is suitable for booting in VirtualBox. Create a VM, attach the disk, boot.

The output image lives in `output/deploy/images/$target/core-image-web-kiosk-$target.sdcard`. Write that directly to your SD card.

About the OS
------------

This is a _very_ bare-bones Linux, with a typical embedded mostly-busybox runtime. It has the Midori web browser installed, with the various Xorg supporting bits necessary. It is intended to be retargetable, and indeed there are three branches for the three targets I've used. It boots into runlevel 5, with Midori running in kiosk mode.

The root filesystem is mounted read-only! And none of that half-assed aufs shit. This is real, actual read-only root. If you need to write files, you can do it in `/tmp/` and `/var/run/`. Nothing you do there will persist. You cannot write to the SD card without some serious(ly bad) acrobatics.

No accounts on this system permit login (that is, all lines in `/etc/shadow` contain `!` or `*`).

How to develop
--------------

My usual workflow involves interacting with the Docker container directly (ala a VM) because I'm lazy, and the thing was really intended to be fire-and-forget. Anyway, if you make changes to a layer, you'll need to rebuild that specific layer, and then rebuild.

```bash
yocto@container $ cd build
yocto@container $ bitbake -c $updated_layer -f
yocto@container $ bitbake core-image-web-kiosk
```

If you're not operating interactively, you need to figure some way to source `poky/oe-init-build-env build` before invoking bitbake. I haven't solved that problem yet.

The brute-force option, obviously, is to remove the contents of your output directory, triggering another complete, multi-hour build. Sorry.


Useful links
------------

[Yocto Project Development Manual](http://www.yoctoproject.org/docs/1.6/dev-manual/dev-manual.html), which is the reference manual and user guide.
[Documentation for the meta-web-kiosk layer](https://wiki.yoctoproject.org/wiki/Web_Application_for_Interactive_Kiosk_Devices#Integration_Of_meta-web-kiosk_Into_Poky)
[SolidRun's documentation on Yocto for the CuBox-i](http://wiki.solid-run.com/Yocto)
[How to get to the CuBox' serial console](http://wiki.solid-run.com/Serial_console)

TODO
----

* Test SSL communications (i.e. do we have root certs?)
* Make wifi (untested) work (see https://community.freescale.com/thread/324030)
* Make the mouse pointer go away
* Write a layer to build the touchscreen kernel module and ship it in the image
* Turn off `getty` if we're not going to permit interactive accounts
