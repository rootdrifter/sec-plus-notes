# sec-plus-notes

CompTIA **Security+ (SY0-701)** study notes, organised by the five current exam domains and
cross-linked to **real implementations** in the rootdrifter portfolio — FIDO2/PKI and LUKS2 in
[ironveil], the AdGuard/WireGuard network stack, GrapheneOS compartmentalisation in [nullbyte],
and the [spectre] penetration test — so the theory is anchored to systems actually built and
tested rather than memorised in the abstract.

These notes double as portfolio evidence of foundational knowledge for SOC / analyst targeting:
they show not just that the concepts are known, but that they map onto things this candidate has
deployed and operated.

## SY0-701 domains — primary structure (current exam)

| # | Domain | Weight | Covers |
|---|--------|--------|--------|
| 1 | [General Security Concepts](domains/sy0-701-1-general-security-concepts.md) | 12% | Control categories, AAA, Zero Trust, cryptography, **change management**, **deception tech** |
| 2 | [Threats, Vulnerabilities & Mitigations](domains/sy0-701-2-threats-vulnerabilities-mitigations.md) | 22% | Threat actors, attack surfaces, vulnerability types, mitigation techniques |
| 3 | [Security Architecture](domains/sy0-701-3-security-architecture.md) | 18% | Architecture models, secure design, data protection, resilience & recovery |
| 4 | [Security Operations](domains/sy0-701-4-security-operations.md) | 28% | SIEM/SOC, IAM operations, incident response, digital forensics, vuln management |
| 5 | [Security Program Management & Oversight](domains/sy0-701-5-program-management.md) | 20% | Governance, risk management, third-party risk, compliance, audits & assessments |
| — | [Exam tips & high-yield topics](domains/sy0-701-exam-tips.md) | — | Trap questions, acronym disambiguation, formula sheet, last-day checklist |
| — | [Practice questions (all 5 domains)](practice-questions.md) | — | 50 exam-style items (weighted by domain) with answers, distractor notes, and portfolio links |
| — | [SOC shift scenarios](scenarios/soc-scenarios.md) | — | 25 operational "you're on shift, X happens — what do you do?" decision scenarios (5 per domain) |

## Portfolio cross-references

Each concept below is anchored to a real build in the portfolio — the notes link out to the
implementation so revision and evidence reinforce each other.

| SY0-701 concept | Portfolio implementation | Repo |
|-----------------|--------------------------|------|
| MFA / phishing-resistant auth (FIDO2, CTAP2) | Nitrokey 3A NFC FIDO2 LUKS2 unlock (touch-only) | [ironveil] |
| Cryptography at rest (AES-XTS, Argon2id KDF) | LUKS2 full-disk encryption | [ironveil] |
| Secure remote access | dracut-sshd pre-boot SSH unlock over Tailscale | [ironveil] |
| DNS security / filtering | AdGuard Home, DoH upstream, loopback binding | [ironveil] |
| Network segmentation / tunnelling | WireGuard named-tunnel architecture | [ironveil] |
| Zero Trust applied to a device | Nine-profile compartmentalisation, per-profile keys | [nullbyte] |
| Mobile device security / verified boot | GrapheneOS, Titan M2 root of trust | [nullbyte] |
| Application sandboxing | Sandboxed (unprivileged) Google Play per profile | [nullbyte] |
| Vulnerability scanning & enumeration | nmap, Gobuster, Nikto, WhatWeb workflow | [spectre] |
| Penetration-testing methodology | PTES phase model, grey-box engagement | [spectre] |
| Evidence integrity / chain of custody | SHA-256 artefact hashing, dual session logs | [spectre] |
| Secure configuration / hardening baselines | CIS Apache 2.4 + CIS PostgreSQL 16 Level 1 | [spectre] |
| ML-based detection & adversarial ML | Causal vs correlational phishing detection | [mirage] |
| Imbalanced-class detection methodology | Macro-F1, class-weighted loss (IDS analogue) | [oracle] |

## How to use

- Each domain file is revision-dense — definitions plus the distinctions the exam actually tests —
  with **"Portfolio link"** callouts connecting a concept to a concrete build.
- Acronym-heavy by design: where two concepts are easily confused, the notes state the
  distinguishing line explicitly ("X vs Y: …").
- Each domain ends with the same four-part rehearsal set: a **quick self-test** (recall), short
  **scenario drills**, a one-page **quick reference card** (key terms, acronyms, exam traps —
  the last-day revision sheet), and a ten-question **scenario bank** in
  situation → what-do-you-do → correct action → why → portfolio-link format (PBQ-style judgement).

## Supplementary — classic six-area notes

The files below pre-date the SY0-701 reorganisation and use the classic six knowledge areas. The
underlying concepts are unchanged, so they remain as supplementary cross-reference, but the
**SY0-701 files above are the primary, exam-aligned structure** — start there.

<details>
<summary>Classic six-area notes (supplementary)</summary>

1. [Threats, Attacks & Vulnerabilities](domains/1.0-threats-attacks-vulnerabilities.md)
2. [Technologies & Tools](domains/2.0-technologies-tools.md)
3. [Architecture & Design](domains/3.0-architecture-design.md)
4. [Identity & Access Management](domains/4.0-identity-access-management.md)
5. [Risk Management](domains/5.0-risk-management.md)
6. [Cryptography & PKI](domains/6.0-cryptography-pki.md)

</details>

> Notes reflect general Security+ knowledge anchored to the SY0-701 objectives. Always confirm
> exam-specific objective wording and any changed details against current official CompTIA
> materials before relying on them for the exam.

[ironveil]: https://github.com/rootdrifter/ironveil
[nullbyte]: https://github.com/rootdrifter/nullbyte
[spectre]: https://github.com/rootdrifter/spectre
[oracle]: https://github.com/rootdrifter/oracle
[mirage]: https://github.com/rootdrifter/mirage

---

*Part of the [rootdrifter](https://github.com/rootdrifter) security portfolio — study notes for a security-cleared candidate preparing CompTIA Security+ (SY0-701) and CEH.*
