# ADR-001: Aggregate boundaries

## Status
Accepted

## Context
We need clear consistency boundaries from the first commit.
Evidence: person: Tech lead (example)

## Decision
Subscription and Plan are separate aggregates.
A Subscription refers to a Plan by its identifier only.
Evidence: person: Tech lead (example)

## Alternatives rejected
- One aggregate for both: every Plan change locks all Subscriptions.

## Consequences
Each aggregate has its own directory and public interface.

## Approver
Tech lead (example)
