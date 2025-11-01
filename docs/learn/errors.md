# Error codes

Maybe you want to make a tool that automates our automation tool, or maybe you're just too lazy to read the error message. However, most (if not all) possible exceptions that abort execution are called "FknErrors", and include a readable, identifiable error code. These are all listed here, with a brief explanation of their meaning.

They follow this convention:

```ts
// IF IT'S TWO PARTS
CATEGORY__ERROR
// IF IT'S THREE PARTS
CATEGORY__COMPONENT__ERROR
```

For example, `Env__NoPkgFile` (category:`Environment`, error:`NoPackageFile`).

---

## Operating system [Os]

Errors caused by the underlying OS.

### No APPDATA, No HOME

`Os__NoAppdataNoHome`

Uncommon, but not impossible. We store config files in :fontawesome-brands-windows: APPDATA / :simple-apple: :simple-linux: HOME, or XDG_CONFIG_HOME if the aforementioned doesn't exist. If none of these exists, you get this error.

Check your system's env variables if this happens; if none of these is defined many apps will fail for you, not just this one.

### No Entity

`Os__NoEntity`

Happens when FuckingNode attempts to invoke an entity and doesn't find it. In simpler words, if you set your `buildCmd` (for example) to `foobar` and there's no entity in your PATH named "foobar", we're unable to launch it - thus this error happens.

It's most often caused by either:

- The entity indeed not existing (perhaps you had a typo).
- On Windows, `echo 'hi'` or `Write-Output 'hi'` don't exist, `cmd echo 'hi'` or `powershell Write-Output 'hi'`. If you want to use Windows shell command you need to explicitly call a shell executable (preferably PowerShell). Blame it on Microsoft, not us.

## File system [Fs]

Errors related to the filesystem.

### Unreal

`Fs__Unreal`

In any context, a filepath (probably provided by you) points to nowhere ("is _unreal_"). The file/directory doesn't exist, basically.

### Unparsable Filepath

`Fs__UnparsablePath`

This one is way less likely to appear. It also means a filepath points to nowhere; but because it's not a proper path and cannot be handled. Maybe an illegal character is in there, or whatever else is wrong.

### Demands DIR

`Fs__DemandsDIR`

Happens whenever we ask for a DIRECTORY yet you give us a path that points to a file. We demand a directory.

### Demands Emptying of DIR

`Fs__DemandsEmptying`

Usually happens with kickstart. You provided a path that is _not_ empty, but _has to_ be empty. Thus, we demand emptying of the directory.

## Configuration [Cfg]

Errors related to configuration.

### Invalid favorite IDE

`Cfg__User__FavIDE`

If you manually set your favorite IDE to an invalid value this error happens.

### Invalid CmdKey

`Cfg__FknYaml__InvalidCmdK`

[Cmds](../manual/fknode-yaml.md#cmdsets) require to start with a key character, either `~`, `$`, `=`, or `<`. If the first character of a Cmd is not any of those, this error throws.

## Git [Git]

Errors related to Git operations.

### No branch

`Git__NoBranch`

Happens when the user specifies a branch that does indeed not exist.

### No branch at all

`Git__NoBranchAA`

Happens when there's no branches at all. Git repos are supposed to always have a branch, so it is very unlikely - and if it happens it's most likely a bug.

### Forbidden commit

`Git__Forbidden`

Happens when a forbidden file, like `.env`, is committed. These should be in your `gitignore`, but if for some reason they weren't there, FuckingNode disallows committing them.

As of now, forbidden files are: `".env", ".env.local", ".sqlite", ".db", "node_modules", ".bak"`

### Other errors

There are many Git errors, one for each operation FuckingNode may perform. Except for the above, these are considered obvious to understand, + they always include an error message mentioning the exact Git command that caused the failure together with its output.

To not spend too much time writing documentation they've been omitted.

## Environment [Env]

Errors related to environments; not in the sense of env variables, but in the sense of "project environments". That's how we refer to the structure we make of each of your projects in order to work with it.

### Missing motor

`Env__MissingMotor`

Technically unlikely, except for kickstarting projects that aren't yours. Happens whenever your project uses a package manager that's not installed locally.

### No package file

`Env__NoPkgFile`

A "project" doesn't have the file that makes it a project (`package.json`, `Cargo.toml`, etc...).

### Unparsable package file

`Env__PkgFileUnparsable`

If a project's package file is plain invalid (invalid JSON in a `package.json` file for example) or lacks critical information (like `name` in `package.json` or `go` in `go.mod`), we consider it unparsable and throw this error.

### Cannot determine env

`Env__CannotDetermine`

Differentiating between npm, pnpm, Yarn, Bun, Deno, Rust, or Go projects, or no projects at all, is a bit confusing. We do our best effort, but sometimes a project is not recognizable enough - in which case you'll see this error. It's very unlikely.

### Schrödinger's Lockfile

`Env__SchrodingerLockfile`

_The name's a bit of a joke, but_ this error happens when the same project has two or more lockfiles. Lockfiles are our main tool to determine the "state" (env) of your project; your project is not Schrödinger's cat and shouldn't be in several states at the same time.

### Env not found

`Env__NotFound`

If a project from your list isn't found (in the sense of the filepath not being found), this error may happen.

## Task [Task]

All errors in this category are `Task__[TASK TYPE]`, which can be `Release`, `Commit`, `Launch`, `Update`, `Lint`, `Pretty`, or `Build`. Any unexpected error when running any of these tasks for any project will trigger a Task category error.

## Parameter [Param]

All errors in this category are `Param__[PARAM TYPE]Invalid`, which can be `Target`, `CIntensity`, `Setup`, `Ver`, `GitTarget`, `GitTargetAlias`, or `Whatever` for anything else. When running a command that requires parameters (`fkstart <GIT TARGET>`, `fksetup <SETUP>`, and so on...), any missing or invalid parameter will trigger a Task category error.

If unclear, `Ver` refers to "version" (for the `fkrelease` command), `CIntensity` refers to "cleaner intensity", and both `GitTarget` and `GitTargetAlias` refer to the kickstart parameter, respectively referring to Git URLs and Git aliases.

## Interop [Interop]

All errors in this category are `Interop__[ACTION TYPE]Unable`, which can be `Publish`, `Migrate`, or `JSRun`. Attempting to use a feature in a platform where it's unsupported (most likely Cargo or Go) will trigger a Task category error.

If unclear, `JSRunUnable` means trying to define a task that would go like `npm run X` for Cargo or Go - you cannot do "JS-like run" with these two.

## Internal errors

Errors that are probably our fault for writing bad code. These errors are extremely unlikely to appear, but they're worth documenting.

### Invalid embedded file

`Internal__InvalidEmbedded`

If FuckingNode references a file embedded within the binary that's indeed not embedded within the binary, this error happens.

### Lazy

`Internal__Lazy`

More casual way to call a "NotImplemented" error. If we're lazy to finish a feature or can't finish it on time to fullfil our [release schedule](https://github.com/FuckingNode/FuckingNode/blob/master/RELEASE_SCHEDULE.md), instead of removing references to the feature we'll make it trigger this error, indicating we were indeed lazy to implement it.

## External errors

!!! warning
    This category will be removed by version 5.1, and these errors will be moved somewhere else.

Errors that depend on something external.

### Setting / Favorite IDE

`External__Setting__FavIde`

If you changed your favorite IDE to something unsupported, then got us to attempt to launch it, this happens. You cannot directly set this setting to something invalid, you'd have to manually edit the config file - making this an "external" error.
