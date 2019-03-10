<!--
.. title: Installing Nextcloud on an OrangePi
.. slug: installing-nextcloud-on-an-orangepi
.. date: 2017-08-08 21:08:01 UTC
.. tags: weekend-projects
.. category: 
.. link: 
.. description: 
.. type: text
-->

Tonight I set out to take my OrangePi One out of the closet and make something 
useful with it.

Motivated by the fact that I recently wiped my phone and had no backup of my 
contacts and calendar (I know what you’re thinking but I don’t feel comfortable
hosting those things on certain famous search providers), and also because I had
a spare HDD hanging around, I decided I’d go for a “personal cloud”, running at
home, that should support CalDAV, notetaking and all that convenient stuff I’ve
been missing out on.

After less than 2min of googling, I settled for [Nextcloud](https://nextcloud.com/).
There are even some RaspberryPi images with a preinstalled Nextcloud, but I
wanted to get my hands (minimally) dirty and learn something new, so I decided
to install it myself.

### Chrooting into the image with QEMU

Because I had never installed anything on my OrangePi, and also because I had
no keyboard nor screen available, I figured the best way to go about installing
all the needed stuff was to chroot into an image that I would then flash into
an SD card, to serve as my OrangePi disk.

However, the architecture of the OrangePi is different than that of my laptop.
QEMU to rescue: this virtualization tool acts as a translator for the ARM
binaries to be executable on my laptop.

Following this [RaspberryPi wiki article](https://wiki.debian.org/RaspberryPi/qemu-user-static)
was helpful, although I had to do some of the steps differently, namely:

*   I took note of the sector unit size and of the start sector values, obtained
by running `$ fdisk -lu armbian.img`
*   I ran `# losetup -f -P --show armbian.img` , then mounted the resulting `/dev/loopX`
taking the offset into account (also note that the image I used had a single partition):
     `# mount /dev/loopX -o rw,offset=$((512*8192)) your_mount_point` , where 512
and 8192 are the sector unit size and the start sector, respectively, in my case.
*   Because I’m on Archlinux, I used `$ arch-chroot` instead of `$ chroot` ,
which means I didn’t manually do all those `$ mount --bind` steps.

### Installing the stuff

I then followed [this guide](http://unixetc.co.uk/2016/11/20/simple-nextcloud-installation-on-raspberry-pi/)
on installing Nextcloud on a RaspberryPi.

I then configured my local network on the OrangePi, while still chrooted. Cleaned
everything up, unmounted the stuff, flashed the image on a microSD card and...

### The "powers" that be

I noticed I wasn’t able to turn my OrangePi on because I didn’t have a power
adaptor. How frustrating... I assumed from the beginning that you could power
it with a USB cable...

And you can, as it turns out. I bumped into [this video](https://www.youtube.com/watch?v=KF1IJvINjYE)
which explains clearly how to do it. Luckily enough I had the necessary connectors
and was able to assemble a hacky power connector.

Another power-related thing I had to do was manually split the USB cable I
was connecting to my HDD drive, so that only the data cables were talking with
the OrangePi, and not the power ones - which I connected to a spare phone
charger. This is because the HDD wouldn't be able to drain enough current from
the OrangePi. I used this simple schematic, which I got from the [Electronics
StackExchange](https://electronics.stackexchange.com/questions/218500/usb-charge-and-data-separate-cables):

![usb split](/images/usb-split.png)

Voilá! A private cloud at home!

