---
title: "FuckingNode Stater"
description: "Have a quick look at a project’s state from anywhere."
---

# Using FuckingNode: Check state of a project

> `fkn state [...projects]`

The `state` command is a tiny utility to check state at any time.

For now, state is simply defined as the result of `git status`. *However*, I plan to add more stuff (like checking outdated dependencies, other likely useful stuff, and also allowing to define custom things to check for via `fknode.yaml`)

You can pass one or more project names/paths to get a *detailed* view of all specified projects, or leave it empty for a *short* view of all projects from your list.

## Usage

Run the command alone to check all projects.

```bash
fkn state
```

You’ll get each project printed out with its git status in two lines and the project itself described in another two lines.

If you provide one or more projects explicitly, e.g. like this:

```bash
fkn state project-foo ~/Projects/Bar
```

You’ll get extra lines showing a summary of each type of Git file status. This is, amount of modified/added/removed/untracked files, using the same key characters as `git status --porcelain`.

---

You've now learnt how to glance at some project’s state.

Next: Stats - (can't think of a description for this one).
