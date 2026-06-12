# Last-Minute Study Guide — SY0-701

The one document to read in the final hour. Highest-probability material per domain, in a fixed format:
**must-know · common traps · quick definitions · portfolio evidence.** Nothing here is filler — if it
is on this page, it is because it shows up heavily on the exam or is a documented trap. Domains are
ordered by exam weight (revise top-down if time is short).

> Weights: **D4 Security Operations 28% · D2 Threats/Vulns/Mitigations 22% · D5 Program Management 20%
> · D3 Security Architecture 18% · D1 General Concepts 12%.** Spend your last hour proportionally.

---

## Domain 4 — Security Operations (28%) — *the biggest, revise first*

**Must-know**
- **Incident response lifecycle (NIST 800-61):** Preparation → Detection & Analysis → Containment →
  Eradication → Recovery → Lessons Learned. Know the order cold; questions test sequence.
- **Order of volatility** (acquire first → last): CPU registers/cache → RAM → network state/ARP →
  disk → remote logs → archival media. *Capture memory before powering off.*
- **Log sources & what each proves:** firewall/NetFlow = the connection; DNS/proxy = resolution/intent;
  EDR/Sysmon = process lineage; SIEM = correlation. **4624** logon success, **4625** failure, **4688/
  Sysmon 1** process creation, **4104** PowerShell script-block.
- **Email auth:** SPF (sender IP), DKIM (signature), DMARC (alignment + policy). All three together.
- **SOAR** automates playbooks; **UEBA** baselines behaviour; **DLP** stops exfil; **FIM** watches file
  integrity.
- **Digital forensics:** chain of custody, hashing (SHA-256) for integrity, write-blockers, legal hold.

**Common traps**
- "Power off the machine to preserve evidence" → **WRONG**; you lose RAM. Isolate, then image memory.
- Confusing **detection** (find it) with **containment** (stop spread) — containment comes *after*
  analysis confirms it.
- Picking **eradication** before **containment** — you contain first, then remove.
- Treating **MTTD/MTTR** as the same thing: *detect* vs *respond/recover*.

**Quick definitions**
SIEM · SOAR · EDR/XDR · UEBA · DLP · FIM · NAC · SPF/DKIM/DMARC · IoC vs IoA · playbook vs runbook ·
e-discovery vs legal hold.

**Portfolio evidence**
[watchtower](../watchtower) SIEM lab (20 Wazuh detection scenarios, MTTD tracker); [gauntlet](../gauntlet)
writeups each ship a detection rule + Event IDs; the "alert fatigue" thesis (tune > add rules).

---

## Domain 2 — Threats, Vulnerabilities & Mitigations (22%)

**Must-know**
- **Social engineering:** phishing (email), vishing (voice), smishing (SMS), whaling (execs),
  pretexting, **BEC**, watering-hole (compromise a site the target visits), typosquatting.
- **Password attacks:** **spraying** (one password → many accounts, evades lockout) vs **stuffing**
  (breached creds reused) vs **brute-force/dictionary** (many passwords → one account). Detection
  differs: spraying = correlate by *source*; per-account thresholds miss it.
- **Malware:** virus, worm (self-propagates), trojan, RAT, **ransomware**, logic bomb, rootkit (kernel),
  **fileless/LOLBin** (lives in memory / abuses signed binaries — defeats signature AV).
- **App attacks:** SQLi, XSS (stored/reflected/DOM), CSRF, SSRF, directory/path traversal (`../`),
  LFI/RFI, **IDOR/BOLA**, race condition (TOCTOU), buffer overflow, injection.
- **Supply chain:** compromised dependency, hardware implant, vendor/MSP compromise; **SBOM** as control.
- **Indicators:** account lockouts, impossible travel, concurrent sessions, resource spikes, new admin.

**Common traps**
- **Encoding ≠ encryption ≠ hashing.** base64 is encoding (reversible, *not* security).
- **Spraying vs stuffing** — the #1 swapped pair. Memorise the one-password-many-accounts vs
  breached-creds-reused distinction.
