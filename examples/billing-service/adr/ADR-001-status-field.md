# ADR-001: Explicit status on Invoice

## Status
Accepted

## Context
The code calculates the status from payment flags and void flags. This is slow and causes errors.
Evidence: person: Tech lead (example)

## Decision
Invoice has an explicit status field: draft, issued, paid, void.
All status changes go through one function.
Evidence: person: Tech lead (example)

## Alternatives rejected
- Keep the calculated status: the errors continue.

## Consequences
Queries become simple. Remove the calculation code over time.

## Approver
Tech lead (example)
