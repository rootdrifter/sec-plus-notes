# Practice Exam 05 — Cross-Domain Integration (SY0-701)

20 questions, **every one spanning at least two domains**. The real SY0-701 rewards candidates who
can apply a concept from one domain inside the context of another (a SOC analyst reasoning about
crypto; an architect reasoning about compliance). Questions are written fresh for this exam.

| Block | Pairing | Questions |
|-------|---------|-----------|
| A | D1 + D4 — security concepts in operations | Q1–Q5 |
| B | D2 + D4 — threats in a SOC context | Q6–Q10 |
| C | D3 + D5 — architecture with a compliance angle | Q11–Q14 |
| D | D2 + D3 — vulnerabilities with mitigation | Q15–Q17 |
| E | D4 + D5 — incident response + governance | Q18–Q20 |

Single best answer. Cover the key (below the divider) while sitting.

---

## Block A — D1 + D4 (Q1–Q5)

**Q1.** A SOC analyst sees a user account authenticate successfully from London and from Singapore
within 30 minutes. The org enforces MFA. What is the MOST likely explanation and best first action?
A) Legitimate travel — close the alert
B) Token/session theft or MFA fatigue compromise — disable the account and invalidate sessions
C) Clock skew on the SIEM — resync NTP
D) A false positive from a corporate VPN — whitelist the IP

**Q2.** During triage an analyst needs to prove a downloaded file was not altered between capture and
analysis. Which concept, and which artefact, satisfies this?
A) Confidentiality — encrypt the file with AES
B) Availability — store a second copy
C) Integrity — record a SHA-256 hash and re-verify it
D) Non-repudiation — have the analyst sign an email

**Q3.** A new detection rule must alert when a *non-admin* account is suddenly added to the Domain
Admins group. Which security-concept pairing does this control represent operationally?
A) Deterrent + physical
B) Detective + technical, supporting least privilege
C) Compensating + managerial
D) Corrective + directive

**Q4.** An analyst wants to confirm whether a flagged host actually contacted a known-malicious
domain. Which two log sources answer this MOST directly?
A) Windows Security log + antivirus quarantine
B) DNS/proxy logs + firewall/NetFlow logs
C) DHCP leases + email gateway logs
D) Patch-management + asset inventory

**Q5.** A zero-trust rollout requires that every access request be evaluated against policy and
signals before access is granted. Which operational data source MOST improves these access decisions
over time?
A) Static firewall ACLs
B) Behavioural/identity telemetry feeding the policy engine (risk-adaptive signals)
C) A longer password policy
D) A quarterly access review spreadsheet

---

## Block B — D2 + D4 (Q6–Q10)

**Q6.** Logs show hundreds of `4625` events for many usernames from one IP, then a single `4624`.
Which attack, and what is the immediate containment?
A) Credential stuffing — rotate TLS certs
B) Password spraying / brute force succeeded — disable the account, block the IP, force reset
C) Kerberoasting — disable Kerberos
D) Pass-the-hash — rebuild the domain

**Q7.** A host runs `powershell -enc <base64>` spawned by a Word process, with no file written to
disk. Which technique and which log best detects it?
A) Macro-based fileless / living-off-the-land — PowerShell script-block logging (Event `4104`)
B) Rootkit — disk forensics
C) SQL injection — web server logs
D) DDoS — NetFlow

**Q8.** A threat-intel feed provides file hashes, domains, and ATT&CK TTPs. Which indicator type
gives the MOST durable detection value, and why?
A) File hashes — they never change
B) IP addresses — attackers reuse infrastructure
C) TTPs/techniques — hardest for an adversary to change (top of the Pyramid of Pain)
D) Email subjects — unique per campaign

**Q9.** An analyst suspects data exfiltration over DNS. Which indicator in the logs supports this?
A) A spike in NXDOMAIN to a typo domain
B) Long, high-entropy subdomains queried repeatedly to one authoritative server
C) A drop in total DNS queries
D) TLS handshakes to a CDN

**Q10.** Ransomware is detected encrypting a file server. Following the order of volatility, which
action is correct?
A) Power off immediately to stop encryption
B) Isolate the host on the network (preserve RAM/live connections), then capture memory and image disk
C) Delete the malware binary first
D) Restore from backup before any evidence capture

---

## Block C — D3 + D5 (Q11–Q14)

**Q11.** An architecture stores EU customers' personal data in a US cloud region. Which design +
governance requirement applies?
A) Encrypt at rest only; no transfer concern
B) Address GDPR cross-border transfer rules (e.g. SCCs/adequacy) and data residency in the design
C) PCI-DSS network segmentation
D) HIPAA Security Rule safeguards

**Q12.** A payments platform must minimise systems in scope for PCI-DSS. Which architecture choice
BEST achieves this *and* the compliance objective?
A) Encrypt the whole network
B) Network segmentation isolating the cardholder data environment (CDE) + tokenisation of PANs
C) A single flat VLAN with a strong firewall
D) Store the CVV encrypted for refunds

**Q13.** A high-availability design adds a warm site with hourly replication. Which two governance
metrics does this most directly set, and how?
A) MTBF and MTTF — hardware reliability
B) RPO (~1h via replication) and RTO (time to cut over to the warm site)
C) ALE and SLE — financial loss
D) KRI and KPI — reporting