- A **signed** process is not automatically safe (LOLBin/fileless).
- Calling path traversal "SQL injection" because both are "injection."

**Quick definitions**
Zero-day · APT · IoC vs IoA · TTP (Pyramid of Pain — TTPs hardest to change) · CVE/CVSS · CWE ·
watering-hole · BEC · supply-chain · LOLBin.

**Portfolio evidence**
[spectre](../spectre) grey-box pentest (primary finding **CWE-548** directory indexing); [gauntlet](../gauntlet)
demonstrates spraying, LFI, web-shell, token impersonation against lab boxes.

---

## Domain 5 — Security Program Management & Oversight (20%)

**Must-know**
- **Risk formulae:** **SLE = Asset Value × EF**; **ALE = SLE × ARO**; ROSI compares control cost to
  ALE reduction. Know how to compute ALE in one step.
- **Risk treatment:** avoid · transfer (insurance) · mitigate · accept. Risk register, risk appetite,
  KRI.
- **BC/DR metrics:** **RTO** (how fast back up), **RPO** (how much data loss tolerable), **MTTR**,
  **MTBF**. RPO ↔ backup frequency; RTO ↔ recovery design.
- **Agreements:** **SLA, MSA, SOW, MOU/MOA, NDA, BPA**. Know SOW = specific work; MSA = master terms.
- **Frameworks/compliance:** NIST CSF, ISO 27001, SOC 2 (Type I = point-in-time, Type II = over a
  period), **PCI-DSS** (cardholder data, never store CVV), **GDPR** (72-hour breach notification),
  HIPAA.
- **Third-party risk:** due diligence, right-to-audit, vendor assessment, SBOM.
- **Data:** classification, owner vs custodian vs processor vs controller; retention; sovereignty.

**Common traps**
- **RTO vs RPO** swapped — Time-to-restore vs Point-of-data-loss. The single most-tested D5 pair.
- **SOC 2 Type I vs II** — point-in-time vs over-a-period.
- Confusing **data owner** (accountable) with **data custodian** (implements).
- **Quantitative** (numbers: ALE) vs **qualitative** (high/med/low) risk.

**Quick definitions**
ALE/ARO/SLE/EF · RTO/RPO/MTTR/MTBF · SLA/MSA/SOW/MOU/NDA/BPA · controller vs processor · due care vs
due diligence · SOC 2 I/II.

**Portfolio evidence**
ironveil/nullbyte threat models frame controls as *impact/likelihood reduction*; clearance =
demonstrated handling of vetting/governance obligations.

---

## Domain 3 — Security Architecture (18%)

**Must-know**
- **Network appliances & placement:** NGFW, WAF (app-layer), UTM, proxy (fwd/reverse), load balancer,
  **IDS (detect) vs IPS (block, inline)**, jump box/bastion. Know **fail-open vs fail-closed**.
- **Zero Trust:** never trust/always verify; policy engine + policy administrator + **PEP**; identity-
  and context-aware per-request; microsegmentation. *Not a product; increases logging need.*
- **Segmentation:** VLANs, DMZ, screened subnet, air-gap, east-west vs north-south.
- **Cloud:** IaaS/PaaS/SaaS + **shared responsibility**; CASB; SASE; containers; **IaC** (drift, secure
  templates); serverless.
- **Resilience:** HA, clustering, RAID, load balancing, backups (3-2-1, **immutable/offline** tier),
  hot/warm/cold sites.
- **Data protection:** encryption at rest/in transit, tokenisation, masking, **DLP**, HSM, secrets mgmt.

**Common traps**
- **IDS vs IPS** — detect-and-alert vs inline-block. And **fail-open** (availability) vs **fail-closed**
  (security).
- "Zero Trust means no firewall/no logging" → wrong; it relocates trust and *needs more* logging.
- **Tokenisation vs encryption** — token is a non-reversible surrogate (no math relationship);
  encryption is reversible with a key.
- Hot vs warm vs cold site recovery times.

