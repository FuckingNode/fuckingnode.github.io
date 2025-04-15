# Using FuckingNode: Audit a project

> `fuckingnode audit [project-name]`

The `audit` command is a command that automatically runs a security audit for a project you specify (or for all projects if no name is specified), and interrogates security vulnerabilities (if any) to determine if they're worth fixing.

## Usage

Run the command alone to audit all added projects one by one, or specify a project root path / name to audit that project individually.

```bash
fkn audit [project-name]
```

What we'll do is run your package manager's `audit` command, and if any vulnerability exists, we'll analyze it to prompt you with some generic questions - e.g. "does this project use _x_ feature?".

The whole purpose of this command is to find out if vulnerable dependencies are worth fixing or not, as sometimes a breaking-changes update might not be necessary. For example, if a certain package has a vulnerability related to cookies and your project is a simple RNative app that does not use cookies, it's considered _not worth fixing_.

### The audit process

A sample audit would look like this:

```txt
===     FOUND VULNERABILITIES (001)     ===

GHSA-XXXX-XXXX-XXXX

=== STARTING F*CKINGNODE SECURITY AUDIT ===

Does your app use {x} feature? [V:XXX] [y/N]
```

The question prompted will vary on the identified "vulnerability vector" (denoted by the `[V:XXX]` code). Depending on your responses, we'll show different questions. Then we'll compute a percentage and show it to you, where 0% means _not worth fixing_ and 100% means _absolutely needs fixing_. This percentage, which we call Risk Factor, is computed using a basic scoring system and a bit of math.

We made a research paper-like page [here](../learn/audit.md) explaining in detail how this works.

---

You've now learnt everything about F\*ckingNode.
