# Practice Exam 03 — Scenario-Only (SY0-701)

40 questions, **every one scenario-based** — no recall items. Each presents a realistic situation
and asks for the MOST appropriate action/response/tool/policy. Harder than exam-01: distractors
are built from the misconceptions documented in the per-domain quick-reference cards and
`sy0-701-exam-tips.md`. Real exam timing: aim for 60 minutes on these 40, leaving margin.

Weighting matches the blueprint — D1 ×5 (12%), D2 ×9 (22%), D3 ×7 (18%), D4 ×11 (28%), D5 ×8 (20%).
Portfolio-referencing items (ironveil / nullbyte / spectre / oracle / mirage / gauntlet) are
marked ★ — 15 of them.

> Answer key, full explanation, and distractor analysis follow the questions. Don't scroll early.

---

## Questions

**Q1 (D1).** You are a security architect at a logistics firm rolling out Zero Trust. A subject
requests a resource; the request reaches a component that evaluates policy and decides allow/deny,
then a second component that actually enforces the verdict on the data-plane connection. Which pair
is correct?
- A. Policy Enforcement Point decides; Policy Decision Point enforces
- B. Policy Decision Point decides; Policy Enforcement Point enforces
- C. Policy Administrator decides; Policy Engine enforces
- D. Policy Engine decides; Policy Administrator enforces

**Q2 (D1) ★.** ironveil unlocks its LUKS2 volume with a Nitrokey 3A NFC enrolled touch-only (no
clientPin, firmware 1.8.3). A reviewer asks which security property the touch-only choice
specifically guarantees. Best answer?
- A. Confidentiality of the passphrase in transit
- B. Physical presence at every unlock — defeating remote/unattended key activation
- C. Non-repudiation of the unlock event
- D. Key escrow for recovery

**Q3 (D1).** A hospital wants signed electronic prescriptions such that a prescriber cannot later
deny issuing one, and any tampering is detectable. Which combination MOST directly delivers this?
- A. Symmetric encryption with a shared key
- B. Hashing alone
- C. A digital signature (private-key sign, public-key verify) over a hash of the document
- D. TLS for the transport channel

**Q4 (D1).** A change-advisory board approves adding a new internet-facing API. The firewall
allow-list is updated, the service deployed — and an unrelated overnight batch job breaks. What
change-management element was most likely skipped?
- A. Maintenance window
- B. Impact/dependency analysis
- C. Approval authority
- D. Version control

**Q5 (D1).** An organisation benchmarks its current controls against the NIST CSF to identify what
is missing before budgeting. This activity is best described as:
- A. A penetration test
- B. A gap analysis
- C. A business impact analysis
- D. An attestation

**Q6 (D2) ★.** mirage shows a correlational phishing filter that learned the token "URGENT" fails
when the attacker writes "time-sensitive". An analyst asks why a causal detector resists this. The
MOST accurate reason?
- A. Causal detectors use larger training corpora
- B. The causal driver (urgency) cannot be removed without defeating the attack, so paraphrase does not evade it
- C. Causal detectors run faster at inference
- D. Correlational detectors cannot process email headers

**Q7 (D2) ★.** A SOC sees: a signed vendor update installed routinely, then days later many of that
vendor's customers are compromised through it. (ironveil deliberately omits vendor cloud daemons —
Razer Synapse, iCUE — to shrink exactly this surface.) Which attack category is the breach above?
- A. Insider threat
- B. Supply-chain compromise
- C. Watering-hole attack
- D. Living-off-the-land

**Q8 (D2).** Staff receive a fluent, personalised email referencing a genuine internal project and
a real manager's name, asking for an urgent gift-card purchase. Which two factors make this
higher-risk than commodity phishing?
- A. Volume and randomness
- B. Personalisation (spear phishing) and authority pressure
- C. Poor grammar and generic greeting
- D. Attachment size and link count

