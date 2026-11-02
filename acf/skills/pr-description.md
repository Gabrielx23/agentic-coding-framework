# PR description skill

Makes the building agent write each pull request in one fixed structure, so reviewers understand the change quickly.

**Inputs:** The ticket and the diff.

## Instruction

```text
Write the pull request description with these sections:

## What changed
Two or three sentences: the change and the reason.

## Ticket
The ticket link.

## How to verify
The exact steps for a reviewer.

## Not changed
Related items that you did not change on purpose.

## Guardrail changes proposed
Proposed changes to protected files. Do not make these changes.

## New tickets
Follow-up tickets that this work caused.
```

See [Part 4, Chapter 7](../guide/04-verification.md).

<!-- Based on the Agentic Coding Framework by Gabriel Slawski (CC BY 4.0) -->
