---
title: "FuckingNode Uncommitter"
description: "Made a fucked up commit? Easily undo it."
---

# Using FuckingNode: Unmake a commit

> `fuckingnode uncommit`, or `fkuncommit`

The `uncommit` command in FuckingNode allows you to quickly remake a commit. It automatically undoes the last local commit (storing its name), then hangs for you to modify its files as needed, and once you tell it to run, it re-runs `commit` (including `commitCmd` if any) and remakes the commit with the same message.

## Usage

To uncommit changes to your project, just run this from the root of the repo:

```bash
fuckingnode uncommit
```

### What to expect

You'll see a confirmation like this one, showing what will be made:

```txt
❓ We will unstage all currently staged files (if any), and immediately undo commit 39a6d31.
If you terminate the program you won't recover it, it's us who handle remaking it. Proceed?
Confirm? [y/N]
```

If you input `y`, the commit will be unmade and you'll see this:

```txt
Undid commit 39a6d31 (some wrong commit, by ZakaHaceCosas at Sun Sep 28 15:30:47 2025 +0200)

Make any modifications to the existing files now.
Use regular git commands (git add / git remove) from a separate terminal to stage/unstage files.
Once done, come to this terminal and hit 'Y',
    we'll run your commitCmd (if any) and re-make the commit with the same message and files (unless changed) as before.
You may hit 'n' as well, result will be the same.

waiting for you to hit 'Y' [y/N] 
```

After hitting `y` (or `n`), our [commit command](commit.md) will immediately run and your commit will be remade (unless a `commitCmd` exists and fails, of course).

---

You've now learnt how to speed up fixing fucked up commits.

Next: Release - How to speed up npm / jsr package releases?
