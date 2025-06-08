# Using FuckingNode: Kickstart a project

> `fuckingnode kickstart <repo-url> [file-path] [package manager]`, or `fkstart <repo-url> [file-path] [package manager]`

The `kickstart` command is an extra command that increases your productivity by doing all of the following from a single command:

- Clones a Git repo wherever you want
- Installs dependencies automatically using the project's default package manager (or at your choice, another one).
- Launches your favorite code editor (as defined by your user settings).
- Adds the project to the FuckingNode list.

## Usage

Just run the following:

```bash
fuckingnode kickstart < REPO-URL > [PATH] [PKG MANAGER]
```

`REPO-URL` is obvious and mandatory. `PATH` is optional and defines the path where you want us to clone the project. If not provided, we'll create a directory in the CWD with the name of the repository (just as Git would do by default).

`PKG MANAGER` lets you override the project's package manager, so a project that's using `npm` gets its dependencies installed with, for example, `pnpm` instead.

## Git scopes / shorthands

We make your workflow faster by making you type this:

```bash
fkstart https://github.com/jonathan/some_app.git
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
fkstart gh:jonathan/some_app
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

---

You've now learnt how to get stuff from Git the FuckingNode way.

Next: Commit - Committing stuff the FuckingNode way.
