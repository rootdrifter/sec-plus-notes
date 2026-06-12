# SY0-701 Domain 3 — Security Architecture (18%)

Maps to classic notes in [3.0-architecture-design.md](3.0-architecture-design.md) with
expanded cloud, infrastructure, and data security coverage.

---

## 1. Cloud security architecture

### Service models and shared responsibility

| Model | You manage | Provider manages |
|-------|-----------|-----------------|
| **IaaS** (EC2, Azure VMs) | OS, middleware, runtime, apps, data, IAM | Hypervisor, network, physical hardware |
| **PaaS** (App Service, Lambda) | Apps, data, IAM | OS, runtime, middleware, infrastructure |
| **SaaS** (O365, Salesforce) | Data, IAM (users/access) | Everything else |

**Exam rule:** the customer **always** owns their data and access management, regardless of service model.

### Cloud deployment models

- **Public:** shared infrastructure, multi-tenant (AWS, Azure, GCP)
- **Private:** dedicated infrastructure, single tenant; on-prem or hosted
- **Hybrid:** combination — regulated data on-prem, burst/dev workloads in public
- **Community:** shared by a specific group with common requirements (government cloud, healthcare)

### Cloud-specific security controls

- **CASB (Cloud Access Security Broker):** sits between users and cloud services; enforces policy,
  provides visibility, DLP, threat protection. Four pillars: visibility, compliance, data security, threat protection.
