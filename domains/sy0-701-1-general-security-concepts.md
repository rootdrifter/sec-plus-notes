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

> Portfolio link: [nullbyte](../../nullbyte)'s nine-profile compartmentalisation is Zero Trust
> applied to a device — each profile is a separate trust domain with independent credentials,
> network policy, and data isolation.

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

### Quick self-test
- Name a control that is simultaneously technical AND detective.
- FIDO2 is phishing-resistant but TOTP is not — explain the mechanism.
- AAA: define each A. Why is accounting important for non-repudiation?
- Zero Trust vs perimeter model — what is the core change in assumption?
- Tokenisation vs data masking vs encryption — what distinguishes them?
- CER — which direction do you bias it for maximum security? For maximum usability?
