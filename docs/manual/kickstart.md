---
title: "FuckingNode Kickstarter"
description: "Get your projects cloned, launched, and ready for development with just one line."
---

# Using FuckingNode: Kickstart a project

> `fkn kickstart <repo-url> [path] [package manager]`

The `kickstart` command increases a lot your productivity when working with remote repositories by doing all of the following from a single command:

- Clones a Git repo wherever you want
- Installs dependencies automatically using the project's default package manager (or at your choice, another one).
- Launches your favorite code editor (as defined by your user settings).
- Adds the project to the FuckingNode list.

Plus, **if it takes long, you'll receive a [system notification](../learn/notifications.md) once done,** so if it's a large repo you can just switch tabs and focus on something else, and get notified once ready so you can get to coding.

And, best of all, it also provides post-clone scripts.

## Usage

Just run the following:

```bash
fkn kickstart <REPO-URL> [PATH] [PKG MANAGER]
```

`REPO-URL` is obvious and mandatory. `PATH` is optional and defines the path where you want us to clone the project. If not provided, we'll create a directory in the CWD with the name of the repository (just as Git would do by default).

`PKG MANAGER` lets you override the project's package manager, so a project that's using `npm` gets its dependencies installed with, for example, `pnpm` instead.

## Git scopes / shorthands

We already make your workflow faster by making you type this:

```bash
fkn kickstart https://github.com/jonathan/some_app.git
```

instead of this:

```bash
git clone https://github.com/jonathan/some_app.git
cd dev-utils
npm install
code .
```

You can save a few extra seconds, however, by typing this instead:

```bash
fkn kickstart gh:jonathan/some_app
```

and we'll convert that into `https://github.com/jonathan/some_app.git`. And it's not just GitHub that we support, there are plenty of shorthands:

| Alias | Points to            | That means                         |
|:------|:---------------------|:-----------------------------------|
| gh    | GitHub               | github.com/USER/REPO               |
| gl    | GitLab               | gitlab.com/USER/REPO               |
| bb    | Bitbucket            | bitbucket.org/USER/REPO            |
| sr    | SourceForge          | sourceforge.net/p/USER/REPO        |
| bbp   | Bitbucket Pipelines  | bitbucket.org/USER/REPO/pipelines  |
| gist  | GitHub Gist          | gist.github.com/USER/REPO          |
| cb    | Codeberg             | codeberg.org/USER/REPO             |
| gt    | Gitee                | gitee.com/USER/REPO                |
| fg    | Framagit             | framagit.org/USER/REPO             |
| op    | OpenPrivacy Git      | git.openprivacy.ca/USER/REPO       |

### Post-clone scripts

You can use FuckingNode's CmdSet system to create a `kickstartCmd`, or what you'd call a post-clone script.

These are scripts written in a special, cross-platform "language" within the `fknode.yaml` file.

!!! success "Safety first."
    Scripts are scripts; they're unsafe by nature. To prevent this from causing issues, you're prompted after cloning whether you want to run them or not and are shown every command that they'll run, one by one. Choosing not to run it won't alter the rest of the kickstart process.

How to write this kind of scripts is covered in [the CmdSet documentation](fknode-yaml.md#cmdsets).

---

You've now learnt how to get stuff from Git the FuckingNode way.

Next: Commit - Committing stuff the FuckingNode way.
