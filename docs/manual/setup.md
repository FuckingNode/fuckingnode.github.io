# Using FuckingNode: Setup a project

> `fuckingnode setup <setup> [project]`, or `fksetup <project> [project]`

!!! question "Don't mess terms up"
    It's not the same to _setup FuckingNode_ ([configure the CLI first time](configuration.md)) than to use _fuckingnode setup_ (here)

The `setup` command in FuckingNode basically adds a pre-made text-config file (like a preset `tsconfig.json` or a preset `fknode.yaml`). There's currently few _setups_ (we refer to each "preset" / "template" / ... as a _setup_); however they're easy to add, so soon we'll likely have a setup for every use case. _You could contribute your own, too :wink:._

## Usage

To list available setups, run:

```bash
fuckingnode setup
```

You'll see something like the following (but with more setups and CLI colors):

```txt

┌───────────────────────┬──────────────────────────────────────────────────────────────────┐
│ Name                  │ Description                                                      │
├───────────────────────┼──────────────────────────────────────────────────────────────────┤
│ fknode-basic          │ A very basic fknode.yaml file.                                   │
│ fknode-allow-all      │ An fknode.yaml file that enables every feature (commits too!).   │
│ gitignore-js          │ A gitignore for JavaScript projects.                             │
│ gitignore-js-nolock   │ A gitignore for JavaScript projects (ignores lockfiles!).        │
│ gitignore-golang      │ A gitignore for Go projects.                                     │
│ gitignore-rust        │ A gitignore for Rust projects.                                   │
│ ts-strictest          │ Strictest way of TypeScripting, ensuring cleanest code.          │
│ ts-library            │ Recommended config for libraries.                                │
│ editorconfig-default  │ A basic .editorconfig file that works for most people.           │
│ prettierrc-default    │ An unopinionated Prettier config that suits everyone.            │
└───────────────────────┴──────────────────────────────────────────────────────────────────┘
You didn't provide any argument, or provided invalid ones, so up here are all possible setups.
You can filter setups by typing part of the name, e.g. 'setup license' to show all LICENSE setups.

```

Then, to apply a setup, run:

```bash
fuckingnode setup <setup-name>
# for example
fuckingnode setup ts-strictest
```

`setup-name` is obvious and mandatory, its the name of the setup to be applied. When listing setups you'll see their names (and a brief description).

This will add a setup to the project in the current working directory. You can add a setup to a project anywhere by passing a path as the 2nd argument.

```bash
fuckingnode setup <setup-name> <path>
# for example
fuckingnode setup gitignore-js ./projects/some-js-framework
```

Since we add more setups from time to time (and the table is already larger than what shown in the documentation), you might want a search option. If you type a setup that doesn't exist but partially matches existing setups, these will be shown.

For example, running `fuckingnode setup ts-` returns something like this:

```txt

┌───────────────┬──────────────────────────────────────────────────────────┐
│ Name          │ Description                                              │
├───────────────┼──────────────────────────────────────────────────────────┤
│ ts-strictest  │ Strictest way of TypeScripting, ensuring cleanest code.  │
│ ts-library    │ Recommended config for libraries.                        │
└───────────────┴──────────────────────────────────────────────────────────┘
You didn't provide a valid setup. Above are all setups that match ts-.

```

---

You've now learnt how to quickly get your text-config files ready.

Next: Stats - (can't think of a description for this one).
