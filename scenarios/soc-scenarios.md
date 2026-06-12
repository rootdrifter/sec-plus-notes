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

---

# Expansion — Scenarios 26–50 (2026-06-12)

Twenty-five further shift scenarios, again 5 per domain, in the fuller format:
**situation → response → why → ATT&CK → portfolio link.** Deduplicated against S1–S25 and the
per-domain drills. ATT&CK IDs are top technique + sub-technique where the sub-technique is specific.

## Domain 1 — General Security Concepts

**S26.** *A change ticket to open a new inbound firewall port is marked "emergency — skip CAB".*
→ Emergency changes are allowed, but still require a documented justification, a named approver, a
backout plan, and *retrospective* CAB review. Implement, then file the record same-day; don't let
"emergency" become a standing bypass. **Why:** change management exists to prevent unreviewed attack
surface; the audit trail is the control. **ATT&CK:** prevents unmanaged exposure (defensive — no
single technique). **Portfolio:** ironveil/nullbyte are documented, reproducible builds — change is
captured in git, the same discipline at home scale.

**S27.** *Marketing wants to deploy a chatbot that will hold customer chat transcripts.*
→ Apply privacy-by-design before launch: data minimisation (don't store what you don't need),
classification, retention limits, and a lawful basis. Treat transcripts as potential PII.
**Why:** building privacy in up front is cheaper and is a GDPR expectation; bolt-on fails audits.
**ATT&CK:** reduces collectable data if breached (T1530 data-from-cloud impact lowered).
**Portfolio:** mirage deliberately synthesised data (CVAE) to avoid processing real PII — privacy by
design as a methodology choice.

**S28.** *A team proposes a single shared admin login for an app "so everyone can manage it".*
→ Refuse: shared accounts destroy accountability and non-repudiation. Issue individual accounts with
RBAC, and use PAM/check-out for the privileged role. **Why:** you must be able to attribute every
action to a person (the third A — accounting). **ATT&CK:** removes a valid-accounts blind spot
(T1078). **Portfolio:** nullbyte's nine *separate* profiles embody per-identity compartmentalisation.

**S29.** *A vendor's TLS cert for an integration expired overnight; an engineer wants to disable cert
validation "to restore service fast".*
→ Don't disable validation — that opens MITM. Renew/replace the cert (or pin a temporary valid one),
and add expiry monitoring so it never surprises you again. **Why:** turning off validation trades an
outage for a confidentiality/integrity hole. **ATT&CK:** prevents adversary-in-the-middle (T1557).
**Portfolio:** the rootdrifter.io deploy uses Let's Encrypt with automated renewal + a renewal
dry-run — expiry handled by process, not panic.

**S30.** *An exec asks you to grant a contractor "the same access as a full employee for convenience".*
→ Scope to the contractor's actual task, time-box it to the engagement, and schedule a deprovision
date. Convenience is not a access-control criterion. **Why:** least privilege + joiner/mover/leaver
hygiene; orphaned contractor access is a classic breach path. **ATT&CK:** closes valid-accounts
persistence (T1078). **Portfolio:** ties to D5 third-party-access discipline (S21) — same principle,
identity side.

## Domain 2 — Threats, Vulnerabilities & Mitigations

**S31.** *A signed, legitimate process on an endpoint is spawning PowerShell with an encoded command.*
→ Treat as fileless/memory injection or living-off-the-land. Capture the process tree + the decoded
command, isolate the host (preserve RAM first), hunt the same parent-child pattern fleet-wide.
**Why:** signature AV trusts the signed host process — behaviour, not signature, is the tell.
**ATT&CK:** T1059.001 (PowerShell), T1055 (process injection). **Portfolio:** maps to gauntlet's
post-exploitation notes and watchtower's planned T1055 detection scenario.

**S32.** *DNS logs show one host resolving long random-looking subdomains under a single parent
domain, steadily, all day.*
→ Likely DNS tunnelling / exfil or beaconing. Correlate with NetFlow volume, block the parent domain,
inspect the host, and quantify what may have left. **Why:** high-entropy, high-frequency subdomain
queries are an exfil signature; DNS is often unmonitored. **ATT&CK:** T1071.004 (DNS C2), T1048
(exfil over alternative protocol). **Portfolio:** ironveil's AdGuard query log is exactly where
you'd spot this at host scale; watchtower would alert on it.

**S33.** *A developer pulled an npm package that was updated yesterday and now their build calls out to
an unknown host.*
→ Suspected supply-chain/dependency compromise. Pin/rollback the version, isolate the build agent,
diff the package, check for credential theft in CI, and report upstream. **Why:** trusted update
channels are a top-tier vector (the "trusted relationship" problem). **ATT&CK:** T1195.002
(compromise software supply chain). **Portfolio:** D2 §2.3 supply-chain catalogue; spectre's
SBOM-style asset reasoning.

