# SY0-701 Domain 4 — Security Operations (28%)

The largest exam domain. Heavy on SOC operations, incident response, identity management, and
endpoint security. Maps to classic notes in
[2.0-technologies-tools.md](2.0-technologies-tools.md),
[4.0-identity-access-management.md](4.0-identity-access-management.md), and
[5.0-risk-management.md](5.0-risk-management.md) §5.

---

## 1. Security monitoring and SIEM

### SIEM functions (all testable)

| Function | Description |
|----------|-------------|
| **Log aggregation** | Collects logs from firewalls, endpoints, cloud, apps into one platform |
| **Correlation** | Links related events across sources to identify patterns (alert on 5 failed logins + successful login from new IP) |
| **Alerting** | Generates alerts when correlation rules trigger |
| **Dashboards** | Real-time visualisation for SOC analysts |
| **Retention** | Long-term log storage for forensics and compliance (often 90 days minimum, 1 year+ for compliance) |
| **WORM/immutable storage** | Ensures log integrity — logs can't be altered after writing |
| **Time synchronisation** | NTP is critical — events from different sources must have aligned timestamps for correlation |
| **Automated triggers** | Run playbooks or SOAR actions on rule match |

**SOAR** (Security Orchestration, Automation and Response): adds playbook automation on top
of SIEM. Automates repetitive analyst tasks (phishing triage, ticket creation, IP blocking).
SIEM = detection and alerting; SOAR = automated response.

**Common SIEMs:**
- **Splunk** — most common commercial SIEM; query language SPL (Search Processing Language)
- **Microsoft Sentinel** — cloud-native; KQL (Kusto Query Language)
- **IBM QRadar** — enterprise; AQL
- **Elastic SIEM / OpenSearch** — open-source option
- **Wazuh** — open-source HIDS/SIEM; common in home labs and SMEs

**Log sources:** syslog, Windows Event Logs, firewall logs, IDS/IPS alerts, proxy/DNS logs,
VPN logs, cloud audit trails (AWS CloudTrail, Azure Activity Log), NetFlow.

**Alert tuning:**
- High false-positive rate exhausts analysts and causes alert fatigue (real events missed).
- Tune rules to reduce FP rate: adjust thresholds, add context (time of day, user role), whitelist known-good.
- **Sensitivity vs specificity trade-off** in detection: high sensitivity catches everything but
  creates noise; high specificity reduces noise but may miss novel attacks.

> Portfolio link: sec-plus-notes [applications-private] identifies a **SIEM home lab** (Wazuh
> or Splunk) as the top portfolio gap for SOC analyst targeting. Building one and producing
> real MTTD/MTTR data would close this gap.

---

## 2. Identity and access management (operations)

### Core protocols

| Protocol | Use | Key distinction |
|----------|-----|-----------------|
| **Kerberos** | Windows/AD authentication | Ticket-based (TGT/TGS); KDC; mutual auth; time-sensitive (NTP) |
| **LDAP/LDAPS** | Directory queries | LDAPS = TLS-wrapped; never use plaintext LDAP (389) for auth |
| **RADIUS** | AAA for network access (VPN, 802.1X) | UDP; encrypts only the password field |
| **TACACS+** | AAA for network device management | TCP; encrypts entire payload; separates auth/authz/accounting |
| **SAML 2.0** | Web SSO / federation (XML-based) | Browser-based; IdP issues assertion to SP |
| **OAuth 2.0** | **Authorisation** — delegated resource access | NOT authentication; issues access tokens |
| **OpenID Connect** | **Authentication** built on OAuth 2.0 | Adds ID token to OAuth; used for "Login with Google" |
| **802.1X / EAP** | Port-based network access control | EAP-TLS (cert-based) is strongest; PEAP wraps MSCHAPv2 |

