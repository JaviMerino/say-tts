# Git Hooks

This directory contains git hooks that run the same checks as the github
worflow.

## Setup

To configure git to use these hooks, run the following command from the
repository root:

```bash
git config --local core.hooksPath $PWD/.githooks
```
