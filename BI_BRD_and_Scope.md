# Business Intelligence Business Requirements Document (BI-BRD)

| Document field | Details |
|---|---|
| Project | Supply Chain SLA, OTIF & Contribution Analytics |
| Business context | Hypothetical Flipkart-style Indian e-commerce operation |
| Document owner | Shruti Thacker — portfolio case study |
| Version | 1.0 |
| Status | Portfolio specification; not production-approved |
| Data classification | Synthetic, non-confidential sample data |

> **Disclaimer:** This is an independent portfolio exercise, not an official Flipkart project. No actual company data or internal systems are represented.

## 1. Background and problem statement

The hypothetical business consolidates order, warehouse and carrier data to understand service performance and cost drivers. Spreadsheet-based reporting can create inconsistent KPI definitions, slow exception management and weak visibility across fulfilment hubs. The proposed Power BI report provides a consistent, filterable view for operations and finance stakeholders.

## 2. Objectives and success measures

- Establish a reconciled baseline for shipment volume, booked GMV, realized revenue, contribution profit, OTIF and RTO.
- Compare warehouse dispatch performance against documented hub targets.
- Compare carrier outcomes by service level, shipment volume, RTO and logistics cost.
- Identify recurring delay/RTO reasons and formulate testable improvement hypotheses.
- Define access governance and a repeatable UAT process.

**Targets are proposed business targets, not observed results.** A production target should be approved by the business owner after baseline validation.

## 3. Scope

### In scope
- One shipment-level fact table and dimensions for calendar, warehouse, carrier and product.
- Data type enforcement, key cleaning, exception bucketing and reconciliation checks.
- Four dashboard pages: executive overview, warehouse operations, carrier scorecard, RTO/root-cause analysis.
- Business requirements, stakeholder matrix, DAX library, Power Query M, user stories and UAT cases.
- Dynamic row-level security design for warehouse/zone-level access.

### Out of scope
- Live integration to ERP, WMS, OMS or carrier APIs.
- Production deployment, gateway configuration and credentials.
- Claims of realized financial savings or actual carrier contract performance.
- A finished `.pbix` report; the repository contains a build specification and supporting artefacts.

## 4. Stakeholders

| Persona | Primary need | Decisions supported |
|---|---|---|
| COO / Finance | Revenue, margin and service overview | Prioritize improvement initiatives |
| Supply Chain Lead | Carrier and network performance | Investigate carrier and route exceptions |
| Regional Operations Manager | Hub-level dispatch and SLA | Adjust staffing, cut-offs and dispatch waves |
| Customer Experience Lead | RTO and failure reasons | Improve address validation and customer confirmation |
| BI / Data Owner | Consistent definitions and trusted refresh | Own data quality, model and access controls |

## 5. KPI definitions

| KPI | Definition | Notes |
|---|---|---|
| Booked GMV | Sum of `Gross_Booked_GMV_INR` | Gross order value recorded in the sample |
| Realized revenue | Sum of `Realized_Revenue_INR` for delivered shipments | Assumes delivery is the recognized realization condition in this sample; confirm finance policy in real projects |
| OTIF rate | Sum of `Is_OTIF_Flag` divided by shipment count | Current sample uses all shipment records as denominator; confirm treatment of damaged shipments with stakeholders |
| RTO rate | RTO shipment count divided by shipment count | Segment-specific rates use segment-specific shipment count |
| Average dispatch hours | Average `Dispatch_Time_Hours` | Validate whether this measures order-to-dispatch elapsed time and how outliers are treated |
| Logistics cost per shipment | Sum of `Total_Logistics_Cost_INR` divided by shipment count | Report both network and carrier-level values |
| Net contribution profit | Sum of supplied `Net_Contribution_Profit_INR` | Preserve the synthetic source logic; do not infer a universal accounting definition without finance sign-off |

## 6. Functional requirements

| ID | Requirement | Priority | Acceptance evidence |
|---|---|---|---|
| FR-01 | Show core financial and service KPIs with consistent filters | Must | KPI totals reconcile to source data |
| FR-02 | Allow drill-down by date, warehouse, carrier, product and payment mode | Must | Filters affect relevant visuals consistently |
| FR-03 | Compare hub dispatch hours against target hours | Must | Target and actual are visible with exception formatting |
| FR-04 | Compare carrier OTIF, RTO, volume and cost | Must | Carrier values reconcile to fact rows |
| FR-05 | Show RTO reasons and payment-method breakdown | Must | Denominators are explicitly labelled |
| FR-06 | Provide scenario analysis with assumptions exposed | Should | Scenario label and assumptions visible on page |
| FR-07 | Restrict warehouse rows by signed-in user | Must for deployment | RLS tests pass for authorized and unauthorized identities |
| FR-08 | Display data refresh timestamp and data-quality status | Should | Refresh metadata and exception counts visible |

## 7. Non-functional requirements

- **Usability:** consistent page titles, units, date formats and KPI definitions.
- **Performance:** agree a target after testing in the actual Power BI environment; do not claim an unmeasured response time.
- **Reliability:** refresh failures and data-quality exceptions must be visible to the owner.
- **Security:** least-privilege access; validate RLS in Power BI Service, not only Desktop.
- **Maintainability:** parameterized source paths, documented measures and version-controlled definitions.
- **Accessibility:** meaningful titles, adequate contrast, alt text where supported and no reliance on colour alone.

## 8. Assumptions, risks and dependencies

- The provided dataset is synthetic and limited to 3,600 records dated April–September 2026.
- The source contains order-level financial values and shipment-level operational fields; grain and aggregation rules must be confirmed before production reuse.
- Payment-mode comparisons are observational, not proof that payment mode causes RTO differences.
- RLS manager email values are placeholders and must be replaced with an approved identity mapping in any real implementation.
- Data refresh, production permissions, source ownership and finance-approved KPI definitions remain dependencies.

## 9. Approval and change control

For a real engagement, record the business owner, data owner, version, review date, approval status and change log before treating this BRD as approved. For this portfolio project, it remains a proposed specification.
