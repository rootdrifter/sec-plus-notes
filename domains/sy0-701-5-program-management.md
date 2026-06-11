# SY0-701 Domain 5 — Security Program Management & Oversight (20%)

Maps to classic notes in [5.0-risk-management.md](5.0-risk-management.md) with expanded
governance, compliance, and third-party coverage.

---

## 1. Risk management (deep)

### Risk fundamentals

**Risk = likelihood × impact** (of a threat exploiting a vulnerability against an asset)

**Risk treatment options:**
- **Mitigate / reduce:** apply controls to lower likelihood or impact.
- **Transfer / share:** insurance, outsourcing, contracts. Transfers financial consequences, not liability.
- **Avoid:** stop the risky activity entirely.
- **Accept:** formally acknowledge and document the risk within appetite. Requires explicit sign-off.

**Key risk terms:**
- **Inherent risk:** risk before any controls are applied.
- **Residual risk:** risk remaining after controls are applied.
- **Risk appetite:** how much risk an organisation is willing to accept in pursuit of objectives.
- **Risk tolerance:** the acceptable variance above/below the risk appetite threshold.
- **Risk register:** living document tracking all identified risks, their owners, scores, treatment
  status, and review dates.

### Quantitative risk assessment (know the formulas)

| Formula | Meaning |
|---------|---------|
| **SLE = AV × EF** | Single Loss Expectancy = Asset Value × Exposure Factor (% of asset lost per incident) |
| **ALE = SLE × ARO** | Annualised Loss Expectancy = SLE × Annualised Rate of Occurrence |
| **Control justification** | Annual cost of control < reduction in ALE it delivers |

**Example:** Asset value £100,000. EF = 0.40 (40% of asset destroyed per incident). ARO = 0.5 (occurs once every two years).
- SLE = £100,000 × 0.40 = £40,000
- ALE = £40,000 × 0.5 = £20,000
- A control costing £5,000/year that halves ALE (saves £10,000/year) is cost-justified.

**Qualitative:** likelihood and impact rated Low/Medium/High; plotted on a **risk matrix / heat map**.
Faster and cheaper than quantitative; more subjective; used when hard figures are unavailable.

> Portfolio link: [spectre](../../spectre) used OWASP qualitative likelihood × impact scoring
> for finding severity. The ALE formulas apply when assigning remediation budget priority.

---

## 2. Security frameworks

| Framework | Purpose | Key structure |
|-----------|---------|---------------|
| **NIST CSF** (v1.1/v2.0) | Voluntary cyber risk framework | **Identify → Protect → Detect → Respond → Recover** (five functions); high-yield exam |
| **NIST RMF** (SP 800-37) | Federal system risk management process | Categorize → Select → Implement → Assess → Authorize → Monitor |
| **NIST SP 800-53** | Control catalogue for federal systems | Families: AC, AU, CA, CM, IA, IR, MA, MP, PE, PL, RA, SA, SC, SI, SR |
| **ISO/IEC 27001** | ISMS certification standard | Annex A controls; PDCA improvement cycle |
| **ISO/IEC 27002** | Control implementation guidance for 27001 | 93 controls in 4 themes (Organisational, People, Physical, Technological) |
| **CIS Controls** (v8) | Prioritised 18 implementation groups | IG1 (essential), IG2 (intermediate), IG3 (advanced) |
| **COBIT** | IT governance and management | Focus on aligning IT with business objectives |
| **PCI DSS** | Payment card data security | 12 requirements; applies if you handle card data |
| **MITRE ATT&CK** | Adversary TTP knowledge base | Tactics, techniques, sub-techniques; use for threat modelling and detection rule development |
| **SOC 2** | Service-organisation trust reporting | Based on Trust Service Criteria (TSC) |

**Exam focus:** NIST CSF five functions are highest-yield. ISO 27001 vs 27002 distinction (standard vs guidance). CIS controls as a prioritised implementation guide.

> Portfolio link: [spectre](../../spectre) maps countermeasures to **ISO/IEC 27002:2022** and
> **CIS Apache 2.4 Benchmark** — a direct demonstration of framework-driven assessment.

---

## 3. Compliance and regulations

### Key regulations

