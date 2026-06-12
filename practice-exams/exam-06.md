# Practice Exam 06 — Performance-Based Question (PBQ) Simulation (SY0-701)

The real SY0-701 opens with a handful of PBQs — interactive tasks that reward *doing* over recall.
They are worth disproportionate marks and eat time, so the exam strategy is: **flag the longest PBQs,
do the multiple-choice first, return to PBQs with the remaining time.** Below are 10 PBQ-style tasks
in text form: scenario → task → correct answer → full explanation.

---

## PBQ 1 — Order the incident-response steps

**Scenario.** A workstation is beaconing to a C2 domain. Put these actions in the correct order
(NIST SP 800-61).

`a) Re-image and restore from known-good backup`
`b) Disable the account and isolate the host on the network`
`c) Write the lessons-learned report and update detections`
`d) Confirm the alert is a true positive and scope affected systems`
`e) Remove persistence (rogue service/task) and reset credentials`

**Answer:** **d → b → e → a → c**
**Explanation.** Detection & Analysis (d) → Containment (b) → Eradication (e) → Recovery (a) →
Post-Incident (c). Contain *before* eradicate; isolate rather than power off to preserve volatile
evidence; lessons-learned is always last.

---

## PBQ 2 — Match the tool to its function

| Tool | | Function |
|------|--|----------|
| 1. `nmap` | | A. Password cracking (offline hashes) |
| 2. `Wireshark` | | B. Host/port discovery and service enumeration |
| 3. `Hashcat` | | C. Packet capture and protocol analysis |
| 4. `Nessus` | | D. Web application proxy / interception |
| 5. `Burp Suite` | | E. Authenticated vulnerability scanning |

**Answer:** 1→B, 2→C, 3→A, 4→E, 5→D
**Explanation.** Classic SY0-701 tool taxonomy. Note the trap: Wireshark *captures/analyses* but does
not actively scan; nmap *discovers* but is not a full vuln scanner (Nessus/OpenVAS are).

---

## PBQ 3 — Configure the firewall rule

**Scenario.** Requirement: web servers in `10.0.10.0/24` must serve HTTPS to the Internet, and an
admin subnet `10.0.99.0/24` must reach them over SSH. Everything else is denied. Order/complete the
ruleset (rules evaluated top-down, first match wins; implicit deny last).

```
# Fill in action / src / dst / port for each:
R1: ____ src=0.0.0.0/0      dst=10.0.10.0/24  port=____   # public web
R2: ____ src=10.0.99.0/24   dst=10.0.10.0/24  port=____   # admin mgmt
R3: ____ src=any            dst=any           port=any     # cleanup
```

**Answer:**
```
R1: ALLOW src=0.0.0.0/0     dst=10.0.10.0/24  port=443
R2: ALLOW src=10.0.99.0/24  dst=10.0.10.0/24  port=22
R3: DENY  src=any           dst=any           port=any   (explicit deny + log)
```
**Explanation.** Specific allows precede the cleanup deny. SSH (22) is restricted to the admin source
— exposing 22 to `0.0.0.0/0` would be the wrong answer. The explicit logged deny aids detection.

---

## PBQ 4 — Identify the attack from the log

**Scenario.** Apache access log excerpt:
```
10.0.0.5 - - "GET /products.php?id=1' UNION SELECT username,password FROM users-- HTTP/1.1" 200
10.0.0.5 - - "GET /products.php?id=1 AND 1=1 HTTP/1.1" 200
10.0.0.5 - - "GET /products.php?id=1 AND 1=2 HTTP/1.1" 500
```
**Task.** Identify (a) the attack, (b) the vulnerability class, (c) the fix.

**Answer:** (a) **SQL injection** (UNION-based + boolean test), (b) **injection / CWE-89**,
(c) **parameterised queries / prepared statements**; defence-in-depth: WAF, least-privilege DB user.
**Explanation.** `UNION SELECT … FROM users--` extracts data; the `1=1`/`1=2` pair with differing
responses is a boolean-blind confirmation. Input validation alone is insufficient — bind parameters.

---

## PBQ 5 — Select the correct cryptographic algorithm

Match the requirement to the BEST algorithm/primitive.

| Requirement | Options: AES-256-GCM · RSA-4096 · SHA-256 · ECDHE · Argon2id · HMAC-SHA256 |
|-------------|----------------------------------------------------------------------------|
| 1. Encrypt a large file at rest (confidentiality + integrity) | |
| 2. Store user login passwords | |
| 3. Verify a download was not modified | |
| 4. Establish a session key with forward secrecy | |
| 5. Exchange a symmetric key to a known public-key holder | |
| 6. Authenticate an API message with a shared secret | |

