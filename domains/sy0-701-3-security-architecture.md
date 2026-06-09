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
