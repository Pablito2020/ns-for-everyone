# Network Simulator 2 (ns-2) for everyone! 🎉

## Requirements

Install [nix](https://nixos.org/), we recommend you to install it via the determinate systems installer:

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --no-confirm
```

## Usage

You can have a shell with ns already installed with:

```bash
nix develop --accept-flake-config github:pablito2020/ns-for-everyone#ns
```

You can even run it without spawning a new shell, just do: 

```bash
nix run --accept-flake-config github:pablito2020/ns-for-everyone#ns <your-ns-script> <your-script-args>
```

If you want to run the patched version that prints the timeout, just change `#ns` with `#ns-patched`, for example, if you want a shell with the patched version of ns:

```bash
nix develop --accept-flake-config github:pablito2020/ns-for-everyone#ns-patched
```

Or, run it directly:

```bash
nix run --accept-flake-config github:pablito2020/ns-for-everyone.#ns-patched <your-ns-script> <your-script-args>
```

## Use it with docker

**It is not the recommended path**, but you can download the ns-for-everyone image and run a new container:

```bash
docker pull ghcr.io/pablito2020/ns-for-everyone:main
docker run -it ghcr.io/pablito2020/ns-for-everyone:main
```
