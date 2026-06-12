# Domain Cross-Reference Map — SY0-701

The five domains are taught as silos but tested as a web. The same concept appears in multiple domains
wearing different hats — *encryption* is a D1 primitive, a D3 design choice, a D4 forensic tool, and a
D5 compliance control all at once. This map traces those connections so that when a scenario question
crosses domains (most of them do), you recognise the bridge instead of forcing the answer into one
silo.

> Companion to [practice-exams/exam-05.md](practice-exams/exam-05.md) (cross-domain exam) and
> [LAST_MINUTE_GUIDE.md](LAST_MINUTE_GUIDE.md). Domains: D1 Concepts · D2 Threats · D3 Architecture ·
> D4 Operations · D5 Program Management.

## How concepts span domains

| Concept | D1 (Concepts) | D2 (Threats) | D3 (Architecture) | D4 (Operations) | D5 (Program Mgmt) |
|---------|---------------|--------------|-------------------|-----------------|-------------------|
| **Encryption** | symmetric/asymmetric, hashing, PFS | attacks on weak crypto, downgrade | at-rest/in-transit design, HSM, TLS | evidence integrity (hashing), key mgmt ops | compliance (PCI/GDPR), key-mgmt policy |
| **Identity/MFA** | authn factors, AAA | phishing, MFA fatigue, password attacks | Zero Trust, IAM, SSO/federation | logon monitoring (4624/4625), deprovisioning | access policy, joiner-mover-leaver, audit |
| **Logging** | accountability, non-repudiation | IoC sources, anti-forensics (log clearing) | log architecture, SIEM placement | the core of detection/IR, correlation | audit evidence, retention, SOC 2 |
| **Access control** | least privilege, separation of duties | privilege escalation, IDOR | segmentation, RBAC/ABAC, ZTA | account review, PAM operations | policy, periodic recertification |
| **Vulnerability** | CIA impact | CVE/CWE, exploit classes | secure design, hardening | scanning, patch ops, prioritisation | risk register, remediation SLA |
| **Backup/Recovery** | availability | ransomware (the threat it answers) | immutable/offline tier, 3-2-1, sites | restore ops, IR recovery phase | RTO/RPO, BCP/DR, testing |
| **Network controls** | defence in depth | lateral movement, exploitation | firewall/IDS/IPS placement, DMZ | alert tuning, rule maintenance | control selection, cost/risk |
| **Risk** | CIA as the thing at risk | likelihood (active exploitation) | control = the mitigation | intel operationalised → priority | ALE/ARO, treatment, appetite |

## The high-value bridges (where exam questions live)

These pairings recur because real incidents force the connection. Learn the *bridge sentence*.

### D2 ↔ D4 — "what's the attack" → "how do I see it"
The most-tested bridge. Every D2 attack has a D4 detection signature.
- Password **spraying** (D2) → correlate failures **by source** across accounts (D4); per-account
  thresholds miss it.
- **Fileless/LOLBin** (D2) → process-lineage + script-block logging (D4); signature AV won't.
- **EternalBlue/MS17-010** (D2) → SMBv1 IDS signature on 445 + anomalous SYSTEM process (D4).
- **Exfiltration via DNS** (D2) → high-entropy/long subdomains to one resolver (D4).
> *Bridge sentence:* "Name the attack, then name the log source that proves it."

### D1 ↔ D4 — "the primitive" → "the operational use"
- **Hashing** (D1 integrity) → SHA-256 in the **chain of custody** (D4 forensics).
- **Forward secrecy** (D1) → why captured TLS can't be retro-decrypted in an investigation (D4).
- **Control functions** (D1) → a SIEM rule *is* a detective technical control (D4).
> *Bridge sentence:* "The concept becomes a tool the moment an incident needs it."

### D3 ↔ D5 — "the design" → "the obligation"
- **Segmentation** (D3) → shrinks **PCI-DSS** scope / limits breach blast-radius (D5).
- **Immutable backups** (D3) → satisfy **RPO** and ransomware recoverability (D5 BCP).
- **Zero Trust** (D3) → a risk *posture* decision (D5), not a product.
- **Shift-left / secure SDLC** (D3) → lowers expected-loss curve (D5 risk).
> *Bridge sentence:* "Architecture is how you discharge a compliance or risk requirement."

### D2 ↔ D3 — "the vulnerability" → "the mitigation by design"
- **Directory traversal / CWE-548 indexing** (D2) → `Options -Indexes`, canonicalisation, hardening (D3).
- **SQLi** (D2) → parameterised queries + least-priv DB + WAF in depth (D3).
- **SSRF** (D2) → egress allow-listing + block metadata endpoint (D3).
> *Bridge sentence:* "Every vuln class has a secure-by-default design that removes it."

### D4 ↔ D5 — "the incident" → "the governance"
- **IR** (D4) must satisfy **GDPR 72-hour** breach notification (D5).
- **Post-incident lessons-learned** (D4) → updates the **risk register/treatment** (D5).
- **Alert fatigue** (D4 operations) → a materialised **operational risk** (D5).
- **Third-party incident** (D4) → governed by the prior **TPRM** assessment + contract clauses (D5).
> *Bridge sentence:* "Operations executes; governance defines who must be told and what changes."

## Concept-collision warnings (terms that mean different things per domain)

| Term | One domain's meaning | Another domain's meaning | Don't confuse |
|------|----------------------|--------------------------|---------------|
| **Integrity** | D1: hash proves data unchanged | D4: evidence integrity / chain of custody | same primitive, different use |
| **Control** | D1: type × function taxonomy | D5: a selected risk treatment | taxonomy vs decision |
| **Detection** | D2: indicators of attack | D4: the operational act of detecting | knowing vs doing |
| **Recovery** | D3: HA/resilient design | D4: IR recovery phase / D5: RTO metric | design vs action vs metric |
| **Trust** | D1: trust anchor (PKI/root) | D3: Zero Trust (never trust) | anchor vs posture |

## How to use this in the exam
1. Read the scenario and ask **"which domain is this *really* testing?"** — the distractors are other
   domains' correct answers.
2. If two answers look right, one is usually the **bridge partner** from a different domain — pick the
   one that matches the *stressed* domain, not the adjacent one.
3. For "BEST/FIRST" questions, the cross-domain map tells you which control acts *earliest* in the chain.

## Cross-references
- Practice: [exam-05.md](practice-exams/exam-05.md) (every question crosses ≥2 domains)
- Recall: [MEMORY_AIDS.md](MEMORY_AIDS.md) · Final hour: [LAST_MINUTE_GUIDE.md](LAST_MINUTE_GUIDE.md)
- Evidence: [PORTFOLIO_MAP.md](PORTFOLIO_MAP.md) (each portfolio repo → the objectives it proves)
