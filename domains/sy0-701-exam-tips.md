# SY0-701 Exam Tips — High-Yield Topics and Trap Questions

## Formula sheet

| Formula | Variables | Use |
|---------|-----------|-----|
| **SLE = AV × EF** | Asset Value × Exposure Factor | Single loss expectancy |
| **ALE = SLE × ARO** | × Annualised Rate of Occurrence | Annual expected loss |
| **Control justified if:** Annual cost < ALE reduction | | ROI check for security investment |

---

## High-yield topics by domain

### Domain 1 — General Security Concepts (12%)
- Control types: function (preventive/detective/corrective/deterrent/compensating/directive) × nature (technical/administrative/physical) — expect questions combining both
- AAA framework — authentication vs authorisation vs accounting
- FIDO2 phishing-resistant vs TOTP/SMS not phishing-resistant — know the mechanism
- Biometrics: FAR, FRR, CER — which to minimise for security vs usability
- Non-repudiation — digital signatures, not just hashing

### Domain 2 — Threats, Vulnerabilities & Mitigations (22%)
- Social engineering principles — Cialdini: authority, urgency, scarcity, consensus, familiarity, trust, intimidation
- Malware taxonomy — rootkit vs bootkit; fileless malware (LOLBins); ransomware vs crypto-malware
- Password attacks — spraying (few passwords, many accounts) vs stuffing (reused breached creds) vs brute force
- STIX vs TAXII — format vs transport
- CVE vs CVSS vs CWE — catalogue entry vs score vs weakness type
- XSS vs CSRF — whose trust is abused in each (classic wording on the exam)
- CISA KEV — highest-priority patching list; confirms active exploitation

### Domain 3 — Security Architecture (18%)
- Cloud shared responsibility — customer always owns data and IAM
- CASB vs CSPM — CASB = visibility/policy for cloud app usage; CSPM = misconfiguration detection
- Hypervisor Type 1 (bare-metal) vs Type 2 (hosted) — and VM escape as the critical risk
- OT/ICS: prioritises availability over confidentiality; Purdue model; compensating controls
- Backup types: full (slow backup, fast restore) vs incremental (fast backup, slow restore) vs differential (middle)
- 3-2-1 rule: 3 copies, 2 media types, 1 offsite
- RTO vs RPO: downtime vs data loss

### Domain 4 — Security Operations (28% — highest weight)
- SIEM vs SOAR — detection + alerting vs automated response on top
- NTP importance: required for SIEM event correlation AND Kerberos (5-minute skew limit)
- OAuth vs OpenID Connect — authorisation vs authentication (OpenID Connect adds auth on top of OAuth)
- RADIUS vs TACACS+ — RADIUS UDP/encrypts only password; TACACS+ TCP/encrypts everything
- Access models: DAC (owner decides) vs MAC (system enforces labels) vs RBAC (role decides) vs ABAC (attributes + context)
- NIST 800-61 IR phases: Preparation → Detection → Containment → Eradication → Recovery → Lessons Learned
- Order of volatility: RAM/cache → disk → remote logs → archives (volatile first)
- Write blockers: required for forensically sound evidence acquisition
- EDR vs AV: EDR provides continuous telemetry, behaviour detection, automated response

### Domain 5 — Program Management & Oversight (20%)
- NIST CSF five functions: Identify, Protect, Detect, Respond, Recover
- SOC 2 Type I (designed at a point in time) vs Type II (operating effectively over a period)
- Audit (conformance check) vs assessment (posture evaluation)
- GDPR: 72-hour breach notification to supervisory authority; data controller vs processor
- KRI (leading indicator) vs KPI (performance measure)
- Crypto-erase works on SSDs; degaussing does not
- Data sanitisation methods: deletion (recoverable) vs wiping vs crypto-erase vs degaussing vs physical destruction

---

## Common trap questions

| Trap | Correct distinction |
|------|---------------------|
| OAuth vs OpenID Connect | OAuth = authorisation (what you can do); OIDC = authentication (who you are) |
| SAML vs OAuth | SAML = XML-based web SSO (browser redirect); OAuth = token-based API authorisation |
| IDS vs IPS | IDS = out-of-band, detect + alert only; IPS = inline, can block |
| Forward proxy vs reverse proxy | Forward = client protection (hides clients); Reverse = server protection (hides servers) |
| Network firewall vs WAF | Firewall = L3/L4 (IP/port); WAF = L7 (HTTP, application layer) |
| Symmetric vs asymmetric | Symmetric = fast, shared secret; Asymmetric = key pair, slow, used for key exchange |
| Signing vs encrypting | Sign with *sender's* private key; encrypt with *recipient's* public key |
| Authentication vs authorisation | Authn = prove identity; Authz = what you may do |
| Audit vs assessment | Audit = conformance pass/fail; Assessment = posture evaluation + recommendations |
| Full vs incremental backup | Full = fastest restore; Incremental = fastest backup |
| RTO vs RPO | RTO = max downtime (how long can you be offline?); RPO = max data loss (how old can the backup be?) |
| MTTD vs MTTR | MTTD = time to detect; MTTR = time to respond/recover |
| KRI vs KPI | KRI = leading (risk is rising); KPI = performance (how well did you do?) |
| CVE vs CVSS vs CWE | CVE = catalogue entry; CVSS = severity score; CWE = weakness type |
| Data controller vs processor | Controller = decides purpose; Processor = acts on controller's behalf |
| Tokenisation vs encryption | Tokenisation = non-sensitive token replaces real value (stored in vault); Encryption = reversible with key |
| STIX vs TAXII | STIX = data format for threat intel; TAXII = transport/sharing protocol |

