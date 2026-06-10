# Practice Exam 01 — CompTIA Security+ SY0-701 (90 questions)

A full-length simulated exam. Domain weighting matches the real exam:

| Domain | Weight | Questions |
|--------|--------|-----------|
| 1 — General Security Concepts | 12% | 1–11 |
| 2 — Threats, Vulnerabilities & Mitigations | 22% | 12–31 |
| 3 — Security Architecture | 18% | 32–47 |
| 4 — Security Operations | 28% | 48–72 |
| 5 — Security Program Management & Oversight | 20% | 73–90 |

**Instructions.** Single best answer per question. Target ~90 minutes. The answer key is below a
clear divider so you can cover it while sitting the exam. Questions are written fresh for this exam
(not copied from [practice-questions.md](../practice-questions.md) or the per-domain drills). Several
reference the rootdrifter portfolio to connect study to real builds.

---

## Domain 1 — General Security Concepts (Q1–Q11)

**Q1.** A CCTV camera that is clearly visible and records footage provides which two control functions?
A) Preventive and corrective
B) Detective and deterrent
C) Compensating and directive
D) Technical and physical

**Q2.** Which mechanism most directly provides non-repudiation for an electronic document?
A) AES-256-GCM encryption
B) An SHA-256 hash of the document
C) A digital signature created with the sender's private key
D) A shared HMAC key

**Q3.** In a Zero Trust architecture, which component makes the access decision by evaluating policy
against signals?
A) Policy Enforcement Point (PEP)
B) Policy Engine (PE)
C) Policy Administrator (PA)
D) Implicit trust zone

**Q4.** ironveil unlocks its LUKS2 volume with a Nitrokey 3A NFC enrolled for touch-only FIDO2 (no
clientPin). Which single authentication factor does this represent?
A) Something you know
B) Something you are
C) Something you have
D) Somewhere you are

**Q5.** A security team deliberately seeds a fake credential named `svc_backup_DONOTUSE` into a
production system and alerts on any use of it. What have they deployed?
A) A honeypot
B) A honeytoken
C) A DNS sinkhole
D) A bastion host

**Q6.** Which certificate-status mechanism removes the client→CA round trip and the associated privacy
leak by having the server present a signed status during the TLS handshake?
A) CRL
B) OCSP
C) OCSP stapling
D) Key escrow

**Q7.** An organisation compares its current control set against the NIST CSF to find what is missing.
This activity is best described as:
A) A penetration test
B) A gap analysis
C) A risk transfer
D) Change management

**Q8.** Which password-storage approach is designed to be deliberately slow and memory-hard to resist
brute force?
A) SHA-1
B) Base64 encoding
C) Argon2id
D) AES-CBC

**Q9.** A change ticket adds a new internet-facing service. The firewall allow-list is updated and the
service goes live, but an overnight batch job that relied on the old port silently fails. Which
change-management element was most likely skipped?
A) Maintenance window
B) Impact analysis / dependency mapping
C) Approval by the CAB
D) Stakeholder notification

**Q10.** Which statement correctly distinguishes tokenisation from encryption?
A) Tokenisation is irreversible; encryption is reversible
B) Tokenisation replaces data with a token whose real value lives in a separate vault; encryption transforms data using a key
C) Tokenisation provides integrity; encryption provides availability
D) They are identical in effect

**Q11.** A subject requests access to a resource. Order the Zero Trust flow correctly.
A) PEP → PA → PE, then the PEP issues the token
B) PE → PEP → PA, then the PA enforces at the resource
C) Request hits the PEP → PDP evaluates (PE decides, PA issues/revokes the token) → PEP allows or blocks
D) PA decides, PE enforces, PEP audits

---

## Domain 2 — Threats, Vulnerabilities & Mitigations (Q12–Q31)

**Q12.** What three attributes define an Advanced Persistent Threat (APT)?
A) Automated, public, temporary
B) Advanced tooling, persistent long-dwell access, organised/funded threat
C) Anonymous, prolific, transient
D) Amateur, political, targeted

**Q13.** An attacker tries a handful of common passwords (`Summer2026!`, `Password1`) across hundreds
of accounts to stay under lockout thresholds. This is:
A) Credential stuffing
B) Password spraying
C) Pass-the-hash
D) A rainbow-table attack

**Q14.** Cross-Site Scripting (XSS) and Cross-Site Request Forgery (CSRF) differ in whose trust they
abuse. Which is correct?
A) XSS abuses the site's trust in the user; CSRF abuses the user's trust in the site
B) XSS abuses the user's trust in the site; CSRF abuses the site's trust in the user's browser
C) Both abuse the server's trust in the database
D) Both abuse the browser's trust in the DNS resolver

