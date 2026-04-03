---
title: "FuckingNode Terminator"
description: "Resign with ease."
---

# Using FuckingNode: Automate quitting your career

> `fkn terminate <runtime> [--remove-all-motherfuckers-too]`

If `surrender` isn't enough for you, we actually made an automation for quitting entirely too. You know how whenever you uninstall a program it usually leaves leftovers on your machine? Well, `terminate` will automatically uninstall any runtime that we support from your machine and remove leftovers, giving you both your storage back and the peace of not touching NodeJS again (unless you reinstall it, of course).

## Usage

Just run the following:

```bash
fkn terminate <runtime>
```

Where `<runtime>` is either `node`, `deno`, `bun`, `go`, or `rust`.

To prevent accidental runs, this command requires confirmation, and also runs a short countdown before executing (giving you time to ++ctrl+c++ out of it).

While risky, we also added a `--remove-all-motherfuckers-too` flag (which will prompt an additional warning) which **deletes from your hard drive** any project written in said stack. This will show an additional warning and an additional countdown.

### The process

It's simple, it runs a shell script (you can view them from our repository) that tries to uninstall said runtime. For all runtimes it just runs their uninstaller, except for NodeJS which is harder to uninstall, and as such it brutely tries any known uninstall method hoping for any of it to work.

### Aliases

There are different _aliases_ that invoke the exact same command, for you to choose from depending on your mood.

There's these, that do not affect to the parameters taken.

- `fkn terminate (params...)` (original)
- `fkn fuck-the-lang (params...)`
- `fkn ftl (params...)` (shortened from above)
- `fkn fuck-the-runtime (params...)`
- `fkn ftr (params...)` (shortened from above)
- `fkn never-again-using (params...)`
- `fkn resign (params...)`

Then there's these, which remove the need to specify the runtime to remove, taking no arguments (except for the project removal flag).

- `fkn unnode` (removes node)
- `fkn undeno` (removes deno)
- `fkn unbun` (removes bun)
- `fkn ungo` (removes go)
- `fkn unrust` (removes rust)
- `fkn seriously-fuck-node` (removes node)

---

You've now learnt how to ensure your JavaScript developer career dies properly.

Next: Audit - how to make security audits actually understandable.
