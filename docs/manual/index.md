---
title: "FuckingNode user manual"
description: "A complete guide for your complete dev-life-quality improver."
---

# FuckingNode user manual

Everything, from the basic to the complex, is documented here step by step. **Use the sidebar to navigate everything page by page and learn everything in detail.**

You can also just keep reading this page for a TL;DR.

## TL;DR for getting started as soon as possible

### Step 0: Install

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

### Step 1: Initial setup

Add your projects to FuckingNode's project list. This is done manually with the `fuckingnode add <path>` (or `fkadd <path>`) command. `<path>` can be any file path, or empty to use the CWD.

```bash
# relative
fuckingnode add "../projects/project1"
# absolute
fuckingnode add "/home/Zaka/Code/project2"
# self path
cd project3
fuckingnode add
```

It's recommended that from now on you run `fkadd .` immediately after running `npm init` (or `pnpm init` or whatever) each time you create a project.

### Step 2: Start using it

A basic cleanup is invoked by running this command, with no arguments.

```bash
fuckingnode clean
# or "fkclean"
```

While it doesn't recover gigabytes of storage, it's simple, fast and gets the job done. Flags can be passed for using extra features.

Keep in mind cleanup is global by default; it'll run (with the same flags if passed) across all the projects you've added, saving you time.

A config file `fknode.yaml` can be created at the root of a project to customize behavior. [Learn more here](fknode-yaml.md).

You can also clean a specific project providing it's path, or it's name from the `package.json`.

```bash
# only clean /home/users/me/project1, for example
fuckingnode clean ../project1

# only clean the project with "my-framework" in the "name" field
fuckingnode clean my-framework
```

### Step 3: Use it better

For increased intensity, use this.

```bash
fuckingnode clean hard
```

When cleaning like this, global caches from all your installed package managers will be cleared immediately after cleaning all of your projects.

If you only wish to clear global caches without waiting for individual cleanup of all of your projects, use `fuckingnode clean hard-only`, or a shortcut (`fuckingnode global-clean` or `fuckingnode hard-clean`).

### Step 4: Use it even better

For the best experience, you can pass flags to the clean command for using additional features. Detailed explanations are available at the [usage manual](../manual/usage.md), but basically:

- `--lint` runs ESLint (or desired linter)
- `--pretty` runs Prettier (or desired prettifier)
- `--destroy` removes unneeded files (e.g. `dist/`)
- `--update` updates dependencies
- `--commit` commits changes made by us (e.g. changes to your lockfile because of updating)

Each flag can be invoked with its 1st letter for faster typing (`-l` = `--lint`, `-p` = `--pretty`...).

As outlined [before](#step-2-start-using-it) cleaning is global. When running with `--lint` all your projects will be automatically linted (unless overridden via an [`fknode.yaml` file](fknode-yaml.md)), greatly increasing your productivity.

Behavior itself can also be overridden via an `fknode.yaml` file, in case you'd like to use a different linter than ESLint, or a different prettifier than Prettier.

Note `--destroy` and `--commit` _are_ affected by the global cleaning rule, however they won't run by default as they require configuration via an `fknode.yaml` file:

- `--destroy` requires you to specify what you want to be removed. We don't have "default" directories to auto-remove like `dist/`, to avoid removing something you _might_ need.
- `--commit` requires you to specify permission to run. Making a commit is a sensible action, as we could potentially commit something you did _not_ intend to commit yet. Hence, committing requires explicit allowance from you, and additional safety checks are performed [as outlined here](../manual/usage.md#committing-your-code-commit).

---

And that's the basic manual. For further learning about `fknode.yaml` or advanced features, keep navigating the documentation. You've got it all in the sidebar.

---

*[CWD]: Current Working Directory
