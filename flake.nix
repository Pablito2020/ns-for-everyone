{
  description = "Flake for building the legacy Network Simulator (ns)";

  nixConfig = {
    extra-substituters = ["https://cache.garnix.io"];
    extra-trusted-public-keys = ["cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {flake-parts, ...} @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.devshell.flakeModule
      ];
      # perSystem defines what to build per system
      perSystem = {
        self',
        pkgs,
        ...
      }: {
        packages = rec {
          tk = pkgs.symlinkJoin {
            name = "tk";
            paths = [pkgs.tk.dev pkgs.tk.out];
          };
          otcl = pkgs.callPackage ./packages/otcl.nix {inherit tk;};
          tclcl = pkgs.callPackage ./packages/tclcl.nix {inherit otcl tk;};
          ns = pkgs.callPackage ./packages/ns.nix {inherit otcl tclcl tk;};
          ns-patched = pkgs.callPackage ./packages/ns.nix {
            inherit otcl tclcl tk;
            withPatch = true;
          };
          ns-docker-image = pkgs.dockerTools.buildImage {
            name = "ns";
            tag = "latest";
            copyToRoot = [
              ns
              pkgs.bashInteractive
              pkgs.coreutils
              pkgs.findutils
              pkgs.gnugrep
              pkgs.gawk
              pkgs.util-linux
              pkgs.less
              pkgs.vim
              pkgs.git
              pkgs.curl
              pkgs.procps
            ];
            config = {
              WorkingDir = "/root";
              Cmd = ["bash"];
              Env = ["LC_ALL=C.UTF-8" "LANG=C.UTF-8" "PATH=/bin"];
            };
          };
          default = ns;
        };
        apps = {
          ns = {
            type = "app";
            program = "${self'.packages.ns}/bin/ns";
            meta.description = "Discrete event simulator targeted at networking research (ns‑2)";
          };
          ns-patched = {
            type = "app";
            program = "${self'.packages.ns-patched}/bin/ns";
            meta.description = "Patched ns‑2 for printing the TCP RENO timeout";
          };
        };
        treefmt.config = {
          package = pkgs.treefmt;
          programs = {
            alejandra.enable = true;
            deadnix.enable = true;
            statix.enable = true;
          };
        };
        devshells = rec {
          ns = {
            packages = [self'.packages.ns];
            devshell.motd = ''
              {202}🔨 Shell with normal ns, powered py pablito2020{reset}
              $(type -p menu &>/dev/null && menu)
            '';
          };
          ns-patched = {
            packages = [self'.packages.ns-patched];
            devshell.motd = ''
              {202}🔨 Shell with PATCHED ns, powered py pablito2020{reset}
              $(type -p menu &>/dev/null && menu)
            '';
          };
          default = ns;
        };
      };
    };
}
