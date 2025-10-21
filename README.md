# Network Simulator 2 (ns-2) for (almost) everyone! 🎉

## Requirements

Install [nix](https://nixos.org/), we recommend you to install it via the determinate systems installer:

```bash
$ curl -fsSL https://install.determinate.systems/nix | sh -s -- install --no-confirm
```

## Usage

You can have a shell with ns already installed with:

```bash
nix develop github:pablito2020/ns-for-everyone#ns
```

You can even run it without spawning a new shell, just do: 

```bash
nix run github:pablito2020/ns-for-everyone#ns <your-ns-script> <your-script-args>
```

If you want to run the patched version that prins the timout, just change `#ns` with `ns-patched`, just like so:

```bash
# If you want the shell
nix develop github:pablito2020/ns-for-everyone#ns-patched
```

Or, if you want to run it directly:

```bash
nix run github:pablito2020/ns-for-everyone.#ns-patched <your-ns-script> <your-script-args>
```

## Use it with docker

For executing it you can download the image and run a new container:

```bash
$ docker pull ghcr.io/pablito2020/ns-for-everyone:main
$ docker run -it ghcr.io/pablito2020/ns-for-everyone:main
```
