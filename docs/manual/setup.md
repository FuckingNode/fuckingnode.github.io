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

You'll see something like the following (but with more options):

```txt
┌───────────────────────┬───────────────────────────────────────────────────────────────────────┐
│ Name                  │ Description                                                           │
├───────────────────────┼───────────────────────────────────────────────────────────────────────┤
│ fknode-basic          │ A very basic fknode.yaml file.                                        │
│ fknode-allow-all      │ An fknode.yaml file that allows every feature to run (commits too!).  │
│ gitignore-js          │ A gitignore file for JavaScript projects.                             │
│ gitignore-js-nolock   │ A gitignore file for JavaScript projects (also ignores lockfiles).    │
│ ts-strictest          │ Strictest way of TypeScripting, ensuring cleanest code.               │
│ ts-library            │ Recommended config for libraries.                                     │
│ editorconfig-default  │ A basic .editorconfig file that works for everyone.                   │
└───────────────────────┴───────────────────────────────────────────────────────────────────────┘
You didn't provide any argument, or provided invalid ones, so up here are all possible setups.
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

---

You've now learnt how to quickly get your text-config files ready.

Next: Stats - (can't think of a description for this one).
