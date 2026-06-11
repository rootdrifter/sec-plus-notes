# Error Log — questions answered wrong

The single highest-leverage study tool: track every miss, find the *pattern*, redrill the
pattern (not the individual question). A question you got wrong once is noise; a trap you fall
for three times is your real weakness and the next score gain.

## How to use

After each practice run (`run-exam.sh`), add a row for every wrong answer. Be honest about *why*
you missed it — that diagnosis is the whole point.

**Miss reasons (pick one):**
- `KNOWLEDGE` — didn't know the fact → go (re)read the domain note section
- `TRAP` — knew it but fell for the distractor → re-read the quick-ref "exam traps"
- `MISREAD` — misread the stem (NOT/EXCEPT/MOST/LEAST) → slow down, underline the qualifier
- `TIMING` — rushed under the clock → pacing problem, not knowledge
- `CONFUSED-PAIR` — mixed up two similar terms → drill the disambiguation list

## Log

| Date | Exam | Q# | Domain | Topic | Miss reason | Correct answer | Note / what to review |
|------|------|----|--------|-------|-------------|----------------|-----------------------|
| | | | | | | | |

## Pattern analysis (fill in weekly)

Once you have ~15 rows, tally them:

| Pattern | Count | Action |
|---------|-------|--------|
| Domain most-missed | | Redrill that domain's scenario bank |
| Most common miss reason | | If TRAP-heavy → exam-tips traps; if MISREAD → pacing |
| Recurring confused pair | | Add to a personal flashcard set |

> Recurring traps worth pre-empting (from `sy0-701-exam-tips.md`): RPO↔RTO inversion,
> SPF/DKIM/DMARC roles, STIX↔TAXII, SLE→ALE arithmetic (don't stop at SLE), false
> positive↔negative, XSS↔CSRF trust direction, IaC "still misconfigurable", "client-side
> validation is not a security control".