**Exam traps:**
- OAuth ≠ authentication (it's authorisation). OpenID Connect adds the identity layer.
- RADIUS encrypts only the password; TACACS+ encrypts everything — use TACACS+ for device management.
- Kerberos requires accurate time (NTP) — time skew > 5 minutes breaks authentication.

### Access control models

| Model | Who/what decides access | Example |
|-------|------------------------|---------|
| **DAC** (Discretionary) | The resource owner | Linux file permissions; owner sets r/w/x |
| **MAC** (Mandatory) | The system, based on labels/clearances | Military: SECRET clearance can read SECRET data |
| **RBAC** (Role-Based) | Permissions assigned to roles; users assigned to roles | Enterprise standard; IT Admin role → admin permissions |
| **ABAC** (Attribute-Based) | Policy over multiple attributes (user, resource, environment, context) | "Allow access if user.department=Finance AND resource.sensitivity=Low AND time=business_hours" |
| **Rule-based** | Global rules (e.g. ACL, time-of-day) | Firewall ACL: allow/deny based on IP/port |

**Least privilege:** users and services have only the permissions they need for their job function — nothing more. Applies to user accounts, service accounts, API keys, and IAM roles.

**Separation of duties:** no single person can complete a sensitive transaction alone (e.g. request + approve a payment). Reduces insider threat and fraud.

**Job rotation:** periodically rotating employees through roles detects fraud (dormant schemes come to light) and reduces dependency on any one person.

**Mandatory vacation:** forces a period where a user's access is not used — schemes that require daily presence are exposed.

### Privileged Access Management (PAM)

- **Vaulting:** privileged credentials stored in a secure vault; checked out for use and rotated after.
- **Just-in-time (JIT) access:** elevated privileges granted only when needed, for a time-bounded window, then revoked.
- **Session recording:** all privileged sessions recorded for audit.
- **Credential rotation:** automatic rotation of service account passwords, API keys, certificates.

### Account lifecycle

**Provisioning → review/recertification → de-provisioning**

- De-provisioning on offboarding is a classic gap — disable accounts promptly (same day for
  departing employees, especially those terminated involuntarily).
- Periodic **access recertification/review** — managers confirm that access is still required.
- Disable rather than delete accounts initially — preserves audit history.
- Service accounts should have their own lifecycle; rotate credentials when the responsible
  person leaves.

### Multifactor authentication (4.6 — high-frequency exam topic)

**The four factors** (an exam favourite — memorise which category each example falls in):

| Factor | "Something you…" | Examples |
|--------|------------------|----------|
| Knowledge | know | password, PIN, security question |
| Possession | have | hardware token, smartphone (push/TOTP), smart card, FIDO2 security key |
| Inherence | are | fingerprint, face, iris, voice (biometrics) |
| Location | are somewhere | GPS, IP geolocation, geofencing |

- **True MFA combines *different* factors.** Password + PIN is **not** MFA (both knowledge). Password
  + TOTP app **is** MFA (knowledge + possession).
- **Token types:** *hard token* = dedicated device (RSA SecurID, YubiKey); *soft token* = app
  (Google/Microsoft Authenticator generating TOTP). *Security key* = FIDO2/U2F hardware (phishing-
  resistant — the only listed method that defeats real-time relay/AiTM phishing).
- **Biometric metrics:** FAR (false accept — security risk), FRR (false reject — usability cost), CER
  (crossover — where FAR=FRR, the tuning sweet spot). Bias the threshold toward low FAR for security.
- **Passwordless:** FIDO2 passkeys, Windows Hello — no shared secret to phish or replay.
- **Password best practice (SY0-701 shift):** length over complexity; **no forced periodic
  expiration** unless compromise is suspected (current NIST guidance); screen against breached-
  password lists; use a password manager; block reuse.

### Conditional access and Zero Trust identity

- Conditional access: allow/step-up/deny based on user risk, device compliance, location,
  application sensitivity.
- Impossible travel: same user logs in from two geographically distant locations within an
  implausible time window.
- Continuous authentication: re-evaluate trust mid-session based on behavioural signals.

> Portfolio link: [ironveil](../../ironveil) Nitrokey FIDO2 = possession factor, touch-only =
> physical presence requirement. [nullbyte](../../nullbyte) per-profile credentials = access
> segregation by operational identity.

---

## 3. Incident response

### NIST SP 800-61 lifecycle (memorise all six phases and their order)

1. **Preparation** — policies, playbooks, IR team trained and equipped, SIEM configured, contacts established
2. **Detection / Identification** — alerts, anomalies, user reports, log analysis indicating a potential incident
3. **Containment** — short-term (isolate the affected system) and long-term (remove persistence, block C2)
4. **Eradication** — remove malware, close exploit, patch vulnerability, reset credentials
5. **Recovery** — restore systems from clean backups, verify integrity, return to production
6. **Lessons Learned** — post-incident review; update playbooks, controls, and policies

**Containment strategies:**
- **Isolation:** remove the system from the network (physical or logical)
- **Segmentation:** use VLANs/firewalls to contain spread
- **Sandboxing:** move to isolated environment for analysis

**CSIRT roles:** incident commander, technical analyst, communications lead, legal/HR liaison.
**Playbooks/runbooks:** pre-approved, step-by-step procedures for known incident types.

### Digital forensics

**Order of volatility** (collect most volatile first — it disappears fastest):

1. CPU registers and cache
2. RAM / live memory
3. Swap space / page file
4. Disk (non-volatile but may be encrypted or overwritten)
5. Remote logging / SIEM
6. Archives, backup media

**Chain of custody:** documented, unbroken record of who handled evidence, when, and what was done.
Breaks in custody can render evidence inadmissible.

**Write blockers:** hardware or software that prevents any writes to the evidence media during
acquisition — preserves the original state. Required for forensically sound imaging.

**Imaging:** `dd` or `dcfldd` for bit-for-bit disk images. Hash before and after to prove integrity.

**Memory forensics:** Volatility framework for analysis of RAM dumps. Process lists, network connections, injected code, encryption keys in memory.

**E-discovery / legal hold:** preserve all potentially relevant data when litigation is anticipated.

> Portfolio link: [spectre](../../spectre) applied **SHA-256 integrity hashing** and separate
> session logs — the same evidence integrity discipline used in forensics and IR.

---

## 4. Endpoint security

**EDR (Endpoint Detection and Response):** continuous telemetry from endpoints; behaviour-based
detection; automated response and rollback. Significantly beyond classic AV.

**XDR (Extended DR):** extends EDR across endpoint, network, cloud, and identity data — correlated view.

**Key endpoint controls:**

| Control | Description |
|---------|-------------|
| FDE (Full-Disk Encryption) | Protects data at rest (LUKS2, BitLocker) |
| Host firewall | Local packet filter (iptables/nftables, Windows Firewall) |
| Application allow-listing | Only approved apps can execute — stronger than block-listing |
| FIM (File Integrity Monitoring) | Alerts on unexpected changes to critical files |
| DLP (Data Loss Prevention) | Prevents exfiltration of sensitive data |
| Sandboxing | Runs untrusted code in an isolated environment |
| HIDS/HIPS | Host-based intrusion detection/prevention |
| EPP (Endpoint Protection Platform) | AV + firewall + basic EDR in one product |

**Hardening steps:** remove unnecessary software and services, update firmware, disable legacy
protocols, enforce strong authentication, apply CIS/STIG baseline.

> Portfolio link: [ironveil](../../ironveil) demonstrates endpoint hardening — LUKS2 FDE,
> vendor cloud daemon elimination, and a minimal attack surface (no unnecessary services).

---

## 5. Vulnerability management in operations

**Operational cycle:**
- Continuous scanning (agent-based for endpoints, network-based for infrastructure)
- Patch management: test → deploy → verify cycle; track patch latency (days from release to deployment)
- Prioritisation by KEV status, CVSS severity, asset criticality, and exploitability
- Compensating controls for systems that cannot be patched (legacy, OT/ICS)

**Metrics:**
- **Patch latency:** average time from vulnerability disclosure to patch deployment
- **% assets at baseline:** proportion of systems meeting the hardened configuration standard
- **Mean time to patch (MTTP):** operational measure of patch responsiveness

---

## 6. Alert triage and analysis terminology (4.3/4.4 — core SOC skill)

The single most-tested SOC concept: classifying what an alert actually means.

| Term | Meaning | Analyst consequence |
|------|---------|---------------------|
| **True positive** | Alert fired and a real malicious/anomalous event occurred | Escalate / respond — the system worked |
| **False positive** | Alert fired but the activity was benign | Tune the rule; FP fatigue is the #1 SOC failure mode |
| **True negative** | No alert and nothing happened | Normal steady state |
| **False negative** | No alert but a real event occurred | The dangerous one — the attack was *missed*; drives detection-gap analysis |

- **Tuning trade-off:** loosening rules cuts false positives but raises false negatives (missed
  attacks), and vice versa. The art is maximising true positives without burying analysts.
- **Alert response workflow (4.4):** triage → validate → **quarantine/contain** → escalate or close →
  feed lessons back into rule tuning. *Validation* (confirm the alert reflects real activity) comes
  before action — acting on an unvalidated alert wastes effort and can cause self-inflicted outages.
- **Detection methods:** *signature-based* (matches known IOCs/patterns — precise, blind to novel
  attacks); *anomaly/behaviour-based* (flags deviation from a learned baseline — catches novel
  activity, noisier); *heuristic* (rule-of-thumb scoring). Modern SOCs layer all three.

> Portfolio link: [mirage](../../mirage) is a direct study of this problem — whether an automated
> classifier (an LLM) can move beyond surface signature matching to *causal* detection of social-
> engineering tactics, and where its false negatives cluster (multi-hop causal chains).

---

## 7. Email security and anti-phishing authentication (4.5 — heavily tested)

Phishing is the most common initial-access vector, so the three sender-authentication records are
prime exam material. Memorise what each proves:

| Record | Mechanism | What it proves / does |
|--------|-----------|-----------------------|
| **SPF** (Sender Policy Framework) | DNS TXT listing IPs/hosts authorised to send for the domain | Receiver checks the sending IP is allowed — anti-spoofing at the envelope level |
| **DKIM** (DomainKeys Identified Mail) | Sender signs headers/body with a private key; public key in DNS | Cryptographic proof the message wasn't altered and came from the domain |
| **DMARC** | DNS policy built **on top of SPF + DKIM**; sets `none` / `quarantine` / `reject` + reporting | Tells receivers what to do when SPF/DKIM *fail*, and sends the domain owner aggregate reports |

- **Order/dependency:** DMARC requires SPF and/or DKIM to be in place first — it is the *policy and
  alignment* layer, not a standalone check. "Alignment" = the visible `From:` domain must match the
  SPF/DKIM-authenticated domain.
- **Secure email gateway (SEG):** inbound filtering — attachment sandboxing, URL rewriting/detonation,
  spam/malware scoring, impersonation/BEC detection.
- **Other email controls:** S/MIME (sign/encrypt messages with certs), banner tagging external mail,
  blocking/rewriting links.

## 8. Enterprise security capability tuning (4.5)

Modifying existing infrastructure to improve the security posture:

- **Firewall:** rules / **ACLs** (allow-deny by source/dest IP, port, protocol — default-deny is the
  secure baseline); **screened subnet (DMZ)** for public-facing services; ports & protocols hygiene.
- **IDS vs IPS:** IDS *detects and alerts* (out-of-band, passive); IPS *detects and blocks* (inline,
  can drop traffic). Both run on **signatures** (known patterns) and/or **trend/anomaly** detection.
- **Web filtering:** centralised proxy or agent-based; **URL scanning, content categorisation,
  reputation, block rules.** **DNS filtering** sinkholes malicious domains at resolution time.
- **NAC (Network Access Control):** posture-checks a device before granting network access (patch
  level, AV present, certificate); quarantines non-compliant hosts. Often 802.1X-backed.
- **DLP:** detects/blocks sensitive-data exfiltration (endpoint, network, cloud).
- **FIM (File Integrity Monitoring):** alerts on unexpected changes to critical system files.
- **UEBA (User and Entity Behaviour Analytics):** baselines normal user/host behaviour and flags
  deviation — impossible travel, abnormal data access, off-hours activity. The analytics engine
  behind many insider-threat and account-takeover detections.
- **OS security:** **Group Policy** (Windows central config), **SELinux** (Linux mandatory access
  control — the `getenforce`/`sestatus` control referenced in ironveil hardening).

> Portfolio link: [ironveil](../../ironveil) applies several of these directly — **AdGuard Home =
> DNS filtering**, host firewall, SELinux enforcing; [nullbyte](../../nullbyte) uses **RethinkDNS**
> as a per-profile DNS-filtering firewall.

## 9. Automation and orchestration (4.7 — SOAR)

**SOAR** automates and orchestrates response so analysts focus on judgement, not toil.

- **Use cases:** user/resource provisioning, **guard rails**, security-group management, automated
  **ticket creation and escalation**, enabling/disabling services and access, continuous integration
  and testing, API integrations, automated phishing-triage and IOC-blocking playbooks.
- **Benefits:** speed (faster reaction time / lower MTTR), consistency (enforced baselines and
  standard configs), scale (a workforce multiplier), fewer human errors, analyst retention (less
  repetitive work).
- **Considerations / risks:** complexity, cost, a **single point of failure** if the automation
  breaks, **technical debt**, and ongoing supportability. Over-automation without guard rails can
  amplify a mistake at machine speed.

## 10. Investigation data sources and log types (4.9)

When investigating, know which log answers which question:

| Source | Tells you |
|--------|-----------|
| **Firewall logs** | Allowed/blocked connections, port/protocol, source/dest — lateral movement, C2 egress |
| **IDS/IPS logs** | Signature/anomaly alerts on the wire |
| **Endpoint/EDR logs** | Process execution, file/registry changes, parent-child process trees |
| **OS security logs** | Windows Event Logs (4624 logon, 4625 failed logon, 4688 process creation), Linux `auth.log`/`/var/log/secure` |
| **Application logs** | App-specific events, auth, errors — web-server access logs for web attacks |
| **Network logs / NetFlow** | Flow records: who talked to whom, how much, when (no payload) |
| **DNS / proxy logs** | Domain resolution and web requests — beaconing, exfil, malicious domains |
| **Vulnerability scans** | Known weaknesses on assets |
| **Packet captures (pcap)** | Full payload — the ground truth, but storage-heavy |
| **Metadata** | Headers, timestamps, geolocation — email headers are key for phishing analysis |

- **Dashboards and automated reports** summarise these for situational awareness; **SNMP traps** and
  **NetFlow** feed infrastructure monitoring.
- **Time synchronisation (NTP)** underpins all of this — correlation across sources is impossible if
  timestamps disagree.

## 11. Asset management and secure disposal (4.2)

- **Acquisition/procurement → assignment/accounting (ownership, classification) → monitoring/tracking
  (inventory, enumeration) → disposal/decommissioning.** Unknown/unmanaged assets are unpatched
  attack surface — inventory is a security control, not just IT housekeeping.
- **Data sanitisation/destruction methods:**

| Method | Description | When |
|--------|-------------|------|
| **Wiping/overwriting** | Multiple-pass overwrite of the data | Reusing the drive internally |
| **Cryptographic erase** | Destroy the encryption key so ciphertext is unrecoverable | Fast erase of self-encrypting / FDE drives |
| **Degaussing** | Strong magnetic field destroys magnetic media | HDDs/tape (not SSDs) |
| **Physical destruction** | Shred, crush, incinerate, pulverise | Highest assurance / classified media |

- **Certification of destruction** documents that media was sanitised — needed for compliance and
  chain-of-custody. **Data retention** policy governs how long data is kept before disposal.

---

## 12. Network security tools (operational use)

| Tool | Use | Key flags/notes |
|------|-----|-----------------|
| **nmap** | Port and service discovery | -sS (SYN scan), -sV (version), -O (OS), -p- (all ports), --script |
| **Wireshark** | Packet capture and analysis | GUI; protocol dissection; filter language |
| **tcpdump** | Command-line packet capture | `tcpdump -i eth0 host 10.0.0.1 and port 80` |
| **netcat** | TCP/UDP Swiss-army tool | Port scanning, file transfer, reverse shells, banner grabbing |
| **dig / nslookup** | DNS queries | `dig @8.8.8.8 example.com A` |
| **curl** | HTTP testing | `-v` for verbose; `-I` for headers; `-s` silent; `-L` follow redirects |
| **ss / netstat** | Socket and network state | `ss -tulpn` (TCP+UDP, listening, process, numeric) |
| **SCAP / OpenSCAP** | Automated compliance scanning against benchmarks | Agent or agentless; maps to CIS/STIG baselines |

---

## 13. Hardening targets — mobile, wireless, application (objective 4.1)

### Mobile solutions

**Deployment models — know the trade-off each makes:**

| Model | Who owns | Who controls | Exam cue |
|-------|----------|--------------|----------|
| **BYOD** (bring your own) | User | Org controls a managed container/profile only | Cheapest, weakest control; privacy tension — org must not wipe personal data |
| **COPE** (corporate-owned, personally enabled) | Org | Org controls the device; personal use allowed | Full MDM control + user convenience |
| **CYOD** (choose your own) | Org | Org controls; user picks from an approved list | Compromise between BYOD flexibility and COPE control |

**MDM capabilities** (the *mechanism* behind every mobile-hardening answer): enforce
encryption + lockscreen policy, remote wipe (full or container-only on BYOD), application
allow/deny lists, geofencing/geolocation, jailbreak/root posture checks, OS-version compliance
gates, certificate deployment.

- *Commonly confused:* **containerisation** (separating work data inside one device) vs
  **segmentation** (network-level separation). On a BYOD stem, container wipe is the answer that
  respects personal data.
- *Connection methods as attack surface:* cellular (rogue base station), Wi-Fi (evil twin —
  cross-ref Domain 2 wireless attacks), Bluetooth (bluesnarfing/bluejacking), NFC (proximity
  reads). Hardening = disable unused radios, no auto-join.
- *Exam trap:* "sideloading" and "jailbreaking/rooting" stems → the control is MDM posture
  checking + app allowlisting, not antivirus.
- *Portfolio connection:* nullbyte is a worked mobile-hardening build — per-profile encryption,
  verified boot, per-app network policy (RethinkDNS) are the GrapheneOS equivalents of the
  MDM control set, applied at OS level.

### Wireless security settings

- **WPA3-Personal (SAE):** replaces the WPA2 4-way-handshake PSK exchange with Simultaneous
  Authentication of Equals — resistant to **offline dictionary attacks** (each guess requires a
  live exchange) and provides forward secrecy. Protected Management Frames (PMF) are mandatory —
  blunts deauthentication attacks.
- **WPA3-Enterprise / WPA2-Enterprise:** authentication via **802.1X → RADIUS → EAP** (cross-ref
  §2 core protocols). EAP-TLS (certificate both sides) is the phishing-resistant gold standard;
  PEAP/EAP-TTLS tunnel a legacy credential.
- **Personal vs Enterprise in one line:** Personal = shared secret (PSK/SAE password); Enterprise
  = per-user authentication against an AAA server.
- Hardening checklist: WPA3 (or WPA2+AES minimum), disable WPS, disable open/WEP, unique
  pre-shared secrets, PMF on, RADIUS for anything corporate.
- *Exam trap:* a stem where the Wi-Fi password was cracked "from a captured handshake, offline" →
  WPA2-PSK weakness; the fix is **WPA3-SAE**, not a longer passphrase (a longer passphrase only
  raises cost, SAE removes the offline vector).

### Application security (hardening side — attack side lives in Domain 2 §5)

- **Input validation** (server-side, allow-list) — the single control that kills injection
  classes.
- **Secure cookies:** `Secure` (TLS only), `HttpOnly` (no script access — blunts XSS session
  theft), `SameSite` (CSRF mitigation).
- **Code signing:** integrity + publisher authenticity for shipped binaries/updates (supply-chain
  stems).
- **Static vs dynamic analysis:** SAST reads source before run; DAST probes the running app —
  stems with "without access to source code" → DAST.
- **Sandboxing:** execute untrusted code in an isolated environment (browser tabs, mobile apps,
  detonation chambers).
- *Exam trap:* "client-side validation" is never the correct *security* control — it is a UX
  feature; the server must re-validate.

---

### Quick self-test
- NTP: why is it critical for a SIEM and for Kerberos?
- SIEM vs SOAR — what does each do?
- OAuth vs OpenID Connect — which is authentication, which is authorisation?
- RADIUS vs TACACS+ — what does each encrypt, and which protocol does each use?
- NIST 800-61 IR lifecycle — name the six phases in order.
- Order of volatility — what do you collect first in live forensics and why?
- Write blocker — why is it required for forensically sound evidence?
- Least privilege vs separation of duties — define each with a practical example.
- EDR vs AV — what does EDR provide that AV does not?
- True/false × positive/negative — define all four and say which is the dangerous one for a SOC.
- SPF vs DKIM vs DMARC — which proves the message wasn't altered, which lists authorised senders,
  and which sets the policy when the first two fail?
- IDS vs IPS — which is inline and can drop traffic?
- MFA: is "password + PIN" multifactor? Why or why not? Give a genuinely multifactor pair.
- Which sanitisation method works on an SSD where degaussing does not, and why?
- FAR vs FRR vs CER — which way do you bias the threshold for a high-security door?

### Scenario drills

1. *A SOC analyst sees 200 alerts/day from one rule; every one investigated so far has been benign
   user activity.* What is the classification, the risk if ignored, and the fix? → **False
   positives**; risk is **alert fatigue masking a real true positive**; fix is **rule tuning**
   (thresholds/context/allow-listing).
2. *A phishing email perfectly spoofs `From: ceo@company.com`. The domain publishes SPF and DKIM but
   DMARC policy is `p=none`.* Why did it still land, and what one change blocks it? → SPF/DKIM may
   fail or misalign, but `p=none` tells receivers to **take no action**; set DMARC to
   **`p=reject` (or quarantine)** with alignment.
3. *An account logs in from London, then from São Paulo 20 minutes later.* Which monitoring capability
   flags this and under which name? → **UEBA / conditional access — impossible travel.**
4. *Incident: ransomware is encrypting a file server right now.* Map the immediate next NIST 800-61
   phase and one concrete action. → **Containment** — isolate the host from the network (and preserve
   volatile evidence before powering down).
5. *A decommissioned laptop used LUKS2 full-disk encryption and must be disposed of quickly for
   internal reuse.* Fastest sound sanitisation method? → **Cryptographic erase** (destroy the key;
   the ciphertext becomes unrecoverable) — no multi-pass overwrite needed.
6. *You must confirm whether a flagged host actually beaconed to a C2 domain.* Which two log sources
   answer this most directly? → **DNS/proxy logs** (resolution of the malicious domain) and
   **NetFlow/firewall logs** (the outbound connection pattern).

---

## Quick reference card — Domain 4

One-page revision sheet. If any line is not instant recall, re-read that section above.

**Acronyms:**
SIEM/SOAR (event management / orchestration & automated response) · UEBA (user & entity behaviour
analytics) · EDR/XDR/EPP (endpoint detection / extended / protection platform) · FIM (file
integrity monitoring) · DLP (data loss prevention) · NAC (network access control) · PAM/JIT
(privileged access management / just-in-time) · KDC/TGT (Kerberos key distribution centre /
ticket-granting ticket) · SAML/OAuth/OIDC (web SSO / delegated authz / authn on OAuth) ·
SPF/DKIM/DMARC (sender policy / signed mail / failure policy) · SEG (secure email gateway) ·
MTTP (mean time to patch) · pcap (packet capture)

**Key term one-liners:**
- SIEM detects and alerts; SOAR executes playbooks on top. NTP underpins both correlation and
  Kerberos (>5 min skew breaks auth).
- AAA protocols: RADIUS (UDP, encrypts password only) vs TACACS+ (TCP, encrypts all — device
  admin); 802.1X/EAP-TLS for port-based admission; NAC posture-checks before granting access.
- Access models: DAC (owner decides) · MAC (labels/clearances) · RBAC (roles) · ABAC (attributes/
  context) · rule-based (global ACLs).
- PAM stack: vaulting → JIT elevation → session recording → credential rotation.
- IR lifecycle (NIST 800-61): Preparation → Detection → Containment → Eradication → Recovery →
  Lessons Learned.
- Forensics: order of volatility (registers → RAM → swap → disk → remote logs → archives);
  write blockers; hash before/after imaging; chain of custody.
- Triage: TP (respond) · FP (tune) · TN (normal) · **FN (the dangerous one — missed attack)**.
  Workflow: triage → validate → contain → escalate/close → tune.
- Email auth: SPF (authorised senders) · DKIM (signed, unaltered) · DMARC (policy on failure +
  alignment + reports).
- Sanitisation: overwrite (reuse) · crypto-erase (FDE/SED, fast) · degauss (magnetic only) ·
  destroy (highest assurance) — plus certification of destruction.
- Detection styles: signature (precise, blind to novel) · anomaly/behavioural (novel, noisy) ·
  heuristic — layered in practice.

**Exam traps:**
- OAuth is authorisation; OpenID Connect adds authentication. Don't accept "log in with OAuth".
- Password + PIN is one factor (both knowledge).
- Validate before you contain — acting on an unvalidated alert causes self-inflicted outages.
- Disable (don't delete) accounts on offboarding — preserve the audit trail.
- IDS alerts out-of-band; IPS sits inline and blocks. Only inline devices can drop traffic.
- A SIEM retention window shorter than your dwell time means the evidence is gone when you need it.

---

## Scenario bank — situation → action

Ten decision-format questions, distinct from the drills above and from
[soc-scenarios](../scenarios/soc-scenarios.md). Format: situation → what do you do? → correct
action → why → portfolio link.

**1. Monday-morning lockout**
- **Situation:** After a weekend hypervisor migration, every user fails Windows authentication.
  Domain controllers are up; passwords are correct; tickets mention "clock" errors.
- **What do you do?** Find the common cause.
- **Correct action:** Check **time synchronisation** — the migrated VMs' clocks drifted past
  Kerberos's 5-minute skew tolerance. Re-point NTP, resync, and add clock-drift monitoring.
- **Why:** Kerberos timestamps tickets to stop replay; skew breaks all authentication at once.
  Time is also the silent dependency of every SIEM correlation you run.
- **Portfolio link:** [spectre](../../spectre)'s evidence chain depends on the same property —
  timestamps you can defend.

**2. The meeting-room socket**
- **Situation:** A visitor plugs a personal laptop into a meeting-room ethernet port and receives
  a corporate IP with reach to internal file shares.
- **What do you do?** Close the admission gap.
- **Correct action:** Deploy **NAC with 802.1X**: unauthenticated/non-compliant devices get
  quarantined to a guest VLAN after posture checks (certificate, patch level, EDR present);
  unused ports default-disabled.
- **Why:** A network that hands full access to any cable is one walk-in away from compromise.
  Admission control moves the decision from "got a socket" to "proved identity and posture".
- **Portfolio link:** [nullbyte](../../nullbyte)'s isolation matrix applies the same gate per
  profile: network access is granted by policy, never by default.

**3. The account that outlived the employee**
- **Situation:** Reviewing VPN logs, you find successful logins from an account belonging to a
  developer who left **two weeks ago**.
- **What do you do?** Respond and fix the process.
- **Correct action:** Disable the account and kill its sessions now, then investigate everything
  it did since the leave date (treat as compromise until proven otherwise). Root-cause the
  offboarding failure: same-day deprovisioning, leaver checklists, periodic access recertification.
- **Why:** Orphaned accounts are valid credentials with no owner watching them — indistinguishable
  from an attacker by design. The control is lifecycle discipline, not detection cleverness.
- **Portfolio link:** [nullbyte](../../nullbyte) treats identity lifecycle explicitly — profiles
  exist, get locked, and die as deliberate acts, never by drift.

**4. "This app would like to read your mail"**
- **Situation:** A user reports they "logged in with Microsoft" on a productivity site; you find an
  OAuth grant from their account to an unknown app with `Mail.Read` and `offline_access` scopes.
- **What do you do?** Respond to the consent, not the password.
- **Correct action:** Revoke the application grant and its refresh tokens (resetting the password
  alone does NOT cut token access), audit what the app read, then restrict user consent to
  verified publishers/admin approval.
- **Why:** **Illicit consent** phishing steals authorisation, not credentials — MFA never fires
  because the user genuinely authenticated. The token, not the password, is the loot.
- **Portfolio link:** [mirage](../../mirage)'s core finding applies: the attack works by making a
  *legitimate mechanism* serve the attacker — surface signals look clean.

**5. Twenty-four standing admins**
- **Situation:** An audit finds 24 accounts hold standing Domain Admin; most "needed it once" for
  a migration years ago. Each is a permanent pass-the-hash target.
- **What do you do?** Redesign privileged access.
- **Correct action:** Introduce **PAM**: vault the credentials, grant **JIT elevation** scoped and
  time-boxed per task, record privileged sessions, rotate secrets on check-in, and cut standing
  membership to the minimum that genuinely needs it.
- **Why:** Privilege that exists only while used cannot be stolen while dormant — the attacker's
  window shrinks from "always" to "minutes, logged".
- **Portfolio link:** [ironveil](../../ironveil)'s touch-to-unlock FIDO2 key is JIT in hardware:
  the privilege (disk unlock) exists only at the moment of physical presence.

**6. The CFO's laptop, mid-board-meeting**
- **Situation:** EDR raises a *medium-confidence* alert on the CFO's laptop during a board meeting.
  Auto-isolate would kill their presentation; ignoring it might let something spread.
- **What do you do?** Balance containment against business impact.
- **Correct action:** **Validate first** (process tree, network destinations, hash reputation —
  minutes of work), apply *targeted* containment meanwhile (block the suspect domain/hash
  estate-wide), and isolate the host the moment validation says real — with an executive
  communication path, not silently.
- **Why:** Containment is a judgement call on confidence × impact. Reflex isolation on every
  medium alert trains the business to fight the SOC; reflex inaction trains attackers to time
  their moves to board meetings.
- **Portfolio link:** [scenarios/soc-scenarios.md](../scenarios/soc-scenarios.md) drills this
  shift principle throughout: validate → contain → investigate, in that order.

**7. The trail that expired**
- **Situation:** An intrusion is confirmed; initial access traced to roughly five months ago. Your
  SIEM retains 30 days. The earlier evidence no longer exists.
- **What do you do?** Fix retention as a control, not a setting.
- **Correct action:** Set retention against *dwell-time reality and compliance needs* (commonly
  12+ months for security-relevant logs), tier storage (hot 30–90 days, cold/archive beyond),
  and protect archives with WORM/immutability.
- **Why:** Median dwell times exceed 30 days; a retention window shorter than dwell time means
  every serious investigation starts with destroyed evidence.
- **Portfolio link:** [spectre](../../spectre) retained hash-verified logs of every session
  precisely so later questions could still be answered.

**8. `/etc/passwd` changed at 03:12**
- **Situation:** FIM alerts: `/etc/passwd` modified at 03:12, outside any change window. A new
  UID-0 account `sysupd` exists.
- **What do you do?** Run the alert down.
- **Correct action:** Treat as **persistence via account creation** (true positive until proven
  otherwise): isolate, snapshot evidence, check auth logs for what session made the change and
  how it got in, hunt the same artefact on other hosts, then eradicate and reset credentials.
- **Why:** A second root account is a classic post-exploitation move — the FIM alert is the
  tripwire; correlation (who, from where, after what) is the investigation.
- **Portfolio link:** [gauntlet](../../gauntlet)'s privilege-escalation writeups document exactly
  why attackers want that file — and what the artefacts look like from the attacker's side.

**9. Servers going back to the lessor**
- **Situation:** Forty leased servers with regulated data are being returned. Finance wants them
  shipped Friday; the drives are self-encrypting.
- **What do you do?** Sanitise with proof.
- **Correct action:** **Crypto-erase** the self-encrypting drives (destroy the keys), verify, and
  obtain/produce a **certificate of destruction/sanitisation** per device before they leave custody.
- **Why:** Crypto-erase is fast and sound for SED/FDE media; the certificate is what compliance
  and the next audit actually ask for. Chain of custody ends with paper, not hope.
- **Portfolio link:** [ironveil](../../ironveil)'s LUKS2 design makes the same move available —
  destroying one key renders the disk's ciphertext permanently unreadable.

**10. The phish that beat the sandbox**
- **Situation:** Attachment sandboxing is on, yet credential-phishing mail still lands: plain
  HTML attachments and links to pages that turn malicious *after* delivery.
- **What do you do?** Layer the email defences.
- **Correct action:** Enable **URL rewriting with time-of-click detonation**, external-sender
  banners, and an easy report-phish button feeding SOC triage; pair with phishing-resistant MFA
  so harvested passwords are worth less.
- **Why:** Attackers weaponise content after the gateway scan — time-of-click checks re-decide at
  the moment that matters, and FIDO2 caps the damage when a user is still fooled.
- **Portfolio link:** [mirage](../../mirage)'s 88,647-email corpus is the scale of what gateways
  face — and its causal findings explain why surface filtering alone keeps losing.
