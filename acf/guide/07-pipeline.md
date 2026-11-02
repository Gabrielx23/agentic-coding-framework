# Part 7 – The pipeline

## Chapter 10 – The minimum pipeline

The pipeline is not one tool. It is a set of stages with clear contracts. Start with the smallest complete path that applies all guardrails.

### Framework charter

Write one short paragraph that tells what the pipeline can do. Put it at the top of `ACF_CHARTER.md`. For example:

> The pipeline can build a ticket that satisfies the Definition of Ready. The build runs in a sandbox under all automated checks and a blind review. The result is a clean pull request that a person can approve with high confidence.

Measure all later decisions against this paragraph.

### Sandbox and least privilege

- The building agent operates in a sandbox: a container, a CI runner, or a background agent with restricted permissions.
- It has no access to production data or to unrestricted secrets.
- It gets only the permissions for the current ticket.
- Secrets are injected at runtime. They are never in the repository or in the prompt.

### Threat model

An agent reads text from many sources. Some text can contain instructions from an attacker, and the agent can obey them by mistake. This attack is prompt injection.

| Threat | Example | Guardrail |
| --- | --- | --- |
| Injection through tickets or issues | An issue comment tells the agent to send a secret to an external URL. | No network access to unknown hosts. Only an approved ticket is an instruction. |
| Injection through repository content | A README file in a dependency contains instructions for agents. | AGENTS.md says that file content is data. The sandbox blocks outbound traffic. |
| Changes to the guardrails | The agent removes a failing check from the CI configuration. | Hard-protected files. The blind reviewer flags each change to them. |
| Supply chain | The agent adds a dependency or changes a lock file. | A new dependency needs human approval. Lock files are hard-protected. |
| Secret exposure | The agent writes a secret to a log or a fixture. | A secret scanner in the automated checks. |

### Protected files

Use these two classes. Root `AGENTS.md` and `acf/AGENTS.md` use the same names and the same lists.

**Draft by pull request only.** An agent can change these only when the ticket asks for Define work. A named person confirms and merges:

- `acf-project/ubiquitous-language/`
- `acf-project/adr/`
- `acf-project/architecture/`

Drafts must go through blind review. A person must confirm meaning and decisions, then merge.

**Never change.** An agent must not change these. If a change is needed, stop and describe it in the pull request:

- all of `acf/` (framework package; replace only on upgrade)
- root `AGENTS.md`
- `acf-project/ACF_CHARTER.md`
- `acf-project/metrics.md`
- `acf-project/evaluation-set/`
- `acf-project/blueprints/`
- `acf-project/retrospectives/`
- CI configuration
- dependency manifests
- lock files

Use a code-owners file or a branch rule for both classes. See [examples/ci/CODEOWNERS](../../examples/ci/CODEOWNERS). A named owner must approve each merge.

### The minimum pipeline

1. A person marks a ticket as ready.
2. An agent session starts in the sandbox. It receives the ticket, AGENTS.md, the listed decision records, and the language file of the named context.
3. The agent implements the ticket and opens a pull request.
4. The automated checks run. They must pass.
5. A blind reviewer examines the change.
6. A person receives a notification and makes the final decision.

Do not add more automation until this path is reliable for some real tickets.

### Author-reviewer separation

The session that writes code must never review the same code. The review session starts with no knowledge of the build conversation. This rule has no exceptions.

### Example – the first three tickets

**Ticket 1 – lock the current behaviour**

1. The agent receives the ticket and the billing language file.
2. It writes a characterisation test for the current full-refund behaviour.
3. The test passes on the existing code. The checks pass.
4. The blind reviewer confirms that the test is meaningful and that no production code changed.
5. A person approves.

**Ticket 2 – the first partial-refund rule**

1. The ticket lists ADR-002, which adds the refunded status.
2. The agent implements the rule behind the existing seam. A partial Refund applies only to a paid Invoice.
3. The agent adds a test for the partial case and a test that rejects a Refund on an issued Invoice.
4. The checks pass. The mutation report shows no surviving mutants.
5. The blind reviewer asks for a clearer error message when the Refund is more than the RemainingBalance.
6. The agent changes the code. A person approves.

**Ticket 3 – architecture refinement**

