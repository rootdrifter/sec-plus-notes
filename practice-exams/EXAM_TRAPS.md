# Exam Traps — SY0-701 morning-of single sheet

The gotchas that cost marks even when you know the material. Re-read this the morning of the exam.
SY0-701 questions are frequently "which of these four near-identical terms is the precise one" or
"what do you do FIRST" — the trap is rarely ignorance, it's imprecision under time pressure.

## Read the qualifier — it decides the answer
**BEST / MOST / FIRST / NEXT / GREATEST** changes the correct option. Several answers will be "true";
only one is what the qualifier asks. Underline the qualifier mentally before reading the options.

## Order of operations (the "FIRST/NEXT" trap)
- **Incident response:** Preparation → Detection/Analysis → **Containment → Eradication → Recovery** →
  Lessons Learned. *Contain before you eradicate.* The most thorough action is usually not the *first*.
- **Risk:** identify → assess → **respond** (mitigate/transfer/avoid/accept) → monitor.
- **Change/forensics:** preserve/acquire **before** you analyse; document chain of custody throughout.
- **Digital forensics order of volatility:** CPU/cache/registers → RAM → network state → disk →
  backups/archives. Collect most-volatile first.

## Near-synonyms that get swapped
| If the scenario says… | …the answer is | not |
|---|---|---|
| Weakness that *could* be exploited | **Vulnerability** | threat / risk |
| The actor/event that *could* exploit it | **Threat** | vulnerability |
| Likelihood × impact of that happening | **Risk** | threat |
| Verify identity | **Authentication** | authorisation |
| Grant permissions after identity | **Authorisation** | authentication |
| Prove the action happened (logs) | **Accounting / non-repudiation** | integrity |
| Same key both ways, fast, bulk data | **Symmetric** | asymmetric |
| Key pair, key exchange / signatures | **Asymmetric** | symmetric |
| Fixed-length fingerprint, one-way | **Hashing** (integrity) | encryption (confidentiality) |
| Login from London + Tokyo, 8 min apart | **Impossible travel** | brute force |
| Many users, one common password | **Password spraying** | brute force / dictionary |
| One account, many password guesses | **Brute force** | spraying |

## Controls — type vs function (a classic double-axis trap)
- **Type:** technical / managerial / operational / physical.
- **Function:** preventive / deterrent / detective / corrective / compensating / directive.
- A question often asks for *one axis* — a CCTV is **physical + detective** (and a sign saying
  "CCTV in use" is **deterrent**). Answer the axis asked.

## Cryptography precision
- **Salt** defeats rainbow tables / makes equal passwords hash differently; **pepper** is a secret
  added separately; **key stretching** (PBKDF2/bcrypt/scrypt/**Argon2id**) slows guessing. (Your
  ironveil LUKS2 passphrase slot *is* Argon2id key-stretching — anchor it to that.)
- **Nonce / IV / salt** are all "use-once" values but for different purposes — read which.
- **PFS / ephemeral keys**: session compromise doesn't expose past sessions.

## Recovery metrics (don't mix them up)
- **RTO** = how long you *can be down* (time target). **RPO** = how much *data* you can lose (the
  last good backup). **MTTR** = mean time to repair. **MTBF** = mean time between failures.

## Agreements (D5 — underestimated, 20% of the exam)
- **SLA** performance/uptime · **MOU/MOA** intent (often non-binding) · **SOW** specific work/deliverables
  · **MSA** master terms for an ongoing relationship · **BPA** business partner profit/loss/ownership ·
  **NDA** confidentiality. Match the scenario's emphasis (uptime? scope? partnership?).

## Other reliable traps
- **Vishing/smishing/whaling/BEC** — match the *channel and target*, not just "phishing".
- **Tabletop vs simulation vs full failover** — tabletop is *discussion only*, no systems touched.
- **Detection vs prevention:** IDS detects/alerts; **IPS** sits inline and blocks. "Inline + block" = IPS.
- **Fail-open vs fail-closed:** safety/availability → fail-open; security → fail-closed. Read which the
  scenario prioritises.
- **Due care** = doing the reasonable thing; **due diligence** = the ongoing verification it's working.

Re-read `../LAST_MINUTE_GUIDE.md` for the per-domain one-pager; this sheet is only the traps.
