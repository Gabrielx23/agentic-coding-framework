# Part 4 – Verification

## Chapter 7 – Three verification gates

Each change goes through three gates. Each gate finds a different type of problem.

| Gate | Type | Finds | Must be |
| --- | --- | --- | --- |
| 1. Automated checks | Deterministic | Type errors, failed tests, lint violations, format problems, weak tests | Fast, on each change |
| 2. Blind review | Agent judgement | Ticket drift, wrong terms, decision-record violations, missing edge cases | Independent of the author |
| 3. Human approval | Human judgement | Design quality, product fit, risk | Selective, but always for public behaviour and data integrity |

When gates 1 and 2 become stronger, gate 3 can become more selective. Gate 3 never stops for changes to public behaviour or data integrity.

### Gate 2: blind review

A blind reviewer is a separate agent session. It did not see the conversation that produced the code. It receives only the ticket, the listed domain terms and decision records, the diff, and the mutation-testing report.

A new session removes the bias of the build conversation. It does not remove the bias of the model. A model that reviews code from the same model has the same blind spots. Use one or more of these methods to make the review independent:

- Use a different model family for review.
- Use an adversarial instruction: the reviewer must find a real problem or explain why there is none.
- For high-risk changes, use two reviewers with different models. If they do not agree, the result is NEEDS HUMAN REVIEW.

Record the reviewer model and version in the framework charter.

### PR description skill

The building agent writes each pull request in this structure:

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

### Blind review skill

```text
You are a blind reviewer.
You did not see the conversation that produced this code.
Inputs: ticket, listed domain terms, listed decision records, diff, mutation report.
Assume that the diff contains at least one problem. Find it, or explain why there is none.

Answer each question with YES or NO and one reason:
1. Does the diff do exactly what the ticket says, and nothing more?
2. Does the diff use only the listed domain terms for business concepts?
3. Does the diff obey all listed decision records?
4. Does the mutation report show surviving mutants in the changed code?
5. Does the diff cross a module boundary, or add a container or external system that the C2 view does not show?
6. Is the error handling the same as in the nearby code?
7. Is an obvious edge case missing?
8. Does the diff change a protected file?

If question 8 is YES, the result must be NEEDS HUMAN REVIEW.
Result: APPROVE | REQUEST CHANGES | NEEDS HUMAN REVIEW.
```

A language model cannot reliably tell if a test fails when behaviour breaks. Mutation testing answers this question with data (Chapter 9). Thus, the pipeline runs mutation testing before the blind review, and the reviewer reads the report.

### Calibrate the blind reviewer

1. Keep a small set of diffs with known defects.
2. Run the blind reviewer on the set.
3. Compare its findings with the known defects.
4. Change the instruction until it finds the defects that are important to you.
5. Do steps 2 to 4 again after each change to the instruction or to the reviewer model.

### Gate 3: protect the human reviewer

When the build becomes fast, the human reviewer becomes the bottleneck. A tired reviewer approves without a careful check. Then gate 3 stops to operate, and nobody sees the failure.

Set a maximum review load for each person each day. A good start is 8 pull requests. Measure and adjust.

When the review queue is full, the pipeline does not start new tickets.

Send NEEDS HUMAN REVIEW results and high-risk changes to a full review. Other changes get a short check.

One time each week, a second person reviews one approved pull request in full detail. Record each problem that the first review did not find.

### Run retrospective

After each important run, answer five questions in writing:

1. What did the agent do correctly?
2. Where was the output bad or incorrect?
3. Which one change to a skill, a check, or a template prevents this problem?
4. Do the framework metrics (Chapter 11) support more or less autonomy for this type of job?
5. Did a new type of error occur? If yes, add the ticket to the evaluation set.

Apply at least one improvement before the next run.

← [Part 3 – Blueprints](03-blueprints.md) · [Contents](https://github.com/Gabrielx23/agentic-coding-framework#contents) · [Part 5 – Code shape](05-code-shape.md) →

---

© 2026 Gabriel Slawski · [Agentic Coding Framework](https://github.com/Gabrielx23/agentic-coding-framework) · Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
