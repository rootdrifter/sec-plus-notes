# SY0-701 Practice Questions

Exam-style rehearsal across all five SY0-701 domains: a mix of multiple-choice and short scenario
items. **Answers and explanations are at the bottom** — work the question set first, then check.

These are original practice items written to drill the concepts in the domain notes; they are not
real exam questions. Track which ones you miss and route back to the matching domain file:
[D1](domains/sy0-701-1-general-security-concepts.md) ·
[D2](domains/sy0-701-2-threats-vulnerabilities-mitigations.md) ·
[D3](domains/sy0-701-3-security-architecture.md) ·
[D4](domains/sy0-701-4-security-operations.md) ·
[D5](domains/sy0-701-5-program-management.md)

---

## Domain 1 — General Security Concepts

**Q1.** A company wants a control that both *discourages* an attacker and, if the attack proceeds,
*records* it for later review. Which two control functions does a visible CCTV camera with recording
provide?
- A) Preventive and corrective
- B) Deterrent and detective
- C) Compensating and directive
- D) Preventive and detective

**Q2.** Which authentication method is phishing-resistant because the credential is cryptographically
bound to the legitimate site's origin?
- A) TOTP app
- B) SMS one-time code
- C) FIDO2 / WebAuthn security key
- D) Security questions

**Q3.** In a Zero Trust architecture, which component *makes* the access decision, and which one
*enforces* it in front of the resource?

**Q4.** A developer stores user passwords using a fast hash (SHA-256, unsalted). Name two specific
weaknesses and the correct replacement approach.

---

## Domain 2 — Threats, Vulnerabilities & Mitigations

**Q5.** An attacker sets up a wireless access point broadcasting the same SSID as the corporate
Wi-Fi so employees' devices connect to it automatically. What is this attack called?
- A) Rogue AP
- B) Evil twin
- C) Jamming
- D) WPS attack

**Q6.** A trusted software vendor's update server is compromised, and a malicious update is pushed to
all customers. Which vulnerability category is this, and what mitigation most directly addresses it?

**Q7.** Match the trust relationship being abused:
- (i) XSS  (ii) CSRF
- A) abuses the *site's* trust in the user's authenticated browser
- B) abuses the *user's* trust in the site

**Q8.** A SOC notices a service account logging in from two countries 8 minutes apart, followed by a
large outbound transfer to an unknown domain. Name the two indicators of malicious activity present.

**Q9.** Which is more dangerous to a security team and why: a false positive or a false negative?

---

## Domain 3 — Security Architecture

**Q10.** Which cloud responsibility model term describes the principle that the provider secures the
infrastructure *of* the cloud while the customer secures what they put *in* it?
- A) Tenancy isolation
- B) Shared responsibility model
- C) Cloud access security broker
- D) Infrastructure as code

**Q11.** A company wants to allow a public-facing web server to be reached from the internet while
keeping its internal database network unreachable from outside. Which architectural control places
the web server in an isolated zone between two firewalls?

**Q12.** Define the RTO and RPO and explain the difference with a one-line example.

**Q13.** Which is designed for fastest failover at highest cost: a hot site, a warm site, or a cold
site?

---

## Domain 4 — Security Operations

**Q14.** Put the NIST SP 800-61 incident-response phases in order.

**Q15.** Three DNS records work together to authenticate email senders. Which record sets the
*policy* (none/quarantine/reject) applied when the others fail, and depends on them being present?
- A) SPF
- B) DKIM
- C) DMARC
- D) MX

**Q16.** During live forensic acquisition, which is collected first under the order of volatility:
the contents of RAM, or the disk image? Why?

**Q17.** A SIEM rule fires 200 times a day and every investigated instance has been benign employee
activity. Classify the alerts and state the correct remediation.

**Q18.** A Windows service runs as SYSTEM and its executable sits in a directory writable by a
standard user. Which privilege-escalation technique does this enable, and what is the fix?

---

## Domain 5 — Program Management, Risk & Compliance

**Q19.** A risk has been identified. The organisation buys cyber-insurance to offset the financial
impact rather than fixing the underlying issue. Which risk-treatment strategy is this?
- A) Avoidance
- B) Mitigation
- C) Transference
- D) Acceptance

**Q20.** Define SLE, ARO, and ALE, and give the formula linking them.

**Q21.** Which agreement type is a *non-binding* statement of intent between parties, as opposed to a
legally enforceable contract?
- A) SLA
- B) MOU
- C) BPA
- D) NDA

**Q22.** Under GDPR, what is the maximum window to report a qualifying personal-data breach to the
supervisory authority, and to whom else may notification be required?

---
---

## Answer key & explanations

**Q1 — B (Deterrent and detective).** Visible = deters; recording = detects after the fact. It is
*not* preventive (it doesn't stop entry) or corrective (it doesn't fix anything). Control *functions*
(deterrent/preventive/detective/corrective/compensating/directive) are distinct from control *types*
(technical/managerial/operational/physical). → D1.

**Q2 — C (FIDO2 / WebAuthn).** The credential is bound to the site's origin, so a phishing site at a
different domain cannot use it. TOTP and SMS codes can be relayed in real time by an
adversary-in-the-middle phishing kit. → D1.