**Q9 (D2).** An attacker tries `Summer2026!` and `Password1` against hundreds of usernames, once
each, to avoid lockout. Detection should key on:
- A. Many failures against one account (vertical brute-force)
- B. Few attempts across many accounts in a short window (password spraying)
- C. Repeated TLS renegotiation
- D. A single successful login

**Q10 (D2) ★.** spectre's primary finding was an Apache host returning a full directory listing at
the web root. Which CWE is this, and why does it matter beyond the listing itself?
- A. CWE-89 — it enables SQL injection directly
- B. CWE-548 — it exposes any future file (backups, source, credentials) to anonymous enumeration
- C. CWE-79 — it allows stored XSS
- D. CWE-200 only — it is purely a version-disclosure issue

**Q11 (D2) ★.** A workstation runs malware that never writes an executable to disk — it operates via
PowerShell and WMI in memory. Signature AV misses it. gauntlet's defender-perspective writeups pair
each attack with detection signals; which evasion technique and best detection apply here?
- A. Polymorphism; signature updates
- B. Fileless / living-off-the-land; behaviour-based EDR and script-block logging
- C. Packing; static analysis
- D. Rootkit; firmware re-flash

**Q12 (D2).** An access point broadcasts the corporate SSID with a stronger signal so nearby
clients associate to it, letting the attacker intercept traffic. This is:
- A. Bluejacking
- B. An evil twin / rogue AP
- C. A disassociation flood only
- D. WPS brute-force

**Q13 (D5).** A risk owner must formally treat an essential device that cannot be patched (vendor
defunct, firmware end-of-life). Which risk-treatment decision is MOST appropriate?
- A. Accept the risk silently
- B. Isolate/segment the device, restrict its network reach, and monitor it closely
- C. Expose it to the internet behind a single firewall rule
- D. Reinstall the OS

**Q14 (D2).** Two findings: XSS and CSRF. Which statement correctly distinguishes whose trust each
abuses?
- A. XSS abuses the server's trust in the user; CSRF abuses the user's browser trust in the site
- B. XSS abuses the site's trust the browser places in returned content; CSRF abuses the site's trust in the user's authenticated browser
- C. Both abuse DNS resolution
- D. They are the same attack with different names

**Q15 (D2).** A threat-intel feed arrives as machine-readable objects over a defined transport
protocol. Which pairing is correct?
- A. STIX is the transport; TAXII is the data format
- B. STIX is the data format; TAXII is the transport/exchange protocol
- C. Both are encryption standards
- D. Both are SIEM products

**Q16 (D3) ★.** nullbyte isolates nine user profiles so a compromise in one cannot reach another.
A candidate is asked which architecture principle this implements and what it limits. Best answer?
- A. Defence in depth; it limits patch frequency
- B. Compartmentalisation / blast-radius containment; it limits how far one compromise propagates
- C. Single sign-on; it limits password reuse
- D. High availability; it limits downtime

**Q17 (D3).** A business states: "we can lose at most one hour of data, and we must be operational
again within four hours." Which metrics are being specified, in order?
- A. MTBF = 1h, MTTR = 4h
- B. RPO = 1h, RTO = 4h
- C. RTO = 1h, RPO = 4h
- D. SLA = 1h, MTTD = 4h

**Q18 (D3).** A team wants identical, auditable, repeatable cloud deployments and is fighting
configuration drift between environments. The MOST appropriate approach is:
- A. Manually document each deployment in a wiki
- B. Infrastructure as Code with version-controlled templates and drift detection
- C. Give every engineer admin to fix drift as they find it
- D. Snapshot the VMs nightly

**Q19 (D5).** You are drafting the responsibility matrix in a cloud vendor contract. Under the
shared-responsibility model, which obligation does the customer ALWAYS retain — and must therefore
be written as the customer's duty — regardless of IaaS/PaaS/SaaS?
- A. Physical datacentre security
- B. Hypervisor patching
- C. Their own data classification and access management
- D. The provider's network backbone

