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
| 1.4 Hardware root of trust / attestation | D1/D3 | Titan M2 (+ Trusty TEE + Tensor G5 security core) verified-boot chain, bootloader relocked, boot key hash confirmed (`6836b3c5…`) | nullbyte |
| 2.2 Attack types — directory listing exposure | D2 | CWE-548 primary finding (web root indexing) | spectre |
| 2.2 Service/version disclosure recon | D2 | nmap -sS -sV -O banner disclosure (CWE-200) | spectre |
| 2.3 Vulnerability types — misconfiguration, least-privilege violation | D2 | sudo over-privilege (CWE-250), missing security headers | spectre |
| 2.3 Supply-chain attack surface | D2 | Vendor cloud daemons (Synapse/iCUE) deliberately absent | ironveil |
| 2.4 Indicators of compromise / analysis | D2 | Causal phishing-construct detection over 88,647 emails | mirage |
| 2.4 Social-engineering mechanisms (urgency/authority/trust) | D2 | Five validated causal constructs, DoWhy-refuted | mirage |
| 2.5 Mitigations — hardening, host isolation | D2 | LUKS2 + FIDO2 + WireGuard + AdGuard defence-in-depth | ironveil |
| 3.1 Architecture models — compartmentalisation / blast radius | D3 | Nine-profile isolation, no cross-profile state | nullbyte |
| 3.1 Encrypted egress / secure comms | D3 | WireGuard `wg-CH-FI-2` + `wg-SE-FI-1`, full-tunnel routing for all external traffic | ironveil |
| 3.3 Data states — data at rest | D3 | LUKS2 `aes-xts-plain64`/512-bit, Argon2id passphrase + 2× PBKDF2/SHA-512 FIDO2 keyslots | ironveil |
| 3.3 Data at rest (mobile) / per-profile encryption | D3 | Per-profile keys derived from lockscreen credential | nullbyte |
| 3.4 Resilience — key custody redundancy | D3 | NK#1 primary, NK#2 offline backup, offline passphrase | ironveil |
| 4.1 Hardening targets — workstation baseline | D4 | Fedora 44 hardening: dracut-sshd (v0.7.1-5.fc44) pre-boot SSH, service minimisation, RGB-without-vendor-daemons (SELinux status pending) | ironveil |
| 4.1 Hardening targets — mobile (MDM-equivalent) | D4 | GrapheneOS posture: verified boot, per-app network policy (RethinkDNS) | nullbyte |
| 4.4 Security monitoring — DNS chokepoint | D4 | AdGuard Home (`*:53`) → Quad9 DoH over the WireGuard tunnel; all queries filtered and encrypted pre-egress | ironveil |
| 4.4 Detection engineering from attack technique | D4 | gauntlet defender-perspective sections (Event IDs, Sigma/Splunk) | gauntlet |
| 4.5 Email security / anti-phishing | D4 | Phishing-corpus causal analysis (channel-independent constructs) | mirage |
| 4.6 IAM — authentication factors, phishing-resistant | D4 | FIDO2 hardware key (something-you-have + presence) | ironveil |
| 4.8 Incident response — evidence handling / chain of custody | D4 | SHA-256-hashed artefacts, dual session logs, scope-halt discipline; full forensic spec in `spectre/evidence-chain.md` (integrity vs authenticity vs custody kept distinct) | spectre |
| 4.8 Forensics — order of volatility, defensible reporting | D4 | PTES-aligned reporting, ISO 27002 / CIS mapping | spectre |
| 3.1 Architecture — threat modelling / adversary analysis | D3 | `ironveil/threat-model.md`: defined adversary set, asset inventory, per-vector (control → residual → honest gap) incl. the measured-boot/evil-maid gap | ironveil |
| 3.1 Architecture — blast-radius / per-boundary threat model | D3 | `nullbyte/threat-model.md`: per-profile blast-radius analysis against a defined adversary set | nullbyte |
| 5.1 Risk management — compensating controls, scope/ROE | D5 | LinPEAS halted pre-token-harvest (rules-of-engagement) | spectre |
| 5.2 Frameworks / benchmark mapping | D5 | CIS Apache 2.4 + PostgreSQL 16 L1, ISO/IEC 27002:2022 | spectre |
| 5.4 Privacy by design / data minimisation | D5 | CVAE-synthesised vishing data — no real voice processed | mirage |
| 5.5 Third-party / supply-chain risk, provenance | D5 | Auditable from-scratch model vs opaque pretrained (provenance trade-off) | oracle |
| 5.6 Evaluation methodology / measurement rigour | D5 | ICC(2,1)=0.98 inter-rater reliability; DoWhy refutation | mirage |