**Q15.** A vendor pushes a routine signed software update; days later, multiple of that vendor's
customers are breached through the updated binary. Which vulnerability type and vector?
A) Misconfiguration — open S3 bucket
B) Supply-chain — compromised software update channel
C) Cryptographic — weak TLS
D) Zero-day — browser exploit

**Q16.** spectre's primary finding was an Apache host returning a full directory listing. Which CWE
and remediation match this?
A) CWE-89; use parameterised queries
B) CWE-79; output-encode user input
C) CWE-548 (directory listing); disable auto-indexing (`Options -Indexes`)
D) CWE-78; validate shell input

**Q17.** Which prioritisation is correct when scheduling patches?
A) Always patch the highest CVSS first regardless of context
B) A CVSS 7.5 on the CISA KEV list (actively exploited) generally outranks a CVSS 9.8 with no known exploit
C) Internal hosts before internet-facing hosts
D) Patch by alphabetical asset name

**Q18.** A wireless access point broadcasts the same SSID as the corporate network so clients
auto-connect to it. What is this attack?
A) Rogue AP
B) Evil twin
C) Jamming
D) WPS brute force

**Q19.** Which two controls specifically defeat rainbow-table attacks and slow password cracking?
A) Salting and a memory-hard KDF
B) Hashing and base64
C) Tokenisation and masking
D) TLS and HSTS

**Q20.** Fileless malware most commonly evades signature-based antivirus by:
A) Encrypting the disk
B) Living in memory and abusing legitimate tools (PowerShell, WMI, certutil)
C) Replacing the MBR
D) Exhausting CPU via mining

**Q21.** A SOC sees a user account log in from London and then from Tokyo eleven minutes later, then a
spike in outbound traffic to an unfamiliar domain. Which indicators fired?
A) Resource exhaustion and missing logs
B) Impossible travel and anomalous outbound/beaconing
C) Account lockout and failed logins
D) DNS poisoning and ARP spoofing

**Q22.** mirage studies the causal mechanisms behind social engineering. Which set lists genuine
social-engineering levers (Cialdini-style)?
A) Authority, urgency, scarcity, consensus
B) Encryption, hashing, salting, signing
C) RAID, backup, snapshot, replication
D) SPF, DKIM, DMARC, DNSSEC

**Q23.** Pass-the-hash specifically captures and reuses:
A) A Kerberos TGT
B) An NTLM hash to authenticate without cracking it
C) A TOTP seed
D) A TLS session ticket

**Q24.** An asset cannot be patched because the vendor no longer exists and the firmware is end-of-life.
What is the correct response?
A) Remove it from the inventory
B) Apply compensating controls (segment/isolate, restrict access, monitor) and document a risk exception
C) Ignore it until it fails
D) Connect it to the flat network for visibility

**Q25.** Staff receive a fluent, personalised, grammatically perfect phishing email referencing a real
internal project. Which defence still holds even though the classic "grammar tells" are gone?
A) A spam filter keyword blocklist
B) Phishing-resistant FIDO2 MFA plus out-of-band verification
C) Longer passwords
D) Disabling macros only

**Q26.** STIX and TAXII relate how?
A) STIX is the transport; TAXII is the data format
B) STIX is the data format for threat intel; TAXII is the transport protocol that shares it
C) Both are encryption standards
D) Both are vulnerability scanners

**Q27.** Which distinguishes a false negative from a false positive in detection, and why does it
matter most?
A) A false positive misses a real attack — the dangerous one
B) A false negative misses a real attack — the dangerous one, because it creates false confidence
C) They are equally harmful in all contexts
D) A false negative is always benign

**Q28.** Bluesnarfing differs from bluejacking in that bluesnarfing:
A) Sends unsolicited messages
B) Steals data over Bluetooth
C) Jams the 2.4 GHz band
D) Clones an RFID badge

**Q29.** A penetration tester performs only WHOIS lookups, certificate-transparency searches, and
Shodan queries before touching the target. This is:
A) Active reconnaissance
B) Passive reconnaissance / OSINT
C) Exploitation
D) Privilege escalation

**Q30.** Which is a virtualization-specific *attack* (as opposed to a hygiene problem)?
A) VM sprawl
B) VM escape
C) Snapshot accumulation
D) Over-provisioning

**Q31.** A legacy in-house service crashes whenever an input field exceeds ~1,000 characters. The most
security-relevant interpretation is:
A) A harmless stability bug
B) A probable buffer overflow that could become code execution; confirm DEP/ASLR and add bounds checking
C) A DNS misconfiguration
D) A TLS handshake failure

---

## Domain 3 — Security Architecture (Q32–Q47)

**Q32.** Under the cloud shared-responsibility model, what does the customer ALWAYS retain across
IaaS, PaaS, and SaaS?
A) The hypervisor
B) Physical security
C) Their data and identity/access management
D) The host operating system