**Q20 (D3).** A design needs a public web server reachable from the internet while the database
stays unreachable from outside. The correct architecture is:
- A. Put both on the public subnet
- B. Web server in a screened subnet (DMZ); database on an internal segment with no inbound internet path
- C. Both internal, exposed via port-forwarding
- D. Database in the DMZ, web server internal

**Q21 (D3).** Microservices replace a monolith. Which security statement is correct?
- A. Microservices are inherently more secure because they are smaller
- B. The internal (east-west) attack surface grows; secure service-to-service comms (mTLS / API gateway) and per-service least privilege become essential
- C. Microservices remove the need for authentication between components
- D. Microservices eliminate supply-chain risk

**Q22 (D3) ★.** ironveil's DNS path is application → systemd-resolved (127.0.0.1) → AdGuard Home →
WireGuard → upstream. A reviewer asks what an on-path observer on the external interface can see.
Best answer?
- A. Plaintext DNS queries and the host IP
- B. Only WireGuard-encrypted traffic — no plaintext queries, never the host's real query content
- C. The full browsing history in cleartext
- D. The AdGuard blocklists in use

**Q23 (D3).** An OT/ICS plant network is being secured. Which priority ordering reflects OT
correctly (versus IT)?
- A. Confidentiality first, then integrity, then availability
- B. Availability and safety first; patching windows are rare and disruptive
- C. Identical priorities to corporate IT
- D. Confidentiality only; availability is irrelevant

**Q24 (D4) ★.** gauntlet documents Blue (EternalBlue/MS17-010). As a SOC analyst building a
detection for this from the writeup, which data source and signal are MOST relevant?
- A. DNS logs for domain generation algorithms
- B. SMB traffic / Windows security logs for anomalous SMBv1 use and the MS17-010 exploitation pattern
- C. Email gateway logs for attachments
- D. Web proxy logs for directory listings

**Q25 (D4).** A SOC sees a user log in from London, then from Tokyo eleven minutes later. The
single MOST useful term and response?
- A. A false positive; ignore it
- B. Impossible-travel indicator; trigger conditional-access challenge / session review
- C. Brute-force; lock the account permanently
- D. Data exfiltration; wipe the endpoint

**Q26 (D4) ★.** An organisation hardens email against spoofing — the same phishing channel mirage
modelled across 88,647 emails. Which sequence correctly describes the SPF/DKIM/DMARC relationship?
- A. DMARC works without SPF or DKIM
- B. SPF authorises sending hosts, DKIM signs the message, DMARC sets policy and alignment using SPF/DKIM results
- C. DKIM authorises sending IPs; SPF signs the body
- D. DMARC encrypts the message in transit

**Q27 (D4) ★.** During incident response, you have contained a compromised host and now need to
preserve evidence for possible legal action. spectre applied a SHA-256 hash to all 24 artefacts for
exactly this reason. The MOST important discipline is:
- A. Reboot to clear the malware
- B. Maintain chain of custody — document who handled what, when, with hashes, in order of volatility
- C. Delete the malicious files immediately
- D. Email the disk image to the legal team

**Q28 (D4).** Order the NIST SP 800-61 incident-response phases correctly.
- A. Detection → Preparation → Containment → Eradication → Recovery → Lessons learned
- B. Preparation → Detection & Analysis → Containment, Eradication & Recovery → Post-incident activity
- C. Containment → Detection → Recovery → Preparation
- D. Preparation → Recovery → Detection → Lessons learned

**Q29 (D4) ★.** spectre halted LinPEAS enumeration before the API-key-harvesting phase even though
deeper access was possible. From a SOC/governance view, what does this demonstrate?
- A. A technical failure of the tool
- B. Scope discipline / rules-of-engagement adherence — staying inside authorised boundaries
- C. Insufficient privileges
- D. A misconfiguration of LinPEAS

**Q30 (D4).** A SOAR playbook is proposed to auto-isolate any host that triggers a single EDR alert.
What is the primary risk, and the mitigation?
- A. No risk; automate everything
- B. False positives causing mass disruption; gate auto-isolation behind higher-confidence/correlated triggers and a human checkpoint for broad actions
- C. SOAR cannot isolate hosts
- D. It will slow the SOC down