**Q3.** The **Policy Decision Point (PDP)** — comprising the Policy Engine (PE) and Policy
Administrator (PA) — *makes* the decision; the **Policy Enforcement Point (PEP)** *enforces* it in
front of the resource. → D1.

**Q4.** Weaknesses: (1) **no salt** → identical passwords share a hash and are vulnerable to
**rainbow tables**; (2) **fast hash** → billions of guesses/sec for offline brute force. Replacement:
a deliberately slow, salted **key-derivation function** — **Argon2id** (or bcrypt/scrypt/PBKDF2). →
D1 (key stretching).

**Q5 — B (Evil twin).** It spoofs an *existing* SSID to lure clients. A rogue AP is an unauthorised
AP added to the network but not necessarily impersonating a known SSID. → D2.

**Q6.** **Supply-chain (software) vulnerability.** Most direct mitigations: **code signing /
update integrity verification**, vendor due diligence, an **SBOM**, and least-privilege for vendor
access. (SolarWinds is the canonical example.) → D2.

**Q7.** (i) XSS → **B** (abuses the user's trust in the site — script runs in the user's browser in
the site's context). (ii) CSRF → **A** (abuses the site's trust in the user's authenticated browser).
→ D2.

**Q8.** **Impossible travel** (same account, two distant locations in an implausible time) and
**anomalous outbound transfer / beaconing** (large transfer to an unknown domain → likely
exfiltration). Action: contain the account. → D2 / D4.

**Q9.** A **false negative** is more dangerous — a real attack occurred but produced no alert, so it
goes undetected and creates false confidence. False positives are costly (alert fatigue) but visible
and tunable. → D2 / D4.

**Q10 — B (Shared responsibility model).** Provider secures *of* the cloud (hardware, hypervisor,
facilities); customer secures *in* the cloud (data, IAM, configuration). Misconfiguration on the
customer side is the most common cloud breach cause. → D3.

**Q11.** A **screened subnet (DMZ)** — the web server sits between an external and an internal
firewall, reachable from the internet but unable to reach the internal database network directly. →
D3.

**Q12.** **RTO (Recovery Time Objective)** = the maximum tolerable *time* to restore a service after
an outage. **RPO (Recovery Point Objective)** = the maximum tolerable *data loss*, measured as time
back to the last good backup. Example: RTO 4h ("back online within 4 hours"); RPO 1h ("lose at most
1 hour of data" → back up at least hourly). → D3.

**Q13.** A **hot site** — fully equipped and near-real-time replicated, enabling the fastest failover
at the highest cost. Warm = some equipment/data, hours-to-restore. Cold = space/power only, longest
to bring up, cheapest. → D3.

**Q14.** **Preparation → Detection/Analysis → Containment → Eradication → Recovery → Lessons
Learned.** → D4.

**Q15 — C (DMARC).** DMARC sets the policy applied when SPF and/or DKIM fail or don't align, and adds
reporting; it depends on SPF/DKIM being configured. SPF lists authorised senders; DKIM signs the
message. → D4.

**Q16.** **RAM first.** Memory is more volatile than disk — it is lost on power-down and changes
continuously, so it must be captured before the less-volatile disk. (Order of volatility: registers/
cache → RAM → swap → disk → remote logs → backups.) → D4.

**Q17.** **False positives.** The rule is mis-firing on benign activity; the remediation is **rule
tuning** (adjust thresholds, add context, allow-list known-good) to cut the noise — alert fatigue
from FPs is the leading cause of missed true positives. → D4.

**Q18.** A writable service-binary path lets a standard user replace the executable, which then runs
as SYSTEM on service restart — an **insecure service permissions / privilege-escalation** vector
(related: unquoted service path). Fix: restrict write permissions on service binaries (and quote
service paths). *(This is the Steel Mountain CTF privesc.)* → D4.

**Q19 — C (Transference).** Shifting the financial impact to a third party (insurer) is risk
transference. Avoidance = stop the activity; mitigation = reduce likelihood/impact; acceptance =
knowingly take the risk. → D5.

**Q20.** **SLE** (Single Loss Expectancy) = Asset Value × Exposure Factor. **ARO** (Annualised Rate
of Occurrence) = expected occurrences per year. **ALE** (Annualised Loss Expectancy) = **SLE × ARO**.
ALE justifies how much it's rational to spend annually on a control. → D5.

**Q21 — B (MOU).** A Memorandum of Understanding is a non-binding statement of intent. An SLA defines
service levels (often within a contract); a BPA is a business partnership agreement; an NDA governs
confidentiality. → D5.

**Q22.** **72 hours** to notify the supervisory authority after becoming aware of a qualifying
breach. Affected **data subjects** must also be notified **without undue delay** where the breach is
likely to result in a high risk to their rights and freedoms. → D5.

---

*Score yourself by domain. Anything below ~80% in a domain → re-read that domain file and re-test.
For the real exam, also practise CompTIA performance-based questions (PBQs) — drag-and-drop and
configuration tasks — which this text format can't fully replicate.*
