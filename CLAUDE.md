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
- **`thoughts/` holds Iain's essays,** such as
  [The process](thoughts/PROCESS.md), the why behind the practice. They
  are his words: change them only when he asks. Projects link to them
  here rather than keeping copies.
- **Read a document as a PDF after changing it:**
  `scripts/readme-pdf.sh PRACTICE.md`, or with no arguments for every
  document. The PDFs are git-ignored.