**Q31 (D4) ★.** An analyst must choose a log source to investigate suspected data exfiltration over
DNS tunnelling. (ironveil's AdGuard Home on loopback is the equivalent chokepoint where such queries
would be visible and filterable.) The MOST relevant source is:
- A. Physical badge logs
- B. DNS query logs (high volume of unusual TXT/long subdomain queries to one domain)
- C. Patch-management reports
- D. HR records

**Q32 (D4) ★.** nullbyte's Façade profile holds the only copy of the IRONVEIL Termux unlock key,
inaccessible from other profiles. A SOC lead asks which IAM principle this enforces. Best answer?
- A. Single sign-on
- B. Least privilege + separation of duties via compartmentalisation — the key exists only where needed
- C. Federation
- D. Privilege creep

**Q33 (D5).** A decommissioned server held regulated data. Which disposal step is MOST defensible
for data-governance and audit purposes?
- A. Delete the files and reformat
- B. Cryptographic erase or physical destruction, with a certificate of sanitisation/destruction recorded
- C. Move it to a storeroom
- D. Donate it as-is

**Q34 (D4).** A workstation must run software that triggers a single AV heuristic but is known-good.
The correct operational action is:
- A. Disable AV on all endpoints
- B. Add a tuned, documented exception for that specific software (allow-list), keeping AV active
- C. Ignore all future alerts from that host
- D. Reimage the workstation daily

**Q35 (D4).** A BYOD fleet must enforce encryption and allow remote action if a phone is lost,
without giving the company the right to wipe personal photos. The MOST appropriate control is:
- A. Full-device MDM with full remote wipe
- B. Containerisation with selective (container-only) wipe via MDM
- C. No MDM; trust the user
- D. Network segmentation only

**Q36 (D5).** A risk assessment values an asset at £200,000, estimates a single loss would destroy
25% of it, and expects one such event every four years. The ALE is:
- A. £50,000
- B. £12,500
- C. £200,000
- D. £25,000

**Q37 (D5).** A processor handling EU residents' personal data on behalf of a controller suffers a
breach. Under GDPR-style obligations, the processor's first duty is to:
- A. Notify the public immediately
- B. Notify the controller without undue delay
- C. Delete all logs
- D. Nothing — only the controller has duties

**Q38 (D5) ★.** mirage processed 88,647 real phishing emails but synthesised the vishing dataset
via a CVAE to avoid handling real voice data. Which program-level principle does the CVAE choice
demonstrate?
- A. Security through obscurity
- B. Privacy by design / data minimisation
- C. Separation of duties
- D. Defence in depth

**Q39 (D5).** A vendor will process your customer data. Which artifact MOST directly governs the
security expectations and right to audit?
- A. A marketing brochure
- B. A contract with security clauses / SLA plus a right-to-audit and data-handling terms
- C. An email thanking them
- D. The vendor's public website

**Q40 (D5) ★.** oracle argues that in a cleared environment an auditable from-scratch model
(TerraCNN, 93.97%) can beat a more accurate third-party one (ResNet-18, 99.11%). Which governance
concept does this trade-off illustrate?
- A. Accept-the-risk by default
- B. Supply-chain risk and provenance/auditability as security properties that can outweigh raw performance
- C. Quantitative risk assessment formulas
- D. Separation of duties

---

## Answer key, explanations, and distractor analysis

**Q1 — B.** PDP decides (Policy Decision Point = Policy Engine + Policy Administrator), PEP
enforces. *Distractors:* A inverts the two — the classic trap; C/D split the PDP's sub-components
but assign the wrong roles.

**Q2 — B ★.** Touch-only enrollment forces physical presence at every unlock; a remotely
activatable key would defeat that. *A* confuses it with transport confidentiality; *C* non-repudiation
is a signature property; *D* nothing here provides escrow (the offline passphrase is fallback, not
escrow). Ref: ironveil nitrokey.md.

