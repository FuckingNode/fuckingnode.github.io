# F*ckingNode user manual

Everything, from the basic to the complex, is documented here step by step.

## Outline

These are links to individual pages. For the full manual, click the first one, then keep reading. For a faster, one page guide to quickly get started, [skip here](#tldr-for-getting-started-as-soon-as-possible).

- [Install the CLI](install.md)
- [Configuration](configuration.md)
- [Main usage guide](usage.md)
- [Individual project config (fknode.yaml)](fknode-yaml.md)
- [Extra - Kickstart](kickstart.md)
- [Extra - Commit](commit.md)
- [Extra - Release](release.md)
- [Extra - Launch](launch.md)
- [Extra - Surrender](surrender.md)
- [Extra - Setup](setup.md)
- [Extra - Stats](stats.md)
- [What's next?](whats-next.md)

For further learning:

- [Cross-runtime support](../learn/cross-runtime-support.md)

## TL;DR for getting started as soon as possible

### Step 0

Install it for your platform following the instructions [here](./install.md) (just like any professional tool, installation is as easy as running one CLI command).

### Step 1

Add your projects to FuckingNode's project list. This is done manually with the `fuckingnode manager add <path>` (or `fkadd <path>`) command. `<path>` can be any file path, or `--self` to use the CWD.

```bash
# relative
fuckingnode manager add "../projects/project1"
# absolute
fuckingnode manager add "/home/me/projects/project2"
# self path
cd project3
fuckingnode manager add --self
```

It's recommended that from now on you run `fkadd --self` immediately after running `npm init` (or `pnpm init` or whatever) each time you create a project.

### Step 2

A basic cleanup is invoked by running this command, with no arguments.

```bash
fuckingnode clean
# or "fkclean"
```

While it doesn't recover gigabytes of storage, it's simple, fast and gets the job done. Flags can be passed for using extra features.

Keep in mind cleanup is global by default; it'll run (with the same flags if passed) across all the projects you've added, saving you time.

A config file `fknode.yaml` can be created at the root of a project to customize behavior. Learn more [here](fknode-yaml.md).

You can also clean a specific project providing it's path, or it's name from the `package.json`.

```bash
# only clean /home/users/me/project1, for example
fuckingnode clean ../project1

# only clean the project with "my-framework" in the "name" field
fuckingnode clean my-framework
```

### Step 3

For increased intensity, use this.

```bash
fuckingnode clean hard
```

When cleaning like this, global caches from all your installed package managers will be cleared immediately after cleaning all of your projects.

If you only wish to clear global caches without waiting for individual cleanup of all of your projects, use `fuckingnode clean hard-only`, or a shortcut (`fuckingnode global-clean` or `fuckingnode hard-clean`).

### Step 4

For the best experience, you can pass flags to the clean command for using additional features. Detailed explanations are available at the [usage manual](../manual/usage.md), but basically:

- `--lint` runs ESLint (or desired linter)
- `--pretty` runs Prettier (or desired prettifier)
- `--destroy` removes unneeded files (e.g. `dist/`)
- `--update` updates dependencies
- `--commit` commits changes made by us (e.g. changes to your lockfile because of updating)

Each flag can be invoked with its 1st letter for faster typing (`-l` = `--lint`, `-p` = `--pretty`...).

As outlined [before](#step-2) cleaning is global. When running with `--lint` all your projects will be automatically linted (unless overridden via an [`fknode.yaml` file](fknode-yaml.md)), greatly increasing your productivity.

Behavior itself can also be overridden via an `fknode.yaml` file, in case you'd like to use a different linter than ESLint, or a different prettifier than Prettier.

Note `--destroy` and `--commit` _are_ effected by the global cleaning rule, however they won't run by default as they require configuration via an `fknode.yaml` file:

- `--destroy` requires you to specify what you want to be removed. We don't have "default" directories to auto-remove like `dist/`, to avoid removing something you _might_ need.
- `--commit` requires you to specify permission to run. Making a commit is a sensible action, as we could potentially commit something you did _not_ intend to commit yet. Hence, committing requires explicit allowance from you, and additional safety checks are performed as outlined [here](../manual/usage.md#committing-your-code-commit).

---

That's the basic manual. For further learning about `fknode.yaml` or advanced features, [refer to the desired manual section](#outline).

---

*[CWD]: Current Working Directory