**GDPR (General Data Protection Regulation):**
- EU and UK law governing personal data of EU/UK residents.
- Principles: lawfulness/fairness/transparency, purpose limitation, data minimisation, accuracy,
  storage limitation, integrity/confidentiality, accountability.
- Key rights: access (DSARs), rectification, erasure ("right to be forgotten"), portability, objection.
- **Breach notification:** within 72 hours to the supervisory authority; without undue delay to affected individuals if high risk.
- **DPO (Data Protection Officer):** required for certain organisations (large-scale processing, special category data, public authorities).
- **Data transfers outside EEA:** require adequacy decision, SCCs, or binding corporate rules.
- Penalties: up to €20M or 4% of global annual turnover (whichever is higher).

**Other regulations to recognise:**
- **HIPAA (US):** health information protection; covered entities + business associates.
- **PCI DSS:** card payment security; 12 requirements; fines for non-compliance.
- **SOX (Sarbanes-Oxley, US):** financial reporting integrity; IT controls for financial systems.
- **CCPA (California):** California consumer privacy; similar principles to GDPR.

**Data sovereignty:** data subject to the laws of the country where it is stored or processed.
**Data residency:** contractual or regulatory requirement that data stays within a specific geography.

---

## 4. Data governance and privacy roles

| Role | Responsibility |
|------|---------------|
| **Data owner** | Business decision-maker responsible for a dataset; decides classification, retention, sharing |
| **Data controller** | Decides the purpose and means of processing (GDPR concept) |
| **Data processor** | Processes data on the controller's behalf (cloud provider, payroll processor) |
| **Data custodian / steward** | Day-to-day handling, operational responsibility for data security |
| **DPO** | Independent advisory role; ensures GDPR compliance; not decision-maker |

**Data lifecycle:** classification → handling → storage → retention → secure disposal/sanitisation.

**Secure disposal / sanitisation:**
- **Deletion:** marks space as available but does not erase data (recovery possible).
- **Wiping / overwriting:** writes over data multiple times (DoD 5220.22-M pattern).
- **Crypto-erase:** destroys the encryption key; encrypted data becomes unrecoverable. Fast; used for FDE volumes.
- **Degaussing:** magnetic field destroys data on magnetic media. Does not work on SSDs/flash.
- **Physical destruction / shredding:** definitive; used for classified media or when other methods are insufficient.

---

## 5. Third-party and supply-chain risk

**Why third-party risk matters:** your security posture is only as strong as your weakest partner.
A breach at a supplier can expose your data (e.g. SolarWinds supply-chain attack).

**Due diligence process:**
1. Vendor questionnaire / security assessment
2. Review certifications (ISO 27001, SOC 2 Type II)
3. Contractual requirements (right to audit, minimum security standards, breach notification SLA)
4. Continuous monitoring (threat intel, public breach notifications)

**Agreement types:**

| Agreement | Purpose |
|-----------|---------|
| **SLA** (Service Level Agreement) | Defines service performance levels and remedies |
| **NDA** (Non-Disclosure Agreement) | Protects confidential information shared with third parties |
| **MOU/MOA** (Memorandum of Understanding/Agreement) | Informal; documents intent and shared understanding |
| **BPA** (Business Partnership Agreement) | Formal terms for a business relationship |
| **ISA** (Interconnection Security Agreement) | Governs security requirements for network interconnections |
| **DPA** (Data Processing Agreement) | GDPR requirement; governs how a processor handles personal data |
| **MSA** (Master Service Agreement) | Overarching contract setting standard terms for an ongoing relationship; individual work is ordered under it |
| **SOW** (Statement of Work) | Specifies the deliverables, scope, timeline, and acceptance criteria for **one** engagement under an MSA |

**MSA vs SOW — the exam trap:** the MSA is the *umbrella* (legal/commercial terms agreed once);
each SOW hangs off it and defines *a specific piece of work*. Stem asking "which document defines
the deliverables and timeline for this particular project?" → **SOW**. "Which sets the standing
terms governing all future work with this vendor?" → **MSA**. Don't confuse the SLA (performance
levels + remedies) with either — an SLA can live inside an MSA but answers a different question.

**Fourth-party risk:** your vendor's vendors. If your cloud provider relies on a software component
from a supplier you've never assessed, their breach is your exposure.

**EOL/EOSL risk:** software or hardware with no vendor support is unpatched by definition. Assess
and plan to replace before support ends.