**Answer:** 1→**AES-256-GCM**, 2→**Argon2id**, 3→**SHA-256**, 4→**ECDHE**, 5→**RSA-4096**,
6→**HMAC-SHA256**
**Explanation.** GCM gives authenticated encryption (confidentiality + integrity). Passwords need a
*slow, salted* KDF (Argon2id/bcrypt/scrypt) — never plain SHA-256. Hashing verifies integrity. ECDHE
provides perfect forward secrecy. RSA encrypts/wraps a key for a known recipient. HMAC authenticates
with a shared key. Trap: choosing SHA-256 for passwords (too fast) or AES for integrity-only.

---

## PBQ 6 — Complete the risk calculation

**Scenario.** Asset value £800,000. A fire would destroy 50%. Historical rate: 1 fire every 25 years.
A £5,000/yr suppression system reduces the exposure factor to 10%.

**Task.** Compute SLE, ARO, ALE (before), ALE (after), and state whether the control is justified.

**Answer.**
- SLE = AV × EF = £800,000 × 0.50 = **£400,000**
- ARO = 1/25 = **0.04**
- ALE before = £400,000 × 0.04 = **£16,000/yr**
- ALE after = (£800,000 × 0.10) × 0.04 = £80,000 × 0.04 = **£3,200/yr**
- Avoided loss = £16,000 − £3,200 = **£12,800/yr** > £5,000 cost ⇒ **control IS justified**

**Explanation.** Compare the *reduction in ALE* to the control cost. Here the control changes the
exposure factor, not the rate — so recompute SLE with the new EF.

---

## PBQ 7 — Identify the vulnerability in the network diagram

**Scenario (described).**
```
Internet ── Firewall ── [ DMZ: Web + Database on the SAME subnet ] ── Firewall ── Internal LAN
                                  (DB has a public route; admin RDP open to 0.0.0.0/0)
```
**Task.** Identify the two most serious design flaws and the fix for each.

**Answer.**
1. **Database in the DMZ / same subnet as the web server** → move the DB to an internal tier; only
   the app tier reaches it (defence-in-depth, reduce attack surface). A DMZ DB exposed to the
   Internet is a breach waiting to happen.
2. **RDP/admin open to `0.0.0.0/0`** → restrict management to a jump host / VPN / admin subnet, use
   MFA. Internet-exposed RDP is a top ransomware entry vector.
**Explanation.** The principle is tiered architecture + least exposure: front-ends in the DMZ,
data tiers internal, management never open to the world.

---

## PBQ 8 — Select the framework/regulation that applies

Match each scenario to the BEST-fit framework.

| Scenario | Options: GDPR · PCI-DSS · HIPAA · ISO 27001 · NIST CSF · SOC 2 |
|----------|----------------------------------------------------------------|
| 1. An EU retailer handling customer personal data | |
| 2. A clinic storing patient health records (US) | |
| 3. An e-commerce site processing card payments | |
| 4. A SaaS firm proving security controls to enterprise customers | |
| 5. An org seeking a certifiable, auditable ISMS | |
| 6. Voluntary framework to organise a security programme (Identify/Protect/Detect/Respond/Recover) | |

**Answer:** 1→**GDPR**, 2→**HIPAA**, 3→**PCI-DSS**, 4→**SOC 2**, 5→**ISO 27001**, 6→**NIST CSF**
**Explanation.** Match by data type/purpose. ISO 27001 is the *certifiable* ISMS standard; NIST CSF
is a voluntary organising framework; SOC 2 is an attestation report for service providers.

---

## PBQ 9 — Order the digital-forensics evidence collection (order of volatility)

Put these sources in collection order, most volatile first:
`a) Disk image  b) CPU cache/registers  c) Archival backups  d) RAM (processes, connections)  e) Remote/SIEM logs`

**Answer:** **b → d → a → e → c**
**Explanation.** Registers/cache → RAM → disk → remote logs → archival (RFC 3227). Capturing disk
before RAM (or powering off) destroys the most volatile, highest-value evidence.

---

## PBQ 10 — Configure the access-control model

**Scenario.** A hospital needs: clinicians see records only for *their own patients*; access depends
on role *and* attributes (department, time, location); break-glass emergency access is logged.

**Task.** Choose the access-control model and name the two supporting principles.

**Answer.** **ABAC (Attribute-Based Access Control)** — decisions on role + attributes (department,
time, location). Supporting principles: **least privilege** and **separation of duties**, with
**break-glass** access fully audited.
**Explanation.** RBAC alone can't express "their own patients" + contextual attributes; ABAC
evaluates attributes per request. MAC would be too rigid for clinical workflows; DAC too permissive.

---
---

## How to use this exam

PBQs reward method, not memorisation. For each one, practise narrating the *rule* you applied
(order of volatility, contain-before-eradicate, specific-allows-before-deny, slow-KDF-for-passwords).
On exam day: **triage PBQs by length, bank the MCQs, return to PBQs.** Never leave a PBQ blank —
partial credit is awarded on multi-part PBQs.
