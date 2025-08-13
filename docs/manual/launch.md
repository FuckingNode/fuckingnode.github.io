# Using FuckingNode: Launch a project

> `fuckingnode launch <project>`, or `fklaunch <project>`

The `launch` command is a command that automatically launches your favorite editor with a project open, and automatically runs a "launch task", e.g. `npm run start`. It can also auto-update your dependencies on launch. It can take a project's name from the `package.json` / `deno.json` / `Cargo.toml`, so it's as simple as doing `fklaunch my-project`.

## Usage

Just run the following:

```bash
fuckingnode launch <PROJECT>
```

`PROJECT` is obvious and mandatory. It can be a relative file path, absolute file path, or the project's name as mentioned before.

By default it just launches your favorite editor with your project opened. For us to be able to run a task or update your dependencies, [setup those features from the project's `fknode.yaml` file](./fknode-yaml.md#launchcmd).

---

You've now learnt how to speed up launching your projects.

Next: Migrate - How to escape npm.
