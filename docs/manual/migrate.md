# Using FuckingNode: Migrate a project

> `fuckingnode migrate <project> <target>`, or `fklaunch <project> <target>`

The `migrate` command automatically migrates your project from one JS stack to another. For example, from npm to Bun, or from npm to pnpm, or from npm to anything better.

It doesn't do any migration _per se_, it relies on package managers knowing how to manage that (which is usually the case). Its purpose is to automate the process, since a migration involves several steps (updating lockfiles, removing node_modules, installing, removing old lockfile...).

As this can take time, **if it takes long, you'll receive a [system notification](../learn/notifications.md) once done,** so you can just switch tabs and focus on something else, and get notified once ready so you can get back to coding.

## Usage

Just run the following:

```bash
fuckingnode migrate <TARGET> <PROJECT>
```

`TARGET` is the target package manager (the one to migrate to), can be either npm or pnpm or yarn or deno or bun. `PROJECT` is optional, specifies what project to be migrated, if not provided the CWD is used.

We'll tell you step by step what are we doing. Previous lockfile will be copied to a `.bak` file.

---

You've now learnt how to escape npm.

Next: Setup - How to quickly get text-config files ready.
