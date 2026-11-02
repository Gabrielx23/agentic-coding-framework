# Part 5 – Code shape

## Chapter 8 – Code that agents can change safely

The shape of the codebase is also a guardrail. Agents make fewer errors in a codebase with deep modules and clear boundaries.

A deep module supplies much behaviour through a small and simple interface. A shallow module makes the caller understand almost all of its internal complexity. An agent that uses a shallow module must keep many details in its context. Thus, it makes more errors.

### Find shallow modules

1. Open one package or service.
2. For each public type or function, ask two questions:
   - Is the interface much simpler than the implementation?
   - Must the caller know internal details to use it correctly?
3. Record the modules that fail. Refine these modules first.

### Seams and adapters

When behaviour in existing code must change, add a seam: an interface or a strategy. Do not edit the old code in many locations. The agent then implements the new behaviour behind the seam. The risk of damage to other code decreases.

### Make legacy code safe to change

1. Add characterisation tests that lock the current behaviour.
2. Add interfaces for hard dependencies, for example the database or an external service.
3. Let the agent change the production code only after steps 1 and 2.

### Enforce module boundaries

Configure the language tools, so that an illegal dependency fails the automated checks:

| Language | Method |
| --- | --- |
| TypeScript | Project references and a boundary linter |
| PHP | Namespaces and static-analysis rules |
| Go | The internal-package convention and a linter that obeys it |

When a tool enforces a boundary, agents stop to cross it.

### Architecture refinement skill

This skill makes one small improvement in one named area:

- Deepen one shallow module, or
- Add one missing seam, or
- Remove one circular dependency.

The skill must obey the existing decision records and language files. It must add tests for new behaviour. A large refactor is never one open task. It needs a blueprint, like a feature.

← [Part 4 – Verification](04-verification.md) · [Contents](https://github.com/Gabrielx23/agentic-coding-framework#contents) · [Part 6 – Learning loops](06-learning-loops.md) →

---

© 2026 Gabriel Slawski · [Agentic Coding Framework](https://github.com/Gabrielx23/agentic-coding-framework) · Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