## Expansion — additional verified mappings (2026-06-12)

Further objective rows with concrete evidence, including the precision-pass concepts (flow
telemetry, ephemeral keys, fail-modes) and the now-live publication platform. Same rule: nothing
aspirational — watchtower rows are marked **(in build)** and describe the *designed* detection, not
claimed results.

| Objective (SY0-701) | Domain | Portfolio evidence | Repo |
|---------------------|--------|--------------------|------|
| 1.4 Ephemeral keys / perfect forward secrecy | D1 | WireGuard Curve25519 ephemeral session keys (`wg-CH-FI-2`/`wg-SE-FI-1`) — PFS by design | ironveil |
| 1.4 Key stretching / memory-hard KDF | D1 | LUKS2 passphrase keyslot derived with **Argon2id** (memory-hard), not plain PBKDF2 | ironveil |
| 2.3 Memory-resident / signature-evasion concepts | D2 | gauntlet post-exploitation notes (living-off-the-land, behaviour over signature) | gauntlet |
| 3.2 Secure communication protocols — DoH vs plaintext DNS | D3 | AdGuard → Quad9 **DoH/443** inside the full tunnel; no plaintext :53 egress | ironveil |
| 3.2 Network appliance placement / chokepoint | D3 | DNS filtering chokepoint (AdGuard) + SSH-only management ingress (dracut-sshd), no open mgmt ports | ironveil |
| 3.4 Backups / RTO-RPO / tested restore | D3/D4 | rootdrifter.io: daily automated backups + verified restore path; immutable off-host copy | rootdrifter.io |
| 4.1 Hardening — web platform (TLS, headers, CSP) | D4 | rootdrifter.io nginx: HTTP→HTTPS 301, 6 security headers, Ghost-correct CSP, `server_tokens off` | rootdrifter.io |
| 4.4 Flow/telemetry visibility (host scale) | D4 | AdGuard query log + WireGuard interface counters = who/where without payload (NetFlow analogue) | ironveil |
| 4.4 Defensive monitoring — SIEM detection design | D4 | Wazuh ATT&CK detection scenarios + custom rule templates **(in build)** | watchtower |
| 4.5 Brute-force detection / response | D4 | rootdrifter.io fail2ban actively banning real SSH brute-force (5 IPs observed) | rootdrifter.io |
| 4.8 Offensive technique → detection mapping | D4 | gauntlet ATT&CK techniques mapped to watchtower detection scenarios (GAUNTLET_BRIDGE) **(in build)** | gauntlet→watchtower |
| 5.5 Pentest classification (grey-box / RoE) | D5 | spectre = partially-known environment, PTES-structured, LinPEAS halted at scope boundary | spectre |
| 5.5 Provenance / from-scratch vs pretrained trade-off | D5 | oracle TerraCNN (93.97% / F1 0.9390, auditable) vs ResNet-18 (99.11% / F1 0.9916, opaque) | oracle |
| 5.4 Data classification / handling at OS level | D5 | nullbyte per-profile compartmentalisation = data separation by sensitivity | nullbyte |

> rootdrifter.io is the live publication/SIEM-blog platform (Stage 1). It is operational
> infrastructure, not one of the six project repos, but it is real, deployed evidence for the
> hardening/monitoring objectives above.

## How to drill with this map

- **Per domain:** before a domain's exam, read its rows here and open the linked repo page — turn
  each abstract objective into "the thing I built".
- **Interview prep:** for any "tell me about a time you…" question, this table gives the repo +
  the specific artefact. Pair with `cv/interview-prep.md`.
- **Accuracy guard:** when citing figures in an answer, use the canonical values (oracle TerraCNN
  93.97% from scratch vs ResNet-18 99.11% pretrained — never swapped; mirage 88,647 / ICC 0.98;
  spectre Apache 2.4.58 / CWE-548; nullbyte nine profiles / Titan M2; ironveil Nitrokey 3A NFC).