**Q3 — C.** Digital signature over a document hash = integrity + non-repudiation + authenticity.
*B* hashing alone gives integrity but no identity binding; *A* symmetric keys can't prove who
signed (both parties hold the key); *D* TLS protects transit, not the document at rest.

**Q4 — B.** Impact/dependency analysis would have caught the batch-job dependency. *A/C/D* are real
change elements but wouldn't surface a downstream break.

**Q5 — B.** Comparing current state to a framework to find missing controls = gap analysis. *A*
tests exploitability; *C* BIA measures impact of loss; *D* attestation is a compliance statement.

**Q6 — B ★.** The robustness argument: surface tokens are attacker-controlled; the causal driver
is not removable without defeating the attack. *A/C* are irrelevant properties; *D* is false. Ref:
mirage.

**Q7 — B.** Trusted, signed update as the delivery vehicle = supply-chain compromise. *C*
watering-hole compromises a site the target visits; *D* LOTL uses built-in tools post-access.

**Q8 — B.** Personalisation = spear phishing; the manager reference = authority. *C* describes the
opposite (commodity) cues; *A/D* are not the risk drivers.

**Q9 — B.** Few attempts spread across many accounts = password spraying (lockout-evasion). *A* is
vertical brute-force (the inverse pattern); detection must look horizontally.

**Q10 — B ★.** CWE-548, directory listing — its real danger is exposing *future* sensitive files
to anonymous enumeration and seeding recon. *A* overclaims a direct SQLi link (the exam-tip
correction: it is a recon multiplier, not a direct enabler); *C* wrong class; *D* understates it.
Ref: spectre.

**Q11 — B.** Fileless/LOTL; detect with behaviour-based EDR + PowerShell script-block logging.
*A/C* are signature-era answers that this technique specifically defeats; *D* over-escalates.

**Q12 — B.** Evil twin / rogue AP. *A* bluejacking is unsolicited Bluetooth messaging; *C* is only
part of a forced-deauth setup; *D* targets WPS PINs.

**Q13 — B (D5).** Mitigate via compensating controls (isolate, restrict reach, monitor) and a
documented, signed-off residual-risk acceptance — the governed risk-treatment path. *A* silent
acceptance is ungoverned; *C* increases exposure; *D* doesn't help EOL firmware.

**Q14 — B.** XSS abuses the trust the *browser* places in content the site returns; CSRF abuses the
trust the *site* places in the user's authenticated browser. *A* is a common half-right inversion.

**Q15 — B.** STIX = structured data format; TAXII = transport/exchange. *A* inverts them — the
trap.

**Q16 — B ★.** Compartmentalisation limits blast radius. *A/C/D* name unrelated principles. Ref:
nullbyte operational-profiles.md.

**Q17 — B.** RPO = tolerable data loss (1h); RTO = tolerable downtime (4h). *C* inverts them — the
classic trap; *A* MTBF/MTTR are reliability metrics, not targets.

**Q18 — B.** IaC with version control + drift detection. *A* manual docs don't prevent drift; *C*
worsens it; *D* snapshots capture state but don't define/enforce it.

**Q19 — C (D5).** Data classification and IAM remain the customer's across all service models, so
the contract must assign them to the customer. *A/B/D* shift to the provider as you move IaaS→SaaS.

**Q20 — B.** Web in DMZ/screened subnet, DB internal with no inbound internet. *A/C* expose the DB;
*D* inverts the tiers.

**Q21 — B.** East-west surface grows; mTLS/API gateway + per-service least privilege required. *A/C/D*
are the over-optimistic microservice myths.

**Q22 — B ★.** Only WireGuard-encrypted traffic is visible externally; DNS is filtered on loopback
before egress. *A/C* describe the unprotected case; *D* isn't externally visible. Ref: ironveil
network-stack.md.

**Q23 — B.** OT prioritises availability/safety; patch windows are rare. *A/C* apply IT priorities;
*D* overstates.

**Q24 — B ★.** SMB traffic + Windows security logs for SMBv1/MS17-010. *A/C/D* are the wrong
telemetry for an SMB exploit. Ref: gauntlet thm-blue.

