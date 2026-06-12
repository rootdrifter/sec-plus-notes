# Exam Simulation Guide — SY0-701 under real conditions

A practice score only means something if it was earned under exam conditions. CompTIA SY0-701 is
**up to 90 questions in 90 minutes**, performance-based questions (PBQs) **first**, then multiple
choice. This guide reproduces that accurately so the score predicts the real result.

## Set the conditions

- **90-minute timer, no pause.** One sitting. No phone, no notes, no second monitor.
- **PBQs first.** Start with `exam-06.md` (the PBQ set) — this mirrors the real exam, where the
  hardest, most time-expensive questions come while you're freshest. Practising them first trains
  you not to panic-burn 20 minutes on question 1.
- **Then a full MCQ set.** Work straight through `exam-04.md` or `exam-05.md`.
- **No scoring mid-exam.** Mark uncertain questions, move on, return at the end — exactly as you
  will on the day. Score only when the timer stops.

## Pacing maths (internalise this)

90 questions / 90 minutes = **1 minute per question average**, but PBQs eat 3–5 minutes each. So:
budget the PBQs at ~15–20 minutes total, then you have ~70 minutes for the MCQs — roughly **50
seconds each** with a few minutes spare to revisit flags. If a PBQ is sinking you, **flag it and
move** — a 4-minute PBQ and a skipped easy MCQ is a bad trade.

## Scoring → decision (the honest gate)

CompTIA scales 100–900, pass = **750**, which is roughly **83% raw** on a balanced set. Use this gate:

| Practice score | Decision |
|---|---|
| **85%+** | Book the exam. You are ready; further delay is avoidance. |
| **75–84%** | One more focused week on the weak domains (see below), then re-sit a fresh set. |
| **Below 75%** | Specific domain review needed — don't book yet; target the lowest domain. |

## After scoring — turn errors into a plan

1. Log every miss in `error-log.md` with **why** you missed it (didn't know / misread / trap).
2. Bucket misses by **domain** — the SY0-701 weighting tells you where a point is worth most:
   **D4 Security Operations 28% · D2 Threats/Vulns/Mitigations 22% · D5 Program Management 20% ·
   D3 Architecture 18% · D1 General Concepts 12%.** A 10% gap in D4 costs far more marks than a 10%
   gap in D1.
3. For each weak domain, drill its `sprint-d{n}.md` sheet, then re-test on a *different* exam set so
   you're testing recall, not memory of the questions.

## Don't fool yourself

- A high score on an exam you've **already seen** measures memory, not readiness. Rotate sets.
- "I knew that really" is a miss. Score it as wrong; the exam won't give partial credit for almost.
- Simulate at the **time of day** you've booked the real exam — alertness varies.

See `EXAM_DAY.md` for the day-before and day-of protocol, and `EXAM_TRAPS.md` for the specific
gotchas to re-read the morning of.
