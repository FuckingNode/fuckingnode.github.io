# Setup FuckingNode

!!! question "Don't mess terms up"
    It's not the same to _setup FuckingNode_ (here) than to use _fuckingnode setup_ (a [separate utility](setup.md) we provide)

Here we'll learn everything about setting up and configuring the CLI to your liking.

!!! tip "Pro tip"
    If you just want to learn how to quickly add a project so you can use the CLI, [skip here](#adding-a-project).

## Manager

### Adding a project

> `fuckingnode manager add <project>`, or `fkadd <project>`

_We care about user experience, and that's why we're constantly working to ensure peak performance..._ blah blah blah TL;DR: **you need to setup projects yourself so we don't consume your time and CPU looking in your entire drive for JavaScript projects** (which trust me, would've been easier for me - kind off).

There are 3 ways to add a project:

**1 /** You can add a relative or absolute path:

```bash
fuckingnode manager add "../projects/something/"
# or
fuckingnode manager add "C:\Users\sigma_boy\projects\something"
#                        ^^^^^^ (or /home/whatever in linux / mac)
```

**2 /** You can get in the root of the project and add `--self`

```bash
cd generic-js-project-name-here
fuckingnode manager add --self
```

This is our recommended way, as you can run it right after running `npm init` and you don't have to type a long folder name.

**3 /** You also can waste your time opening the config file. It's a plain text file that stores absolute paths separated by line breaks. On :fontawesome-brands-windows: Windows it lives at your local `%APPDATA%`, and on :simple-linux: Linux & :simple-apple: macOS it lives on `HOME` (or `XDG_CONFIG_HOME`). It looks kinda like this:

```txt title="fuckingnode-motherfuckers.txt" linenums="1"
C:\Users\JohnDoe\projects\Sokora
C:\Users\JohnDoe\projects\electronJS-clone
```

**Keep in mind paths must always point to the root**. If any path point to the `package.json` itself or to anything else that isn't the root of the project (the DIR that holds `package.json`), you're cooked (the entire CLI won't work).

**Once you're done with adding your projects, you can** theoretically **skip the rest of the page and get started with [using the CLI](usage.md)**. Keep reading for learning the rest about configuring the CLI.

### Removing a project

> `fuckingnode manager remove <project>`, or `fkrem <project>`

As easy as using one of the previously mentioned methods, but instead of using `add`, using `remove`.

```bash
fuckingnode manager remove "../projects/something/"
fuckingnode manager remove "C:\Users\me\projects\something"
```

However, there's one more thing. Thanks to our innovative expertise, you can use a project's _name_ (as in `package.json > "name"`):

```bash
fuckingnode manager remove flamethrower
```

The above would work as long as you have one added project with this package.json:

```json title="package.json" linenums="1"
{
    "name": "flamethrower",
    "version": "6.9.0"
    // etc...
}
```

### Listing projects

Just run `fuckingnode manager list`. It'll beautifully show you all of your projects in a `name@version path` format, like below, but with colors and cool stuff.

```bash
💡 Here are the m*therf*ckers you added so far:

sokora@0.3.0 /home/zaka/Code/Sokora
vuelto.pp.ua@v1.1.2 /home/zaka/Code/vuelto
personaplus-website@0.1.0 /home/zaka/Code/personaplus-website
personaplus@0.0.6-preapp.30 /home/zaka/Code/personaplus
@zakahacecosas/fuckingnode@3.1.1 /home/zaka/Code/FuckingNode
```

Later on we'll see how to "ignore" projects; here we'll tell you that you can pass `--ignored` to only list ignored projects, or `--alive` to only list non-ignored projects. If you try to mix both flags to create a loophole and break the matrix, you won't break anything; the flag you write first will overrule the second one.

## Settings

As most apps, we offer settings you can tweak. We use default values that should work for most people, to save you even more time - however you _might_ want to change them, **especially if you don't use Visual Studio Code**, as it's your "favorite editor" by default.

Currently supported settings are the following them. Change them with `settings change <KEY> <value>`

| KEY | Value Type | Description | Notes |
| :--- | ---: | :--- | ---: |
| `defaultIntensity` | `normal`, `hard`, `hard-only`, `maxim`, or `maxim-only` | Changes the default intensity for the `clean` command. | / |
| `updateFreq` | A fixed number | Changes how frequently (in DAYS) the CLI sends an HTTP request for updates. | We recommend setting it to a high value as we don't frequently update, so you can save up those HTTP requests. |
| `flushFreq` | A fixed number | Changes how frequently (in DAYS) the CLI removes the `.log` file to save up space. | Cannot be disabled, setting it to `0` will make it auto-flush each time. |
| `favEditor`  | `vscode`, `sublime`, `emacs`, `atom`, `vscodium`, `notepad++` | Your favorite code editor. Used by `kickstart`. | / |

### View current settings

To view your current settings, run `fuckingnode settings` with no args. You should see something like this:

```bash
💡 Your current settings are:
---
Update frequency: Each 69 days. updateFreq
Default cleaner intensity: hard. defaultIntensity
Favorite editor: vscodium. favEditor
Auto-flush log file frequency: Each 13 days. flushFreq
```

As you can see, you're shown at the end the key used to change a setting.

### Change settings

To change them, execute `fuckingnode settings change (SETTING) (VALUE)`, for example:

```bash
fuckingnode settings change default-int "hard"
fuckingnode settings change update-freq 15
```

### Additional settings commands

Settings includes an additional `flush` command, that takes a `<file>` (`logs`, `updates`, `projects`, or `all`) as an argument, removing that from F\*ckingNode's configuration. Removing `logs` is particularly recommended. Removals of `projects` and `all` are discouraged - by the way, yes, we store all logs in a `.log` file, it lives in `%APPDATA%/FuckingNode` on :fontawesome-brands-windows: Windows and `/home/USER/.config/FuckingNode` on :simple-linux: Linux & :simple-apple: macOS.

There's another settings command, `settings repair`. It simply resets settings to defaults.

---

You're now fully setup and ready to put those f*cking JavaScript projects in place!

Next: Usage - How to actually put those f*cking JavaScript projects in place?