**SBOM (Software Bill of Materials):** inventory of all components in a software product, including
open-source libraries. Essential for supply-chain risk management. Mandated in some US government contracts.

---

## 6. Audits, assessments, and reporting

### Audit vs assessment distinction

| | Audit | Assessment |
|---|-------|-----------|
| Goal | Checks conformance to a defined standard | Evaluates security posture and risk broadly |
| Outcome | Pass/fail against each control | Findings, recommendations, risk rating |
| Assurance | Typically higher if external/independent | Varies |
| Example | SOC 2 Type II audit | Vulnerability assessment, red team assessment |

**Internal vs external:** external/independent audits carry more weight (no conflict of interest).

**SOC 2 reports:**
- **Type I:** controls were suitably *designed* at a specific point in time.
- **Type II:** controls were *operating effectively* over a period (typically 6–12 months).
  Type II is much more valuable — it proves sustained control operation, not just design.

**Attestation:** formal third-party statement confirming compliance or effectiveness.
**Right to audit clause:** contractual right to audit a third party on demand.

### Security testing types

| Type | Description | Exam note |
|------|-------------|-----------|
| Vulnerability assessment | Identifies and categorises vulnerabilities | No exploitation |
| Penetration test (black/grey/white box) | Exploits to prove impact | Grey-box combines internal knowledge with external testing |
| Red team | Simulates full APT campaign over extended period | Tests detection + response, not just prevention |
| Blue team | Defenders operating the SIEM/SOC | Real-time detection and response |
| Purple team | Red and blue working together to improve controls | Fastest improvement cycle |
| Tabletop exercise | Discussion-based scenario walkthrough | No live systems; tests process and decision-making |
| Bug bounty | External researcher programme; reward for reported vulnerabilities | Continuous, crowd-sourced testing |

---

## 7. Security awareness and the human element

- **Phishing simulations:** send simulated phishing emails; track click rate; provide immediate
  teachable moment to users who click.
- **Role-based training:** different content for different roles (executives get CEO-fraud training;
  developers get secure-coding training).
- **Security culture metrics:** repeat clicker rate, report rate, completion rate of mandatory training.
- **Gamification:** leaderboards, badges — increases engagement with training.
- **Recognition of indicators:** teach users to recognise urgency/authority manipulation, suspicious
  sender addresses, unexpected attachments, out-of-band requests for payments or credentials.

> Portfolio link: [mirage](../../mirage) is the research evidence base for why awareness training
> must address causal mechanisms (urgency/authority/trust), not just surface symptoms like poor
> grammar. The research finding — models miss multi-hop causal chains — directly informs training
> programme design.

---

## 8. Metrics, KPIs, and risk reporting

| Metric | Description |
|--------|-------------|
| **MTTD** (Mean Time to Detect) | Average time from incident start to detection |
| **MTTR** (Mean Time to Respond/Recover) | Average time from detection to containment/resolution |
| **Dwell time** | Time attacker was present in the environment before detection (MTTD equivalent) |
| **Alert volume / FP rate** | Total alerts and proportion that are false positives |
| **Patch latency** | Days from vulnerability disclosure to patch deployment |
| **% assets at baseline** | Proportion meeting hardened configuration standard |
| **KRI** (Key Risk Indicator) | Leading indicator that a risk is rising (e.g. rising failed-login rate) |
| **KPI** (Key Performance Indicator) | Measures performance against a target (e.g. MTTD < 60 minutes) |

**KRI vs KPI:** KRI is a *leading* signal (it precedes an event); KPI is a *performance* measure
(it tells you how well you performed against a target). Track both.

**Reporting up:** security metrics must be translated into business risk language for the board
and executive team. "CVSS 9.8" means nothing to a CFO; "risk of £X loss within 12 months" does.

---

## 9. Policies and governance

| Policy | Purpose |
|--------|---------|
| **AUP** (Acceptable Use Policy) | Defines permitted and prohibited use of systems and data |
| **Information security policy** | Top-level governance document; delegates to sub-policies |
| **Clean desk / clear screen** | Physical and digital information control |
| **BYOD / MDM policy** | Governs personal device use for work |
| **Data classification policy** | How data is classified, handled, and retained |
| **Change management policy** | Controls changes to production systems (CAB, change windows, rollback plans) |
| **Incident response policy** | Mandates the IR process, roles, escalation |

