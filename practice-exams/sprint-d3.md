# Sprint Exam — Domain 3: Security Architecture (18%)

10 hard D3 items: enterprise infrastructure, secure design, data protection, and resilience.
Single best answer; key below the divider.

**Q1.** Which device fails in a way that *blocks* traffic when it dies, and which *passes* it?
A) Both always fail open  B) Fail-closed = blocks (secure); fail-open = passes (available) — choice depends on the asset  C) Both fail closed  D) Firewalls always fail open

**Q2.** An inline device that can drop malicious packets in real time is a(n):
A) IDS  B) IPS  C) SPAN port  D) TAP

**Q3.** Best placement for a WAF?
A) On the database  B) In front of the web application (reverse-proxy)  C) On the client  D) On the domain controller

**Q4.** Tokenisation differs from encryption because:
A) It is reversible with a key  B) It replaces data with a non-mathematical surrogate; the mapping lives in a secure vault  C) It is faster encryption  D) It hashes the data

**Q5.** Which BEST protects data *in use*?
A) TLS  B) Full-disk encryption  C) Confidential computing / secure enclaves (TEE)  D) Hashing

**Q6.** A microservices app needs east-west traffic encrypted and authenticated between services. BEST fit?
A) A perimeter firewall  B) A service mesh with mTLS  C) A VPN concentrator  D) A WAF

**Q7.** RAID 5 vs RAID 1 — RAID 5 primarily provides:
A) No redundancy  B) Striping with distributed parity (capacity + single-disk fault tolerance)  C) Mirroring only  D) Encryption

**Q8.** A "high availability" cluster across two AZs primarily addresses which CIA pillar and which metric?
A) Confidentiality / ALE  B) Availability / RTO  C) Integrity / RPO  D) Availability / MTBF

**Q9.** An embedded/ICS device cannot be patched. The BEST compensating control is:
A) Ignore it  B) Network segmentation/isolation + monitoring  C) Stronger passwords only  D) Reinstall the OS

**Q10.** Which deployment keeps the *key* under customer control while using a cloud KMS?
A) Provider-managed keys  B) BYOK / customer-managed keys (CMK), ideally HSM-backed  C) No encryption  D) Plaintext with ACLs

---
---

## Answer Key — Sprint D3

1. **B** — fail-closed favours security, fail-open favours availability; the right choice is asset-dependent.
2. **B** — an IPS is inline and can drop; an IDS only detects (out-of-band via SPAN/TAP).
3. **B** — a WAF sits as a reverse proxy in front of the app.
4. **B** — tokenisation swaps in a surrogate with a vault mapping (shrinks PCI scope).
5. **C** — data-in-use protection needs enclaves/confidential computing.
6. **B** — service mesh + mTLS secures service-to-service traffic.
7. **B** — RAID 5 = striping + distributed parity, tolerates one disk loss.
8. **B** — HA targets availability; RTO is the recovery-time metric.
9. **B** — isolate and monitor what you cannot patch.
10. **B** — BYOK/CMK keeps key custody with the customer.

**Score:** 9–10 mastery · 7–8 solid · ≤6 re-read D3 appliances/placement + data protection + resilience.
