# SY0-701 Study Schedule — spaced-repetition plan

A six-week plan from now to the exam. Weeks are templates, not calendar-locked — set your own
exam date and count back six weeks. The structure is deliberate: broad coverage first, then
weak-domain depth driven by your own `practice-exams/error-log.md`, then exam-condition
rehearsal, then taper. Spaced repetition: each week re-touches earlier material, it does not
move on and forget it.

> Tooling: `practice-exams/run-exam.sh <file>` (timed), `error-log.md` (track misses),
> `EXAM_READINESS.md` (coverage matrix), `PORTFOLIO_MAP.md` (concept → real evidence).

## Week 1–2 — Full domain coverage

**Goal:** touch every objective once, at depth, and take a baseline mock.

- Read one domain note end-to-end per study block (D4 and D2 get two blocks each — highest
  weight). Do the in-file self-test + scenario drills as you go.
- Day-after-reading: redo only the self-test for the previous domain (first spaced touch).
- End of Week 2: **full timed mock — `run-exam.sh exam-01.md`** (90Q). This is your baseline;
  log every miss. Don't be discouraged by the number — it tells you where to spend Weeks 3–4.

## Week 3–4 — Weak-domain deep dive

**Goal:** convert your two weakest domains (from the baseline + error-log) into strengths.

- Re-read the two lowest-scoring domains' notes; for each miss in the error-log, read the exact
  section and the matching quick-reference card.
- Drill the per-domain **scenario banks** for the weak domains daily.
- Mid-Week-4: **`run-exam.sh exam-03.md`** (40 scenario-only, harder). Compare domain breakdown
  to the baseline — the weak domains should be climbing.
- Keep one short daily touch of your *strong* domains so they don't decay (spaced repetition).

## Week 5 — Mock-exam conditions + final review

**Goal:** exam-day readiness — pacing, stamina, trap-recognition.

- Two full timed mocks this week (re-run exam-01; then exam-03 + practice-questions.md as a
  combined set). Strict 90-minute timer, no notes, one sitting.
- After each: full error-log pattern analysis. By now misses should cluster into 2–3 recurring
  traps — drill those specifically from `sy0-701-exam-tips.md`.
- Memorise the formula sheet cold: SLE/ALE/ARO, RTO/RPO/MTTR/MTBF, RAID levels.

## Week 6 — Light review + rest

**Goal:** arrive sharp, not exhausted. No new material.

- Daily: quick-reference cards + acronym list (`ACRONYMS.md`) + the exam-tips trap list. 20–30
  min, no marathon sessions.
- Two days before: last full read of `sy0-701-exam-tips.md` "last-day review checklist".
- Day before: rest. Re-read only the formula sheet and your top-5 personal traps. Sleep.

## Daily rhythm (any week)

| Block | Activity |
|-------|----------|
| Core (45–60 min) | the week's primary reading/drill |
| Spaced touch (10 min) | previous day's self-test + one earlier domain's quick-ref |
| Trap watch (5 min) | one item from the exam-tips trap list |

## Readiness gate (don't book/sit until all true)

- [ ] Two full mocks ≥ 85% (margin above the ~83% line)
- [ ] Every domain ≥ 80% on the most recent mock
- [ ] Error-log shows no trap missed more than once in the last two runs
- [ ] Formula sheet recalled from memory, zero errors
- [ ] Finishing mocks inside 75 minutes (time buffer for the real thing)
