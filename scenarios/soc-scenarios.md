# SOC Shift Scenarios — "You are on shift, X happens. What do you do?"

Twenty-five operational, decision-style scenarios (5 per SY0-701 domain). Unlike the recall items in
[../practice-questions.md](../practice-questions.md) and the per-domain drills, these simulate **being
on a SOC shift**: each gives a situation and a worked **response** — the reasoning, actions, and order.
This is the higher-value format for SOC interview prep and exam PBQ-style thinking, because real work
is "what do I do next?", not "define this term".

> Grounded in the domain notes + the portfolio's own tooling. Re-read the matching domain file on any
> scenario you can't reason through cleanly: [D1](../domains/sy0-701-1-general-security-concepts.md) ·
> [D2](../domains/sy0-701-2-threats-vulnerabilities-mitigations.md) ·
> [D3](../domains/sy0-701-3-security-architecture.md) ·
> [D4](../domains/sy0-701-4-security-operations.md) ·
> [D5](../domains/sy0-701-5-program-management.md).

General shift principle used throughout: **validate → contain → investigate → escalate/close → tune.**
Don't act on an unvalidated alert; don't sit on a validated one.

---

## Domain 1 — General Security Concepts

**S1.** *A developer asks you to approve storing API keys in the application's source repo "just for
now".*
→ Push back: secrets in source are exposure (and end up in git history forever). Recommend a secrets
manager / vault, environment injection at runtime, and key rotation. Principle: least privilege +
don't trust "temporary". Offer to help wire up the vault rather than just saying no.

**S2.** *A user wants an exception to use SMS codes instead of the FIDO2 key "because it's faster".*
→ Explain the risk in plain terms: SMS/TOTP can be relayed by real-time phishing; the FIDO2 key is
phishing-resistant because it's bound to the site origin. If a genuine accessibility need exists,
find a compliant alternative — don't just grant the weaker factor. Document the decision.

**S3.** *Two services need to talk; a colleague suggests giving the service account Domain Admin "to
avoid permission issues".*
→ Refuse on least-privilege grounds — Domain Admin on a service account is a lateral-movement jackpot.
Scope the account to exactly the resources/permissions it needs; use a managed service account and
credential rotation.

**S4.** *You're asked whether a new internal tool needs encryption "in transit" if it's "only on the
internal network".*
→ Yes — Zero Trust assumes the internal network is hostile; an attacker who's already inside shouldn't
get plaintext. Require TLS internally too. "Internal" is not a security boundary.

**S5.** *An auditor asks you to prove who deleted a record and when.*
→ This is non-repudiation → point them at the accounting/audit logs (the "third A" of AAA) with
synchronised timestamps (NTP) tying the action to an authenticated identity. If logging wasn't
enabled, that's the finding.

---

## Domain 2 — Threats, Vulnerabilities & Mitigations

**S6.** *Finance reports an email from the "CEO" urgently requesting a payment to a new account.*
→ Treat as BEC/whaling. Do NOT act on the email. Verify out-of-band (known-good phone number, not
details in the email). Check headers/SPF-DKIM-DMARC alignment, search the mail gateway for similar
messages to other recipients, and alert finance to hold. Report it.

**S7.** *Threat intel says a CVE affecting your web stack was just added to the CISA KEV list.*
→ KEV = actively exploited → highest priority regardless of a moderate CVSS. Identify affected assets
(SBOM/inventory helps), prioritise internet-facing ones, patch or apply compensating controls now,
and monitor for exploitation indicators in the meantime.

**S8.** *A user plugged in a USB stick they "found in the car park".*
→ Treat as baiting (T1091/social engineering). Isolate the host from the network, image/scan it,
check for autorun execution and new processes/persistence, and reset any credentials used since. Then
a reminder on the found-media policy — non-punitive, so people keep reporting.

**S9.** *Scanning shows an EOL appliance that the vendor no longer patches, running a known-vulnerable
service.*
→ Can't remediate → compensating controls: segment/isolate it, restrict access to only what needs it,
monitor it closely, and raise a documented risk exception with an owner and a replacement plan. Don't
just leave it on the flat network.

**S10.** *Wi-Fi users report being repeatedly disconnected, then connecting to an AP with the same
SSID.*
→ Likely deauth/disassociation + evil twin. Locate the rogue AP (wireless survey), confirm 802.11w
(management-frame protection) and 802.1X/EAP-TLS are enforced, warn users not to ignore cert warnings,
and escalate the physical investigation. Map to wireless attack set.

---

## Domain 3 — Security Architecture

**S11.** *A team wants to expose a new internal app to the internet "quickly" for a demo.*
→ Don't put it on the internal segment with a port-forward. Place it in a screened subnet (DMZ),
behind a reverse proxy/WAF, with no inbound path to internal systems, TLS enforced, and a time-boxed
firewall rule that you remove after the demo (change-management with a backout).