- **CSPM (Cloud Security Posture Management):** continuously monitors cloud configurations for
  misconfigurations (the #1 cloud breach cause — open S3 buckets, over-permissive IAM).
- **CWPP (Cloud Workload Protection Platform):** secures workloads (VMs, containers, serverless).
- **SASE (Secure Access Service Edge):** combines SD-WAN with cloud-delivered security (SWG, CASB,
  ZTNA, FWaaS) into one service edge. Architecture shift for distributed/remote workforces.
- **Security groups / NSGs:** virtual firewall rules for cloud instances (stateful, per-instance or per-VPC).
- **IAM roles:** cloud-native identity with least-privilege policies; prefer roles over static keys.
- **KMS (Key Management Service):** cloud key management; customer-managed keys (CMK) vs AWS/Azure managed.
- **VPC:** isolated virtual network; subnets, route tables, internet gateway, NAT gateway.

**Serverless security:** function-level IAM permissions; no persistent OS to patch; supply-chain
risk in dependencies; timeout/execution environment risks.

> Portfolio link: [ironveil](../../ironveil)'s WireGuard + AdGuard Home is the self-hosted
> equivalent of a cloud egress security stack (SWG + DNS filtering).

---

## 2. Network security architecture

### Segmentation

- **VLANs:** logical separation on the same physical network; prevents broadcast domain spread;
  limits lateral movement.
- **DMZ (Demilitarised Zone) / screened subnet:** the zone between the internet and the internal
  network where public-facing servers (web, email, DNS) are placed. Neither fully trusted nor
  fully exposed. Two-firewall DMZ is stronger than one-firewall.
- **Microsegmentation:** fine-grained segments per workload or per application tier, enforced
  by SDN/software-defined policy.
- **East-west traffic:** lateral traffic within a data centre (server-to-server). Traditional
  perimeters only inspect north-south (in/out of the network).
- **Air gap:** complete physical isolation — no network connectivity. Used for critical OT/ICS or
  extremely sensitive data.
- **Jump box / bastion host:** single, hardened entry point for administrative access; reduces the
  attack surface for management traffic.

### Secure communications protocols

**VPN types:**
- **Site-to-site VPN:** connects two networks permanently (branch → HQ).
- **Remote-access VPN:** individual user connects to a corporate network (IPsec/IKEv2, SSL/TLS VPN).
- **Split tunnel:** only traffic destined for specific ranges goes through VPN; rest goes direct.
- **Full tunnel:** all traffic through VPN — DNS leak protection; more overhead.
- **WireGuard:** modern, fast, minimal codebase; ChaCha20-Poly1305 AEAD; Curve25519 key exchange.

**DNS security:**
- **DNSSEC:** integrity and authentication of DNS records (not confidentiality).
- **DoH (DNS over HTTPS):** DNS queries in HTTPS — hides queries from network observers; port 443.
- **DoT (DNS over TLS):** DNS queries in TLS — port 853; distinguishable but encrypted.
- Plain DNS: UDP/53 — visible to any on-path observer; easily censored.

> Portfolio link: [ironveil](../../ironveil) routes DNS through AdGuard Home → WireGuard →
> upstream resolver; [nullbyte](../../nullbyte) uses RethinkDNS with DoH.

### Network security appliances and placement (objective 3.2)

The exam tests *which appliance* and *where it sits* (inline vs passive, where in the path).

| Appliance | Role | Placement / mode | Exam discriminator |
|-----------|------|------------------|--------------------|
| **Stateful firewall** | Tracks connection state, allows return traffic | Inline at trust boundaries | vs **stateless ACL** which judges each packet alone |
| **NGFW** (next-gen) | Adds app-awareness, IDS/IPS, user-ID, TLS inspection | Inline perimeter / internal segments | "identify the *application* regardless of port" → NGFW |
| **WAF** | Filters HTTP(S) for OWASP-class attacks (SQLi/XSS) | In front of web apps (reverse-proxy position) | "protect a *specific web application*" → WAF, not a network firewall |
| **UTM** | All-in-one (FW+IPS+AV+content filter) | SMB perimeter | "single box, limited staff" → UTM; single point of failure is the trap |
| **Forward proxy** | Clients → internet through it (filtering, caching, anonymity for clients) | Egress | "control/log users' outbound browsing" |
| **Reverse proxy** | Internet → internal servers through it (TLS termination, load spread, hides origin) | Ingress | "hide/offload the backend servers" |
| **Load balancer** | Distributes across server pool (round-robin, least-conn); health checks | Ingress, in front of a pool | adds availability; **active/active vs active/passive** is the HA trap |
| **IDS** | Detects + alerts only | **Passive** — out of band, fed by SPAN/TAP | cannot drop traffic |
| **IPS** | Detects + blocks | **Inline** — sits in the traffic path | can drop; a failure here can break the link |

- **Inline vs passive / fail modes:** an inline device (IPS, firewall) that fails can either
  **fail-open** (traffic flows, *availability* preserved, security lost) or **fail-closed**
  (traffic stops, *security* preserved, availability lost). *Exam trap:* a security-critical
  segment should **fail-closed**; a high-availability business link is often configured
  **fail-open** — the "correct" answer depends on whether the stem prioritises C-I or A.
- **Jump server / bastion** (cross-ref §2) is the *administrative* ingress choke point; a
  **reverse proxy** is the *application-traffic* ingress choke point — don't conflate them.
- *Portfolio connection:* watchtower's planned architecture and ironveil's AdGuard (a filtering
  forward-resolver) are concrete instances; spectre's target sat behind no WAF, which is why the
  directory-indexing finding was directly reachable.

---

## 3. Infrastructure security

### On-premises vs cloud vs hybrid considerations

| Factor | On-prem | Cloud | Hybrid |
|--------|---------|-------|--------|
| Control | Maximum | Shared | Partial |
| Patching | Fully your responsibility | Shared or managed | Mixed |
| Physical security | Your data centre | Provider's | Both |
| Cost model | CapEx (hardware) | OpEx (subscription) | Mixed |
| Regulatory compliance | Easier for strict data residency | Depends on region | Complex |

### Secure baseline configurations

- **CIS Benchmarks:** tiered hardening guides (Level 1 = essential, Level 2 = paranoid) for
  specific platforms (Windows Server, Linux, Apache, PostgreSQL, etc.).
- **STIG (Security Technical Implementation Guide):** US DoD baseline; more prescriptive than CIS.
- Both are examples of **secure baseline / hardening standards** — disable unnecessary services,
  remove defaults, enforce minimum required settings.

> Portfolio link: [spectre](../../spectre) hardened a PostgreSQL server to CIS Level 1 Benchmark
> v2.0.0 — and that hardened server produced zero enumerable findings during the pentest.

### Virtualisation

- **Type 1 hypervisor (bare-metal):** runs directly on hardware (VMware ESXi, Hyper-V on Server Core, KVM).
  More efficient; used in data centres.
- **Type 2 hypervisor (hosted):** runs on a host OS (VirtualBox, VMware Workstation).
  More convenient; used for development and testing.
- **VM escape:** vulnerability that allows code in a VM to break out to the hypervisor or host OS.
  The critical virtualisation risk — patch hypervisors promptly.
- **VM sprawl:** uncontrolled proliferation of VMs (forgotten, unpatched); increases attack surface.
- **Snapshots:** point-in-time VM state; useful for rollback but also a risk (stale credentials, secrets).

### Containers

- Lighter than VMs; share the host kernel → weaker isolation.
- Container security: image vulnerability scanning, immutable images, least-privilege, no root in
  containers, network policy (Kubernetes NetworkPolicy), secrets management (never in env vars).

### Infrastructure as Code, serverless, and microservices (objective 3.1)

**Infrastructure as Code (IaC).**
- *Definition:* infrastructure (networks, VMs, firewall rules, identities) defined in declarative
  template files (Terraform, CloudFormation, Ansible) and deployed by automation rather than
  configured by hand.
- *How it works:* the template is the source of truth — version-controlled, peer-reviewed,
  redeployable; drift detection compares running state against the template.
- *Where it appears on the exam:* "consistent, auditable, repeatable deployments" or "config drift"
  in the stem → IaC is the answer; also as the fix for snowflake-server misconfiguration.
- *Commonly confused with:* simple shell-script provisioning (imperative, no declared end state,
  no drift detection) and SOAR (which automates *security response*, not infrastructure builds).
- *Exam trap:* IaC does **not** eliminate misconfiguration — it **scales** whatever is written.
  One bad template replicates the flaw to every deployment; secrets hard-coded in templates are a
  classic finding. The control for that is template scanning + secrets management, not "use IaC".

**Serverless** (see cloud models above for the responsibility split).
- Customer secures code, data, and function permissions only; there is no customer-patchable OS.
- Risks: over-permissive function roles, event-data injection, provider lock-in.
- *Exam trap:* "serverless" still runs on servers — the *provider* patches them; answers that have
  the customer patching the serverless OS are wrong.

**Microservices.**
- *Definition:* an application decomposed into small, independently deployable services
  communicating over APIs — versus a monolith deployed as one unit.
- *Security implications:* many more network paths (east-west traffic) to authenticate and
  monitor; per-service least privilege; API gateways and mutual TLS between services; one
  compromised service must not imply trust everywhere (zero-trust fits naturally).
- *Where it appears:* stems about "securing service-to-service communication" (→ mTLS / API
  gateway) or "limiting blast radius of one compromised component".
- *Exam trap:* microservices **increase** the internal attack surface (more endpoints, more
  credentials) — they improve resilience and deployability, not inherent security.
- *Portfolio connection:* the nullbyte nine-profile architecture applies the same blast-radius
  principle at the device level — independent trust boundaries so one compromise does not
  propagate.

---

## 4. IoT, OT/ICS and embedded systems

**IoT security challenges:**
- Weak/default credentials (never changed from factory)
- Rare or impossible patching (no update mechanism, or EOL before deployment lifecycle ends)
- No secure-update path; firmware signing often absent
- Long service life (deployed for 10–20 years, software unsupported long before)

**Mitigation:** segregate IoT onto its own VLAN; change all defaults; monitor for anomalous
traffic; network-level controls because device-level controls are often absent.

**OT/ICS/SCADA:**
- Prioritises **availability and safety** over confidentiality (unlike IT security).
- Legacy protocols: Modbus, DNP3, Profibus — designed for reliability, not authentication.
- **Purdue model / ISA-99:** hierarchical segmentation model for industrial networks (Level 0–4).
- Patching windows are rare (can't take down a manufacturing line); compensating controls dominate.
- Air gaps, data diodes, DMZs between OT and IT networks.

**Firmware and RTOS:**
- Secure boot: signed firmware; reject unsigned updates.
- Anti-rollback protection: prevents downgrading to a vulnerable version.
- Hardware root of trust: TPM, secure element — validate firmware before execution.

> Portfolio link: [nullbyte](../../nullbyte) is a worked example of mobile/embedded security:
> verified boot, hardware secure element (Titan M2), per-profile sandboxing, hardware-enforced
> IOMMU isolation of the baseband modem.

---

## 5. Data security and privacy by design

### Data states

| State | Mechanism | Portfolio example |
|-------|-----------|------------------|
| **At rest** | FDE (LUKS2/BitLocker), file encryption, encrypted DB | ironveil LUKS2 |
| **In transit** | TLS, VPN (WireGuard/IPsec), SFTP | ironveil WireGuard |
| **In use / processing** | TEE (Trusted Execution Environment), secure enclaves | Emerging; see Confidential Computing |

### Classification

- Public → Internal → Confidential → Restricted/Secret
- PII (Personally Identifiable Information) — any data that can identify an individual
- PHI (Protected Health Information) — HIPAA-regulated in the US
- SPI (Sensitive Personal Information) — GDPR special categories in EU/UK

### Privacy techniques

| Technique | Reversible? | Use case |
|-----------|-------------|----------|
| **Tokenisation** | Yes (via vault) | PCI payment data; replace PAN with token |
| **Data masking** | Maybe not | Non-prod databases; show partial data (****1234) |
| **Anonymisation** | No | Research data; removes identity permanently |
| **Pseudonymisation** | Yes (via lookup) | GDPR-preferred for research; replaces with pseudonym |
| **Hashing** | No (one-way) | Password storage (salted); integrity checks |
| **Encryption** | Yes (with key) | General-purpose confidentiality |

**Data minimisation:** collect only what is necessary; retain only as long as required.
**Data sovereignty / residency:** data must remain in a specific jurisdiction (GDPR Art. 44–46
for transfers outside the EU/EEA).

> Portfolio link: [mirage](../../mirage) synthesised vishing data with a CVAE specifically to
> avoid processing real personal voice data — privacy by design in research methodology.

---

## 6. Resilience and redundancy

### Availability mechanisms

- **RAID** levels (exam table):

| Level | Description | Redundancy | Min disks |
|-------|-------------|------------|-----------|
| 0 | Striping | None | 2 |
| 1 | Mirroring | Full copy | 2 |
| 5 | Striping with distributed parity | One disk failure | 3 |
| 6 | Striping with dual parity | Two disk failures | 4 |
| 10 | Mirror + stripe | Full mirror | 4 |

- **High availability:** active/active (both systems handle traffic simultaneously) vs
  active/passive (standby takes over on failure). Active/active is more performant but complex.
- **N+1 redundancy:** N components needed + 1 spare.

### Backups

- **Full:** complete copy. Slowest backup, fastest restore.
- **Incremental:** only changes since the last backup (of any type). Fastest backup, slowest restore
  (must chain all incrementals).
- **Differential:** only changes since the last *full* backup. Middle ground on backup/restore speed.
- **3-2-1 rule:** 3 copies, 2 different media types, 1 offsite.
- **Immutable backups:** write-once; cannot be modified or deleted by ransomware. Gold standard.
- **WORM (Write Once, Read Many):** storage technology for immutable backups; satisfies compliance retention.

### Recovery metrics (know the formulas)

- **RTO** (Recovery Time Objective) — maximum acceptable *downtime*. "How long until we're back?"
- **RPO** (Recovery Point Objective) — maximum acceptable *data loss* measured in time.
  "How much data can we afford to lose?" → drives backup frequency.
- **MTD** (Maximum Tolerable Downtime) — absolute maximum before business impact is unacceptable. RTO ≤ MTD.
- **MTBF** (Mean Time Between Failures) — reliability measure.
- **MTTR** (Mean Time To Repair) — how long repairs take on average.

### DR sites

| Site type | Readiness | RTO | Cost |
|-----------|-----------|-----|------|
| **Hot** | Fully operational, live data sync | Minutes | High |
| **Warm** | Partially configured, data needs restoring | Hours | Medium |
| **Cold** | Space and power only; no equipment ready | Days | Low |

---

### Quick self-test
- Shared responsibility model: what does the customer *always* own across IaaS/PaaS/SaaS?
- CASB vs CSPM — which provides visibility into cloud app usage, which finds misconfigurations?
- Type 1 vs Type 2 hypervisor — which is bare-metal, which is hosted?
- VM escape — what is it and why is it the critical virtualisation risk?
- Why does OT/ICS prioritise availability over confidentiality?
- 3-2-1 rule — what do each of the three numbers mean?
- Full vs incremental vs differential backup — which is fastest to back up? Which is fastest to restore?
- RTO vs RPO — which drives backup frequency?

### Scenario drills

1. *A SaaS provider is breached through a misconfigured customer access role that exposed the
   customer's data.* Under the shared responsibility model, whose failure is this? → The
   **customer's** — IAM/configuration of what you put *in* the cloud is always the customer's
   responsibility, even in SaaS.
2. *Design requirement: a public web server must be reachable from the internet, but the internal
   database segment must be unreachable from outside.* Which architecture? → A **screened subnet
   (DMZ)** between two firewalls, with the DB on an internal segment and no inbound path to it.
3. *The business says "we can lose at most 1 hour of data and must be back within 4 hours."* Translate
   to metrics and one design consequence. → **RPO = 1h** (→ back up at least hourly / continuous
   replication), **RTO = 4h** (→ warm or hot site, tested restore runbook).
4. *A factory's industrial control system must never go offline, even briefly, to apply a patch.*
   Which CIA priority dominates and what's the mitigation when you can't patch? → **Availability**
   leads in OT/ICS; use **network segmentation + compensating controls** and scheduled maintenance
   windows rather than ad-hoc patching.
5. *An attacker breaks out of a guest VM and gains code execution on the hypervisor host.* Name the
   attack and the architectural defence. → **VM escape**; defence is hypervisor patching, minimising
   host attack surface, and strong **tenant isolation** (don't co-locate sensitive workloads).
6. *Ransomware encrypts the production fileserver and the most recent backup because the backup share
   was writable.* Which single backup property would have saved them? → **Immutability** (WORM /
   offline air-gapped copy) — the "1" offsite + immutable leg of 3-2-1.

---

## Quick reference card — Domain 3

One-page revision sheet. If any line is not instant recall, re-read that section above.

**Acronyms:**
IaaS/PaaS/SaaS (infrastructure / platform / software as a service) · CASB/CSPM/CWPP (cloud access
broker / posture management / workload protection) · SASE (secure access service edge) · VPC/NSG
(virtual private cloud / network security group) · DMZ (screened subnet) · SDN (software-defined
networking) · DNSSEC/DoH/DoT (DNS integrity / over HTTPS / over TLS) · TEE (trusted execution
environment) · RAID (redundant array of independent disks) · RTO/RPO/MTD (recovery time / point
objective, maximum tolerable downtime) · MTBF/MTTR (mean time between failures / to repair) ·
WORM (write once read many) · ICS/SCADA/OT (industrial control / supervisory control / operational
technology)

**Key term one-liners:**
- Shared responsibility: the customer **always** owns data + IAM, in every service model.
- CASB = visibility/policy over cloud *app usage* · CSPM = finds cloud *misconfigurations* ·
  CWPP = protects *workloads*.
- Segmentation ladder: VLAN → DMZ/screened subnet → microsegmentation → air gap.
  East-west = lateral inside; north-south = in/out.
- VPN: site-to-site (network↔network) vs remote-access (user→network); split tunnel (some
  traffic) vs full tunnel (all traffic — DNS-leak safe).
- DNSSEC = authenticity/integrity (NOT confidentiality) · DoH/DoT = query confidentiality.
- Type 1 hypervisor = bare metal (ESXi, KVM) · Type 2 = on a host OS (VirtualBox).
- VM escape = guest→host break (attack) · VM sprawl = unmanaged VM growth (hygiene).
- Data states: at rest (FDE) · in transit (TLS/VPN) · in use (TEE/enclave).
- Backups: full (slow backup, fast restore) · incremental (fast backup, slow chained restore) ·
  differential (middle) · 3-2-1 = 3 copies, 2 media, 1 offsite · immutable/WORM beats ransomware.
- DR sites: hot (minutes, costly) · warm (hours) · cold (days, cheap).
- RAID: 0 stripe (none) · 1 mirror · 5 single-parity (3 disks) · 6 dual-parity (4) · 10 mirror+stripe.

**Exam traps:**
- A SaaS breach via customer IAM misconfiguration is the **customer's** failure.
- DNSSEC does not encrypt anything — integrity only.
- Degaussing does not work on SSDs/flash.
- RPO drives backup *frequency*; RTO drives recovery *architecture*.
- OT/ICS: availability and safety lead — compensating controls, not forced patching.
- Snapshots are not backups (same storage, same failure domain).

---

## Scenario bank — situation → action

Ten decision-format questions, distinct from the drills above and from
[soc-scenarios](../scenarios/soc-scenarios.md). Format: situation → what do you do? → correct
action → why → portfolio link.

**1. Forty unknown SaaS apps**
- **Situation:** A network review finds staff using ~40 unsanctioned SaaS tools — file converters,
  note apps, AI assistants — some receiving pasted internal data. Nobody approved any of them.
- **What do you do?** Pick the control class for shadow IT.
- **Correct action:** Deploy a **CASB** for visibility and policy over cloud app usage (discover,
  risk-rate, sanction/block, apply DLP to the sanctioned set) — paired with a usable approved-tools
  catalogue.
- **Why:** Shadow IT is a visibility problem before it is a blocking problem; you cannot govern
  usage you cannot see, and pure blocking just drives usage to personal devices.
- **Portfolio link:** [ironveil](../../ironveil)'s AdGuard + WireGuard egress stack is the
  self-hosted miniature of this: every outbound flow passes one observable, policy-enforcing point.

**2. The leaking tunnel**
- **Situation:** Remote workers use split-tunnel VPN. A compliance review finds their DNS queries
  and SaaS traffic go straight to their home ISPs — invisible to corporate monitoring and filtering.
- **What do you do?** Decide the tunnel architecture.
- **Correct action:** Move regulated roles to **full tunnel** (or SASE) so all traffic — including
  DNS — egresses through corporate inspection and filtering; accept the bandwidth cost.
- **Why:** Split tunnelling trades visibility for performance. If policy says "we inspect and
  filter", traffic that bypasses the tunnel makes the policy fiction.
- **Portfolio link:** [ironveil](../../ironveil) routes DNS through AdGuard Home and then the
  WireGuard tunnel — the no-leak pattern at single-host scale.

**3. Hostile tenants**
- **Situation:** A platform team wants to run untrusted third-party code in containers on the same
  Kubernetes nodes as the payment service, because "containers isolate things".
- **What do you do?** Choose the isolation boundary.
- **Correct action:** Untrusted workloads get **VM-level isolation** (or dedicated nodes/separate
  cluster) — containers share the host kernel, so a kernel exploit crosses every container on the
  node.
- **Why:** Isolation strength must match trust level: namespaces/cgroups are a management
  boundary; a hypervisor is a security boundary.
- **Portfolio link:** [nullbyte](../../nullbyte) makes the same call at device scale — nine fully
  separate encrypted profiles rather than one profile with "separated" apps.

**4. Authentic vs private answers**
- **Situation:** Two requirements land the same week: "DNS answers must be tamper-proof so we
  can't be redirected" and "DNS queries must not be readable by the coffee-shop network".
- **What do you do?** Map each requirement to its protocol.
- **Correct action:** Tamper-proof answers → **DNSSEC** (signed records, integrity). Private
  queries → **DoH or DoT** (encrypted transport). They compose; neither replaces the other.
- **Why:** DNSSEC authenticates the answer but transmits in clear; DoH/DoT hides the question but
  doesn't validate the answer's origin. The exam loves swapping these.
- **Portfolio link:** [nullbyte](../../nullbyte) runs RethinkDNS with encrypted DNS — the
  query-confidentiality half of this pair, chosen for hostile-network conditions.

**5. The auditor's third state**
- **Situation:** An auditor accepts your encryption at rest (LUKS2) and in transit (TLS 1.3), then
  asks: "and while the data is being processed?"
- **What do you do?** Answer for data in use.
- **Correct action:** Name the mechanisms honestly: **TEE / secure enclave / confidential
  computing** protect data during processing; where unavailable, compensate with host hardening,
  memory-access controls, and minimising how long secrets exist in memory.
- **Why:** Data in use is the third state and the least mature — credentials and keys live in RAM,
  which is why memory forensics and cold-boot attacks work.
- **Portfolio link:** [nullbyte](../../nullbyte)'s Titan M2 keeps key operations inside a hardware
  element — secrets are *used* where the OS cannot read them.

**6. Three copies, one roof**
- **Situation:** The backup design: production data, a NAS replica in the same rack, and a second
  copy on a USB drive in the same room. The team reports "3-2-1 compliant".
- **What do you do?** Audit the claim.
- **Correct action:** Fail it: 3 copies ✓, 2 media (arguably) ✓, **1 offsite ✗** — a fire, flood,
  or burglary takes all three. Add an offsite (and ideally immutable) leg.
- **Why:** The "1" exists for site-level events. Copies that share a failure domain are one copy
  for disaster purposes.
- **Portfolio link:** [ironveil](../../ironveil) stores its backup LUKS key offline and separately
  from the machine — the same separate-failure-domain rule applied to key material.

**7. Straight to production**
- **Situation:** Admins RDP/SSH to production servers directly from the same laptops they use for
  email and browsing. One phished admin workstation would touch everything.
- **What do you do?** Re-architect the admin path.
- **Correct action:** Force administrative access through a hardened **jump box / bastion** (MFA,
  no internet browsing, logged/recorded sessions), reachable only from defined sources, with
  direct admin ports closed to everything else.
- **Why:** A bastion shrinks the admin attack surface to one auditable, hardened chokepoint —
  the email-and-browsing laptop stops being a path to prod.
- **Portfolio link:** [ironveil](../../ironveil)'s dracut-sshd pre-boot unlock is a single hardened
  entry path with a pinned key — same chokepoint discipline, applied to the riskiest access there is.

**8. Somewhere to detonate**
- **Situation:** The team wants to analyse suspicious files and CTF malware samples. Current plan:
  a VM on an analyst's daily workstation, which has the corporate VPN connected.
- **What do you do?** Specify the lab isolation.
- **Correct action:** Build an **isolated lab** — dedicated host or network segment with no path
  to production or the VPN, snapshot-based resets, and explicit (default-deny) egress. Air gap if
  samples warrant it.
- **Why:** Sandbox escapes and fat-fingered detonations are survivable only when the blast radius
  is a lab. "VM on my workstation" makes the workstation the perimeter.
- **Portfolio link:** [gauntlet](../../gauntlet) practice runs in disposable, isolated platform
  VMs (TryHackMe/HackTheBox) — hostile code never shares a boundary with real data.

**9. The smart building moves in**
- **Situation:** Facilities connects 60 IP cameras, door controllers, and TV panels to the office
  LAN. Default admin passwords, vendor firmware last updated three years ago.
- **What do you do?** Contain the IoT estate.
- **Correct action:** Move IoT to its **own VLAN(s)** with default-deny routing to corporate
  segments, change every default credential, inventory the devices, and monitor their (highly
  predictable) traffic for anomalies.
- **Why:** IoT devices are rarely patchable and often pre-compromised by design (default creds);
  network-level controls must do the work that device-level controls can't.
- **Portfolio link:** [nullbyte](../../nullbyte)'s per-app network policy is the same logic:
  untrusted endpoints get the minimum network they need, not the network you happen to have.

**10. "We'll just roll back the snapshot"**
- **Situation:** A team's ransomware recovery plan is VM snapshots: "we snapshot nightly; if we're
  hit, we roll back." Snapshots live on the same storage array as the VMs.
- **What do you do?** Stress-test the plan.
- **Correct action:** Reject snapshots-as-backups: same storage = same failure domain (array
  failure, ransomware that targets the hypervisor/storage layer). Require real backups — separate
  system, offsite copy, immutability, and a tested restore.
- **Why:** A snapshot is a rollback convenience inside the system you're trying to protect. If
  the attacker (or the array) takes the storage, the "backups" go with it.
- **Portfolio link:** [ironveil](../../ironveil)'s initramfs backout plan is explicitly a rollback,
  not a backup — the distinction this plan missed.
