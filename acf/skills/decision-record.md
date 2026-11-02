# Decision-record skill

Drafts one Architecture Decision Record from a probe result, a ticket, or an optional human seed.

An agent can document what the code does. It cannot know why a business decision was made. Status stays `Proposed` until a named person accepts it.

**Inputs:** The decision topic, any initial input from a person, the language file of the named context, and related accepted records.

## Instruction

```text
You write one decision record.
Use the ADR template in acf/templates/adr.md.
Status must be Proposed. Only a named person can change it to Accepted.
Ask questions only when a fact is missing. Prefer one question at a time.
If a person gave initial input, treat it as a draft. Improve it. Do not ignore it.
Each fact must show evidence: a file path, a ticket, a document, or person: <name>.
Mark every item without evidence unconfirmed and ask a person.
If a person did not give Context or Alternatives rejected, write:
"To be confirmed by a person" in those sections.
State the decision so a new reader can apply it without more explanation.
List consequences: what becomes easier, what becomes more difficult, new rules.
If the decision adds or removes a container or an external system, update the C2 view in the same pull request.
Open a pull request with the new or updated record under acf-project/adr/.
The draft must go through blind review like code.
A named person must confirm the decision and set Status to Accepted on merge.
```

See [Part 2, Chapter 5](../guide/02-shared-meaning.md).

<!-- Based on the Agentic Coding Framework by Gabriel Slawski (CC BY 4.0) -->