**Q33.** Which cloud control's core purpose is continuously detecting misconfigurations (open buckets,
over-permissive IAM)?
A) CASB
B) CSPM
C) CWPP
D) SASE

**Q34.** A design requires a public web server reachable from the internet while the internal database
remains unreachable from outside. Which architecture fits?
A) Place both on the internal VLAN with a port-forward
B) A screened subnet (DMZ) between two firewalls, DB on an internal segment with no inbound path
C) An air gap around the web server
D) A single flat subnet with host firewalls

**Q35.** DNSSEC provides which property?
A) Confidentiality of DNS queries
B) Authenticity and integrity of DNS records (not confidentiality)
C) Encrypted transport over port 853
D) Load balancing of resolvers

**Q36.** ironveil routes queries application → systemd-resolved (127.0.0.1) → AdGuard Home → WireGuard
tunnel → upstream. An observer on the external interface sees:
A) Plaintext DNS on UDP/53
B) Only WireGuard-encrypted traffic
C) The upstream resolver's IP in cleartext
D) The full query and response

**Q37.** A Type 1 hypervisor is best described as:
A) Hosted on a desktop OS (e.g. VirtualBox)
B) Bare-metal, running directly on hardware (e.g. ESXi, KVM)
C) A container runtime
D) A network firewall

**Q38.** Containers provide weaker isolation than VMs primarily because they:
A) Use more memory
B) Share the host kernel
C) Cannot be networked
D) Require a hypervisor

**Q39.** A business states: "we can lose at most one hour of data and must be back within four hours."
Translate to metrics.
A) RTO = 1h, RPO = 4h
B) RPO = 1h, RTO = 4h
C) MTBF = 1h, MTTR = 4h
D) MTD = 1h, RPO = 4h

**Q40.** Ransomware encrypts the production fileserver AND the latest backup because the backup share
was writable. Which single backup property would have prevented the backup loss?
A) Faster backup speed
B) Immutability (WORM / offline air-gapped copy)
C) Incremental scheduling
D) Larger retention window

**Q41.** Which backup type is fastest to *back up* but slowest to *restore* because the chain must be
replayed?
A) Full
B) Differential
C) Incremental
D) Snapshot

**Q42.** OT/ICS environments differ from IT in that they prioritise:
A) Confidentiality over availability
B) Availability and safety over confidentiality
C) Non-repudiation over integrity
D) Encryption over patching

**Q43.** nullbyte isolates each of its nine profiles as a distinct security boundary so a compromise in
one cannot read another's data. This is the device-scale application of which principle?
A) Defence in depth only
B) Zero Trust / least privilege with no implicit cross-boundary trust
C) Security through obscurity
D) Single sign-on

**Q44.** Which RAID level provides striping with dual distributed parity, surviving two simultaneous
disk failures?
A) RAID 0
B) RAID 1
C) RAID 5
D) RAID 6

**Q45.** A SaaS provider is breached because a customer left an access role over-permissive, exposing
that customer's data. Under shared responsibility, whose failure is this?
A) The provider's — they run the platform
B) The customer's — IAM/configuration of what you put in the cloud is always the customer's responsibility
C) Joint and equal
D) Neither; it is an unavoidable risk

**Q46.** Which protects data while it is being processed (the least mature data state)?
A) Full-disk encryption
B) TLS / VPN
C) A Trusted Execution Environment / secure enclave (confidential computing)
D) SFTP

**Q47.** A hot site versus a cold site differs primarily in:
A) Geographic distance
B) Readiness — a hot site is fully operational with live data sync (minutes to recover); a cold site is space/power only (days)
C) Number of staff
D) Network speed only

---

## Domain 4 — Security Operations (Q48–Q72)

**Q48.** What does SOAR add on top of a SIEM?
A) Long-term log storage
B) Playbook automation and orchestration of response
C) Packet capture
D) Vulnerability scanning

**Q49.** Why is accurate time synchronisation (NTP) critical to both a SIEM and Kerberos?
A) It speeds up disk writes
B) Correlation across sources needs aligned timestamps, and Kerberos rejects tickets when clock skew exceeds ~5 minutes
C) It encrypts log data
D) It is required for DNS resolution

**Q50.** Which statement about OAuth 2.0 and OpenID Connect is correct?
A) OAuth is authentication; OIDC is authorisation
B) OAuth is authorisation (delegated access); OpenID Connect adds an authentication/identity layer on top
C) Both are authentication only
D) Both are encryption protocols

**Q51.** RADIUS and TACACS+ differ how?
A) RADIUS encrypts the entire payload over TCP; TACACS+ encrypts only the password over UDP
B) RADIUS encrypts only the password over UDP; TACACS+ encrypts the entire payload over TCP
C) They are identical
D) Both use UDP and encrypt nothing