**S34.** *Several users received an SMS with a shortened link "from the bank" urging immediate login.*
→ Smishing. Tell users not to click, report the number, check whether the link domain is typosquatted,
and warn via a known-good channel. If anyone entered credentials → reset + watch those accounts.
**Why:** mobile out-of-band channels bypass email gateways; urgency is the manipulation lever.
**ATT&CK:** T1660 (phishing — mobile), T1656 (impersonation). **Portfolio:** mirage's research on
urgency/authority causal triggers explains *why* the lure works — informs the training response.

**S35.** *A pentest report flags that your login page reveals "user not found" vs "wrong password".*
→ Username enumeration. Return a single generic failure message, add rate-limiting/lockout, and log
the attempts. **Why:** distinct error messages let an attacker build a valid-user list for spraying.
**ATT&CK:** T1589.001 (gather victim identity), feeding T1110.003 (password spraying). **Portfolio:**
spectre's grey-box methodology checks exactly this kind of information disclosure (CWE-200 family).

## Domain 3 — Security Architecture

**S36.** *A microservice needs a database password; a dev hardcodes it in the container image.*
→ Secrets never belong in images (anyone who pulls the image gets them). Inject via a secrets manager
at runtime, rotate the exposed credential immediately, and scan the registry for other embedded
secrets. **Why:** images are distributed artefacts; an embedded secret is a permanent leak.
**ATT&CK:** T1552.001 (credentials in files), T1610 (deploy container). **Portfolio:** D3 container
security block; nullbyte's "secrets never in env/plain" posture.

**S37.** *Architecture review: a new app puts the database in the same subnet as the public web tier.*
→ Segment it: web tier in the screened subnet, database in a private tier with no inbound internet
path, traffic only via the app tier (defence in depth + microsegmentation). **Why:** flat networks
let one web compromise reach the crown jewels directly (east-west). **ATT&CK:** limits T1210 (exploit
remote services) lateral movement. **Portfolio:** spectre's isolated lab subnet models segmented
test architecture.

**S38.** *A SaaS contract review: who is responsible for patching the underlying OS and the app data?*
→ Apply the shared-responsibility model: for SaaS the provider patches the stack; the customer owns
*data, access, and configuration*. Verify it in the contract, and own your side (IAM, DLP, config).
**Why:** most cloud breaches are the *customer's* config side, not the provider's. **ATT&CK:** prevents
T1530 (data from cloud) via correct config ownership. **Portfolio:** ties to the D3 shared-responsibility
table — guaranteed exam marks.

**S39.** *DR plan lists a hot site, but the runbook has never been exercised and key staff have changed.*
→ Schedule a failover test (or at least a tabletop), update contact trees and runbooks, and validate
the RTO/RPO are still met with current staff/systems. **Why:** an untested DR plan is a document, not
a capability; people and dependencies drift. **ATT&CK:** resilience against T1486 (data encrypted for
impact / ransomware). **Portfolio:** rootdrifter.io has daily backups + a tested restore path — the
small-scale version of this discipline.

**S40.** *A team wants to allow inbound RDP from "anywhere" temporarily for a remote vendor.*
→ Never expose RDP to the internet. Put it behind a VPN or a jump server with MFA, restrict source IPs,
time-box it, and log the session. **Why:** exposed RDP is among the most-exploited initial-access
vectors (ransomware loves it). **ATT&CK:** T1133 (external remote services), T1021.001 (RDP).
**Portfolio:** ironveil's dracut-sshd remote unlock is reachable only via key-based SSH, never an
open management port — the correct pattern.

## Domain 4 — Security Operations

**S41.** *SIEM shows a privileged account active at 03:00 from a country no employee is in, while the
same account also has a 09:00 login from the office.*
→ Impossible-travel / anomalous privileged use. Disable the account, kill sessions, force re-auth,
and investigate what the off-hours session touched. **Why:** concurrent geographically-impossible
logins indicate credential compromise; privileged makes it urgent. **ATT&CK:** T1078.004 (cloud/valid
accounts), detected via UEBA. **Portfolio:** watchtower's planned conditional-access/UEBA scenario;
D4 §2 conditional access.

**S42.** *An analyst wants to "close" a noisy true-positive malware alert because EDR already
quarantined the file.*
→ Quarantine is containment, not closure. Confirm scope (other hosts/same hash), root cause (how it
arrived), persistence removal, and credential exposure — *then* close with notes. **Why:** closing on
"AV caught it" misses the delivery vector and lateral spread. **ATT&CK:** validate against T1204
(user execution) entry + T1547 persistence. **Portfolio:** gauntlet's detection notes ("what log does
this generate?") feed exactly this closure rigor.

