# Part 3 – Blueprints

## Chapter 6 – Plan work that is larger than one session

An agent session has a limited context window. During a long session, intermediate files and conversation history fill the window. The agent loses the full picture, and errors increase. These errors are also more difficult to find in a large diff.

Thus, the framework never gives large work to one session. A blueprint divides the work first.

### The blueprint

A blueprint is a short Markdown document with five sections:

| Section | Content |
| --- | --- |
| Scope: goal | One paragraph about the necessary end state |
| Scope: current state | What exists now, including known defects |
| Work packages | The 4 to 8 parts of the work |
| Dependencies | The packages that must be complete before other packages can start |
| Risk list | The parts that are not clear or that are technically dangerous, and how to remove each risk |

Template:

```markdown
# Blueprint: [Feature name]

## Scope
### Goal
[One paragraph]
### Current state
[What exists now]

## Work packages
1. …
2. …

## Dependencies
- Package 3 needs packages 1 and 2.

## Risk list
| Risk | Type | Removal |
| --- | --- | --- |
| … | unclear rule / technical unknown | probe ticket / spike ticket |
```

### Blueprint sequence

1. Write the scope.
2. Divide the work into packages.
3. Write the risk list.
4. Remove each risk with a probe ticket (unclear rule) or a spike ticket (technical unknown).
5. Write build tickets only after all risks are removed.

### Example – partial refunds

**Goal:** A paid Invoice can receive one or more partial Refunds. The system records each Refund as a domain object. When the RemainingBalance is zero, the Invoice changes to refunded.

**Current state:** Only full refunds exist. A Refund always equals the Invoice total. After a full refund, the status stays paid. This is a defect in the current model.

**Work packages:**

1. Add PartialRefund and its rules to the domain model.
2. Add the refunded status and the RemainingBalance to the Invoice aggregate.
3. Change the payment-provider integration to accept partial amounts.
4. Add the API endpoints and the authorisation rules.
5. Update the report queries that expect full refunds only.

**Risk list:**

| Risk | Type | Removal |
| --- | --- | --- |
| The payment provider can have undocumented limits on partial refunds. | Technical unknown | Spike ticket |
| The new refunded status changes an accepted decision record. | Unclear rule | Probe ticket and a new record |
| Reports can fail with the new status. | Unclear scope | Examine the queries. Decide if they change in the same release. |

### Ticket types

| Type | Purpose | Result | Production code |
| --- | --- | --- | --- |
| Probe ticket | Remove ambiguity | Language entry, decision record, or exact rules | No |
| Spike ticket | Remove a technical unknown | Data and a recommendation | Can be discarded |
| Build ticket | Implement one small change | A pull request | Yes |

### Who writes tickets

When the build is fast, the quality of the tickets controls the quality of the result. Thus:

- An agent can write a draft ticket from a blueprint.
- A person must approve each ticket before it is ready.
- The person who approves the ticket is its owner. The owner answers questions from the agent and the reviewer.

### Definition of Ready

The pipeline starts a ticket only when all conditions are true:

- The ticket names one bounded context and its language file.
- The ticket lists the applicable decision records, domain terms, and containers.
- The goal has a maximum of two sentences.
- A test or a reviewer can confirm each item in the Definition of Done.
- The ticket has an "Out of scope" section and a test plan.
- No open risk from the blueprint applies to the ticket.
- A person approved the ticket.

### Context budget

Each session receives guardrail text: rules, domain terms, and decision records. As the project grows, this text becomes large. Too much text decreases the quality of the work and increases the cost.

Thus, each ticket lists only the records and terms that apply. The agent receives AGENTS.md, the listed records, the language file of the named context, and the C2 view. The blind reviewer receives the same set.

If an agent needs a record that the ticket does not list, it must stop and ask. This stop shows that the ticket is not complete.

### Build ticket template

```markdown
## [Short title]

### Context
Blueprint: [link]
Bounded context: [name] (acf-project/ubiquitous-language/[name].md)

### Guardrails
- Decision records: ADR-002, ADR-004
- Domain terms: Invoice, Refund, RemainingBalance
- Containers (C2): Billing API

### Goal
One or two sentences.

### Definition of Done
- [ ] Observable result 1
- [ ] Observable result 2
- [ ] All checks pass

### Constraints
- Do not change public API X.

### Out of scope
- Performance optimisation

### Test plan
The tests that must exist or that you must add.

### Owner
[Name]
```

A precise Definition of Done gives the agent less space to go away from the goal.

### Select a method

| Condition | Method |
| --- | --- |
| The change fits in one session, and the risk is low. | Write one build ticket. |
| One concept or rule is not clear. | Do a probe session. |
| The work is larger than one session, or it contains unknowns. | Write a blueprint. |

← [Part 2 – Shared meaning](02-shared-meaning.md) · [Contents](https://github.com/Gabrielx23/agentic-coding-framework#contents) · [Part 4 – Verification](04-verification.md) →

---

© 2026 Gabriel Slawski · [Agentic Coding Framework](https://github.com/Gabrielx23/agentic-coding-framework) · Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
