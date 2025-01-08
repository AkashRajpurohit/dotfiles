#!/bin/bash
set -e

if ! command -v tgpt &>/dev/null; then
  echo "Error: 'tgpt' command not found. Please install it first."
  echo "You can download it from: https://github.com/aandrew-me/tgpt"
  exit 1
fi


if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "This command needs to be run in an active Git repository."
  exit 1
fi

DIFF=$(git diff --cached)

if [ -z "$DIFF" ]; then
  echo "No staged changes to commit."
  exit 1
fi

PROMPT="You are an AI that generates precise and clean Git commit messages.
The goal is to follow the Conventional Commits style (Angular format) using the following structure.

Please follow these rules strictly when generating the commit message and only produce the commit message and nothing else:

1. **Commit Message Format**:
	- The commit message consists of a **header**, **body**, and **footer**.
	- The header should be in the format: '<type>(<scope>): <emoji> <subject>'
	- There must be a blank line between the header and the body.

2. **Types**:
The commit type should be one of the following:
	- 'build': Changes that affect the build system or external dependencies (e.g., gulp, npm)
	- 'ci': Changes to CI configuration files (e.g., Travis, Circle)
	- 'docs': Documentation changes only
	- 'feat': A new feature
	- 'fix': A bug fix
	- 'perf': A change that improves performance
	- 'refactor': A change that neither fixes a bug nor adds a feature
	- 'style': Changes that do not affect the meaning of the code (e.g., whitespace, formatting)
	- 'test': Adding or correcting tests

3. **Scope**:
	- If applicable, provide a scope in parentheses, indicating which part of the project is affected (e.g., 'core', 'http', 'router', 'forms', etc.).
	- If no specific scope applies, you may omit it.

4. **Emoji**:
	- Emoji can be any supported emoji that is well suited for the type of commit.

5. **Subject**:
	- Use the **imperative present tense** (e.g., 'add' instead of 'added').
	- Keep the subject concise (less than 100 characters).
	- Do **not** use a period at the end.

**Examples**:
	feat(core): :tada: add new feature
	fix: :bug: fix bug
	chore: :wrench: minor refactoring
	build(deps): :arrow_up: update dependencies

The **git diff** for this commit is as follows:
$DIFF
"

COMMIT_MSG=$(echo "$PROMPT" | tgpt --quiet | tr -d '\r')

echo "Generated commit message:"
echo "-------------------------"
echo "$COMMIT_MSG"
echo "-------------------------"
read -p "Do you want to use this commit message? (y/n): " CONFIRM

if [[ "$CONFIRM" == "y" ]]; then
  git commit -m "$COMMIT_MSG"
  echo "Commit has been made."
else
  echo "Commit aborted."
fi
