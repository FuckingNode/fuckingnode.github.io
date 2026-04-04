---
title: "Configuring FuckingNode"
description: "FuckingNode is easy to config and to tweak, this page explains all you need."
---

# Setup FuckingNode

!!! question "Don't mess terms up"
    It's not the same to _setup FuckingNode_ (here) than to use _fkn setup_ (a [separate utility](setup.md) we provide)

Here we'll learn everything about setting up and configuring the CLI to your liking.

## Adding a project

> `fkn add <project>`

_We care about user experience, and that's why we're constantly working to ensure peak performance..._ blah blah blah TL;DR: **you need to add projects yourself so we don't consume your time and CPU looking in your entire drive for JavaScript projects** (which trust me, would've been easier for me - kind off).

!!! note
    Some features are **addition agnostic**, like `commit` or `setup`. This means they don't need the project to be added. These features usually don't even require you to be on a "supported platform".

There are 4 ways to add projects:

**1 /** You can add a relative or absolute path:

```bash
fkn add "../projects/something/"
# or
fkn add "C:\Users\Zaka\projects\something"
#           ^^^^^^^^^^^ (or /home/whatever in linux / mac)
```

Spreading is supported.

```bash
fkn add ./foo ./bar ./baz
```

**2 /** You can get in the root of the project and add with no args, or a dot (`.`)

```bash
cd generic-js-project-name-here
fkn add .
# this below does the same and is two characters shorter :nerd:
fkn add
```

This is our recommended way, as you can run it right after running `npm init` and you don't have to type a long folder name.

**3 /** If you have one folder for all your projects, you can use a glob pattern

```bash
cd my-projects
fkn add ./*
# this will check every folder
```

**4 /** You also can waste your time opening the config file. It's a plain text file that stores absolute paths separated by line breaks. On :fontawesome-brands-windows: Windows it lives at your local `%APPDATA%`, and on :simple-linux: Linux & :simple-apple: macOS it lives on `HOME` (or `XDG_CONFIG_HOME`). It looks like this:

```txt title="fuckingnode-motherfuckers.txt" linenums="1"
C:\Users\Zaka\projects\Sokora
C:\Users\Zaka\projects\electronJS-clone
```

**Keep in mind paths must always point to the root**. If any path point to the `package.json` itself or to anything else that isn't the root of the project (the DIR that holds `package.json`), the entire CLI will just break.

**Once you're done with adding your projects, you can** theoretically **skip the rest of the page and get started with [using the CLI](usage.md)**. Keep reading for learning the rest about configuring the CLI.

## Removing a project

> `fkn remove <project>`

As easy as using one of the previously mentioned methods, but instead of using `add`, using `remove`.

```bash
fkn remove "../projects/something/"
fkn remove "C:\Users\Zaka\projects\something"
# Spreading is supported.
fkn remove ./foo ./bar ./baz
```

## Smart Project Referencing

There's one more thing to `fkn remove` (and to many more commands). **Thanks to our innovative expertise, you can use a project's _name_ (as in `package.json > "name"`, or your runtime's equivalent)**:

```bash
fkn remove flamethrower
```

The above would work as long as you have one added project with this `package.json`:

```json title="package.json" linenums="1"
{
    "name": "flamethrower",
    "version": "6.9.0"
    // etc...
}
```

It also works for `deno.json`, `Cargo.toml`...

Some facts:

- Any command that takes a project as an input can take a name, except for illogical things like `fkn add`.
- Feature's _not_ officially called "Smart Project Referencing".
- If two projects have the same name... there's no code to explicitly handle it, actually. This thing reads the project list in order, so first one to have the name wins.
    - We like to consider our beloved users "smart". Be smart enough not to keep duplicate project names.

## Listing projects

Just run `fkn list`. It'll beautifully show you all of your projects in a table like below, but with CLI colors and cool stuff.

```bash
💡 Here are the motherfuckers you added  so far:

[bun+bun]   konbini v0.0.1 /home/zaka/Code/Konbini (clear)
[bun+bun]   sokora v0.4 /home/zaka/Code/Sokora (clear)
[bun+bun]   zen-pkgs v0.0.1 /home/zaka/Code/zen-os-search (clear)
[node+npm]  personaplus v0.2.0 /home/Zaka/Code/personaplus (protected from updater)
[deno+deno] /home/zaka/Code/dev-utils (clear)
[deno+deno] @zakahacecosas/fuckingnode v5.3.0 /home/zaka/Code/FuckingNode (protected from cleaner)
```

Data is shown as `[Runtime+PackageManager] ([Name] (v[Version])) [Root] [DivineProtection]`.

Later on we'll see how to "protect" projects; here we'll tell you that you can pass `--ignored` to only list protected projects (or ignored; later we'll talk about terminology), or `--alive` to only list non-ignored projects. If you try to mix both flags to create a loophole and break the matrix, you won't break anything; the flag you write first will overrule the second one.

## Settings

As most apps, we offer settings you can tweak. We use default values that should work for most people, to save you even more time - however you _might_ want to change them; for example if you don't use Visual Studio Code (your "favorite editor" by default).

Currently supported settings are the following. Change them with `settings change <KEY> <value>`

| KEY | Value Type | Default | Description |
| :--- | :--- | ---: | ---: |
| `default-intensity` | `normal`, `hard`, `hard-only`, `maxim`, or `maxim-only` | `normal` | Changes the default intensity for the `clean` command. |
| `update-freq` | A fixed number, represents DAYS. | 5 | Changes how frequently the CLI sends an HTTP request for updates. Recommend to be high, as we don't frequently update. |
| `fav-editor` | `vscode`, `sublime`, `emacs`, `atom`, `vscodium`, `notepad++` | `vscode` | Your favorite code editor. Used by `kickstart` and `launch`. |
| `default-manager` | `npm`, `pnpm`, `yarn`, `deno`, `bun`, `go`, or `cargo` | `npm` | Used when a manager is required and we can't guess what to use. |
| `notifications` | `true`, `false` | `true` | Whether to [use system notifications](../learn/notifications.md). Highly recommended. |
| `notification-threshold` | `true`, `false` | `false` | Makes system notifications only fire up if the task to be notified about takes more than the threshold value. |
| `notification-threshold-value` | A fixed number, represents MILLISECONDS. | `10000` (10 seconds) | Notification threshold value. |
| `always-short-circuit-cleanup` | `true`, `false` | `false` | Makes `clean` immediately halt if an error happens. See [this](usage.md#note-about-error-handling). |
| `kickstart-root` | A file path | (Undefined) | Automatically roots kickstarted projects to there instead of the current working directory. Useful if you have a main "projects" folder or something similar. |
| `workspace-policy` | `standalone` or `unified` | (Undefined) | If set, when adding a project with workspaces, you won't be prompted for how to handle them; `standalone` handling will add each workspace individually and `unified` handling will add just the root. |

### View current settings

To view your current settings, run `fuckingnode settings` with no args. You should see something like this:

```txt
💡 Your current settings are:
---
Check for updates             | Every 5 days. update-freq
Default cleaner intensity     | normal. default-intensity
Default package manager       | npm. default-manager
Favorite code editor          | vscode. fav-editor
Send system notifications     | Enabled. notifications
Threshold notifications?      | Disabled. notification-threshold
Notification threshold        | 10000 milliseconds. notification-threshold
Short circuit on cleanup error? | Disabled. always-short-circuit-cleanup
Root for kickstarted projects?  | /home/zaka/proyectitos. kickstart-root
Workspace clone handling?       | Always unify. workspace-policy
```

As you can see, you're shown at the end the key used to change a setting (it appears _italic_ in your terminal, if it supports that).

### Change settings

To change them, execute `fkn settings change (KEY) (VALUE)`, for example:

```bash
fkn settings change default-intensity "hard"
fkn settings change update-freq 15
```

### Additional settings commands

Settings includes an additional `flush` command, that takes a `<file>` (`errors`, `updates`, `projects`, or `all`) as an argument, removing said file from FuckingNode's configuration, located at `%APPDATA%/FuckingNode` on :fontawesome-brands-windows: Windows and `/home/USER/.config/FuckingNode` on :simple-linux: Linux & :simple-apple: macOS. Removal of `projects` or `all` is kinda discouraged.

There's another settings command, `settings repair`. It simply resets settings to defaults.

---

You're now fully setup and ready to put those f*cking JavaScript projects in place!

Next: Usage - How to actually put those f*cking JavaScript projects in place?
