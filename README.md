# network simulator 2 (ns-2) for (almost) everyone! 🎉
If you have an arm computer (M1 and M2 mac), you can't run this image, sorry 🤷

## How it works
In [ArchLinux](https://archlinux.org/) it's very easy to install ns-2, since it has a patched version on the [aur](https://aur.archlinux.org/), so this repository creates a docker image with archlinux as a base, adds some patches to ns and installs it.

## Added patches
I've added patches for showing the Reno agent current time and current timeout, for now it shows the result on stdout.

## Execute it:
For executing it you can download the image and run a new container:

```bash
$ docker pull ghcr.io/pablito2020/ns-for-everyone:main
$ docker run -it arch-ns
```

