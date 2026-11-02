# Architecture refinement skill

Makes one small, safe structural improvement in one named area.

**Inputs:** The area, the goal (deepen one module, add one seam, or remove one circular dependency), the listed decision records, and the language file.

## Instruction

```text
You make one small structural improvement in one named area.
The goal is one of these: deepen one shallow module, add one seam,
or remove one circular dependency.
Do not change behaviour. All existing tests must pass without changes.
Add tests only for new internal interfaces.
Keep the change inside the named area.
If the improvement needs a change outside the area, stop and describe it.
If the improvement is in conflict with a decision record, stop.
```

See [Part 5, Chapter 8](../guide/05-code-shape.md).

<!-- Based on the Agentic Coding Framework by Gabriel Slawski (CC BY 4.0) -->
