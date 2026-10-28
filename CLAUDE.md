# Working on claude-practice

@PRACTICE.md

The rules above are the practice itself. This repository is how they're
kept, and differs from the projects that import it:

- **One branch, `main`, and no releases, tags or CHANGELOG.** Projects
  read the practice from the working copy, so a change pushed here
  reaches every project at its next session. The commit message says
  what changed and why.
- **A rule moves here only from a project, and leaves it in the same
  session:** remove it from each project's `CLAUDE.md` in a `docs:`
  commit there, so no copy is left to drift. A rule that a project needs
  to differ stays in that project, saying what it overrides.
- **No project's own detail here:** test names, documents and baselines
  stay in the project. Nothing private here either: that goes in
  `../claude-practice-private`.
- **Read `PRACTICE.md` as a PDF after changing it:**
  `../grammar/scripts/readme-pdf.sh PRACTICE.md` with an output path
  outside this repository, until it has a script of its own.
