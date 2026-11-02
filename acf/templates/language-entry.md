# Language entry template

Save entries in `acf-project/ubiquitous-language/<context>.md`. One file for each bounded context.

At the top of each language file, record:

```markdown
# <context> ubiquitous language

Approver: pending | <name>
Last confirmed: <date>
```

Each term:

```markdown
## TermName

Definition: one sentence.
Rules and states: the exact rules that apply.
Not to be confused with: related terms.
Prohibited synonyms: words that must not replace this term.
Evidence: <file path | ticket | document | person: name>
Status: confirmed | unconfirmed
```

Mark every item without evidence `unconfirmed`. A named domain expert must approve the file before agents treat terms as accepted.

See [Part 2, Chapter 3](../guide/02-shared-meaning.md).

---

Part of the [Agentic Coding Framework](https://github.com/Gabrielx23/agentic-coding-framework) · © 2026 Gabriel Slawski · [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