---

## Acronym disambiguation list

| Acronym | Full name | Key distinguisher |
|---------|-----------|-------------------|
| ALE | Annualised Loss Expectancy | = SLE × ARO |
| ARO | Annualised Rate of Occurrence | How often per year |
| CER/EER | Crossover Error Rate | Where FAR=FRR; lower = better biometric |
| CSPM | Cloud Security Posture Management | Finds cloud misconfigurations |
| CASB | Cloud Access Security Broker | Visibility + policy between users and cloud apps |
| DLP | Data Loss Prevention | Stops exfiltration |
| EPP | Endpoint Protection Platform | AV + firewall + basic EDR |
| FAR | False Accept Rate | Let impostors in — security risk |
| FRR | False Reject Rate | Deny legitimate users — usability problem |
| HIDS | Host-Based Intrusion Detection System | On the endpoint, not the network |
| IoC | Indicator of Compromise | Evidence of breach (IP, hash, domain) |
| IoA | Indicator of Attack | Behavioural pattern of ongoing attack |
| MTD | Maximum Tolerable Downtime | RTO must be ≤ MTD |
| MTBF | Mean Time Between Failures | Reliability measure |
| MTTD | Mean Time to Detect | How long until you know about it |
| MTTR | Mean Time to Repair/Recover | How long to fix it |
| NIDS | Network Intrusion Detection System | Monitors network traffic |
| PAM | Privileged Access Management | Vaulting + JIT for admin accounts |
| RAID | Redundant Array of Independent Disks | 0=stripe, 1=mirror, 5=parity, 6=dual-parity, 10=mirror+stripe |
| RPO | Recovery Point Objective | Max acceptable data loss (drives backup frequency) |
| RTO | Recovery Time Objective | Max acceptable downtime |
| SASE | Secure Access Service Edge | SD-WAN + cloud security in one |
| SBOM | Software Bill of Materials | Inventory of all software components |
| SLE | Single Loss Expectancy | AV × EF |
| SOAR | Security Orchestration, Automation and Response | Automates response on top of SIEM |
| STIX | Structured Threat Information eXpression | Threat intel data format |
| TAXII | Trusted Automated eXchange of Indicator Information | Threat intel transport |
| TEE | Trusted Execution Environment | Isolated processing environment |
| UBA/UEBA | User (and Entity) Behaviour Analytics | Detects anomalous user behaviour |

---

## Last-day review checklist

- [ ] NIST CSF five functions: Identify, Protect, Detect, Respond, Recover
- [ ] NIST 800-61 IR lifecycle: Preparation → Detection → Containment → Eradication → Recovery → Lessons Learned
- [ ] ALE = SLE × ARO = (AV × EF) × ARO
- [ ] RTO (downtime) vs RPO (data loss) vs MTD (absolute maximum)
- [ ] Full/incremental/differential backup trade-offs
- [ ] 3-2-1 backup rule
- [ ] Shared responsibility: customer always owns data and IAM
- [ ] IDS out-of-band (detect); IPS inline (block)
- [ ] FIDO2 = phishing-resistant; TOTP/SMS = not phishing-resistant
- [ ] OAuth = authz; OIDC = authn; SAML = XML-based federation
- [ ] RADIUS UDP (encrypts password only); TACACS+ TCP (encrypts everything)
- [ ] Kerberos needs NTP (5-minute tolerance)
- [ ] Order of volatility: RAM first
- [ ] Write blockers for forensically sound imaging
- [ ] FAR (security risk) vs FRR (usability problem) vs CER (lower = better biometric)
- [ ] Data controller (decides purpose) vs processor (acts on behalf of controller) under GDPR
- [ ] GDPR 72-hour breach notification to supervisory authority
- [ ] SOC 2 Type I (design) vs Type II (operating effectiveness over time)
- [ ] CVE (catalogue) vs CVSS (score) vs CWE (weakness type)
- [ ] XSS (abuses user trust in site) vs CSRF (abuses site trust in browser)
- [ ] KRI (leading indicator) vs KPI (performance measure)

---

*Confirm all exam objective wording and any version-specific details against current official
CompTIA SY0-701 materials before sitting the exam.*