**Q52.** Place the NIST SP 800-61 incident-response phases in order.
A) Detection → Preparation → Recovery → Containment → Eradication → Lessons Learned
B) Preparation → Detection → Containment → Eradication → Recovery → Lessons Learned
C) Preparation → Containment → Detection → Recovery → Eradication → Lessons Learned
D) Detection → Containment → Eradication → Preparation → Recovery → Lessons Learned

**Q53.** During live forensic acquisition, which is collected first per the order of volatility?
A) The disk image
B) Backup media
C) CPU registers/cache and RAM
D) Remote SIEM logs

**Q54.** Why is a write blocker required for forensically sound disk imaging?
A) It speeds up imaging
B) It prevents any writes to the evidence media, preserving the original state
C) It encrypts the image
D) It compresses the data

**Q55.** Which three DNS records authenticate email senders, and which one sets the policy applied when
the others fail?
A) SPF, DKIM, DMARC — DMARC sets the failure policy
B) SPF, DKIM, DMARC — SPF sets the failure policy
C) MX, TXT, CNAME — MX sets the policy
D) DNSSEC, DoH, DoT — DoT sets the policy

**Q56.** A detection rule fires 200 times per day; every investigated instance has been benign user
activity. The correct classification and response is:
A) True positives — escalate each one
B) False positives — tune the rule (thresholds/context/allow-listing); do not simply disable it
C) False negatives — lower the threshold
D) True negatives — no action

**Q57.** EDR provides what that traditional signature antivirus does not?
A) Disk encryption
B) Continuous endpoint telemetry, behaviour-based detection, and automated response/rollback
C) Network firewalling only
D) Password management

**Q58.** "Password + PIN" is offered as multifactor authentication. Is it, and why?
A) Yes — two separate secrets
B) No — both are the knowledge factor; MFA requires different factor types
C) Yes — PIN is a possession factor
D) No — PINs are never allowed

**Q59.** Which sanitisation method is fast and sound for a self-encrypting / FDE drive being reused
internally, where degaussing would not apply?
A) Single-pass overwrite
B) Degaussing
C) Cryptographic erase (destroy the key)
D) Reformatting

**Q60.** A Windows host logs Event ID 4624 logon type 3 from an internal host that was itself flagged
earlier, followed by 5145 admin-share access on a second server. Which tactic is indicated?
A) Initial access via phishing
B) Lateral movement over remote services (T1021)
C) Data destruction
D) Reconnaissance scanning

**Q61.** ironveil's AdGuard Home performs DNS filtering. Which enterprise capability is the direct
analogue used to sinkhole malicious domains at resolution time?
A) NAC posture checking
B) DNS filtering / sinkholing
C) Full-disk encryption
D) File integrity monitoring

**Q62.** Which control posture-checks a device (patch level, AV present, certificate) before granting
it network access, quarantining non-compliant hosts?
A) DLP
B) NAC (often 802.1X-backed)
C) SIEM
D) WAF

**Q63.** A phishing email perfectly spoofs `From: ceo@company.com`. The domain publishes SPF and DKIM,
but DMARC is set to `p=none`. Why did it still land, and what one change blocks it?
A) SPF was missing; add SPF
B) `p=none` tells receivers to take no action on failure; set DMARC to `p=reject` (or quarantine) with alignment
C) DKIM keys were too long; shorten them
D) Nothing can block spoofing

**Q64.** UEBA primarily detects threats by:
A) Matching known signatures
B) Baselining normal user/entity behaviour and flagging deviations (impossible travel, abnormal access)
C) Blocking ports
D) Encrypting endpoints

**Q65.** An IDS and an IPS differ in that:
A) An IDS sits inline and blocks; an IPS is passive
B) An IDS detects and alerts out-of-band; an IPS sits inline and can drop traffic
C) Both block traffic
D) Neither can use signatures

**Q66.** A decommissioned laptop used LUKS2 full-disk encryption and must be sanitised quickly for
internal reuse. The fastest sound method is:
A) A seven-pass overwrite
B) Cryptographic erase (destroy the LUKS key so ciphertext is unrecoverable)
C) Degaussing the SSD
D) Deleting the partition table

**Q67.** Which access-control model grants permissions based on attributes and context (user
department, resource sensitivity, time of day)?
A) DAC
B) MAC
C) RBAC
D) ABAC

**Q68.** Just-in-time (JIT) privileged access reduces risk because:
A) It grants standing admin to more people
B) Elevated privileges exist only for a time-bounded window when needed, then are revoked — shrinking the theft window
C) It disables logging
D) It removes the need for MFA

