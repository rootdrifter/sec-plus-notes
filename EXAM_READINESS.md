# SY0-701 Exam Readiness — Honest Coverage Assessment

Assessed 2026-06-11 against the official CompTIA SY0-701 objectives. Method: every domain file's
section structure mapped objective-by-objective, suspected gaps verified by content search (a
topic was only declared missing after a zero-hit search, not from headings alone). This drives
study decisions — optimistic scoring would only hurt the exam result.

**Overall: READY-LEANING.** Two genuine objective gaps existed at assessment time (both now
filled — see notes); depth is at or above exam level everywhere else. The remaining risk is not
coverage, it is **recall under time pressure** — drive the practice exams, not more notes.

**Precision pass 2026-06-12 (overnight session).** A second objective-by-objective sweep using
zero-hit term searches found a handful of genuinely-thin high-yield items (not whole objectives)
and filled them — committed per domain:
- **D4 §14** — network *flow* telemetry (NetFlow/sFlow/IPFIX/SNMP) vs full packet capture, SPAN
  vs TAP, log archiving, and forensic legal concepts (chain of custody, legal hold, e-discovery,
  spoliation). sFlow/IPFIX/archiving had been absent.
- **D2 §5** — memory-injection umbrella (process hollowing/reflective loading) and
  directory/path traversal + LFI/RFI (both previously absent), with the traversal-vs-indexing
  discriminator vs spectre's CWE-548.
- **D5 §6** — pentest knowledge factor (known/unknown/partial environment), responsible
  disclosure vs bug bounty, due care vs due diligence, exemption/exception. due-care and the
  disclosure pairing had been absent.
- **D3 §2** — network security appliances + placement table (NGFW/WAF/UTM/forward+reverse
  proxy/load balancer/IDS vs IPS) and inline-vs-passive **fail-open/fail-closed** decision. This
  was the largest real hole (3.2 appliance placement).
- **D1 §6** — salt vs pepper, key stretching as the password answer (not "stronger hash"),
  ephemeral keys / PFS mechanism, and the nonce/IV/salt disambiguation. salting and ephemeral
  had been absent terms.

These are depth/trap refinements, not new objectives — coverage was already DEEP. The honest
bottom line below is unchanged: the constraint is timed recall, not content.

---

## Domain 1 — General Security Concepts (12%)

- **Objectives covered:** 1.1 control categories/types (§1); 1.2 CIA, non-repudiation (§2), AAA
  (§3), gap analysis (verified present), zero trust incl. planes (§4), physical security (§5),
  deception tech (§8); 1.3 change management (§9); 1.4 crypto use-case mapping (§6) + PKI deep
  (§10).
- **Objectives partial:** none material.
- **Objectives missing:** none.
- **Current depth: DEEP** (521 lines; self-test + scenario drills + quick-ref + scenario bank).
- **Recommended focus time: 3h** — PKI revocation traps and Zero Trust plane terminology are
  the classic point-losers; drill those two only.

## Domain 2 — Threats, Vulnerabilities & Mitigations (22%)

- **Objectives covered:** 2.1 actors (§2) + intel (§1); 2.2 vectors/surfaces (§8) incl.
  wireless attacks; 2.3 full vulnerability catalogue (§10) incl. supply chain; 2.4 indicators
  (§11); 2.5 mitigations (§9). Social engineering (§3), malware (§4), app/network attacks
  (§5–6), vuln management lifecycle (§7).
- **Objectives partial / missing:** none.
- **Current depth: DEEP** (538 lines, uniform component set).
- **Recommended focus time: 5h** — highest-weight domain after D4; drill indicator-recognition
  scenarios (2.4) — the exam loves "which attack is this" stems.

## Domain 3 — Security Architecture (18%)

- **Objectives covered:** 3.1 cloud models/responsibility (§1), network architecture (§2),
  virtualisation/containers (§3), IoT/OT/ICS/embedded (§4), air-gap (verified); 3.2 secure
  infrastructure (§2–3); 3.3 data states/classification/privacy techniques (§5); 3.4
  resilience, backups, RTO/RPO formulas, DR sites (§6).
- **Objectives partial (at assessment):** 3.1 **IaC and microservices had zero coverage**
  (serverless was present). → **FILLED 2026-06-11** (§3 addition: IaC / serverless /
  microservices block).
- **Current depth: DEEP** (439→ lines after fill).
- **Recommended focus time: 4h** — recovery-metric formulas (RTO/RPO/MTTR/MTBF) and shared
  responsibility are guaranteed marks; the new IaC/microservices block needs one rehearsal pass.

## Domain 4 — Security Operations (28% — highest weight)

- **Objectives covered:** 4.1 baselines (cross-ref D3 §3); 4.2 asset mgmt/disposal (§11); 4.3
  vuln mgmt (§5) + triage terms (§6); 4.4 monitoring/SIEM (§1); 4.5 enterprise capabilities
  (§7 email auth, §8 tuning, §12 network tools); 4.6 IAM deep (§2); 4.7 SOAR (§9); 4.8 NIST
  IR lifecycle + forensics (§3); 4.9 data sources (§10).
- **Objectives partial (at assessment):** 4.1 hardening *targets* — **mobile solutions
  (MDM/BYOD/COPE/CYOD) and wireless security settings (WPA3/SAE, Enterprise vs Personal) were
  thin** (scattered mentions, no dedicated block); application-security hardening list likewise.
  → **FILLED 2026-06-11** (§13: Hardening targets — mobile, wireless, application).
- **Current depth: DEEP** (584→ lines after fill; the most SOC-relevant material is the
  strongest).
- **Recommended focus time: 8h** — 28% of the exam. Drill: email auth (SPF/DKIM/DMARC order
  traps), IR phase ordering, log-source selection scenarios, and the new wireless block.

## Domain 5 — Security Program Management & Oversight (20%)

- **Objectives covered:** 5.1 governance/policies (§9); 5.2 risk deep + quantitative formulas
  (§1); 5.3 third-party/supply chain (§5); 5.4 compliance/regulations (§3) + data roles (§4);
  5.5 audits/assessments/testing types (§6); 5.6 awareness (§7). Metrics/KPIs (§8) beyond
  objective scope.
- **Objectives partial / missing:** none.
- **Current depth: DEEP** (448 lines).
- **Recommended focus time: 4h** — SLE/ALE/ARO arithmetic and data-role distinctions
  (controller/processor/owner/custodian) are mechanical marks; don't lose them.

---

## Rehearsal inventory

| Asset | Size | Note |
|-------|------|------|
| practice-questions.md | 50 weighted MCQ | first pass done material |
| practice-exams/exam-01.md | 90 Q weighted, answer key | full mock |
| practice-exams/exam-03.md | 40 Q, all scenario | created this session (no exam-02 exists — exam-01's session note claiming "exam-01/02" was inaccurate; numbering kept per directive) |
| scenarios/soc-scenarios.md | 25 SOC shift scenarios | D4 reinforcement |
| per-domain scenario banks + drills + self-tests | ~110 items | in each domain file |
| sy0-701-exam-tips.md | traps + formulas + acronyms | last-day review |

## Bottom line

Coverage is no longer the constraint. The score now depends on: (1) exam-01/exam-03 under real
90-minute timing (use `practice-exams/run-exam.sh`), (2) error-log review after each run
(`practice-exams/error-log.md`), (3) weak-domain redrill per `STUDY_SCHEDULE.md`.
