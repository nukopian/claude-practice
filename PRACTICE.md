# The practice

These are the working rules shared by the projects Iain Campbell develops
with Claude Code. Each project's `CLAUDE.md` imports this file and adds
its own rules on top: what the project is for, its tests, its documents,
and any exception to what's here. Where the two differ, the project's
rule wins. Each rule comes with the reason for it, and the why behind
them all is Iain's essay,
[The process](thoughts/PROCESS.md).

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
  heading with its id, an **Added:** date and **Size:** line, a line or
  two, no Serves line, newest last. Most useful first in the others,
  which the **Serves:** lines help to judge.
- **Every item has an id, its year and a serial: `2026-0007`,** in its
  heading (`### 2026-0007. Title`, never a Markdown numbered list, which
  renumbers itself). The year is the year it was added, and the serial
  is four digits, from 0001, starting again each year. It's given when
  the item is added, kept as it moves between groups, and never used
  again. The roadmap's opening gives the last id allocated ("Last id:
  2026-0007"): to allocate one, take this year, and add one to the last
  serial if its year is this year, or start at 0001 if not, and change
  that line in the commit that adds the item.
- **The id names the item everywhere:** its heading; its record,
  `docs/changes/2026-0007-short-title.md`; its CHANGELOG line, which
  ends "(roadmap 2026-0007)"; commit messages; and a branch for it, such
  as `experiment/2026-0007-short-title`. Another repository's id goes
  with that repository's name, as "scalar 2026-0001". A project that
  numbered its items 1, 2, 3 converts each number N to the year it was
  added and N as a serial (7 added in 2026 is 2026-0007), so the
  history's "roadmap 7" still reads plainly, and its serials go on from
  the highest.
- **Iain may name an item by its serial alone,** as "26" or "task 26":
  read it as this year's, 2026-0026 in 2026, in the project at hand.
  Where that could mean something else, ask before acting: no such item
  this year, an item from last year that fits better (early in a year),
  a serial that names an item in another repository being discussed, or
  a `TODO.md` task's record sharing the sequence.
- **Every item has a size,** a guess at how much work it is, as a
  T-shirt size and its story points: XS 1, S 2, M 3, L 5, given in a
  **Size:** line, as `**Size:** M (3)`. An item bigger than L is split
  into items that aren't, each with an id of its own and a **Split
  from:** line; the item split is retired, its id named in the commit,
  as a dropped one's is. The roadmap's opening gives the scale.
- **An item that can't be done before another says so,** in a
  **Depends on:** line naming each id. It's never in a group ahead of an
  item it depends on: moving it forward moves those too, so a chain of
  them moves together, and they ship first or with it.
- **An item's questions are settled before work on it starts.** They're
  discussed in the chat, and kept in its record's Decisions, numbered
  D1, D2 and on: unchecked while open, and checked once settled, with
  the answer, the date and why. A **Decisions:** line under the record's
  status sums them up, each settled or open in a few words, so its state
  shows at a glance. An item moves to Now only once every decision is
  checked, or Iain agrees to move one still open to another item or
  task, which the record says. A decision that needs no work of its own
  is kept in the commit message that records it.
- **When Iain mentions an idea in passing,** offer in one line to add it
  ("add as idea 2026-0008?"), and add it in a `docs:` commit.
- **It's kept current:** an item leaves when it ships, in the commit that
  adds it to the CHANGELOG, and a change that ships, starts or drops a
  feature updates it in the same commit.
- **It's public, on `main`,** in every release, with a PDF like the other
  documents. What's kept out of the README is kept out of it too.

Why: the CHANGELOG is the past, the README the present, and the roadmap
the future, so anyone following the project can see what's coming; and
an id that sorts and never changes can be searched for years later.

## Change records

- **A planned change keeps a record** in `docs/changes/`, named for its
  id and the change: `2026-0007-short-title.md`. A roadmap item's record
  is opened when it first has a question to settle, or when work on it
  starts. A `TODO.md` task with steps gets a record too, taking the next
  id from the roadmap's opening, in the same sequence, though the task
  never appears there.
- **The plan is written in it when work starts, and isn't edited
  after.** Its **Started:** line gives the date.
- **What happened is added as the work goes:** the outcome against Done
  when, changes from the plan and why, measurements, what was tried and
  reverted, and what's left. Experiments go in it too, with what they
  showed, as they won't survive anywhere else.
- **It's finished in the commit that ships or drops the change.** Its
  status is open, in progress, shipped, unreleased, shipped in vX.Y.Z, or
  dropped; a dropped change keeps its record, saying why. The CHANGELOG
  line links it: "(roadmap 2026-0007; [record](docs/changes/….md))".
- Small fixes need none. `docs/changes/README.md` has the template.

Why: the plan and its outcome sit side by side, with the decisions
that shaped it, so a reader can see what was predicted and what was
found.

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
  the project stands, and prunes Ideas: list them by id, and Iain
  keeps, promotes (id kept, Serves added) or drops each (deleted, its
  id named in the commit).
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