**Q69.** To confirm whether a flagged host actually beaconed to a C2 domain, which two log sources are
most directly useful?
A) Printer logs and badge logs
B) DNS/proxy logs (domain resolution) and NetFlow/firewall logs (the outbound pattern)
C) BIOS logs and RAID logs
D) Email headers only

**Q70.** A SOC analyst's correct first action on a newly raised, unvalidated alert is to:
A) Immediately isolate every related host
B) Validate that the alert reflects real activity before acting, then contain
C) Close it as a false positive
D) Escalate to the CISO without review

**Q71.** watchtower (the planned Wazuh lab) re-uses gauntlet's attack techniques as detections. Mapping
an attacker technique like SSH brute force to its log evidence (`auth.log` failures → success) and a
SIEM rule demonstrates which SOC skill?
A) Penetration testing only
B) Detection engineering / the attack→detection bridge via MITRE ATT&CK
C) Physical security
D) Cryptanalysis

**Q72.** Which nmap flag set performs a full-port scan with service-version detection and saves all
output formats for evidence?
A) `-sn -PR`
B) `-p- -sV -oA`
C) `-sL` only
D) `--top-ports 10`

---

## Domain 5 — Security Program Management & Oversight (Q73–Q90)

**Q73.** An asset worth £200,000 has an exposure factor of 0.30 and an annualised rate of occurrence of
0.25. What is the ALE?
A) £60,000
B) £15,000
C) £50,000
D) £200,000

**Q74.** A firm buys cyber-insurance instead of fixing a risk's root cause. Which risk-treatment
strategy is this, and what remains?
A) Avoidance; nothing remains
B) Transference; it covers financial loss but not reputational damage or operational disruption, and may not pay if controls were negligent
C) Acceptance; all risk is removed
D) Mitigation; the risk is eliminated

**Q75.** Name the five NIST Cybersecurity Framework functions in order.
A) Identify, Protect, Detect, Respond, Recover
B) Plan, Do, Check, Act, Review
C) Categorize, Select, Implement, Assess, Authorize
D) Prevent, Detect, Contain, Eradicate, Recover

**Q76.** ISO/IEC 27001 versus ISO/IEC 27002 — which is correct?
A) 27001 is implementation guidance; 27002 is the certifiable standard
B) 27001 is the certifiable ISMS standard; 27002 is implementation guidance for the controls
C) They are the same document
D) 27002 is a US federal control catalogue

**Q77.** Under GDPR, a personal-data breach must be reported to the supervisory authority within:
A) 24 hours
B) 72 hours
C) 30 days
D) Immediately, with no defined window

**Q78.** Which GDPR role decides the purpose and means of processing personal data?
A) Data processor
B) Data controller
C) Data custodian
D) Data subject

**Q79.** Two organisations want a non-binding statement of intent to collaborate before signing
anything enforceable. Which document?
A) SLA
B) MOU (Memorandum of Understanding)
C) BPA
D) DPA

**Q80.** What is the key difference between a SOC 2 Type I and a Type II report?
A) Type I covers a period; Type II covers a point in time
B) Type I attests control design at a point in time; Type II attests operating effectiveness over a period
C) Type I is internal; Type II is always internal
D) There is no difference

**Q81.** Why does an SBOM (Software Bill of Materials) matter for supply-chain risk?
A) It encrypts dependencies
B) It inventories every component so you can find and assess where a vulnerable/compromised library is used
C) It blocks malicious updates automatically
D) It replaces penetration testing

**Q82.** A KRI differs from a KPI in that a KRI:
A) Measures performance against a target after the fact
B) Is a leading indicator that a risk is rising (e.g. growing unpatched-host count)
C) Is only used in finance
D) Is the same as an SLA

**Q83.** spectre maps its countermeasures to ISO/IEC 27002 and the CIS Apache 2.4 benchmark, and the
target server was hardened to CIS Level 1. Which governance layer does a CIS benchmark represent?
A) A high-level policy
B) A secure baseline / hardening standard
C) A risk register
D) A business continuity plan

**Q84.** Which security test is a discussion-based scenario walkthrough that tests process and
decision-making without touching live systems?
A) Red team
B) Penetration test
C) Tabletop exercise
D) Vulnerability scan

**Q85.** A control costs £30,000/year. The risk it addresses has AV £200,000, EF 0.30, ARO 0.25. On ALE
alone, is the control justified?
A) Yes — ALE is £60,000
B) No — ALE is £15,000/year, less than the £30,000 control cost (unless it addresses other risks or a mandate)
C) Yes — cost is always justified for security
D) Cannot be calculated

**Q86.** An auditor must give external customers assurance that a SaaS provider's controls *operated
effectively over the past year*. Which report?
A) SOC 2 Type I
B) SOC 2 Type II
C) A penetration-test report
D) A vulnerability assessment