---

### Quick self-test
- ALE formula end-to-end: AV × EF = SLE; SLE × ARO = ALE. Calculate for: AV=£200K, EF=0.30, ARO=0.25.
- NIST CSF five functions — name them in order.
- Audit vs assessment — which checks conformance, which evaluates posture?
- SOC 2 Type I vs Type II — what is the key difference?
- Data controller vs data processor under GDPR — who decides the purpose?
- GDPR breach notification — to whom and within what timeframe?
- KRI vs KPI — which is a leading indicator of rising risk?
- Why does an SBOM matter for supply-chain risk?
- Crypto-erase vs degaussing — which works on SSDs and why?

### Scenario drills

1. *A risk is assessed; rather than fixing the root cause, the firm buys cyber-insurance to cover the
   potential loss.* Which risk-treatment strategy, and what residual exposure remains? →
   **Transference**; insurance covers financial loss but **not** reputational damage or the
   operational disruption — and won't pay out if controls were negligent.
2. *Control costs £30K/yr. The risk it addresses has AV £200K, EF 0.30, ARO 0.25.* Is the control
   justified on ALE alone? → SLE = 200K × 0.30 = **£60K**; ALE = 60K × 0.25 = **£15K/yr**. The control
   costs more (£30K) than the annual expected loss (£15K) → **not justified on ALE alone** (unless it
   addresses other risks or a regulatory requirement).
3. *Two companies want a non-binding statement of intent to collaborate before signing anything
   enforceable.* Which document? → **MOU** (Memorandum of Understanding). A contract/SLA/BPA would be
   binding.
4. *A personal-data breach is confirmed at 09:00 Monday.* Under GDPR, what's the reporting deadline
   and to whom? → Notify the **supervisory authority within 72 hours**; notify affected **data
   subjects without undue delay** if high risk to their rights.
5. *A vendor supplying a critical software component is acquired by an unknown parent and stops
   publishing security updates.* Which program area addresses this and what artefact helps? →
   **Third-party / supply-chain risk management**; an **SBOM** lets you find every place that
   component is used so you can assess and compensate.
6. *The board asks "are we getting riskier?" before any incident has occurred.* Which metric type
   answers that, and how does it differ from the other? → A **KRI (Key Risk Indicator)** — a *leading*
   indicator of rising risk (e.g. rising unpatched-host count); a **KPI** measures performance against
   a goal (often *lagging*).
7. *An auditor must give external customers assurance that a SaaS provider's controls operated
   effectively over the past year.* Which report? → **SOC 2 Type II** (effectiveness *over a period*),
   as opposed to Type I (design *at a point in time*).

---

## Quick reference card — Domain 5

One-page revision sheet. If any line is not instant recall, re-read that section above.

**Acronyms:**
SLE/ALE/ARO/EF/AV (single & annualised loss expectancy, annual rate, exposure factor, asset value) ·
GRC (governance, risk, compliance) · NIST CSF/RMF (cybersecurity framework / risk management
framework) · ISMS (information security management system, ISO 27001) · PDCA (plan-do-check-act) ·
GDPR/DPO/DSAR (EU/UK data law, protection officer, subject access request) · SCC (standard
contractual clauses) · SLA/NDA/MOU/BPA/ISA/DPA/MSA/SOW (service level / non-disclosure /
understanding / partnership / interconnection / data processing / master service / statement of
work) · SBOM (software bill of materials) ·
MTTD/MTTR (mean time to detect / respond) · KRI/KPI (key risk / performance indicator) ·
AUP (acceptable use policy)

**Key term one-liners:**
- Risk = likelihood × impact. Treatments: mitigate · transfer · avoid · accept (formal sign-off).
- Inherent risk (before controls) → residual risk (after). Appetite (willingness) vs tolerance
  (acceptable variance).
- Formulas: **SLE = AV × EF**, **ALE = SLE × ARO**; a control is ALE-justified when it costs less
  than the loss it prevents per year.
- Frameworks: NIST CSF functions **Identify → Protect → Detect → Respond → Recover** · ISO 27001
  (certifiable standard) vs 27002 (implementation guidance) · CIS Controls IG1–IG3 (prioritised) ·
  PCI DSS (card data) · SOC 2 (trust services reporting).
