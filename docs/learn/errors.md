# Error codes

Maybe you want to make a tool that automates our automation tool, or maybe you're just too lazy to read the error message. However, most (if not all) possible exceptions that abort execution are called "FknErrors" (internal name, shown to you), and include a readable, identifiable error code. These are all listed here, with a brief explanation of their meaning.

They follow this convention:

```ts
// IF IT'S TWO PARTS
CATEGORY__ERROR
// IF IT'S THREE PARTS
CATEGORY__COMPONENT_ERROR
```

For example, `Env__NoPkgFile` (category:`Environment`, error:`NoPackageFile`).

---

## Operating system category [Os]

Errors caused by the OS. There's only one as of now.

### No APPDATA, No HOME

`Os__NoAppdataNoHome`

Uncommon, but not impossible. We store config files in :fontawesome-brands-windows: APPDATA / :simple-apple: :simple-linux: HOME, or XDG_CONFIG_HOME if the aforementioned doesn't exist. If none of these exists, you get this error.

Check your system's env variables if this happens; if none of these is defined many apps will fail for you, not just this one.

## File system category [Fs]

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

## Environment category [Env]

Errors related to environments; not in the sense of env variables, but in the sense of "project environments". That's how we refer to the structure we make of each of your projects in order to work with it.

### Missing motor

`Env__MissingMotor`

Technically unlikely, except for kickstarting projects that aren't yours. Happens whenever your project uses a package manager that's not installed locally.

### No package file

`Env__NoPkgFile`

A "project" doesn't have the file that makes it a project (`package.json`, `Cargo.toml`, etc...).

### Unparsable package file

`Env__PkgFileUnparsable`

If your package file is plain invalid (invalid JSON in a `package.json` file for example) or lacks the `name` field, we consider it unparsable.

### Cannot determine env

`Env__CannotDetermine`

Differentiating between npm, pnpm, Yarn, Bun, Deno, Rust, or Go projects, or no projects at all, is a bit confusing. We do our best effort, but sometimes a project is not recognizable enough - in which case you'll see this error. It's very unlikely.

### Schrödinger's Lockfile

`Env__SchrodingerLockfile`

_The name's a bit of a joke, but_ this error happens when the same project has two or more lockfiles. Lockfiles are our main tool to determine the "state" (env) of your project; your project is not Schrödinger's cat and shouldn't be in several states at the same time.

## Task category [Task]

All errors in this category are `Task__[TASK TYPE]`, which can be `Release`, `Commit`, `Launch`, `Update`, `Lint`, `Pretty`. Any unexpected error when running any of these tasks for any project will trigger a Task category `FknError`.

## Parameter category [Param]

All errors in this category are `Param__[PARAM TYPE]Invalid`, which can be `Target`, `CIntensity`, `Setup`, `Ver`, `GitTarget`, `GitTargetAlias`, or `Whatever` for anything else. When running a command that requires parameters (`fkstart <GIT TARGET>`, `fksetup <SETUP>`, and so on...), any missing or invalid parameter will trigger a Task category `FknError`.

If unclear, `Ver` refers to "version" (for the `fkrelease` command), `CIntensity` refers to "cleaner intensity", and both `GitTarget` and `GitTargetAlias` refer to the kickstart parameter, respectively referring to Git URLs and Git aliases.

## Interop category [Interop]

All errors in this category are `Interop__[ACTION TYPE]Unable`, which can be `Publish`, `Migrate`, or `JSRun`. Attempting to use a feature in a platform where it's unsupported (most likely Cargo or Go) will trigger a Task category `FknError`.

If unclear, `JSRunUnable` means trying to define a task that would go like `npm run X` for Cargo or Go - you cannot do "JS-like run" with these two.

## Internal errors

Errors that are probably our fault for writing bad code. These errors are extremely unlikely to appear, but they're worth documenting.

### Non existent app path

`Internal__NonexistentAppPath`

Almost impossible, unless we make a mistake and don't realize until release. Happens if somewhere in the code we reference a path to an internal config file that doesn't exist.

### Improper assignment

`Internal__ImproperAssignment`

Happens if the CLI attempts to proceed with actions that are unsupported with the current project environment. Technically an Interop error should take precedence, making this nonexistent, but sometimes the TS compiler won't shut up, so this error is a thing.

### Invalid embedded file

`Internal__InvalidEmbedded`

If a developer references a file embedded within the binary that's indeed not embedded within the binary, this error happens.

### Lazy

`Internal__Lazy`

If we're lazy to implement a feature but want to quickly make a release for whatever reason, instead of removing references to the feature we'll show this error, indicating we were indeed lazy to implement it. As of now it's impossible (no code leads to it), but as we get bigger ideas for major releases you MIGHT get to see it once.

## External errors

Errors that depend on something external.

### Publish

`External__Publish`

When doing a release, if your package manager's publish command fails, this error code appears.

### Setting / Favorite IDE

If you changed your favorite IDE to something unsupported, then got us to attempt to launch it, this happens. You cannot directly set this setting to something invalid, you'd have to manually edit the config file - making this an "external" error.

### Project / Not found

If a project from your list isn't found (in the sense of the filepath not being found), this error happens. You cannot add a project that doesn't exist unless modifying the config file; or adding one that does exist, then moving the directory - making this an "external" error too.
