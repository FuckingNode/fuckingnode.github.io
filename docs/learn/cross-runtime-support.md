# Cross-runtime compatibility

> `fuckingnode compat [item]`

!!! note "What we mean by _Cross-runtime_"
    While we always use the term "cross-runtime", we also include _cross-platform_ (Golang and Rust) support inside of that term.

While FuckingNode can be a very powerful automation tool if properly used, in the end it's just an executable that _automates_ tasks; it doesn't do much on its own. Thus, **features that aren't supported by a runtime itself, won't work with us**. (Adding "polyfills" or "glue fixes" is not discarded as an idea, but not planned short-term anyway).

You can run `compat` anytime from the CLI to see a table showing what works and what doesn't. **NodeJS is the only environment with 100% platform support.** As of version 3.3.1, that table looks like this:

| Feature    | NodeJS | Deno     | Bun      | Go       | Cargo    |
|------------|--------|----------|----------|----------|----------|
| Cleanup    | Yes    | Partial  | Partial  | Partial  | Partial  |
| Kickstart  | Yes    | Yes      | Yes      | Yes      | Yes      |
| Commit     | Yes    | Yes      | Yes      | Partial  | Partial  |
| Release    | npm    | jsr      | npm      | No       | No       |
| Stats      | Yes    | Yes      | Yes      | Partial  | Yes      |
| Surrender  | Yes    | Yes      | Yes      | Yes      | Yes      |
| Setup      | Yes    | Yes      | Yes      | Yes      | Yes      |
| Audit      | Yes    | No       | No       | No       | No       |
| Launch     | Yes    | Yes      | Yes      | Yes      | Yes      |

Reasons for not supporting a feature are the following.

## Partial Deno, Bun, Cargo & Go support for cleanup

In both runtimes, the kind of cleanup commands we'd use (`prune`, `dedupe`...) aren't available, so the _cleanup itself_ isn't available. `clean` will still work with them, as linting, prettification, or updates may work. Run `fuckingnode compat cleaner`.

## No Deno support for hard cleanup

FuckingNode itself is written in Deno, thus we're disallowed by the runtime from cleaning its cache. While a "gluefix" exists, it doesn't work most of the time.

## No Cargo & Go support for release

We might add them in the future, for now they're not supported because they're harder to implement (as more steps are required).

## Partial Cargo & Go support for commit

`commitCmd` is not supported by these platforms. This is because Cargo and Go don't have "JS-like `run`" tasks.

## Partial Go support for stats

Golang _do_ support it but doesn't support the Recommended Community Standards part. `go.mod` doesn't have any field that can be compared to anything. No module name, no author, no license, etc...

## No Cargo & Go support for migrate

There's a single package manager for these platforms, `migrate` is useless.

## No audit support anywhere non NodeJS

Deno and Bun do not offer an `audit` command, neither do Go nor Cargo.
