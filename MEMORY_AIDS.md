# Memory Aids — Security+ SY0-701

Original mnemonics for the concepts candidates most often confuse under time pressure. These are
written for this repo (not lifted from a cram site) — a memory aid only works if it sticks, so they
are deliberately blunt. Pair each with the underlying domain notes; a mnemonic recalls the *list*,
not the *understanding*.

---

## Authentication factors — "Know, Have, Are, Do, Where"

> **K**nights **H**ave **A**rmour, **D**ragons **W**ander.

- **K**now — password, PIN (knowledge)
- **H**ave — token, smart card, phone (possession)
- **A**re — fingerprint, face, iris (inherence/biometric)
- **D**o — signature dynamics, gait, typing rhythm (behaviour)
- **W**here — geolocation, IP, GPS (location)

*MFA rule:* factors must be from **different** categories. Password + PIN = still one factor (both
"Know"). Password + phone code = two factors.

---

## Risk formula chain — "Annual Risk Stacks Step by Step"

> Compute **bottom-up**: AV → EF → SLE → ARO → ALE.

```
AV   Asset Value            (£ the thing is worth)
EF   Exposure Factor        (% destroyed per event)
SLE  Single Loss Expectancy = AV × EF
ARO  Annual Rate of Occurrence (events per year)
ALE  Annual Loss Expectancy   = SLE × ARO
```

> **"S**ingle **L**oss = **A**sset × **E**xposure; **A**nnual **L**oss = **S**ingle × **R**ate."**
> Then the decision: **a control is worth it only if it cuts ALE by MORE than it costs.**

---

## Incident response phases — NIST: "People Don't Clean Rooms Perfectly"

> **P**eople **D**on't **C**lean **R**ooms **P**erfectly → **P**reparation, **D**etection &
> analysis, **C**ontainment-eradication-**R**ecovery, **P**ost-incident.

SANS variant (PICERL): **"Please Identify Crooks, Eradicate, Recover, Learn"** —
Preparation, Identification, Containment, Eradication, Recovery, Lessons-learned.

> Order trap: **Contain before you Eradicate.** You stop the bleeding before you operate.

---

## Order of volatility — "RAM Rots, Disks Don't"

> Capture most-volatile first: **Registers → RAM → Removable/temp → Rust (disk) → Remote logs → Records (archive).**

The "six R" ladder, top to bottom = most to least volatile. Powering off destroys the top of the
ladder, so **memory before disk, always**.

---

## CIA + the extras — "CIA's Number-One Asset"

> **C**onfidentiality, **I**ntegrity, **A**vailability — then **N**on-repudiation, **A**uthentication.

- Encryption → **C**
- Hashing/signatures → **I** (and signatures add **N**)
- Redundancy/backups/HA → **A**

---

## Cryptographic algorithm families — "Same key, Two keys, No key"

| Family | One-line tell | Members (SY0-701) |
|--------|---------------|-------------------|
| **Symmetric** ("**Same** key") | one shared secret; fast; bulk data | AES, ChaCha20, 3DES(legacy), RC4(broken) |
| **Asymmetric** ("**Two** keys") | public/private pair; key exchange + signatures; slow | RSA, ECC/ECDSA, ECDHE, ElGamal, DSA |
| **Hashing** ("**No** key") | one-way, fixed length, integrity | SHA-2/3, (MD5/SHA-1 broken) |
| **KDF / password** (slow on purpose) | salted + slow → store passwords | Argon2id, bcrypt, scrypt, PBKDF2 |
| **MAC** (keyed integrity) | shared key + hash → integrity *and* authenticity | HMAC, CMAC |

> Trap-buster: **never** hash passwords with plain SHA-256 (too fast) — use a **KDF**. For "confidentiality
> **and** integrity in one go" pick an **AEAD** mode (**AES-GCM**, ChaCha20-Poly1305).

---

## Network/attack categories — "SPIDER"

> **S**poofing, **P**oisoning, **I**nterception (MITM/on-path), **D**oS/DDoS, **E**xfiltration, **R**eplay.

- **S**poofing — ARP/DNS/MAC/IP identity forgery
- **P**oisoning — ARP cache, DNS cache, routing
- **I**nterception — on-path/MITM, SSL strip, evil twin
- **D**oS — volumetric, protocol, application-layer
- **E**xfiltration — DNS tunnelling, covert channels
- **R**eplay — captured-and-resent auth (defeat with nonces/timestamps)

---

## Social-engineering levers — "USA-FICS"

> Why the human clicks: **U**rgency, **S**carcity, **A**uthority, **F**amiliarity, **I**ntimidation,
> **C**onsensus (social proof), **S**ecrecy.

Name the lever and you usually have the answer — e.g. "CEO needs it NOW, tell no one" = Authority +
Urgency + Secrecy (a whaling/BEC tell).

---

## Access-control models — "DR. MAB"

> **D**AC, **R**BAC, **MAC**, **AB**AC.

- **D**AC — owner sets permissions (discretionary)
- **R**BAC — permissions by job role
- **MAC** — labels/clearances enforced by the system (rigid; military)
- **ABAC** — decisions on attributes (role + dept + time + location) — most granular

> "Their own patients / contextual" = **ABAC**. "Top secret labels" = **MAC**. "By job title" = **RBAC**.

---

## Recovery metrics — "Point vs Time, Fail vs Fix"

- **RP**O = **P**oint in the **P**ast you can lose (data) → backup frequency
- **RT**O = **T**ime **T**o restore the service
- **MTB/TT-F** = hardware **F**ailure/reliability
- **MTT-D / MTT-R** = SOC speed to **D**etect / **R**espond

> "How much data?" = RPO. "How long down?" = RTO. Don't swap them — it's a guaranteed exam point.

---

*Use these to recall the list, then prove you understand each item from the domain notes and the
[practice exams](practice-exams/). A mnemonic you can recite but not explain will fail a scenario question.*