**Quick definitions**
NGFW/WAF/UTM · IDS/IPS · DMZ/screened subnet · Zero Trust/PEP · SASE/CASB · shared responsibility ·
IaC · 3-2-1 backup · HSM · tokenisation.

**Portfolio evidence**
[nullbyte](../nullbyte) compartmentalisation (segmentation, least privilege, blast-radius); [ironveil](../ironveil)
defence-in-depth (FDE + FIDO2 + WireGuard + DNS filtering); rootdrifter.io nginx security headers + CSP.

---

## Domain 1 — General Security Concepts (12%) — *smallest, revise last*

**Must-know**
- **CIA triad** + non-repudiation, authenticity, accountability. **AAA** (authn/authz/accounting).
- **Control types** × **functions:** types = technical/managerial/operational/physical; functions =
  preventive/detective/corrective/deterrent/compensating/directive. *Expect a matrix question.*
- **Crypto:** symmetric (AES) vs asymmetric (RSA/ECC); **hashing** (SHA-256, integrity) vs **encryption**
  (confidentiality); **digital signature** = hash + private-key sign (integrity + non-repudiation).
- **KDF/password storage:** salted, slow KDF (**Argon2id/bcrypt/PBKDF2**) — *never* a raw fast hash.
  **Salt** (per-user, anti-rainbow) vs **pepper** (secret, stored separately) vs **nonce/IV**.
- **PKI:** CA, intermediate, CSR, CRL vs **OCSP**, key escrow, pinning. **Forward secrecy** = ephemeral
  keys (ECDHE) so past sessions survive a key compromise.
- **Authn factors:** something you know/have/are + somewhere you are / something you do. MFA combines
  *different* factors.
- **Zero Trust, deception** (honeypots/honeytokens), gap analysis, **CIA vs DAD**.

**Common traps**
- **Hashing ≠ encryption** (hashing is one-way, no key recovers it).
- **Authentication vs authorization** (who you are vs what you may do).
- "Two passwords = MFA" → **no**, same factor.
- **Salt vs pepper** (pepper is secret + stored separately).
- Static RSA has **no** forward secrecy; AES-GCM gives confidentiality+integrity but not PFS.

**Quick definitions**
CIA/AAA · control type vs function · symmetric/asymmetric · hash vs cipher vs signature · salt/pepper/
nonce/IV · Argon2id/bcrypt/PBKDF2 · PFS/ECDHE · CRL/OCSP · MFA factors.

**Portfolio evidence**
[ironveil](../ironveil) LUKS2 **Argon2id** + FIDO2 hardware MFA + PFS WireGuard; [nullbyte](../nullbyte)
verified boot (signature chain + hardware root of trust = integrity).

---

## Exam-day mechanics (the meta-skills that save points)

- **PBQs first or last?** They're worth more and take longer — many candidates **flag and skip** PBQs,
  bank the MCQs, then return. Don't let one PBQ eat 15 minutes up front.
- **Read for the domain being stressed.** SY0-701 scenarios bury the answer behind plausible distractors
  from *other* domains. Identify which domain the scenario is actually about, then answer.
- **"BEST/MOST likely/FIRST"** — more than one option is often technically true; pick the one the
  qualifier demands (first action, best primary control).
- **Eliminate two, then decide.** Most questions have two obviously-wrong options; the work is the
  remaining pair.
- **No blanks.** No penalty for guessing — answer every item; flag for review, never leave empty.
- **Mnemonics:** see [MEMORY_AIDS.md](MEMORY_AIDS.md). **Cross-domain reasoning:** see
  [DOMAIN_CROSSREF.md](DOMAIN_CROSSREF.md) and [practice-exams/exam-05.md](practice-exams/exam-05.md).

## Final-hour checklist
- [ ] Re-read D4 + D2 + D5 (70% of the exam) once more
- [ ] Recite IR lifecycle + order of volatility from memory
- [ ] Compute one ALE = ARO × SLE without notes
- [ ] State spraying-vs-stuffing and RTO-vs-RPO out loud
- [ ] Skim MEMORY_AIDS mnemonics
- [ ] Confirm exam logistics (ID, check-in time, environment)
