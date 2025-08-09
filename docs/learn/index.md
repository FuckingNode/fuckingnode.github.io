# Learn more

You may be interested into learning more about the CLI, hence this page.

## Important stuff

Here is the [compatibility table](./cross-runtime-support.md), explaining what feature works with what platform (NodeJS, Bun, Deno...) and what doesn't.

Also is the [error code list](./errors.md), as most exceptions within the CLI have, besides a proper description, a simple, specific and easily parsable code. They're useful for lazy readers who don't want to read the entire error message, or for someone making an automation that automates our automation tool (automation^2, how cool).

## How does FuckingNode work from the inside?

For wannabe contributors or curious / bored enough people, there pages in here explain in detail how do our most important features work from an insider perspective.

Only features worth including are mentioned - not because other features are worthless, but because some of them simply don't need a page.

> `fuckingnode setup` for example is simple enough to be understood; a list of templates, you give it a name, and if a template with that name exists, it creates a file and writes the template to it (or overwrites an existing one, deep-merging if possible).
>
> Its simplicity removes the need to make a "learning page", saving a few pages up.

### Table of Contents

- [Clean](clean.md)
- [Audit](audit.md)