**Q14.** Auditors need evidence that access controls over a financial reporting system operated
effectively across the year. Which architectural feature and which report satisfy this?
A) Immutable, centralised audit logging → SOC 2 Type II
B) A firewall ruleset export → SOC 2 Type I
C) Disk encryption → ISO 27001 certificate
D) MFA screenshots → PCI ROC

---

## Block D — D2 + D3 (Q15–Q17)

**Q15.** A web app concatenates user input into SQL. Which vulnerability, and which architectural
mitigation removes the *class* of bug (not just one instance)?
A) XSS — output encoding
B) SQL injection — parameterised queries / prepared statements (defence-in-depth: WAF + least-priv DB)
C) SSRF — egress allow-list
D) CSRF — anti-CSRF tokens

**Q16.** A server's web root returns full directory listings. Name the weakness and the fix, and the
architectural principle it violates.
A) IDOR — server-side authz — least privilege
B) Directory listing (CWE-548), misconfiguration — `Options -Indexes` — secure-by-default/hardening
C) Path traversal — input canonicalisation — fail-closed
D) Information disclosure via verbose errors — custom error pages — defence in depth

**Q17.** An internal service can be coerced into requesting `http://169.254.169.254/…`. Which
vulnerability, and which network-architecture control contains it?
A) LFI — disable includes
B) SSRF — block link-local/metadata endpoints and apply an egress allow-list
C) Open redirect — validate redirect targets
D) DNS rebinding — pin IPs

---

## Block E — D4 + D5 (Q18–Q20)

**Q18.** Mid-incident, the analyst confirms a breach of records covered by GDPR. Which governance
clock starts, and what must the IR plan ensure?
A) 30 days to notify customers
B) 72 hours to notify the supervisory authority — IR plan must include the notification workflow + roles
C) No obligation if data was encrypted
D) Immediate public disclosure

**Q19.** After an incident, leadership asks how to reduce recurrence risk. Which post-incident output
feeds which governance process?
A) The disk image → risk register
B) Lessons-learned + root cause → updated risk treatment, detections, and the risk register
C) The malware sample → BIA
D) The SIEM dashboard → SoD

**Q20.** A third-party SaaS vendor suffers a breach exposing your data. Which two governance artefacts
should have defined the response *before* the incident?
A) The DR plan and the AUP
B) The vendor contract's security/breach-notification clauses and the third-party risk assessment
C) The SLA and the BIA only
D) The SoX controls matrix

---
---

# Answer Key — Exam 05 (with domain mapping)

| Q | Ans | Domains | Why |
|---|-----|---------|-----|
| 1 | **B** | D1 (auth) + D4 (triage) | Impossible-travel with MFA ⇒ session/token theft or MFA-fatigue; contain by disabling + killing sessions |
| 2 | **C** | D1 (integrity) + D4 (forensics) | Hashing proves integrity over the evidence chain |
| 3 | **B** | D1 (control types) + D4 (detection) | A SIEM rule is a detective technical control enforcing least privilege |
| 4 | **B** | D1 (concepts) + D4 (log sources) | DNS/proxy = resolution; firewall/NetFlow = the connection |
| 5 | **B** | D1 (zero trust) + D4 (telemetry) | The policy engine improves with identity/behaviour signals |
| 6 | **B** | D2 (password attacks) + D4 (Event IDs) | Many users/one IP = spraying; `4624` after `4625` flood = success |
| 7 | **A** | D2 (fileless/LOLBin) + D4 (logging) | Encoded PowerShell from Office = fileless; `4104` script-block logs catch it |
| 8 | **C** | D2 (intel) + D4 (operationalising IOCs) | TTPs are most durable — Pyramid of Pain |
| 9 | **B** | D2 (exfil) + D4 (DNS analysis) | High-entropy, long subdomains to one server = DNS tunnelling |
| 10 | **B** | D2 (ransomware) + D4 (volatility) | Isolate (preserve RAM) → capture memory → image; don't power off first |
| 11 | **B** | D3 (data architecture) + D5 (GDPR) | Cross-border transfer rules + residency belong in the design |
| 12 | **B** | D3 (segmentation) + D5 (PCI-DSS) | Segment the CDE + tokenise to shrink scope; never store CVV |
| 13 | **B** | D3 (HA/replication) + D5 (BC metrics) | Replication sets RPO; cut-over time sets RTO |
| 14 | **A** | D3 (logging) + D5 (audit) | Immutable central logs evidence SOC 2 Type II (effectiveness over a period) |
| 15 | **B** | D2 (SQLi) + D3 (mitigation) | Prepared statements remove the class; WAF + least-priv DB add depth |
| 16 | **B** | D2 (CWE-548) + D3 (hardening) | Directory listing → `Options -Indexes`; violates secure-by-default *(spectre finding)* |
| 17 | **B** | D2 (SSRF) + D3 (egress control) | Block metadata + egress allow-list contains SSRF |
| 18 | **B** | D4 (IR) + D5 (GDPR) | 72-hour authority notification; IR plan must own the workflow |
| 19 | **B** | D4 (post-incident) + D5 (risk) | Lessons-learned/root-cause update risk treatment + register |
| 20 | **B** | D4 (third-party incident) + D5 (TPRM) | Contract clauses + the prior risk assessment should pre-define the response |

**Scoring:** 17–20 strong cross-domain reasoning · 13–16 solid, review the misses · ≤12 re-drill the
weaker domain in each missed pairing (see the sprint exams). Cross-domain questions punish rote
memorisation — if you missed several, practise *explaining why the other three options are wrong*.
