# network simulator 2 (ns-2) for (almost) everyone! 🎉
Unfortunately, if you're using an ARM computer that isn't an M1 or M2 Mac capable of emulating an x86 architecture via Docker, this image won't be compatible, sorry 🤷

## How it works
In [ArchLinux](https://archlinux.org/) it's very easy to install ns-2, since it has a patched version available on the [aur](https://aur.archlinux.org/). This repository simplifies the process by creating a Docker image based on ArchLinux, integrating necessary patches into ns-2, and installing it seamlessly.

## Added patches
I've added patches for showing the Reno agent current time and current timeout, for now it shows the result on stdout.

To add a patch, generate it from a git commit using:

```bash
$ git format-patch -1 <commit SHA>
```

Then, place the patch in the src/ folder and add it inside the PKGBUILD. You'll need to obtain the SHA256 hash of the .patch file, which can be done with:

```bash
$sha256sum <name of patch>
```

## Execute it:
For executing it you can download the image and run a new container:

```bash
$ docker pull ghcr.io/pablito2020/ns-for-everyone:main
$ docker run -it ghcr.io/pablito2020/ns-for-everyone:main
```