**Q87.** Risk that remains after controls have been applied is called:
A) Inherent risk
B) Residual risk
C) Risk appetite
D) Risk tolerance

**Q88.** A purple-team engagement is characterised by:
A) Attackers only, simulating an APT
B) Defenders only, operating the SOC
C) Red and blue teams working together to improve controls in a fast feedback loop
D) An external compliance audit

**Q89.** A payroll SaaS will process all employee personal data. Beyond the purchase contract, which
instrument does GDPR require with the processor?
A) An NDA only
B) A Data Processing Agreement (DPA) covering scope, security, sub-processors, and breach notification
C) An SLA only
D) A bug-bounty agreement

**Q90.** When a board asks "are we getting riskier?" before any incident has occurred, the most
appropriate metric type is:
A) A lagging KPI such as MTTR
B) A leading KRI trended against a risk-appetite threshold
C) The raw CVSS of the latest vulnerability
D) The number of firewalls deployed

---
---

# ANSWER KEY — cover this section while taking the exam

> Each answer gives the correct letter, a one-sentence rationale, and why the key distractors are wrong.

## Domain 1
**Q1 — B.** A visible recording camera both *deters* (discourages) and *detects* (records) — controls
occupy multiple functions. (A/C wrong functions; D names categories, not functions.)
**Q2 — C.** A private-key digital signature proves the signer held the key, so they cannot deny the
act. (A=confidentiality; B=integrity only; D=integrity+authenticity but not non-repudiation, as the secret is shared.)
**Q3 — B.** The Policy Engine decides; the PA acts on the decision; the PEP enforces. (A enforces; C executes; D is a zone, not a decider.)
**Q4 — C.** A hardware key is "something you have"; touch-only adds presence but no second factor type. (No knowledge/biometric/location factor is used.)
**Q5 — B.** A seeded fake credential is a honeytoken — any use is high-signal. (A is a decoy host; C redirects domains; D is an admin chokepoint.)
**Q6 — C.** OCSP stapling has the server present a signed, time-stamped status, removing the client→CA query. (A can be stale; B leaks the query and adds latency; D is recovery, not status.)
**Q7 — B.** Comparing current vs desired state against a framework is a gap analysis. (Others are unrelated activities.)
**Q8 — C.** Argon2id is a memory-hard KDF designed to be slow. (A is fast/broken; B is encoding; D is bulk encryption, not stretching.)
**Q9 — B.** The unmapped dependency on the old port is a missed impact analysis. (Other elements would not have surfaced the broken job.)
**Q10 — B.** Tokenisation swaps data for a vault-backed token; encryption transforms with a key. (A reverses the reversibility; C/D are wrong.)
**Q11 — C.** Request → PEP → PDP (PE decides, PA issues/revokes token) → PEP allows/blocks. (A/B/D scramble the roles.)