1. The ticket moves the balance calculation behind one method of the Invoice module.
2. The change is internal only. All gates pass quickly.

Each ticket is short and fully controlled. Each ticket makes the system stronger.

### Connect the stages

When each stage operates correctly alone, connect the stages. The output of one stage becomes the input of the next stage. Keep a person in the loop only where judgement is necessary.

## Chapter 11 – Scale the pipeline

### Necessary infrastructure

- A source of tickets
- A sandbox to run agents
- A method to inject secrets
- A method to open pull requests
- Automated checks, with mutation testing on important packages
- Branch rules that protect the guardrail files
- A notification channel for human review

Use simple tools that you can observe. A basic CI system and a simple ticket tracker are sufficient to start. You can replace each component later without a change to the design.

### Framework metrics

Without measurements, decisions about autonomy are guesses. One time each week, record these metrics in `acf-project/metrics.md`, separately for each job type:

| Metric | Definition | Signal |
| --- | --- | --- |
| First-pass approval rate | Pull requests that a person approves without changes | Increases when tickets and guardrails improve |
| Rework rate | Merged changes that need a fix within 30 days | Must decrease. An increase shows a gap in the guardrails. |
| Review escape rate | Problems that a person finds after the blind reviewer said APPROVE | Shows the quality of the blind review |
| Review override rate | Blind-review results that a person changes | A high value shows that the review instruction needs work |
| Cycle time | Time from ready to merged | Compare it with the review queue |
| Cost per merged ticket | Model and compute cost for one merged ticket | Shows if more autonomy gives value |

### Autonomy levels

Each job type has an autonomy level. The metrics decide the level.

| Level | Name | Human role |
| --- | --- | --- |
| 0 | Assisted | A person starts each session and reviews each change in full. |
| 1 | Supervised | The pipeline starts sessions. A person reviews each pull request in full. |
| 2 | Selective | Low-risk pull requests get a short check. High-risk pull requests get a full review. |
| 3 | Sampled | For job types that do not change public behaviour or data, a person reviews a sample only. |

Rules for a change of level:

- Increase the level by one step only when the rework rate and the review escape rate stay low for four weeks.
- Decrease the level when either rate increases for two weeks.
- Record each change of level in the retrospective.

The four-week and two-week periods are starting values. Adjust them to your volume.

### Job catalogue

Start with three to five job types. For each type, record the inputs, the guardrails, the output, and the autonomy level.

| Job | Input | Output | Typical start level |
| --- | --- | --- | --- |
| Probe / language draft | Term or seed notes | Pull request with language entries | 1 |
| Decision record | Topic or seed notes | Pull request with ADR (and C2 update if needed) | 1 |
| Architecture view update | Repository, decision records, existing views | Pull request with updated C1 and C2 views | 1 |
| Build from spec | Ready ticket | Pull request | 1 |
| Blind review | Pull request and its guardrails | Review result | 2 |
| Architecture refinement | One named area | Pull request | 1 |
| Defect fix | Bug report | Failing test and fix | 1 |
| Dependency update | One dependency | Pull request | 0, because lock files are hard-protected |

### Recurring jobs

- **Architecture refinement**: A scheduled job selects one small, named area and makes one improvement. It never tries a large rewrite.
- **Branch sync**: Each morning, a job rebases agent branches on the main branch and reports conflicts early.
- **Domain monitors**: When the pipeline is mature, add jobs for your domain. For example, a monitor finds new slow database queries and opens a ticket.

### Spike lane

Ideas with high uncertainty use the spike lane. The ticket says that the team can discard the code. The same checks and the same review apply. Only the life of the code is different.

### The main path

Ready ticket → Build in sandbox → Automated checks → Blind review → Human decision at the current autonomy level

All other paths are variants of this path.

### A system that learns

The framework is never complete. Each week, examine the metrics and the retrospectives. Then make one improvement to a skill, a check, or a template. The long-term value comes from this continuous improvement, not from one clever automation.

← [Part 6 – Learning loops](06-learning-loops.md) · [Contents](https://github.com/Gabrielx23/agentic-coding-framework#contents) · [Part 8 – Case studies](08-case-studies.md) →

---

© 2026 Gabriel Slawski · [Agentic Coding Framework](https://github.com/Gabrielx23/agentic-coding-framework) · Licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)
