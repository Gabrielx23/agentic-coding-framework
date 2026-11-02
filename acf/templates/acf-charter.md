# ACF charter

## Scope

The pipeline can build a ticket that satisfies the Definition of Ready. The build runs in a sandbox under all automated checks and a blind review. The result is a clean pull request that a person can approve with high confidence.

Agents draft ubiquitous language, decision records, and C1/C2 views with evidence. People must confirm meaning and decisions, then approve merges. Drafts go through blind review.

## Models

| Role | Model | Version |
| --- | --- | --- |
| Build | [name] | [version] |
| Blind review | [name] | [version] |

Do not change the model during a ticket.
Change the model only through a controlled upgrade. See Part 0 – Key terms.

## Job catalogue

| Job | Input | Output | Autonomy level |
| --- | --- | --- | --- |
| Probe / language draft | Term or seed notes | Pull request with language entries | 1 |
| Decision record | Topic or seed notes | Pull request with ADR | 1 |
| Architecture view update | Repository and guardrails | Pull request with C1/C2 views | 1 |
| Build from spec | Ready ticket | Pull request | 1 |
| Blind review | Pull request and its guardrails | Review result | 1 |

Start each job type at autonomy level 1 (Supervised).
Increase or decrease the level only from the metrics. See Chapter 11.

<!-- Template from the Agentic Coding Framework by Gabriel Slawski (CC BY 4.0) -->
