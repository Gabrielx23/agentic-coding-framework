# Architecture view skill

Drafts or updates the C1 and C2 views (C4 model by Simon Brown) of the system that the agents change.

An agent drafts from code and optional seed notes. A person must confirm unconfirmed elements. Correction of labels alone is not enough when meaning is wrong.

**Inputs:** The repository, deployment files, decision records, language files, existing views, and any optional initial input from a person.

## Instruction

```text
You write C4 architecture views: one C1 view and one C2 view.
Inputs: the repository, the deployment files, the decision records,
the language files, the existing views (if any), and any initial input from a person.
If a person gave initial input, treat it as a draft. Improve it. Do not ignore it.
Write each view as C4 Mermaid text under acf-project/architecture/.
For each element and relation, give the evidence: a file path, a ticket, a document, a decision record, or person: <name>.
If you have no evidence, mark the element unconfirmed and ask a question.
Do not guess a technology. Write "?".
Use a maximum of 20 elements in one view.
Write each relation as a verb phrase with its technology.
If views exist, list each difference between the existing views and the code.
Open a pull request. The draft must go through blind review like code.
A person must confirm unconfirmed elements, then merge.
```

See [Part 2, Chapter 5](../guide/02-shared-meaning.md).

<!-- Based on the Agentic Coding Framework by Gabriel Slawski (CC BY 4.0) -->
