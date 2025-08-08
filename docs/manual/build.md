# Using FuckingNode: Automate builds

> `fuckingnode build <project>`, or `fkbuild <project>`

The `build` command in FuckingNode allows you to run all the commands of your project's building / compilation process (which are usually several) from a single command. It'll show progress, and halt execution if any command fails. It makes your workflow slightly faster since it's just one command that you have to run.

## Usage

To build your project, first define all the commands that should run in your `fknode.yaml` by setting the `buildCmd` key. This uses a "peculiar" notation; it's a single string where commands are separated by the `^` character:

```yaml
# imagine a 3 step build process:
# some prerelease code, then locally building your project, then deploying it
buildCmd: "node prerelease.js^npm run build^cd dist^vercel --prod"
```

The above example would result in this:

```bash
node prerelease.js
npm run build
cd dist
vercel --prod
```

Once defined, just run `build` and it'll build the project in the current working directory. You can also explicitly specify a path.

```bash
fuckingnode build # builds here
fuckingnode build ./projects/some-project # builds there
```

---

A cool thing is that you can link it to `release` (feature explained in the [next page](./release.md)), by setting `buildForRelease` to `true` in your `fknode.yaml` (see [fknode.yaml](./fknode-yaml.md#buildforrelease)). If set, these commands will auto run whenever you run the `release` command, so we automatically build your project before releasing it.

---

There's nothing more to configure. It's a relatively simple automation.

### What to expect

Progress with all commands will be printed step by step.

```bash
✔ There we go, time to build <project name here>
Running command 1/5
*output of 1st command*
Done!
Running command 2/5
*output of 2nd command*
Done!
(...)
Running command 5/5
*output of 5th command*
Done!
✅ That worked out! Your project should be built now.
```

If an error happened, it'd show it and stop execution.

And that's pretty much it.

---

You've now learnt how to speed up project builds.

Next: Release - How to speed up project releases.
