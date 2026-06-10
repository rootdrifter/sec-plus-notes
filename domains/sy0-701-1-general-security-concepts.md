# SY0-701 Domain 1 — General Security Concepts (12%)

This domain maps primarily to material from the classic notes in
[1.0-threats-attacks-vulnerabilities.md](1.0-threats-attacks-vulnerabilities.md),
[4.0-identity-access-management.md](4.0-identity-access-management.md), and
[6.0-cryptography-pki.md](6.0-cryptography-pki.md).

---

## 1. Security controls

Controls are the mechanisms that reduce risk. The exam combines two classification schemes:

**By nature (what kind of control):**
- **Technical / logical** — software or hardware enforced (firewalls, encryption, MFA, ACLs)
- **Administrative / managerial** — policy, procedure, governance (security policy, risk assessment, training)
- **Physical / operational** — physical environment (locks, cameras, guards, mantraps, bollards)

**By function (what the control does):**
- **Preventive** — stops an event (firewall, ACL, MFA, FDE, badge-access doors)
- **Detective** — identifies an event (IDS, SIEM, audit logs, security cameras)
- **Corrective** — restores state after an event (backups, patch, incident response)
- **Deterrent** — discourages attempts (warning banners, visible cameras, prosecution notices)
- **Compensating** — alternative when the primary control is not feasible (e.g. VLAN segmentation
  when you can't patch a legacy OT device)
- **Recovery** — restores operations (DR site, backup restore)
- **Directive** — guides behaviour (policy documents, mandatory training, acceptable-use policies)

**Exam trap:** a single control can occupy multiple categories — a CCTV camera is *physical* and
*detective*; a firewall is *technical* and *preventive*.

> Portfolio link: [ironveil](../../ironveil) layers technical preventive controls (LUKS2 FDE,
> WireGuard, FIDO2) with physical controls (hardware key touch requirement) and administrative
> discipline (offline backup key stored separately).

---

## 2. Non-repudiation

The ability to prove that an entity performed an action — they cannot later deny it.

- Mechanism: **digital signatures** (sign with private key; anyone with the public key can verify).
  Verification proves the signer held the private key at the time → non-repudiation.
- Other mechanisms: audit logs, timestamps, blockchain-anchored records.
- Relates to: **accountability** (can you trace who did what?).

> See [6.0-cryptography-pki.md §6](6.0-cryptography-pki.md) for digital signature mechanics.

---

## 3. AAA framework (deep)

**Authentication, Authorisation, Accounting** — the three functions every access control system must address.

| Function | Question | Mechanism |
|----------|----------|-----------|
| Identification | Who are you claiming to be? | Username, user ID, email |
| **Authentication** | Prove it. | Factors (below) |
| **Authorisation** | What are you allowed to do? | ACLs, RBAC, policies |
| **Accounting** | What did you actually do? | Logs, SIEM, audit trails |

### Authentication factors (know these cold)

| Factor | Type | Examples | Attack resistance |
|--------|------|----------|-------------------|
| Knowledge | Something you **know** | Password, PIN, passphrase, secret answer | Phishable; reusable; poor |
| Possession | Something you **have** | Hardware key (FIDO2), smartcard, TOTP token, phone | Better; see below |
| Inherence | Something you **are** | Fingerprint, face, iris, retina, voice | Can't be reset; FAR/FRR trade-off |
| Location | Somewhere you **are** | GPS geolocation, IP range, geofencing | Coarse; use as secondary signal |
| Behaviour | Something you **do** | Typing rhythm (keystroke dynamics), gait | Emerging; continuous auth |

**MFA** = at least two **different factor types**. Two passwords = same type = still just one factor.

### Passwordless and phishing-resistant auth

- **FIDO2/WebAuthn passkeys:** public-key, origin-bound → phishing-resistant (signature is
  tied to the exact domain; can't be relayed to a fake site). The private key never leaves the device.
- **Smartcard/PIV/CAC:** certificate-based; also phishing-resistant.
- **TOTP/SMS/push notifications:** possession factor but NOT phishing-resistant — the OTP can be
  relayed in real time; push can be approved by a fatigued user (MFA bombing/prompt bombing).
- **Roaming vs platform authenticator:** roaming = a portable hardware key (Nitrokey, YubiKey)
  usable across devices; platform = bound to one device's secure enclave (Windows Hello, Face ID).

> Portfolio link: [ironveil](../../ironveil) uses a Nitrokey 3A NFC (FIDO2 roaming authenticator)
> for LUKS2 disk unlock. The touch-only (no clientPin) enrollment is a single-factor *possession*
> control. Adding a clientPin PIN would make it true MFA (possession + knowledge).

### Biometric metrics

- **FAR** (False Accept Rate) = security risk (lets imposters in). Minimise for high-security.
- **FRR** (False Reject Rate) = usability problem (denies legitimate users). Minimise for UX.
- **CER/EER** (Crossover Error Rate) = the point where FAR = FRR. Lower CER = better biometric.

---

## 4. Zero Trust

"Never trust, always verify" — no implicit trust from network location, device ownership, or
previous authentication.

**Core principles:**
- Every resource access is authenticated and authorised — regardless of whether the request
  comes from inside or outside the perimeter.
- Least-privilege access: grant only the minimum rights needed, for the minimum time.
- Assume breach: design as if the network is already compromised.
- Continuous verification: re-evaluate trust mid-session, not just at login.

**Practical pillars:** identity (MFA + conditional access), device (compliance/posture check),
network (microsegmentation, SASE), application (WAF, app-layer controls), data (encryption,
classification, DLP), visibility/analytics (SIEM, UEBA, SOAR).

### Zero Trust planes (high-yield SY0-701 terminology)

The exam splits Zero Trust into a **control plane** (decides) and a **data plane** (enforces).
Know these terms precisely — they appear as direct definition questions:

| Term | Plane | Role |
|------|-------|------|
| **Policy Engine (PE)** | Control | Makes the allow/deny/revoke decision by evaluating policy against signals |
| **Policy Administrator (PA)** | Control | Executes the PE's decision — generates/revokes the session token or credential |
| **Policy Enforcement Point (PEP)** | Data | The gateway that actually allows, monitors, and terminates the connection to the resource |
| **Policy Decision Point (PDP)** | Control | Umbrella term for PE + PA together |
| **Adaptive identity** | Control | Authentication strength scales with risk signals (location, device, behaviour) |
| **Threat scope reduction** | Both | Minimise blast radius — least privilege, microsegmentation |
| **Implicit trust zones** | Data | The (small, audited) area a subject reaches after a PEP grants access |

Mnemonic: the **PE decides**, the **PA acts on the decision**, the **PEP sits in front of the
resource and enforces it**. A request hits the PEP → PEP asks the PDP → PE evaluates policy →
PA issues/revokes the token → PEP allows or blocks.

> Portfolio link: [nullbyte](../../nullbyte)'s nine-profile compartmentalisation is Zero Trust
> applied to a device — each profile is a separate trust domain with independent credentials,
> network policy, and data isolation. The per-profile lockscreen credential acts as the
> enforcement point: no implicit trust carries across a profile boundary even for the device owner.

---

## 5. Physical security

Physical controls are the first layer of defence — if an attacker can reach the hardware, most
software controls can be bypassed.

**Perimeter controls:** fencing, bollards, lighting, signage, vehicle barriers, security guards.

**Entry controls:**
- **Mantrap / access control vestibule** — two-door buffer that allows only one door open at a
  time; forces badge entry; defeats tailgating.
- **Biometric readers** (fingerprint, iris, retina, hand geometry) at sensitive areas.
- **Proximity / RFID cards** — convenient but cloneable; combine with PIN (multi-factor).
- **Faraday cage** — RF shielding; blocks wireless signals in/out of a room.

**CCTV / video surveillance:**
- Deterrent + detective control.
- Must be supported by monitoring and retention policy to be effective.
- Consider privacy law compliance (GDPR in UK/EU).

**Industrial / hardware:**
- **Cable locks** for laptops in accessible areas.
- **USB port blockers** to prevent rogue device insertion.
- **Tamper-evident seals** on server chassis.

> Portfolio link: [ironveil](../../ironveil)'s Nitrokey hardware key enforces physical presence
> for disk unlock — the touch requirement on the key is a physical control layer.

---

## 6. Cryptographic solutions — use-case mapping

The exam asks you to match a primitive to a requirement. Key mappings:

| Requirement | Primitive | Why |
|-------------|-----------|-----|
| Confidentiality (bulk data) | AES-256-GCM (AEAD) | Fast; authenticated |
| Confidentiality (key exchange) | ECDHE + AES-GCM | Hybrid: asymmetric exchange, symmetric bulk |
| Integrity only | SHA-256 hash | One-way; avalanche effect |
| Integrity + authenticity | HMAC-SHA256 | Hash + shared secret |
| Authenticity + non-repudiation | Digital signature (ECDSA/EdDSA) | Private key proves identity |
| Data at rest | AES-XTS (FDE), AES-GCM (file) | XTS designed for disk sectors |
| Data in transit | TLS 1.3 (ECDHE + AES-256-GCM) | Perfect forward secrecy, AEAD |
| Password storage | Argon2id, bcrypt, scrypt | Memory-hard; slow by design |
| Key exchange without prior shared secret | Diffie-Hellman / ECDHE | Public-key key agreement |

**Obfuscation vs encryption:** obfuscation makes something harder to understand (e.g. base64,
code obfuscation) but provides no cryptographic security guarantee. Do not confuse with encryption.

**Steganography:** hiding data within another file (image, audio) — concealment, not encryption.
Can be combined with encryption for defence in depth.

**Tokenisation:** replacing sensitive data (PAN, SSN) with a non-sensitive token. The real value
lives only in a secure token vault. Reduces PCI scope because tokens are useless without the vault.

**Data masking:** presenting a partial or pseudonymised version of data for non-production use.
Different from tokenisation — masking may be irreversible.

---

## 7. Common security infrastructure (rapid-reference)

| Device | Function | Key distinction |
|--------|----------|-----------------|
| Firewall | Filters traffic by rules (L3/L4) | Stateful (tracks connections) vs stateless (per-packet) |
| NGFW | L7 app-aware filtering + IPS + TLS inspection | Goes deeper than traditional firewall |
| IDS | Detect + alert (out-of-band; does not block) | Signature vs anomaly vs behaviour |
| IPS | Detect + block (inline; stops traffic) | Must be inline to block |
| WAF | App-layer HTTP filtering | Stops SQLi/XSS; layer 7 only |
| Proxy | Intermediary | Forward (clients→internet) vs reverse (internet→servers) |
| SIEM | Aggregate + correlate logs | Splunk, Sentinel, QRadar, Elastic |
| SOAR | SIEM + playbook automation + orchestration | Automated response on top of SIEM |
| DLP | Prevents data exfiltration | Endpoint / network / cloud |
| NAC | Controls device admission | Posture checks before granting access; 802.1X |

> See [2.0-technologies-tools.md](2.0-technologies-tools.md) for full coverage.

---

## 8. Deception and disruption technology

SY0-701 objective 1.2 explicitly lists deception technology. These controls do not prevent an
attack — they **detect** intrusion and **waste attacker effort** with high-fidelity, low-false-positive
signals. Because no legitimate user has any reason to touch them, any interaction is suspicious
by definition.

| Technique | What it is | Detection value |
|-----------|-----------|-----------------|
| **Honeypot** | A single decoy system that looks exploitable | Any connection is an alert; studies attacker TTPs |
| **Honeynet** | A whole network of honeypots | Observes lateral movement and multi-stage attacks |
| **Honeyfile** | A bait file (e.g. `passwords.xlsx`) with no real value | Opening/exfiltrating it triggers an alert |
| **Honeytoken** | A fake credential, API key, or DB record seeded into real systems | Use of the token anywhere proves data was stolen and shows where |

**Why these are high-signal:** a SIEM drowns in false positives, but a honeytoken firing is almost
never benign — it is one of the cleanest breach indicators a SOC can deploy. Canary tokens (a
hosted honeytoken service) are the common real-world implementation.

**DNS sinkhole** (a disruption control on the same objective): a resolver that returns a controlled
answer for known-malicious domains, so infected hosts beaconing to C2 are redirected and logged
instead of reaching the attacker. This is the *offensive-detection* sibling of the DNS *filtering*
in ironveil's AdGuard stack — same mechanism (authoritative answer substitution), different intent.

---

## 9. Change management (objective 1.3)

The exam treats change management as a **security** topic because most outages and many incidents
are self-inflicted by uncontrolled change. Memorise both the process elements and the technical
implications.

**Process (governance side):**

| Element | Purpose |
|---------|---------|
| **Approval process** | Changes are authorised before implementation (often a Change Advisory Board, CAB) |
| **Ownership** | A named owner is accountable for the change end to end |
| **Stakeholders** | Everyone affected is identified and consulted |
| **Impact analysis** | What could this break? What is the blast radius? |
| **Test results** | Validate in a non-production environment first |
| **Backout / rollback plan** | A defined way to revert if the change fails — mandatory |
| **Maintenance window** | Scheduled low-impact time to apply the change |
| **Standard Operating Procedure (SOP)** | Documented, repeatable steps |

**Technical implications (the security-relevant side):**
- **Allow lists / deny lists** must be updated when a change adds or removes a service.
- **Restricted activities** — some changes require elevated approval or four-eyes review.
- **Downtime, service/application restart, dependency mapping** — a change to one service can
  cascade; an unmapped dependency is how a "small" change causes a major outage.
- **Legacy applications** resist change (no test environment, no vendor support) — a recognised risk.
- **Documentation:** update network/data-flow diagrams and policies; use **version control** so
  every change is attributable and reversible.

> Portfolio link: [ironveil](../../ironveil)'s `dracut -f --regenerate-all` initramfs rebuild is a
> textbook change-management case — it has a backout path (the prior initramfs), a dependency
> (the baked-in ed25519 key must be re-pinned on the GrapheneOS client or remote unlock breaks),
> and a documented SOP. Skipping the impact analysis here would lock the operator out of their
> own encrypted disk: change management *is* operational security.

---

## 10. PKI and certificates (objective 1.4 — deep)

Objective 1.4 ("appropriate cryptographic solutions") is heavily certificate-focused. The §6
use-case table covers primitive selection; this section covers the **public-key infrastructure**
that the exam tests in detail.

### Trust chain

- **Certificate Authority (CA)** — issues and vouches for certificates. The **root CA** is the
  trust anchor (kept offline); **intermediate CAs** issue day-to-day certs so the root key stays
  protected. A client trusts a cert if it chains to a trusted root.
- **Registration Authority (RA)** — verifies identity before the CA issues a cert.
- **CSR (Certificate Signing Request)** — what you generate (with your public key + identity) and
  submit to the CA. Your private key never leaves your control.

### Validity and revocation (classic exam trap)

| Mechanism | How it works | Trade-off |
|-----------|-------------|-----------|
| **CRL (Certificate Revocation List)** | CA publishes a signed list of revoked serials; client downloads it | Can be large and stale between updates |
| **OCSP (Online Certificate Status Protocol)** | Client queries the CA for one cert's status in real time | Per-query latency; privacy leak to the CA |
| **OCSP stapling** | The *server* fetches and attaches a time-stamped OCSP response to its TLS handshake | Removes the client→CA round trip and the privacy leak — preferred |

**Key escrow** — a copy of a private key is held by a trusted third party so encrypted data is
recoverable if the key is lost. A confidentiality/availability trade-off: convenient for recovery,
but the escrow agent becomes a high-value target.

### Certificate types

- **Wildcard** (`*.example.com`) — one cert for all subdomains; convenient but one compromise
  exposes them all.
- **SAN (Subject Alternative Name)** — multiple explicit names on one cert.
- **Self-signed** — no external CA; fine for internal/lab use, untrusted by default in browsers.
- **Certificate pinning** — the client hard-binds a known cert/public key, defeating a fraudulent
  CA-issued cert (the on-path mitigation referenced in Domain 2).

### Cryptographic hardware and key storage

| Component | Role |
|-----------|------|
| **TPM (Trusted Platform Module)** | On-board chip storing keys/measurements; backs full-disk encryption and measured boot |
| **HSM (Hardware Security Module)** | Dedicated, tamper-resistant appliance for high-volume key ops (CAs, payment) |
| **KMS (Key Management Service)** | Cloud-managed key lifecycle (generation, rotation, destruction) |
| **Secure enclave** | Isolated processor region for keys/biometrics (Apple Secure Enclave, Titan M2) |

**Key stretching** — deliberately slow KDFs (**Argon2id, bcrypt, scrypt, PBKDF2**) make brute force
expensive; the defence for password and passphrase storage. **Blockchain / open public ledger** —
distributed, append-only, integrity via hash chaining; the exam frames it as a tamper-evident
integrity mechanism, not a confidentiality one.

> Portfolio link: [ironveil](../../ironveil) is a concrete map of this objective — LUKS2 uses
> **Argon2id key stretching**; the **Nitrokey 3A NFC** is a hardware key store enrolling FIDO2
> credentials; and [nullbyte](../../nullbyte)'s **Titan M2** is a secure-element root of trust.
> The portfolio demonstrates the 1.4 toolset rather than just naming it.

---

### Quick self-test
- Name a control that is simultaneously technical AND detective.
- FIDO2 is phishing-resistant but TOTP is not — explain the mechanism.
- AAA: define each A. Why is accounting important for non-repudiation?
- Zero Trust vs perimeter model — what is the core change in assumption?
- Tokenisation vs data masking vs encryption — what distinguishes them?
- CER — which direction do you bias it for maximum security? For maximum usability?
- Zero Trust planes: which component *decides* access, which *acts on* the decision, and which
  *enforces* it in front of the resource? (PE / PA / PEP)
- Honeytoken vs honeypot — which is seeded inside a real production system, and why is a
  honeytoken firing such a high-signal alert?
- CRL vs OCSP vs OCSP stapling — which removes the client→CA round trip and the privacy leak?
- TPM vs HSM vs secure enclave — match each to: a CA's bulk signing appliance, a laptop's
  measured-boot key store, a phone's biometric/key isolation chip.

### Scenario drills

1. *A change ticket adds a new public-facing service. The firewall allow list is updated and the
   service goes live, but an overnight batch job that depended on the old port silently fails.*
   Which change-management element was skipped? → **Impact analysis / dependency mapping.**
2. *A SOC receives an alert that a credential named `svc_backup_DONOTUSE` was used to log in from
   an external IP. No such account is provisioned for real use.* What control just fired, and what
   does it prove? → A **honeytoken**; it proves credential theft and reveals the attacker's entry path.
3. *A browser warns that a site's certificate cannot be checked because the revocation server is
   unreachable.* Which revocation mechanism would have avoided the extra round trip by having the
   server present a signed status itself? → **OCSP stapling.**
4. *An engineer rebuilds ironveil's initramfs but forgets the baked-in SSH key is a dependency of
   the remote-unlock path.* Map this to one change-management failure and one Zero Trust idea.
   → Missing **backout/dependency analysis**; the initramfs SSH key is the **enforcement point**
   for pre-boot access — no implicit trust without it.
