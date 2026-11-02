# Part 6 – Learning loops

## Chapter 9 – Make types of error impossible

The Learn stage of the ACF cycle changes errors into rules. When the same type of mistake occurs again, add an automated rule that makes it fail the checks. After some weeks, full types of error become impossible.

### Escalation of a repeated mistake

| Occurrence | Action |
| --- | --- |
| First | Correct it in the review. |
| Second | Add a text rule to AGENTS.md. |
| Third | Write a custom lint rule or a detection script. Add it to the checks. Remove the text rule. |

Each automated rule is a quality lock. After it is in the checks, the codebase cannot go back on that rule without a visible failure. Delete each text rule that no tool and no reviewer enforces.

### Minimum automated checks

1. Type check or static analysis
2. Tests
3. Linter
4. Formatter
5. Mutation testing on the changed code, for packages that have it
6. Secret scanner

Measure the time from push to complete results. If it is more than some minutes, run the jobs in parallel and add a cache. Slow feedback stops the pipeline.

### Mutation testing

Mutation testing changes the production code on purpose and makes sure that the tests fail. If the tests still pass, they do not protect the behaviour. Start on the most important packages. Run it only on changed code, so that it stays fast. The blind reviewer reads the report (Chapter 7).

### Fixtures and contracts

Test fixtures and interface contracts are part of the guardrails. Agents need stable and realistic data. Unreliable fixtures produce unreliable agents.

### Defect protocol

For each bug, do these steps in this sequence:

1. Reproduce the bug with a minimum example.
2. Write a test that fails because of the bug.
3. Fix the bug.
4. Make sure that the test passes.
5. Send the change through all three verification gates.

This protocol prevents fixes that only hide a symptom.

### Frontend verification

Agents can examine screenshots. A screenshot check is a useful fast signal, but it is not a reliable gate, because the result can change between runs. Use deterministic gates:

- Component tests for logic
- End-to-end tests for important user paths
- Visual regression tests that compare images pixel by pixel
- Explicit contracts between frontend and backend

← [Part 5 – Code shape](05-code-shape.md) · [Contents](https://github.com/Gabrielx23/agentic-coding-framework#contents) · [Part 7 – The pipeline](07-pipeline.md) →

---

© 2026 Gabriel Slawski · [Agentic Coding Framework](https://github.com/Gabrielx23/agentic-coding-framework) · Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
