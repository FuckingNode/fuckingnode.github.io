---
title: "fknode.yaml"
description: "FuckingNode project config reference. Fine-grained configuration for each project of yours."
---

# Using FuckingNode: The fknode.yaml file

The `fknode.yaml` file is used to define settings for individual projects. It is opt-in and not required per se, though some specific features do require specific config from here.

Below is a detailed explanation of each configuration option available in the file. They are all optional. Data types are expressed using TypeScript type syntax.

!!! tip "Get autocomplete for VSCode"
    You can [download our Visual Studio Code extension for FuckingNode here](https://marketplace.visualstudio.com/items?itemName=ZakaHaceCosas.fknode), to get autocomplete (as well as some other features).

## General settings

### divineProtection

Divine protection is what we call _ignorance_. Basically, if you run a global cleanup with the `--update` flag (so all projects get their dependencies updated) but don't want a specific project to get its dependencies updated, you'd add `"updater"` to the `divineProtection` option.

It can either be an array of `feature-er` strings (`updater`, `linter`, etc...); or `"*"` to ignore everything.

- **Type**: `("updater" | "cleaner" | "linter" | "prettifier" | "destroyer")[] | "*"`
- **Example**:

```yaml
divineProtection: ["updater", "cleaner"] # ignore dependency updates & project cleanup
```

## cleanerShortCircuit

[As explained here](usage.md#note-about-error-handling), cleanup errors don't stop execution by default. Set `cleanerShortCircuit` to `true` if you want a specific project to halt execution if an error happens.

- **Type**: `boolean`
- **Example**:

```yaml
cleanerShortCircuit: true # any error, even if small, makes the entire thing stop
```

### lintScript

Specifies a script from your package file to be used for linting when `--lint` is passed to `clean`, overriding the default (ESLint).

- **Type**: `string`
- **Example**:

```yaml
lintScript: "lint" # so FuckingNode will run "npm run lint"
```

### prettyScript

Specifies a script from your package file to be used for prettifying when `--pretty` is passed to `clean`, overriding the default (Prettier).

- **Type**: `string`
- **Example**:

```yaml
prettyScript: "prettify" # so FuckingNode will run "npm run prettify"
```

### destroy

Configuration for the destroyer, which removes specified `targets` when `clean` is called with `--destroy` from any of the `intensities`, or an `"*"` for enabling regardless of the intensity.

- **Type**:

```yaml
destroy:
  intensities: ("normal" | "hard" | "maxim")[] | "*"
  targets: string[]
```

- **Example**:

```yaml
destroy:
  intensities: ["high"]
  targets: 
    - "dist"
    - "build"
```

### commitActions

If true, a commit will be made if an action that changes the code is performed and the Git workspace is clean. [Learn more here](usage.md#committing-your-code).

- **Type**: `boolean`
- **Example**:

```yaml
commitActions: true
```

### commitMessage

Specifies the commit message to be used if a commit is made. If not provided, a default message is used.

- **Type**: `string`
- **Example**:

```yaml
commitMessage: "Automated maintenance commit by FuckingNode"
```

### updaterOverride

Overrides the default command for the updating dependencies with the provided runtime script command. Works the same way as [lintScript](#lintscript) or [prettyScript](#prettyscript), we simply made the name more verbose because in most cases you don't need (and should not) mess around with it.

- **Type**: `string`
- **Example**:

```yaml
updaterOverride: "update" # replaces "npm update" with "npm run update"
```

### flagless

Enables flagless features. This makes a feature, like `--pretty`, run for this project even if you don't pass `--pretty` to the `clean` command, allowing you to type less.

- **Type**:

```yaml
flagless:
  flaglessUpdate: boolean
  flaglessDestroy: boolean
  flaglessLint: boolean
  flaglessPretty: boolean
  flaglessCommit: boolean
```

- **Example**:

```yaml
flagless:
  flaglessUpdate: true
  flaglessDestroy: false
  flaglessLint: true
  flaglessPretty: false
  flaglessCommit: true
```

### releaseAlwaysDry

If true, the `release` command will always use `dry-run`.

- **Type**: `boolean`
- **Example**:

```yaml
releaseAlwaysDry: true
```

### projectEnvOverride

FuckingNode uses certain hints (especially your project's lockfile) to infer the runtime to use; however it may rarely fail. You can override its inference system and state the project environment to be used.

- **Type**: `"npm" | "pnpm" | "yarn" | "deno" | "bun" | "go" | "cargo"`
- **Example**:

```yaml
projectEnvOverride: "cargo"
# FuckingNode will treat the project as a Rust (Cargo) project, even if there's a "package-lock.json" on the root
```

### buildForRelease

If enabled and a `buildCmd` is set, it'll always run before releasing when you invoke `release`.

- **Type**: `boolean`
- **Example**:

```yaml
buildCmd: # ...
releaseCmd: # ...
buildForRelease: true # now when running release, buildCmd will auto-run first
```

### kickstarter

Sets defaults for whenever the project is kickstarted.

Just as with your repository's guidelines, you cannot "enforce" them, they're just a _recommendation that autocompletes_ if the cloner wants to follow them.

None of the keys is required, omitting them or setting them to null equals default behavior.

#### kickstarter / install

Set the default handling for dependencies.

- `"no"` - Doesn't try to install anything. Useful for non-code repositories, like a doc site.
- `"use (command)"` - Prompts the user to use a specific install command (as in whole command, you can type `use foobar --a=b` and it'll invoke the `foobar` binary with options `--a=b`). The user can accept or reject execution (in which case the kickstart will halt).

```yaml
kickstarter:
  install: use bun run install.ts # maybe your project's so special you need to install dependencies your own way, who knows?
...
kickstarter:
  install: no # don't install anything
```

#### kickstarter / workspaces

Sets the default handling for workspaces, as in adding them to the user's FuckingNode project for future use.

- `"force-liberty"` - Lets and forces the user to decide, even if they have set a default setting to avoid being prompted. This is annoying and should only be used if you genuinely think it's needed.
- `"unified"` - Adds the root project as a project and nothing else.
- `"standalone"` - Adds each workspaces as an individual project.

```yaml
kickstarter:
  workspaces: standalone # each workspace is treated as an individual project, FuckingNode wise
...
kickstarter:
  workspaces: unified # the root package.json (or whatever) is the only project, FuckingNode wise
```

---

## CmdSets

**CmdSets are a more complex but very powerful type of setting**, they allow to execute any shell command, project file, or whatever you need, whenever a certain trigger fires up. It can also run different commands platform-wise (Win32 / POSIX) and also run commands in parallel. This allows you to make a great automation job.

They look like this:

```yaml
someCmd:
  - ~echo 'Running from my system shell'
  - =scripts/some-script.js --arg1 value1
  - $task:prepublish
  - { msft: ~clear, posix: ~cls }
  - { msft: ~Write-Host 'Cleared console from Windows!', posix: ~echo 'Cleared console from Linux/macOS!' }
  - <powershell -c 'echo foo'
```

They're an array of special strings (or objects) with a key prefix indicating type of Cmd. The type modifies the command by prefixing it before execution. Cmd keys are:

| Cmd key | Cmd type | Behavior |
| :--- | :--- | ---: |
| `~` | **SHELL SCRIPT** | Auto-prefixes with `powershell -c` on Windows and `bash -c` on macOS/Linux. |
| `$` | **PROJECT SCRIPT** | Auto-prefixes with your runtime’s script run prefix (e.g. `npm run`, `deno task`). |
| `=` | **PROJECT FILE** | Auto-prefixes with your runtime’s file run prefix. |
| `<` | **RAW EXEC** | Doesn't auto-prefix. Use this for manually invoking other programs. |

For cross-platform scripting, you can use a `{ msft: Cmd, posix: Cmd }`, where MSFT runs on Windows and POSIX runs on macOS and Linux. Each Cmd needs to be prefixed with a key (they don't need to be the same).

It's something like this:

```yaml
{ msft: ~Write-Host 'Hi from Windows!', posix: ~echo 'Hi from Linux/macOS!' }
```

All commands run in order and block each other. Also, colons are not required. Single and double colons are accepted. `~foo` is equal to `~"foo"` and  `~'foo'`.

By default, output for each Cmd is not live; this is, invisible until the command ends execution. However, sometimes you might not want that, for example for a live server which "never terminates" and you might want to interact with (to refresh it, for example).

If you want a command to be interactive, you may manually specify it as a _detached Cmd_, by using the special `;;` prefix (between the Cmd key and the actual command).

For example:

```yaml
launchCmd:
  - $;;some-script
```

This will "detach" the script, allowing to interact with it. ++ctrl+c++-ing out of it will end the detached process and continue the sequence if any Cmd (detached or not) exists after it.

If you want to run several commands at the same time, nest an array, like this:

```yaml
launchCmd:
  - - $script-a
    - $script-b
```

In that example, `$script-a` and `$script-b` will be evaluated and started at the same time as separate child processes of FuckingNode. The Cmd finishes when all processes have finished. You cannot nest a detached Cmd and doing so will result in undefined behavior.

You can use CmdSets for the following project settings:

### commitCmd

Specifies a CmdSet to be executed upon running the `commit` command.

- **Type**: `CmdSet`
- **Example**:

```yaml
commitCmd:
  - =tasks/precommit.js # e.g. 'node tasks/precommit.js'
  - $test # e.g. 'npm run test'
```

### launchCmd

Specifies a CmdSet to be executed upon running the `launch` command.

- **Type**: `CmdSet`
- **Example**:

```yaml
launchCmd:
  - ~rm .cache # shell remove-item
  - $start # e.g. 'npm run start'
```

### buildCmd

Specifies a CmdSet to be executed upon running the `build` command.

- **Type**: `CmdSet`
- **Example**:

```yaml
buildCmd: 
  - $build # e.g. 'npm run build'
  - ~cd dist # shell change-dir
  - <vercel --prod # raw-runs the vercel executable
```

### releaseCmd

Specifies a CmdSet to be executed upon running the `release` command.

- **Type**: `CmdSet`
- **Example**:

```yaml
releaseCmd:
  - $release # e.g. 'npm run release'
```

### kickstartCmd

Specifies a CmdSet to be executed upon cloning the project with the `kickstart`.

- **Type**: `CmdSet`
- **Example**:

```yaml
kickstartCmd:
  - =tasks/setup-env.mjs
  - ~echo 'project is now ready to work on!'
```

---

## Full sample

This is an example of a full `fknode.yaml` file.

```yaml
divineProtection: ["updater", "cleaner"]
cleanerShortCircuit: true
lintScript: "lint"
prettyScript: "prettify"
destroy:
  intensities: ["high"]
  targets: ["dist", ".cache"]
commitActions: true
commitMessage: "Automated commit by fknode"
updaterOverride: "update"
flagless:
  flaglessUpdate: true
  flaglessDestroy: false
  flaglessLint: true
  flaglessPretty: false
  flaglessCommit: true
releaseCmd:
  - $release
releaseAlwaysDry: true
commitCmd:
  - $precommit
  - $test
launchCmd:
  - $start
projectEnvOverride: "bun"
buildCmd: 
  - ~cd src
  - =build.ts
  - ~mv ./out ./dist
buildForRelease: true
kickstartCmd:
  - =tasks/setup-env.mjs
  - ~echo 'project is now ready to work on!'
```

---

You've now learnt how to configure each project to your liking.

Next: Kickstart - Now proceed a bunch of extra features from the CLI to enhance productivity; kickstart is the first one.
