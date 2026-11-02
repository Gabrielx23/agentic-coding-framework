# Build-from-spec skill

Changes a ready ticket into an implementation for review.

**Inputs:** A ticket that satisfies the Definition of Ready, root AGENTS.md and `acf/AGENTS.md`, the listed decision records and domain terms, the language file of the named context, and the C2 view.

## Instruction

```text
You implement one ready ticket.
Implement only the ticket. Do not change items in "Out of scope".
Use only the listed domain terms for business concepts.
Obey all listed decision records.
If you need a decision record that the ticket does not list, stop. Ask.
Put the change only in the containers that the ticket lists.
Write tests for each item in the Definition of Done.
If information is missing, stop. Ask the ticket owner. Do not invent a rule.

Protected files — Draft by pull request only (Define tickets only):
acf-project/ubiquitous-language/, acf-project/adr/, acf-project/architecture/.

Protected files — Never change:
all of acf/, root AGENTS.md, acf-project/ACF_CHARTER.md, acf-project/metrics.md,
acf-project/evaluation-set/, acf-project/blueprints/, acf-project/retrospectives/,
CI configuration, dependency manifests, lock files.
If a Never-change file needs a change, stop. Describe it in the pull request description.

When all checks pass, open a pull request with the PR description skill.
```

See [Part 7, Chapter 10](../guide/07-pipeline.md).

<!-- Based on the Agentic Coding Framework by Gabriel Slawski (CC BY 4.0) -->
