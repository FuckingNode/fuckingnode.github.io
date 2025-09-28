---
title: "FuckingNode Committer"
description: "Safest way to 'git commit' out there. Never again push a .env to remote, never again forget to run your test suite, never again type two commands ('git add' then 'git commit') when you can type just one."
---

# Using FuckingNode: Make a commit

> `fuckingnode commit <message> [branch] [--push]`, or `fkcommit <message>`

The `commit` command in FuckingNode allows you to run maintenance tasks and any task of your liking before making a commit, and then having the commit made ONLY if these task succeed. This way you ensure you didn't forget to update dependencies before committing and avoid pushing a change that made a certain test not pass (if you chose, for example, your test runner to be the pre-commit task).

## Usage

To commit changes to your project, use the following command:

```bash
fuckingnode commit <message> <files> [--branch branch] [--push] [--keep-staged] [--yes]
```

`message` and `files` are obvious and mandatory. Anything after the message (which must be quoted) is considered a file until a `--`flag appears. All flags are optional.

Flag `--branch [branch-name]` indicates the branch to commit to. If not given, the branch you're currently on will be used. `--push` can be passed to push the commit to the remote repository. `--keep-staged` can be passed to include files you had in the stage area before running this command (if not passed, the default behavior is to unstage all files, then stage the ones you provide to the command).

### Configuring the task to be executed

As said, you can add a task (e.g., your test suite) and have it run before committing. The commit will only be made if this task succeeds (exits with code 0). Specify the task by setting the `commitCmd` key in your `fknode.yaml` to a script to be executed (see [fknode.yaml docs](fknode-yaml.md)).

```yaml
commitCmd: "test" # "npm run test" / "deno task test" / ...
```

If absent, no custom task will be executed.

### What to expect

You'll see a confirmation like this one, showing what will be made:

```txt
✅ Staged all files for commit (4).
❓ Heads up! We're about to take the following actions:

Run deno task precommit
If everything above went alright, commit 4 files to branch v4 with message "minor fixes"

- all of this at @zakahacecosas/fuckingnode@4.0.0 C:\Users\Zaka\projects\FuckingNode 

Confirm? [y/N]
```

If you input `y`, all tasks will run, and unless they fail, a commit will be made (and pushed if enabled, which would have shown up in the shown above list).

You can also run the command with the `--yes` flag to skip this - though we don't really recommend it.

---

You've now learnt how to speed up commits.

Next: Release - How to speed up npm / jsr package releases?
