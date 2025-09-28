# Using FuckingNode: Automate quitting your career

> `fuckingnode terminate <runtime> [--remove-all-motherfuckers-too]`

If `surrender` isn't enough for you, we actually made an automation for quitting entirely too. You know how whenever you uninstall a program it usually leaves leftovers on your machine? Well, `terminate` will automatically uninstall any runtime that we support from your machine and remove leftovers, giving you both your storage back and the peace of not touching NodeJS again (unless you reinstall it, of course).

## Usage

Just run the following:

```bash
fuckingnode terminate <runtime>
```

Where `<runtime>` is either `node`, `deno`, `bun`, `go`, or `rust`.

To prevent accidental runs, this command requires confirmation, and also runs a short countdown before executing (giving you time to ++ctrl+c++ out of it).

While risky, we also added a `--remove-all-motherfuckers-too` flag (which will prompt an additional warning))which **deletes from your hard drive** any project written in said stack. This will show an additional warning and an additional countdown.

### The process

It's simple, it runs a shell script (you can view them from our repository) that tries to uninstall said runtime. For all runtimes it just runs their uninstaller, except for NodeJS which is harder to uninstall, and as such it brutely tries any known uninstall method hoping for any of it to work.

### Aliases

There are different _aliases_ that invoke the exact same command, for you to choose from depending on your mood.

There's these, that do not affect to the parameters taken.

- `fuckingnode terminate (params...)` (original)
- `fuckingnode fuck-the-lang (params...)`
- `fuckingnode ftl (params...)` (shortened from above)
- `fuckingnode fuck-the-runtime (params...)`
- `fuckingnode ftr (params...)` (shortened from above)
- `fuckingnode never-again-using (params...)`
- `fuckingnode resign (params...)`

Then there's these, which remove the need to specify the runtime to remove, taking no arguments (except for the project removal flag).

- `fuckingnode unnode` (removes node)
- `fuckingnode undeno` (removes deno)
- `fuckingnode unbun` (removes bun)
- `fuckingnode ungo` (removes go)
- `fuckingnode unrust` (removes rust)
- `fuckingnode seriously-fuck-node` (removes node)

---

You've now learnt how to ensure your JavaScript project dies properly.

Next: Audit - how to make NodeJS security audits actually understandable.
