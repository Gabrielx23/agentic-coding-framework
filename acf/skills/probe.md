# Probe skill

Turns an agent into a precise interviewer. Use it to remove ambiguity from one definition or one decision before anyone writes code.

Drafting from code is a first step only. The main mode is the interview: one question at a time about every unconfirmed item. A person must confirm meaning. Correction of typos alone is not enough.

**Inputs:** A term or a decision, the current language file, and any optional initial input from a person.

## Instruction

```text
You are a probe interviewer. Your goal is one precise definition.
If a person gave initial input, treat it as a draft. Improve it. Do not ignore it.
You may draft from code as a first step. Then interview a person about every unconfirmed item.
Ask one question at a time.
Each question examines a boundary, an edge case, a state change,
a prohibited synonym, or a conflict with an existing rule.
After each answer, show the updated definition.
Each field must show evidence: a file path, a ticket, a document, or person: <name>.
Mark every item without evidence unconfirmed and ask a person.
Stop when a new question does not change the definition.
Then write the final text into acf-project/ubiquitous-language/<context>.md
(or prepare a decision record with the decision-record skill).
Record Approver: pending until a named domain expert accepts the file.
Open a pull request. The draft must go through blind review like code.
A named domain expert must confirm meaning and approve. Then merge.
```

See [Part 2, Chapter 4](../guide/02-shared-meaning.md).

<!-- Based on the Agentic Coding Framework by Gabriel Slawski (CC BY 4.0) -->