- GDPR: 72-hour authority notification · controller decides purpose, processor acts on
  instruction · DPO advises independently · transfers need adequacy/SCCs · fines to 4% turnover.
- Roles: data **owner** (business decision-maker) · **custodian/steward** (day-to-day handling).
- Audit (conformance to a standard, pass/fail) vs assessment (posture, findings). External >
  internal for assurance. Attestation = formal third-party statement.
- SOC 2: Type I = design at a point in time · Type II = operating effectiveness over a period.
- Testing ladder: vulnerability assessment → pentest → red team (campaign) → purple (joint) ·
  tabletop = discussion-based process test.
- Metrics: MTTD/dwell (detection speed) · MTTR (response speed) · KRI = leading risk signal ·
  KPI = performance vs target.

**Exam traps:**
- Risk transfer moves financial consequences — never liability or reputation.
- ISO **27001** is what you certify against; **27002** is how-to guidance.
- MOU is non-binding; SLA/BPA/contracts bind.
- The data *owner* classifies data — not IT, who usually act as custodian.
- A KRI leads (risk rising); a KPI lags (how you performed).
- Boards buy "£X expected loss avoided", not "CVSS 9.8".

---

## Scenario bank — situation → action

Ten decision-format questions, distinct from the drills above and from
[soc-scenarios](../scenarios/soc-scenarios.md). Format: situation → what do you do? → correct
action → why → portfolio link.

**1. Ship it anyway?**
- **Situation:** A release is due before peak trading season with one known medium-severity
  vulnerability; fixing it means missing the season. The product lead says "ship it".
- **What do you do?** Make the risk decision properly.
- **Correct action:** Put it through **formal risk acceptance**: the named risk owner (business,
  not security) signs off, the acceptance is time-boxed with a review date, compensating
  monitoring is applied, and it lands in the risk register — not in a hallway conversation.
- **Why:** Accepting risk is legitimate; *undocumented* acceptance is how an organisation
  discovers, post-breach, that nobody owned the decision.
- **Portfolio link:** [spectre](../../spectre) rates each finding likelihood × impact for exactly
  this purpose — giving the owner something concrete to accept or fund.

**2. The vendor who won't answer**
- **Situation:** A vendor processing your customer data refuses the security questionnaire:
  "our security is proprietary information."
- **What do you do?** Get assurance another way or escalate.
- **Correct action:** Require independent evidence instead — **ISO 27001 certificate / SOC 2
  Type II report** — and invoke or negotiate a **right-to-audit clause**. If they offer nothing,
  treat as a risk finding for the business owner: compensate (minimise shared data) or exit.
- **Why:** Due diligence is non-negotiable for processors of your data; "trust us" is the answer
  attackers also give. Certifications exist precisely so vendors can prove posture without
  exposing internals.
- **Portfolio link:** §5–6 above (agreement types, audits) — the contractual toolkit this
  scenario draws on.

**3. "Keep it all forever"**
- **Situation:** Marketing wants the customer database kept indefinitely — "the data might be
  useful someday" — including records of customers inactive for a decade.
- **What do you do?** Apply data governance.
- **Correct action:** Enforce **purpose and storage limitation**: define retention schedules per
  data class, justify each against a stated purpose, and delete (or anonymise) past retention.
  "Might be useful" is not a lawful purpose under GDPR.
- **Why:** Old data is pure liability — it can be breached, subpoenaed, and fined, but the value
  evaporated years ago. Minimisation shrinks the blast radius before any control has to work.
- **Portfolio link:** [mirage](../../mirage) chose synthetic data over collecting real personal
  data — the strongest form of minimisation: never hold it at all.

**4. The plan that's never been run**
- **Situation:** The incident response plan is twelve months old and has never been exercised.
  Budget for testing this quarter is small.
- **What do you do?** Pick the right first exercise.
- **Correct action:** Run a **tabletop exercise**: a facilitated scenario walkthrough with the
  actual responders (and an executive), testing decisions, escalation paths, and contacts — then
  fix the plan and graduate to technical simulation later.
- **Why:** Tabletops are cheap and surface the expensive failures (nobody knows who declares an
  incident; the contact list is stale) before a real attacker administers the test.
- **Portfolio link:** [gauntlet](../../gauntlet)'s premise is the same: rehearse the methodology
  in practice environments so the first execution isn't the real event.

