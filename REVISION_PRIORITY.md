# SY0-701 Revision Priority — the expected-value drill queue

**What this is, and how it differs from the other study docs.** Coverage is already complete —
[`EXAM_READINESS.md`](EXAM_READINESS.md) assessed every domain objective-by-objective and found
**zero missing objectives** (depth DEEP across all five). The honest constraint is no longer content,
it is **timed recall under pressure**. This file is the triage tool for that constraint: a single,
**ranked queue of the specific high-yield topics** to drill first, in priority order, with the exact
asset to drill each against.

- [`EXAM_READINESS.md`](EXAM_READINESS.md) answers *"is it covered?"* (a coverage matrix, per domain).
- [`STUDY_SCHEDULE.md`](STUDY_SCHEDULE.md) answers *"when do I study?"* (a six-week calendar).
- **This file answers *"if I have one hour, what do I revise to gain the most marks?"*** (a topic-level
  priority queue). It is the layer between the two.

## How the ranking is derived

Priority ≈ **exam weight × point-loss probability**. A topic ranks high when it is *either* in a
heavily-weighted domain *or* a known point-leaker — and highest when it is both. Two kinds of topic
leak marks:

1. **Mechanical marks** — formulas and fixed orderings (risk arithmetic, IR phases, recovery
   metrics). These are *guaranteed* points if recalled cleanly and *guaranteed losses* if rusty.
   Pure recall, zero reasoning — the cheapest marks to bank, the most foolish to drop.
2. **Trap-dense topics** — closely-confused concepts the exam deliberately tests with near-miss
   distractors (SPF vs DKIM vs DMARC, the Zero Trust planes, data-role terms). High question
   density, easy to misselect under time pressure.

Domain weights (SY0-701): **D4 28% · D2 22% · D5 20% · D3 18% · D1 12%.**

## The priority queue (drill top-down)