**Q25 — B.** Impossible travel → conditional-access challenge / review. *A* dismisses a real
signal; *C/D* over-react before triage.

**Q26 — B.** SPF (hosts) + DKIM (signature) + DMARC (policy + alignment over both). *A/C/D* break
the dependency or invert SPF/DKIM roles — the heavily tested trap.

**Q27 — B.** Chain of custody, order of volatility, hashes. *A* reboot destroys volatile evidence;
*C* destroys evidence; *D* breaks custody.

**Q28 — B.** Preparation → Detection & Analysis → Containment/Eradication/Recovery → Post-incident.
Others scramble the order.

**Q29 — B ★.** Scope discipline / ROE adherence. *A/C/D* misread a deliberate ethical stop as a
fault. Ref: spectre exploitation.md / README §3.3.

**Q30 — B.** False-positive mass disruption is the risk; gate broad auto-actions behind
higher-confidence triggers + human checkpoint. *A* is reckless; *C* false; *D* misses the point.

**Q31 — B.** DNS query logs (long/odd subdomains, TXT volume to one domain). *A/C/D* are unrelated
sources.

**Q32 — B ★.** Least privilege + separation via compartmentalisation — key only where needed. *A/C*
are federation/SSO concepts; *D* is the opposite. Ref: nullbyte.

**Q33 — B (D5).** Crypto-erase or destruction + a recorded certificate of sanitisation/destruction
is the audit-defensible governance step. *A* reformatting is recoverable; *C/D* leave regulated data
exposed.

**Q34 — B.** Tuned, documented allow-list exception, AV still active. *A/B/C/D* — only B preserves
protection while resolving the false positive.

**Q35 — B.** Containerisation + selective wipe respects personal data on BYOD. *A* full wipe
violates the personal-data constraint; *C* abandons control; *D* doesn't address device encryption.

**Q36 — B.** SLE = £200,000 × 0.25 = £50,000; ARO = 0.25/yr; ALE = SLE × ARO = £12,500. *A* stops at
SLE (the trap); *C/D* misapply the factors.

**Q37 — B.** The processor notifies the controller without undue delay. *A* is the controller's
regulator/data-subject duty; *C/D* are wrong.

**Q38 — B ★.** Privacy by design / data minimisation — synthesise rather than process real voice
data. *A* is unrelated; *C/D* name other principles. Ref: mirage.

**Q39 — B.** Contract with security clauses, SLA, right-to-audit. *A/C/D* have no contractual force.

**Q40 — B ★.** Supply-chain/provenance and auditability as security properties that can outweigh
accuracy. *A* mischaracterises a deliberate trade-off; *C/D* are unrelated. Ref: oracle (figures:
TerraCNN 93.97% from scratch vs ResNet-18 99.11% pretrained — never swap).

---

## Domain score sheet

Distribution matches the SY0-701 blueprint weighting (40 questions). Three items (Q13, Q19, Q33)
are genuinely cross-domain and are scored under Domain 5 — risk treatment, vendor-responsibility
allocation, and disposal governance respectively.

| Domain | Weight | Questions | Count | Your correct | Target (pass ≈ 83%) |
|--------|--------|-----------|-------|--------------|---------------------|
| D1 | 12% | Q1–Q5 | 5 | /5 | 4 |
| D2 | 22% | Q6–Q12, Q14, Q15 | 9 | /9 | 7 |
| D3 | 18% | Q16–Q18, Q20–Q23 | 7 | /7 | 6 |
| D4 | 28% | Q24–Q32, Q34, Q35 | 11 | /11 | 9 |
| D5 | 20% | Q13, Q19, Q33, Q36–Q40 | 8 | /8 | 7 |
| **Total** | **100%** | **Q1–Q40** | **40** | **/40** | **≈33 (83%)** |

> Track every miss in `error-log.md` by domain + trap type. A wrong answer on a ★ portfolio item
> means re-reading that repo's page, not just the note.
