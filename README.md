Lucid Kiosk sdcard image builder
================================

tl;dr
-----

Invoke thusly:

```bash
$ docker build -t luciddg/kiosk .
$ docker run --rm -d -v $(readlink -f output/):/usr/local/share/yocto/ luciddg/kiosk
```

Building the entire OS will take a long (multi-hour) time, requires ~40 GB of disk space, minimum ~4 GB of RAM and as much processor and disk as you can provide. While it builds, go get some coffee or a soda.

The resultant disk image for the generic x86-64 target is suitable for booting in VirtualBox. Create a VM, attach the disk, boot.

**If you want a build an image that will boot on a CuBox**, perform the same steps above, but after checking out the `cubox` branch of this repository.

About the OS
------------

This is a _very_ bare-bones Linux, with a typical embedded mostly-busybox runtime. It has the Midori web browser installed, with the various Xorg supporting bits necessary. It is intended to be retargetable, and indeed there are two branches for the targets I care about. It boots into runlevel 5, with Midori running in kiosk mode.

The root filesystem is mounted read-only! And none of that half-assed aufs shit. This is real, actual read-only root. If you need to write files, you can do it in `/tmp/` and `/var/run/`. Nothing you do there will persist. You cannot write to persistent storage without some serious(ly bad) acrobatics.

No accounts on this system permit login!

How to develop
--------------

If you make changes to an external repository (i.e. one included in the `docker build` step), you can either:
```bash
$ docker exec -ti $container sudo -u yocto bash -l
yocto@container$ cd $updated_repo && git pull
yocto@container$ ./make.sh
```

Or stash (read: move) the contents of the output directory and rebuild the Docker image. So long as you haven't deleted the contents of the `output/` directory (and put it back once you `docker build`), build times should be minutes and not hours. If you **don't** move the `output/` directory, Docker will try to copy all 40+ GB and thousands of files into the image context and that's bad. So do.

If you *must* log in
--------------------

Use kpartx to set up your loopback to the sdcard image, mount the root partition, and edit `/etc/shadow`. Burn the image to a microSDcard, boot, connect with a USB serial connection and screen, and log in. This method will persist across reboots (obviously). Don't ship that image.

Useful links
------------

[Yocto Project Development Manual](http://www.yoctoproject.org/docs/1.6/dev-manual/dev-manual.html), which is the reference manual and user guide.
[Documentation for the meta-web-kiosk layer](https://wiki.yoctoproject.org/wiki/Web_Application_for_Interactive_Kiosk_Devices#Integration_Of_meta-web-kiosk_Into_Poky)
[SolidRun's documentation on Yocto for the CuBox-i](http://wiki.solid-run.com/Yocto)
[How to get to the CuBox' serial console](http://wiki.solid-run.com/Serial_console)

TODO
----

* Write a layer to build the touchscreen kernel module and ship it in the image
* Turn off `getty` if we're not going to permit interactive accounts