**S12.** *Backups exist, but no one has tested a restore in a year.*
→ Untested backups are a hope, not a control. Schedule a restore test against the RTO/RPO; verify
integrity (hashes) and that at least one copy is offline/immutable (ransomware resilience). Document
the actual restore time vs the stated RTO.

**S13.** *A cloud engineer left an S3-equivalent bucket public to "make sharing easier".*
→ Customer-side misconfiguration = the top cloud breach cause (shared-responsibility model). Make it
private immediately, audit access logs for what was exposed/accessed, enable bucket-level public-access
blocks org-wide, and use signed URLs for legitimate sharing.

**S14.** *An OT/ICS engineer refuses a patch window "because the line can't stop".*
→ Respect that availability leads in OT. Don't force-patch. Compensate: segment the OT network from
IT, restrict and monitor access, and schedule patching for a planned maintenance window. Work with,
not against, the safety constraint.

**S15.** *A VM host shows one tenant's VM consuming resources and probing the hypervisor.*
→ Possible VM-escape attempt. Snapshot for evidence, isolate the suspect VM, check hypervisor patch
level, and review tenant isolation. Escalate — host compromise affects every VM on it.

---

## Domain 4 — Security Operations

**S16.** *Alert: 60 failed SSH logins then one success from an external IP on a server.*
→ Validate (is the IP/user expected? impossible travel? is the success real in `auth.log`?). If real:
contain — disable/reset the account, kill the session — then investigate what the session did, escalate
per runbook, and tune the brute-force rule. MITRE T1110. (This is watchtower scenario 2.)

**S17.** *EDR flags a process on a finance workstation making periodic outbound connections to an
unfamiliar domain.*
→ Possible C2 beaconing. Check DNS/proxy logs (the domain) + NetFlow (the pattern) + the process tree
(Sysmon). If malicious: isolate the host (preserve volatile evidence first), block the domain, hunt
for the same IOC elsewhere, then IR lifecycle. (watchtower scenario 8.)

**S18.** *You have 200 alerts from one rule today; every one investigated has been benign.*
→ False positives causing alert fatigue. Don't disable the rule (false-negative risk). Tune it: add
context (asset, time, user role), raise thresholds, allow-list verified-good — and measure the FP rate
before/after.

**S19.** *A Windows host logged Event 7045 (new service installed) overnight with a binary in a temp
directory.*
→ Suspicious — persistence/privesc signal. Validate it's not a legitimate install (change records),
inspect the binary (hash → threat intel/sandbox), check the parent process and what ran it, isolate if
malicious. MITRE T1543.003. (watchtower scenario 4.)

**S20.** *Mid-incident, you must decide what evidence to collect from a live, compromised host.*
→ Order of volatility: capture RAM first (it's lost on power-down), then running processes/network
state, then disk image — hashing each artefact for integrity before/after. Maintain a clear handling
record. Only then consider containment that changes state (e.g. powering down).

---

## Domain 5 — Program Management, Risk & Compliance

**S21.** *A vendor wants admin access to your environment to support their product.*
→ Third-party risk. Grant least-privilege, time-bounded, just-in-time access (not standing admin),
log/record the sessions, require it in a contract/DPA, and review on exit. Vendor access is a
supply-chain attack path.

**S22.** *You confirm a personal-data breach at 09:00 Monday.*
→ GDPR clock starts. Notify the supervisory authority within 72 hours; if high risk to individuals,
notify affected data subjects without undue delay. In parallel run the IR lifecycle and preserve
evidence. Loop in legal/DPO early — this is a reporting obligation, not just a technical incident.

**S23.** *Leadership asks whether a £40K/yr control is "worth it" for a given risk.*
→ Quantify: SLE = AV × EF, ALE = SLE × ARO. If the control costs more than the ALE it reduces, it's
not justified on ALE alone — unless it addresses multiple risks or a compliance/contractual mandate.
Present it in business-risk terms (£ loss avoided), not CVSS.

**S24.** *A new SaaS supplier can't produce a SOC 2 Type II report, only a Type I.*
→ Type I is design at a point in time; Type II proves controls *operated effectively over a period* —
the stronger assurance. Flag the gap as a risk, ask for a remediation timeline, and apply compensating
controls (data minimisation, monitoring) until they can evidence Type II.

**S25.** *The board asks "are we getting riskier?" before any incident has happened.*
→ Use a leading indicator — a KRI (e.g. rising unpatched-host count, growing overdue-access-reviews),
not a lagging KPI. Trend it over time and tie it to a risk appetite threshold so "riskier" has a
defined trigger for action.

---

*Practice by talking through your response out loud before reading the model answer — that's exactly
how a SOC interview and the exam's scenario questions are scored: the reasoning and the order, not a
single keyword.*