| # | Domain (wt) | High-yield target | Why it ranks here | Drill against |
|---|-------------|-------------------|-------------------|---------------|
| 1 | **D4 (28%)** | Email authentication — **SPF / DKIM / DMARC** (what each proves, and DMARC depending on the other two) | Highest-weight domain; the single most trap-dense item in it — distractors swap which record does what | D4 §7; [`sprint-d4.md`](practice-exams/sprint-d4.md); [`EXAM_TRAPS`](practice-exams/EXAM_TRAPS.md) |
| 2 | **D4 (28%)** | **NIST IR phase ordering** (Preparation → Detection & Analysis → Containment/Eradication/Recovery → Post-Incident) | Mechanical mark in the highest-weight domain; "what's the *next* phase" stems are guaranteed appearances | D4 §3; [`MEMORY_AIDS`](MEMORY_AIDS.md) (IR mnemonic) |
| 3 | **D5 (20%)** | **Risk arithmetic — SLE = AV × EF; ALE = SLE × ARO** | Pure mechanical marks; appears almost every sitting; a rusty formula is a certain loss | D5 §1; [`MEMORY_AIDS`](MEMORY_AIDS.md); [`exam-06.md`](practice-exams/exam-06.md) (risk-calc PBQ) |
| 4 | **D2 (22%)** | **Indicator recognition — "which attack is this?"** (2.4) | The exam's favourite stem style in its second-heaviest domain; high question volume | D2 §11 + scenario bank; [`scenarios/soc-scenarios.md`](scenarios/soc-scenarios.md) |
| 5 | **D3 (18%)** | **Recovery metrics — RTO / RPO / MTTR / MTBF** + the shared-responsibility split | Mechanical/definitional marks; RTO-vs-RPO is the classic confuser; shared responsibility is a guaranteed cloud question | D3 §6 + §1; [`sprint-d3.md`](practice-exams/sprint-d3.md) |
| 6 | **D1 (12%)** | **PKI revocation (CRL / OCSP / OCSP stapling)** + **Zero Trust planes** (control vs data plane, PEP / PDP / PA) | Low weight but the two classic D1 point-losers — trap-dense terminology the exam reliably exploits | D1 §10 + §4; [`sprint-d1.md`](practice-exams/sprint-d1.md) |
| 7 | **D5 (20%)** | **Data-role distinctions** — owner / controller / processor / custodian; **agreement types** — SLA / BPA / MOU / MSA / NDA | Mechanical, confusable, frequently tested; cheap marks once the lines are crisp | D5 §4 + §9; [`ACRONYMS.md`](ACRONYMS.md) (confused-with pairs) |
| 8 | **D4 (28%)** | **Wireless security** — WPA3 / SAE, Enterprise vs Personal, 802.1X | Recently strengthened block (EXAM_READINESS D4 §13); needs at least one rehearsal pass; high-weight domain | D4 §13; [`sprint-d4.md`](practice-exams/sprint-d4.md) |
| 9 | **D3 (18%)** | **IaC / serverless / microservices** distinctions | Recently filled gap (EXAM_READINESS 3.1); one rehearsal pass to lock it in | D3 §3; [`sprint-d3.md`](practice-exams/sprint-d3.md) |
| 10 | **D2 (22%)** | **Path traversal vs directory indexing**; LFI / RFI | Trap refinement — the discriminator is subtle (anchors to spectre's CWE-548 finding) | D2 §5; [`PORTFOLIO_MAP.md`](PORTFOLIO_MAP.md) (spectre link) |

> Items 1–5 are where the marks concentrate (the two heaviest domains plus the mechanical formulas).
> If revision time collapses, **do 1–5 and stop** — they are the highest expected value on the board.

## First three 90-minute sessions (concrete)

A timed, expected-value-ordered start that mirrors the real exam cadence (use
[`run-exam.sh`](practice-exams/run-exam.sh) where an asset supports it):

1. **Session 1 — bank the mechanical marks (items 2, 3, 5).** IR phase ordering, SLE/ALE/ARO,
   RTO/RPO/MTTR/MTBF. These are pure recall; get them to reflex, then never lose them again. Close
   with [`exam-06.md`](practice-exams/exam-06.md) (PBQ ordering + risk-calc).
2. **Session 2 — the highest-weight trap topics (items 1, 4).** SPF/DKIM/DMARC and the D2
   "which-attack-is-this" indicator bank. Run [`sprint-d4.md`](practice-exams/sprint-d4.md), then
   log every miss to [`error-log.md`](practice-exams/error-log.md).
3. **Session 3 — the trap-dense remainder + a timed mock (items 6, 7, then a full run).** PKI
   revocation, Zero Trust planes, data-roles/agreements; then sit
   [`exam-01.md`](practice-exams/exam-01.md) under a real 90-minute clock and let the error-log,
   not this list, set the next priority.

After the first timed mock, **the error log supersedes this file** — a topic you actually miss
outranks any a-priori weighting. Re-drill the *pattern* behind each miss, per
[`error-log.md`](practice-exams/error-log.md), and feed the weak domains back through the
per-domain sprints.

## Honest status

- **No coverage gaps drive this list.** Every item is a *recall-reinforcement* target, not a hole —
  the content exists and is DEEP (see [`EXAM_READINESS.md`](EXAM_READINESS.md)). Prioritisation here
  is purely about where timed-recall practice buys the most marks.
- **Weights are the published SY0-701 domain percentages**; the per-topic point-loss judgements come
  from the trap analysis in [`EXAM_TRAPS`](practice-exams/EXAM_TRAPS.md) and
  [`sy0-701-exam-tips.md`](domains/sy0-701-exam-tips.md). Confirm objective wording against current
  official CompTIA materials before relying on any single line for the exam.

---

*Part of [sec-plus-notes](README.md) in the [rootdrifter](https://github.com/rootdrifter) portfolio.
Built by a security-cleared candidate preparing CompTIA Security+ (SY0-701).*
