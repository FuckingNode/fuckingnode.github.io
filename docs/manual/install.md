# Getting started

First thing first, install the CLI using any of these methods.

Standard installation for :fontawesome-brands-windows: Microsoft Windows, :simple-linux: Linux and :simple-apple: macOS is script-based, and it's worth noting **these scripts will also create shortcuts.** For example, `fkn`, `fknode`, and also command-specific shortcuts like `fkclean`, `fkaudit`, and so on. These shortcuts are script (SH or PS1) based, and are not created when compiling from source or installing for NixOS.

## Standard installation

### :fontawesome-brands-windows: Microsoft Windows

Copy and paste the following code in a terminal session.

```powershell
powershell -c "irm fuckingnode.github.io/install.ps1 | iex"
```

### :simple-linux: Linux and :simple-apple: macOS

Copy and paste the following code in a terminal session.

```bash
curl -fsSL fuckingnode.github.io/install.sh | bash
```

### :simple-nixos: Nix / NixOS

!!! warning
    ARM (`aarch64-linux`) support is available, but NOT tested!

Add the repo to your `flake.nix`.

```nix
inputs = {
    ...
    fuckingnode.url = "github:FuckingNode/FuckingNode";
    ...
};
```

Then, add this to your system packages:

```nix
inputs.fuckingnode.packages."${pkgs.system}".default;
```

## :simple-deno: Compile from source

For contributors and nerds who clone the entire source just to change one line they don't like, compiling is extremely easy:

1. Install [Deno 2](https://docs.deno.com/runtime/).
2. Open this project from the root.

You can now either:

- Run `deno task compile` and get the output executable from `dist/`.
- Run `deno -A src/main.ts [...commands]` from the root.

!!! note Note for source compiling
    When compiling from source, you'll get an error because of a missing utility "kbi". You can ignore it, we use it for hashing release binaries.

---

You've now learnt how to install the CLI.

Next: Configure the CLI - Get the CLI ready for usage.