## Domain 2
**Q12 — B.** Advanced (custom tooling/0-days), Persistent (long dwell), Threat (organised/funded). (Others invert the meaning.)
**Q13 — B.** Few passwords across many accounts to dodge lockout is spraying. (Stuffing reuses breached pairs; pass-the-hash uses hashes; rainbow tables are precomputed hashes.)
**Q14 — B.** XSS abuses the user's trust in the site; CSRF abuses the site's trust in the user's browser. (A inverts it.)
**Q15 — B.** A poisoned signed update through the vendor channel is a supply-chain attack (SolarWinds pattern). (Others are different classes.)
**Q16 — C.** Directory listing is CWE-548; fix with `Options -Indexes`. (A=SQLi, B=XSS, D=command injection.)
**Q17 — B.** Active exploitation (KEV) outranks a higher raw CVSS with no exploit. (A ignores context; C is backwards; D is arbitrary.)
**Q18 — B.** Spoofing an existing SSID to capture clients is an evil twin. (A is an unauthorised AP; C/D are different attacks.)
**Q19 — A.** Salting defeats rainbow tables; a memory-hard KDF slows cracking. (Others don't address password cracking.)
**Q20 — B.** Fileless malware lives in memory and abuses LOLBins, evading signatures. (A/C/D describe other malware.)
**Q21 — B.** Two distant logins in minutes = impossible travel; the outbound spike = beaconing. (Others don't fit.)
**Q22 — A.** Authority/urgency/scarcity/consensus are social-engineering levers. (B=crypto, C=resilience, D=email/DNS auth.)
**Q23 — B.** Pass-the-hash reuses a captured NTLM hash without cracking it. (A is pass-the-ticket; C/D unrelated.)
**Q24 — B.** Unpatchable EOL assets get compensating controls + a documented risk exception. (A/C/D increase risk or hide it.)
**Q25 — B.** AI-written phishing removes grammar tells, so phishing-resistant FIDO2 + out-of-band verification is the durable defence. (A/C/D are weak or irrelevant.)
**Q26 — B.** STIX is the format; TAXII is the transport. (A inverts; C/D wrong category.)
**Q27 — B.** A false negative misses a real attack and breeds false confidence — the dangerous one. (A mislabels it; C/D wrong.)
**Q28 — B.** Bluesnarfing steals data; bluejacking pushes messages. (A is bluejacking; C=jamming; D=RFID.)
**Q29 — B.** No contact with the target = passive recon/OSINT. (A touches the target; C/D are later phases.)
**Q30 — B.** VM escape is an attack (guest→host break); sprawl/snapshots/over-provisioning are hygiene. 
**Q31 — B.** A crash on long input is the classic buffer-overflow symptom that can become RCE; verify DEP/ASLR and add bounds checks. (A understates; C/D misdiagnose.)

## Domain 3
**Q32 — C.** The customer always owns their data and IAM in every service model. (A/B/D shift with the model.)
**Q33 — B.** CSPM continuously finds cloud misconfigurations. (A=app-usage visibility; C=workload protection; D=network/security edge.)
**Q34 — B.** A two-firewall screened subnet (DMZ) exposes the web server while keeping the DB unreachable. (A/D expose the DB; C breaks public reachability.)
**Q35 — B.** DNSSEC authenticates/integrity-protects records but does not encrypt. (A/C describe DoH/DoT; D is unrelated.)
**Q36 — B.** All egress is WireGuard-encrypted, so an external observer sees only the tunnel. (A/C/D would mean a leak.)
**Q37 — B.** Type 1 is bare-metal (ESXi/KVM). (A is Type 2; C/D are not hypervisors.)
**Q38 — B.** Containers share the host kernel, weakening isolation. (A/C/D are wrong reasons.)
**Q39 — B.** Max data loss = RPO (1h, drives backup frequency); max downtime = RTO (4h). (A swaps them; C/D wrong metrics.)
**Q40 — B.** Immutability (WORM/offline) stops ransomware from encrypting the backup. (A/C/D don't protect integrity.)
**Q41 — C.** Incremental is fastest to back up but must replay the chain to restore. (Full is opposite; differential is middle.)
**Q42 — B.** OT/ICS prioritises availability and safety; compensating controls replace forced patching. (A inverts; C/D wrong.)
**Q43 — B.** Per-profile isolation with no implicit cross-boundary trust is Zero Trust/least privilege at device scale. (A is partial; C/D wrong.)
**Q44 — D.** RAID 6 = dual distributed parity, surviving two disk failures. (0=none, 1=mirror, 5=single parity.)
**Q45 — B.** Customer-side IAM/config is always the customer's responsibility, even in SaaS. (A/C/D misassign it.)
**Q46 — C.** Data in use is protected by a TEE/secure enclave (confidential computing). (A=at rest; B/D=in transit.)
**Q47 — B.** Hot = fully operational/live sync (minutes); cold = space/power only (days). (A/C/D are secondary.)

## Domain 4
**Q48 — B.** SOAR adds playbook automation/orchestration on top of SIEM detection. (A is SIEM retention; C/D are other tools.)
**Q49 — B.** Correlation needs aligned timestamps and Kerberos fails past ~5-min skew. (A/C/D are not its role.)
**Q50 — B.** OAuth = authorisation; OIDC adds the identity/authentication layer. (A inverts; C/D wrong.)
**Q51 — B.** RADIUS (UDP) encrypts only the password; TACACS+ (TCP) encrypts the whole payload. (A inverts; C/D wrong.)
**Q52 — B.** Preparation → Detection → Containment → Eradication → Recovery → Lessons Learned. (Others reorder phases.)
**Q53 — C.** Most volatile first: registers/cache and RAM before disk and remote logs. (A/B/D are less volatile.)
**Q54 — B.** A write blocker prevents writes to evidence, preserving original state. (A/C/D are not its purpose.)
**Q55 — A.** SPF/DKIM/DMARC authenticate senders; DMARC sets the failure policy and alignment. (B/C/D misassign.)
**Q56 — B.** All-benign repeated fires are false positives — tune, don't disable (disabling risks false negatives). (A/C/D misclassify.)
**Q57 — B.** EDR adds continuous telemetry, behavioural detection, and automated response beyond signatures. (A/C/D are other functions.)
**Q58 — B.** Password + PIN are both knowledge — not MFA, which needs different factor types. (A/C/D are wrong.)
**Q59 — C.** Crypto-erase (destroy the key) is fast and sound for SED/FDE media; degaussing doesn't work on flash. (A is slower; B invalid for SSD; D recoverable.)
**Q60 — B.** Network logon from an already-flagged internal host plus admin-share access = lateral movement (T1021). (A/C/D don't fit the evidence.)
**Q61 — B.** AdGuard Home is DNS filtering — the same mechanism used to sinkhole malicious domains. (A/C/D are different controls.)
**Q62 — B.** NAC posture-checks and quarantines devices before granting access. (A=exfil prevention; C=log aggregation; D=web filtering.)
**Q63 — B.** `p=none` means receivers take no action; setting `p=reject`/quarantine with alignment blocks the spoof. (A/C/D misdiagnose.)
**Q64 — B.** UEBA baselines behaviour and flags deviations. (A=signatures; C/D unrelated.)
**Q65 — B.** IDS detects/alerts out-of-band; IPS is inline and can drop. (A inverts; C/D wrong.)
**Q66 — B.** Crypto-erase destroys the LUKS key, rendering ciphertext unrecoverable — fastest sound method. (A is slower; C invalid for SSD; D recoverable.)
**Q67 — D.** ABAC decides on attributes/context. (A=owner; B=labels; C=roles.)
**Q68 — B.** JIT grants time-bounded privilege only when needed, shrinking the theft window. (A/C/D increase risk.)
**Q69 — B.** DNS/proxy logs (resolution) plus NetFlow/firewall (the outbound pattern) confirm beaconing. (A/C/D irrelevant.)
**Q70 — B.** Validate before containing — acting on an unvalidated alert causes self-inflicted outages. (A/C/D skip validation.)
**Q71 — B.** Mapping a technique to its log evidence and a SIEM rule is detection engineering / the ATT&CK attack→detection bridge. (A/C/D miss the point.)
**Q72 — B.** `-p- -sV -oA` scans all ports, detects versions, and saves all output formats. (A=host discovery; C=list scan; D=top-ports only.)

## Domain 5
**Q73 — B.** SLE = 200,000 × 0.30 = £60,000; ALE = 60,000 × 0.25 = £15,000. (A is the SLE; C/D miscompute.)
**Q74 — B.** Insurance is transference — it covers financial loss but not reputation/operations and may not pay for negligence. (A/C/D overstate the effect.)
**Q75 — A.** Identify, Protect, Detect, Respond, Recover. (B=PDCA, C=RMF, D=IR phases.)
**Q76 — B.** 27001 is the certifiable ISMS standard; 27002 is control implementation guidance. (A inverts; C/D wrong.)
**Q77 — B.** 72 hours to the supervisory authority. (A/C/D incorrect.)
**Q78 — B.** The controller decides purpose and means; the processor acts on instructions. (A/C/D don't decide purpose.)
**Q79 — B.** An MOU is a non-binding statement of intent. (A/C/D are binding.)
**Q80 — B.** Type I = design at a point in time; Type II = operating effectiveness over a period. (A inverts; C/D wrong.)
**Q81 — B.** An SBOM inventories components so you can locate and assess a vulnerable/compromised library. (A/C/D overstate or misstate.)
**Q82 — B.** A KRI is a leading indicator of rising risk; a KPI measures performance after the fact. (A describes a KPI; C/D wrong.)
**Q83 — B.** A CIS benchmark is a secure baseline / hardening standard (the "how" layer below policy). (A/C/D are other artefacts.)
**Q84 — C.** A tabletop is a discussion-based walkthrough testing process without live systems. (A/B/D touch systems or people differently.)
**Q85 — B.** ALE = £15,000/yr < £30,000 control cost → not justified on ALE alone unless it covers other risks/a mandate. (A uses the SLE; C/D wrong.)
**Q86 — B.** Effectiveness *over a period* = SOC 2 Type II. (A is point-in-time design; C/D don't attest controls over time.)
**Q87 — B.** Risk after controls is residual risk. (A is before controls; C/D are appetite/tolerance.)
**Q88 — C.** Purple = red and blue collaborating for fast control improvement. (A/B are single teams; D is an audit.)
**Q89 — B.** GDPR requires a DPA with the processor (scope, security, sub-processors, breach SLA). (A/C/D don't satisfy the requirement.)
**Q90 — B.** A leading KRI trended against an appetite threshold answers "are we getting riskier?" before an incident. (A is lagging; C/D don't measure trend.)

---

*Portfolio-linked questions (study ↔ real work): Q4, Q16, Q22, Q36, Q43, Q61, Q66, Q71, Q83 directly
reference rootdrifter builds (ironveil, nullbyte, spectre, mirage, watchtower), plus Q2/Q6/Q8 (PKI/KDF
in ironveil), Q34/Q35 (network-stack architecture), Q55/Q63 (email auth), Q60/Q69 (gauntlet/watchtower
detection) reinforce the same connections — 15+ items anchoring theory to the portfolio.*
