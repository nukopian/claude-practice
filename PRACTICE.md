# The practice

These are the working rules shared by the projects Iain Campbell develops
with Claude Code. Each project's `CLAUDE.md` imports this file and adds
its own rules on top: what the project is for, its tests, its documents,
and any exception to what's here. Where the two differ, the project's
rule wins. Each rule comes with the reason for it, and the why behind
them all is Iain's essay,
[The process](https://github.com/nukopian/scalar/blob/main/docs/PROCESS.md).

## Using it

- **A project imports the practice from its working copy beside it,**
  with a line of its own in `CLAUDE.md`, outside any code span:

  ```
  @../claude-practice/PRACTICE.md
  ```

  A public project says beside it where the practice lives
  ([nukopian/claude-practice](https://github.com/nukopian/claude-practice)),
  for anyone who clones the project alone.
- **Which practice a project imports follows its visibility on GitHub**
  (`gh repo view --json visibility`), checked when its `CLAUDE.md` is set
  up and whenever the visibility changes:
  - **Private:** this file, then `@../claude-practice-private/PRIVATE.md`,
    whose rules are private.
  - **Public:** this file only.
  - **Public, with private context:** this file, and the private one only
    from a `CLAUDE.md` that is git-ignored, so nothing public points at it.
  - **Going public:** remove the private import from every committed file,
    and run gitleaks over the whole history first.
- **At the start of a session, `git -C ../claude-practice pull --ff-only`**
  (and the private one, where it's imported). Imports load before the
  pull, so if it brought changes, read them before working.

Why: one copy of the practice can't drift. Three copies did, within days.

## Planned work

- **`TODO.md` holds work for a later session,** at the top of the
  repository, committed (on `develop` where there is one), with enough
  to do it cold: what, why, what's known, the files involved, the steps,
  and how to check it's done. Not only in Claude's memory or the chat,
  which Iain can't review and a fresh session may not have.
- **At the start of a session, check for `TODO.md`.** If it's there,
  read it, ask Iain whether each task should still be done, and do the
  ones he confirms. Remove each task in the commit that completes it,
  and delete the file with the last one. A task he drops is removed too,
  saying why in the commit message.
- **Before each commit, `git pull --ff-only` and re-read `TODO.md`.**
  Sessions in other repositories add tasks, mid-session too, and a commit
  that completes a task must remove it.
- **Each task opens with where it came from and what it waits on,** so a
  session can see at a glance which tasks it can do now, and whom to tell
  when one is done:

  ```markdown
  ## Mark each match with scalar's Autovivify(false)

  **From:** scalar's session, 2026-10-25 (scalar 5fd3f0dd76c34de50c011d0389719abf85dcc0f2)
  **Waiting on:** a scalar release with Autovivify
  ```

  `From` names the repository whose session added it, the date, and the
  full hash of the commit that prompted it, or, if that work isn't
  committed yet, the last commit and "work uncommitted". `Waiting on` is
  "nothing" when the task can be done now.
- **A task added to another repository's `TODO.md` is committed and
  pushed there at once,** after a `git pull --ff-only`, as its own `docs:`
  commit. Left uncommitted, it blocks that repository's next pull and
  never reaches the session that would do it. A code fix made in another
  working copy to get past a bug stays uncommitted, with a task saying so.
- **`TODO.md` comes first:** its tasks take priority over the roadmap's
  items. When a session takes up an item, its next steps go into
  `TODO.md`, or are done at once.
- **`TODO.md` never reaches `main`.** A release waits until the file is
  gone: each task done, or, to outlast the release, a feature moved word
  for word into `ROADMAP.md`, or a decision awaiting Iain to a Claude Doc.
  No GitHub issues for planned work.
- **A release ends by looking in the other repositories' `TODO.md`** for
  tasks waiting on it, and telling Iain which can now be done. Nothing
  else tells their sessions it has landed.

Why: planned work survives between sessions in the open, where Iain
reviews it like any other change, and a release never carries an
unfinished list.

## The roadmap

- **`ROADMAP.md` holds what the project means to do:** features and
  outcomes, not session tasks. **Now** is what's being worked on, at most
  three items, so it stays a queue, not a fire-hose: each a paragraph,
  a **Serves:** line, and a link to its change record; another starts
  only when one ships or goes back to Next. **Next** is decided but not
  started (what, why, done when). **Later** is meant to be done but not
  yet planned, in a line or two. **Ideas** might be done, or never: a
  numbered heading, the date added, a line or two, no Serves line, newest
  last. Most useful first in the others.
- **Every item has a number** in its heading (`### 7. Title`, never a
  Markdown numbered list, which renumbers itself): the next one when it's
  added, which the roadmap's opening gives ("Next number: 8"), kept as it
  moves between groups and never used again. A shipped item's CHANGELOG
  line ends "(roadmap 7)".
- **When Iain mentions an idea in passing,** offer in one line to add it
  ("add as idea 8?"), and add it in a `docs:` commit.
- **It's kept current:** an item leaves when it ships, in the commit that
  adds it to the CHANGELOG, and a change that ships, starts or drops a
  feature updates it in the same commit.
- **It's public, on `main`,** in every release, with a PDF like the other
  documents. What's kept out of the README is kept out of it too.

Why: the CHANGELOG is the past, the README the present, and the roadmap
the future, so anyone following the project can see what's coming.

## Change records

- **A planned change keeps a record** in `docs/changes/`: opened when
  work starts on a roadmap item or a `TODO.md` task with steps, holding
  the plan word for word. The plan isn't edited once work starts.
- **A record is named for the day work started,** then, for a roadmap
  item, "r" and its number: `2026-10-26-r7-short-title.md`. A search for
  `r7` finds it, where a bare 7 would match every date and figure. A
  record for a `TODO.md` task has no number: `2026-10-26-short-title.md`.
- **What happened is added as the work goes:** the outcome against Done
  when, changes from the plan and why, measurements, what was tried and
  reverted, and what's left.
- **It's finished in the commit that ships or drops the change.** Its
  status is in progress, shipped, unreleased, shipped in vX.Y.Z, or
  dropped; a dropped change keeps its record, saying why. The CHANGELOG
  line links it: "(roadmap 7; [record](docs/changes/….md))".
- Small fixes need none. `docs/changes/README.md` has the template.

Why: the plan and its outcome sit side by side, so a reader can see what
was predicted and what was found.

## Branches, commits and releases

- **Work is committed and pushed to `develop`.** `main` is the latest
  release, protected, and moves only at a release, by a fast-forward to
  `develop`, with the tag on it. Releases come often, at the close of a
  run of work, after a wash-up. Ask Iain before tagging.
- **Conventional commits** (`feat:`, `fix:`, `docs:`, `test:`, `ci:`),
  saying why as well as what. Name the paths to commit; never a bare
  `git add -A`, which takes in whatever lies about.
- **Claude commits and pushes once a change is done and checked,** and
  Iain reviews it. Commits are signed. Every commit ends with a
  `Co-Authored-By` trailer for the Claude model that worked on it,
  currently `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>`.
- **What changed for users goes into `CHANGELOG.md` under Unreleased in
  the same commit.** Unreleased is never blank: a release leaves
  `Nothing yet.` under it, and the first change after replaces that line.
- **Credit goes where the work was done:** keep the README's
  Acknowledgements accurate.
- Each project's `docs/MAINTAINING.md` has the release steps and the git
  and GitHub work done by hand.

## How changes are made

- **Measure, don't predict.** For a speculative performance change:
  branch from a clean tree, record baseline benchmarks, and profile
  first, because the profile's share sets a ceiling on the gain. Put the
  change behind a switch with a differential test. Keep what pays, revert
  what doesn't, and record reverted ideas and their numbers so they
  aren't retried blind.
- **Wash-ups.** When a run of work reaches a natural close, and always
  before a release, audit everything since the last tag for crashes,
  correctness, inconsistency, inefficiency and slop. Offer one when an
  iteration seems to be closing. Save the outputs first, reproduce each
  finding before reporting it, rank the findings, write a failing test
  before each fix, and show that nothing else moved. The most egregious
  findings go into the CHANGELOG, each with what it would have broken.
  The wash-up also checks the roadmap and the README's account of where
  the project stands, and prunes Ideas: list them by number, and Iain
  keeps, promotes (number kept, Serves added) or drops each (deleted, its
  number named in the commit).
- **Dogfooding.** Use each library in real programs, and note where it
  fought you. Friction that blocks the work is fixed in the library's
  working copy, left uncommitted, with a task in its `TODO.md`; friction
  with a workaround becomes an idea in its roadmap. Check a fix by
  reworking the programs with their output unchanged, and leave the
  using project a task to take it up after the release.

Why: predictions here have been wrong more than once, and the wash-ups'
findings are the evidence that the process works.

## Documents

- **A feature isn't done until its documentation is.** A change to what a
  project does, has measured or will do next updates its documents in the
  same commit.
- **Every link must resolve,** `#anchor`s included.
- **PDFs are for reading offline,** built by `scripts/readme-pdf.sh` and
  git-ignored. After a change to a document, rebuild its PDF and read the
  changed pages. `TODO.md`, the CHANGELOG and change records have none:
  they're read as Markdown, and the script refuses them.

## Secrets

- **gitleaks scans the whole history:** in CI on every push, and by hand
  (`gitleaks git --redact .`) before a repository goes public, before a
  tag, and after any history rewrite, before it's pushed. GitHub's secret
  scanning and push protection are on. A leak stops the work like a
  failing test: once history is published, it can't be taken back.
