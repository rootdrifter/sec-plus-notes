# Sprint Exam — Domain 1: General Security Concepts (12%)

10 of the hardest D1 items: control types, CIA/AAA/non-repudiation, zero trust, change management,
and cryptographic solutions (where most D1 traps live). Single best answer; key below the divider.

**Q1.** A bollard outside a data centre is which control type(s)?
A) Detective + technical  B) Preventive/deterrent + physical  C) Compensating + managerial  D) Corrective + operational

**Q2.** Which BEST provides non-repudiation?
A) Symmetric AES encryption  B) An HMAC with a shared key  C) A digital signature with the sender's private key  D) TLS

**Q3.** In Zero Trust, which plane contains the Policy Engine and Policy Administrator?
A) Data plane  B) Control plane  C) Management VLAN  D) Trust zone

**Q4.** Passwords are stored as `SHA-256(password)`. The single biggest weakness?
A) SHA-256 is broken  B) No salt → identical passwords hash identically and rainbow tables apply  C) Output too short  D) It is reversible

**Q5.** A salt and a pepper differ how?
A) Identical terms  B) Salt is unique per-hash and stored alongside; pepper is a secret kept separately (e.g. HSM)  C) Pepper is per-user, salt is global  D) Salt is encryption, pepper is hashing

**Q6.** Which provides confidentiality *and* integrity/authenticity of the ciphertext in one step?
A) AES-CBC  B) AES-ECB  C) AES-GCM  D) RSA-OAEP

**Q7.** Why use ECDHE instead of static RSA key exchange in TLS?
A) Faster certificates  B) Perfect forward secrecy — past sessions stay safe if the long-term key leaks  C) Smaller keys only  D) Avoids certificates

**Q8.** A change-management process requires a documented back-out plan primarily to ensure:
A) Confidentiality  B) Recoverability if the change fails (availability)  C) Non-repudiation  D) Least privilege

**Q9.** A honeytoken is BEST described as:
A) A hardware key  B) A decoy credential/record that should never be used — any use is a high-fidelity alert  C) A password vault  D) A TLS token

**Q10.** Which correctly orders certificate trust validation?
A) Leaf → root → intermediate  B) Leaf → intermediate(s) → root CA, checking signatures + revocation (CRL/OCSP)  C) Root → leaf only  D) Any order; order is irrelevant

---
---

## Answer Key — Sprint D1

1. **B** — a bollard physically deters/prevents vehicle access.
2. **C** — only a private-key signature ties an action to one identity (HMAC's key is shared → no non-repudiation).
3. **B** — PE/PA are control-plane; the PEP sits in the data plane enforcing the decision.
4. **B** — unsalted hashes enable rainbow-table/precomputation and reveal duplicate passwords. (Also: use a slow KDF.)
5. **B** — salt = per-hash, stored; pepper = secret, stored separately.
6. **C** — GCM is authenticated encryption (AEAD). ECB leaks patterns; CBC needs a separate MAC.
7. **B** — ephemeral DH gives forward secrecy.
8. **B** — the back-out plan restores service if the change breaks something.
9. **B** — unused decoy; any interaction is malicious by definition.
10. **B** — build the chain leaf→intermediate→trusted root and check validity + revocation.

**Score:** 9–10 mastery · 7–8 solid · ≤6 re-read D1 cryptographic solutions + zero trust.
