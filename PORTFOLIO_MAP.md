# Portfolio → Exam Cross-Reference Map

Every SY0-701 objective that has **direct, real evidence** in the rootdrifter portfolio. Two uses:

1. **Study reinforcement** — a concept you have actually built sticks far better than one you only
   read. When a note feels abstract, jump to the implementation.
2. **Interview evidence** — "give me an example of X" has a concrete portfolio answer for every row
   here. The same mapping powers the exam's portfolio-referencing scenario questions
   (`practice-exams/exam-03.md`, ★ items).

Only verified implementations are listed — nothing aspirational. Repos: ironveil (hardened
workstation), nullbyte (GrapheneOS mobile), spectre (grey-box pentest), oracle (applied-ML
security), mirage (causal LLM phishing research), gauntlet (CTF methodology).

| Objective (SY0-701) | Domain | Portfolio evidence | Repo |
|---------------------|--------|--------------------|------|
| 1.2 Fundamental security concepts — non-repudiation, integrity | D1 | SHA-256 evidence chain across 24 artefacts | spectre |
| 1.2 Zero Trust / least privilege boundaries | D1/D4 | Nine independently-encrypted profiles; key exists only where needed (Façade) | nullbyte |
| 1.2 Deception & disruption technology | D1 | (concept) honeytokens — seen in exam-01 Q5; no live honeypot yet | — |
| 1.4 PKI / certificates / key storage | D1 | FIDO2 credential in hardware (Nitrokey 3A NFC), touch-only, no clientPin | ironveil |
| 1.4 Hardware root of trust / attestation | D1/D3 | Titan M2 verified boot chain, bootloader relocked | nullbyte |
| 2.2 Attack types — directory listing exposure | D2 | CWE-548 primary finding (web root indexing) | spectre |
| 2.2 Service/version disclosure recon | D2 | nmap -sS -sV -O banner disclosure (CWE-200) | spectre |
| 2.3 Vulnerability types — misconfiguration, least-privilege violation | D2 | sudo over-privilege (CWE-250), missing security headers | spectre |
| 2.3 Supply-chain attack surface | D2 | Vendor cloud daemons (Synapse/iCUE) deliberately absent | ironveil |
| 2.4 Indicators of compromise / analysis | D2 | Causal phishing-construct detection over 88,647 emails | mirage |
| 2.4 Social-engineering mechanisms (urgency/authority/trust) | D2 | Five validated causal constructs, DoWhy-refuted | mirage |
| 2.5 Mitigations — hardening, host isolation | D2 | LUKS2 + FIDO2 + WireGuard + AdGuard defence-in-depth | ironveil |
| 3.1 Architecture models — compartmentalisation / blast radius | D3 | Nine-profile isolation, no cross-profile state | nullbyte |
| 3.1 Encrypted egress / secure comms | D3 | WireGuard wg-SE-RO-1, all external traffic tunnelled | ironveil |
| 3.3 Data states — data at rest | D3 | LUKS2 Argon2id full-disk encryption, 3 keyslots | ironveil |
| 3.3 Data at rest (mobile) / per-profile encryption | D3 | Per-profile keys derived from lockscreen credential | nullbyte |
| 3.4 Resilience — key custody redundancy | D3 | NK#1 primary, NK#2 offline backup, offline passphrase | ironveil |
| 4.1 Hardening targets — workstation baseline | D4 | Documented Fedora hardening: SELinux, services, RGB-without-daemons | ironveil |
| 4.1 Hardening targets — mobile (MDM-equivalent) | D4 | GrapheneOS posture: verified boot, per-app network policy (RethinkDNS) | nullbyte |
| 4.4 Security monitoring — DNS chokepoint | D4 | AdGuard Home on loopback; all queries filtered pre-egress | ironveil |
| 4.4 Detection engineering from attack technique | D4 | gauntlet defender-perspective sections (Event IDs, Sigma/Splunk) | gauntlet |
| 4.5 Email security / anti-phishing | D4 | Phishing-corpus causal analysis (channel-independent constructs) | mirage |
| 4.6 IAM — authentication factors, phishing-resistant | D4 | FIDO2 hardware key (something-you-have + presence) | ironveil |
| 4.8 Incident response — evidence handling / chain of custody | D4 | SHA-256-hashed artefacts, dual session logs, scope-halt discipline | spectre |
| 4.8 Forensics — order of volatility, defensible reporting | D4 | PTES-aligned reporting, ISO 27002 / CIS mapping | spectre |
| 5.1 Risk management — compensating controls, scope/ROE | D5 | LinPEAS halted pre-token-harvest (rules-of-engagement) | spectre |
| 5.2 Frameworks / benchmark mapping | D5 | CIS Apache 2.4 + PostgreSQL 16 L1, ISO/IEC 27002:2022 | spectre |
| 5.4 Privacy by design / data minimisation | D5 | CVAE-synthesised vishing data — no real voice processed | mirage |
| 5.5 Third-party / supply-chain risk, provenance | D5 | Auditable from-scratch model vs opaque pretrained (provenance trade-off) | oracle |
| 5.6 Evaluation methodology / measurement rigour | D5 | ICC(2,1)=0.98 inter-rater reliability; DoWhy refutation | mirage |

## How to drill with this map

- **Per domain:** before a domain's exam, read its rows here and open the linked repo page — turn
  each abstract objective into "the thing I built".
- **Interview prep:** for any "tell me about a time you…" question, this table gives the repo +
  the specific artefact. Pair with `cv/interview-prep.md`.
- **Accuracy guard:** when citing figures in an answer, use the canonical values (oracle TerraCNN
  93.97% from scratch vs ResNet-18 99.11% pretrained — never swapped; mirage 88,647 / ICC 0.98;
  spectre Apache 2.4.58 / CWE-548; nullbyte nine profiles / Titan M2; ironveil Nitrokey 3A NFC).
