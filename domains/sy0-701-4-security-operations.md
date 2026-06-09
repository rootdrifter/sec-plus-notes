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

## 6. Network security tools (operational use)

| Tool | Use | Key flags/notes |
|------|-----|-----------------|
| **nmap** | Port and service discovery | -sS (SYN scan), -sV (version), -O (OS), -p- (all ports), --script |
| **Wireshark** | Packet capture and analysis | GUI; protocol dissection; filter language |
| **tcpdump** | Command-line packet capture | `tcpdump -i eth0 host 10.0.0.1 and port 80` |
| **netcat** | TCP/UDP Swiss-army tool | Port scanning, file transfer, reverse shells, banner grabbing |
| **dig / nslookup** | DNS queries | `dig @8.8.8.8 example.com A` |
| **curl** | HTTP testing | `-v` for verbose; `-I` for headers; `-s` silent; `-L` follow redirects |
| **ss / netstat** | Socket and network state | `ss -tulpn` (TCP+UDP, listening, process, numeric) |

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