**S43.** *You need to prove an alert's binary is malicious without tipping off the attacker.*
→ Hash it and check threat intel / detonate a copy in an isolated sandbox — never run it in place or
on the live host, and don't connect the sandbox to production. **Why:** static+dynamic analysis on a
copy preserves the live evidence and avoids tipping C2. **ATT&CK:** analysis supports identifying
T1027 (obfuscated/packed files). **Portfolio:** watchtower's T1027 detection scenario; D4 §4 sandbox.

**S44.** *Logs from a critical server stopped arriving at the SIEM two days ago and nobody noticed.*
→ Treat log-source silence as an incident (could be a crash or deliberate defence evasion). Restore
the pipeline, back-fill if possible, and add a "log source went quiet" heartbeat alert. **Why:**
attackers stop/clear logging to hide; a silent source is a blind spot either way. **ATT&CK:** T1562.001
(impair defences — disable logging), T1070 (indicator removal). **Portfolio:** watchtower's T1562
scenario; this is *the* SOC monitoring-of-the-monitoring lesson.

**S45.** *A new detection rule is proposed; how do you avoid it drowning the SOC?*
→ Test it against historical data first (retro-hunt) to estimate FP rate, scope it (asset/user/time),
add severity, and trial in alert-only mode before it pages anyone. Measure precision before promoting.
**Why:** unvalidated rules cause alert fatigue (the real-world cost of every "just add a rule").
**ATT&CK:** detection-engineering discipline across techniques. **Portfolio:** watchtower's MTTD
tracker + Wazuh rule templates operationalise exactly this validate-before-promote loop.

## Domain 5 — Program Management, Risk & Compliance

**S46.** *A business unit wants to accept the risk of running an unsupported app for another year.*
→ Risk acceptance must be *formal*: documented, quantified (ALE), signed by the risk owner with
authority, time-bounded, and revisited. Pair it with compensating controls. **Why:** informal "we'll
accept it" leaves no accountability and no review trigger. **ATT&CK:** compensating monitoring lowers
exploit likelihood (e.g. T1190). **Portfolio:** D5 §1 risk treatment; mirrors exam-04 Q25
exception-vs-compensating-control.

**S47.** *Audit finds access reviews haven't run in 18 months; many leavers still have accounts.*
→ Immediate: disable confirmed-leaver accounts. Systemic: reinstate periodic access recertification,
tie deprovisioning to HR offboarding, and report the KRI trend to leadership. **Why:** orphaned
accounts are standing attack surface and a compliance finding. **ATT&CK:** removes T1078 (valid
accounts) footholds. **Portfolio:** D4 §2 account lifecycle; D5 §8 KRI reporting.

**S48.** *A processor (sub-vendor) of your cloud provider will store EU customer data in a third
country.*
→ Data-sovereignty/transfer issue. Confirm a lawful transfer mechanism (SCCs/adequacy), update the
DPA and records of processing, and assess sub-processor risk. **Why:** GDPR restricts transfers
outside the EEA; the controller stays accountable for the processor chain. **ATT&CK:** governance,
not a technique. **Portfolio:** D5 §3/§4 regulations + data roles (controller/processor).

**S49.** *Leadership asks for one number that shows whether the security programme is improving.*
→ No single number suffices — present a small KRI/KPI set with trends against risk appetite (e.g.
mean time to detect, % critical patches within SLA, overdue access reviews). **Why:** a single metric
is gameable and hides trade-offs; trends tied to thresholds drive decisions. **ATT&CK:** MTTD ties to
overall detection coverage. **Portfolio:** watchtower's MTTD tracker is a concrete contribution to
this dashboard.

**S50.** *An incident is contained; the board wants a post-incident report.*
→ Deliver a lessons-learned: timeline, root cause, what worked/failed, and concrete control/process
changes with owners and dates — blameless, focused on systemic fixes. Feed it back into the IR plan.
**Why:** the "lessons learned" phase (NIST 800-61) is where detection improves; skipping it repeats
the incident. **ATT&CK:** closes the gaps that allowed the original chain. **Portfolio:** gauntlet's
offensive→detection mapping is the raw material for "how would we catch this next time".

---

*Fifty scenarios total. The format deliberately escalates: S1–S25 build the validate→contain→tune
reflex; S26–S50 add the ATT&CK technique and the portfolio evidence so each answer is interview-ready,
not just exam-ready.*