**5. Whose data is it anyway?**
- **Situation:** A dispute: IT wants the HR dataset classified Confidential; HR says Internal is
  fine. Both ask security to "decide".
- **What do you do?** Route the decision to the right role.
- **Correct action:** The **data owner** — the HR business function — decides classification,
  guided by policy criteria; IT (as **custodian**) implements the handling controls that follow.
  Security facilitates the criteria, not the verdict.
- **Why:** Classification is a business-impact judgement about consequence of disclosure — only
  the function accountable for the data can make it; custodians enforce, owners decide.
- **Portfolio link:** §4 above (governance roles) — owner / controller / processor / custodian
  distinctions this hinges on.

**6. Payroll in someone else's cloud**
- **Situation:** Procurement is about to sign a payroll SaaS that will process all employee
  personal data. They ask if the standard purchase contract is enough.
- **What do you do?** Add the missing instrument.
- **Correct action:** Require a **DPA (Data Processing Agreement)**: processing scope and
  instructions, security measures, sub-processor disclosure, breach-notification SLA, and
  audit/return-or-delete terms — plus due diligence on the provider before signature.
- **Why:** Under GDPR a controller may only use processors providing "sufficient guarantees",
  bound by contract. No DPA = non-compliant on day one, before any breach.
- **Portfolio link:** §3/§5 above (GDPR obligations; agreement types) — the compliance chain
  this scenario walks.

**7. Punish the clickers?**
- **Situation:** The first phishing simulation: 30% clicked. Leadership proposes disciplinary
  action for anyone who clicks twice.
- **What do you do?** Shape the programme, not the punishment.
- **Correct action:** Push back: keep simulations educational (immediate teachable moment),
  track **report rate** as the headline metric (not just click rate), target repeat-clickers with
  tailored training, and protect the no-blame reporting culture.
- **Why:** Punishment teaches one lesson: *never report*. A user who clicks and reports in two
  minutes is your best detection; a user who clicks and hides is your breach.
- **Portfolio link:** [mirage](../../mirage)'s finding — detection fails on surface cues — is why
  training must build contextual judgement ("does this request make sense?"), not fear.

**8. "Which document says how?"**
- **Situation:** An engineer asks where it's written *exactly* how to harden an Ubuntu server.
  They were handed the corporate security policy and found principles, not steps.
- **What do you do?** Map the governance hierarchy.
- **Correct action:** Point to the right layer: the **policy** mandates ("servers shall be
  hardened to baseline"), the **standard/baseline** specifies (CIS Ubuntu benchmark, internal
  baseline), and the **procedure/SOP** gives the steps. If the lower layers don't exist, that's
  the gap to fix.
- **Why:** Policies that try to contain command lines rot instantly; procedures without a policy
  mandate are optional. Each layer does one job.
- **Portfolio link:** [spectre](../../spectre) hardened PostgreSQL **to CIS Level 1** — a worked
  example of standard → procedure → verified result.

**9. "Where do we stand?"**
- **Situation:** A new CISO's first request: "Show me where we are against NIST CSF — what we
  have, what's missing, what's weakest."
- **What do you do?** Choose the right exercise.
- **Correct action:** Run a **gap analysis / framework assessment**: score current state against
  each CSF function and category, rate maturity, and produce a prioritised roadmap. This is an
  assessment (posture), not an audit (conformance pass/fail).
- **Why:** You can't sequence investment without knowing the delta between current and target
  state — and calling it an audit sets the wrong expectation of pass/fail certification.
- **Portfolio link:** §2/§6 above (framework table; audit vs assessment) — the distinction this
  request turns on.

**10. Marking your own homework**
- **Situation:** To win a customer, the company wants to attest its controls. The proposal: the
  engineering team that built the controls writes and signs the assessment.
- **What do you do?** Fix the assurance model.
- **Correct action:** Require **independent assessment** — an external auditor (SOC 2 / ISO 27001
  certification body) for customer-facing attestation; internal review can prepare, never attest.
- **Why:** Assurance value scales with independence — a builder attesting their own controls has
  a structural conflict of interest, and informed customers will discount it to zero.
- **Portfolio link:** [gauntlet](../../gauntlet) practises on externally-graded platforms for the
  same reason — the score means something because the grader isn't the player.
