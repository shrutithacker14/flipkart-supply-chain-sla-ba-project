# Supply Chain SLA & OTIF Analytics | Business Analyst Portfolio

> **Case-study disclaimer:** This is an independent portfolio project using synthetic data in a hypothetical Indian e-commerce operating scenario inspired by the scale and complexity of a Flipkart-style business. It is **not an official Flipkart project**, does not use company-confidential data, and does not imply endorsement or affiliation. The company name is used only to make the business context recognizable; the analysis and all figures are simulated.

![Role](https://img.shields.io/badge/Focus-Business%20Analysis%20%7C%20BI-17365D) ![Tools](https://img.shields.io/badge/Tools-Power%20BI%20%7C%20DAX%20%7C%20Power%20Query-F2C811) ![Data](https://img.shields.io/badge/Data-Synthetic%20%7C%203%2C600%20shipments-138A72)

## Executive summary

This project demonstrates how a Business Analyst translates an operational problem into measurable requirements, a dimensional data model, dashboard specifications, KPI definitions, data-quality controls, and UAT scenarios. The business scenario focuses on shipment delivery performance, on-time-in-full (OTIF), return-to-origin (RTO), carrier performance, warehouse dispatch time, and contribution economics.

### Dataset snapshot (computed from the included CSV)

| Measure | Audited result |
|---|---:|
| Shipment records | 3,600 |
| Booked GMV | ₹16,140,536 |
| Realized revenue | ₹14,801,414 |
| Net contribution profit (as supplied in synthetic data) | ₹5,434,047.40 |
| OTIF shipments | 2,137 (59.4% of all shipment records) |
| RTO shipments | 238 (6.6% of all shipment records) |
| COD RTO rate | 15.7% |
| UPI prepaid RTO rate | 2.3% |

**Interpretation note:** OTIF is calculated against all shipment records in this project; confirm with stakeholders whether damaged shipments should remain in the denominator for a production KPI. COD/UPI RTO rates use each payment method's shipment count as the denominator. Metrics describe only the synthetic sample and are not claims about Flipkart or any real business.

## Business question

How can operations and finance teams identify delivery-SLA gaps and cost leakage across warehouses, carriers, products, and payment methods, then prioritize evidence-based operational improvements?

## Scope and deliverables

- Business requirements and scope: `01_BI_Business_Requirements_Document_BRD/`
- Stakeholder, access and governance matrix: `02_Stakeholder_Analysis_and_RLS_Governance/`
- Data model and dashboard wireframes: `03_Star_Schema_Data_Model_and_Wireframes/`
- Synthetic fact and dimension data: `04_Star_Schema_Datasets_INR/`
- DAX and Power Query scripts: `05_DAX_Measures_and_PowerQuery_M_Scripts/`
- User stories, UAT and traceability workbook: `06_Agile_User_Stories_and_BI_UAT_Workbook/`
- Dashboard implementation and decision recommendations: `07_PowerBI_Build_Guide_and_Executive_Insights/`
- Audit log: `DATA_QUALITY_AUDIT.md`

## Proposed dashboard pages

1. **Executive overview:** GMV, realized revenue, contribution profit, OTIF, RTO and monthly trend.
2. **Warehouse operations:** dispatch-time distribution, SLA comparison, hub-level trend and exception list.
3. **Carrier scorecard:** OTIF, RTO, cost per shipment, contractual benchmark and volume.
4. **RTO and root-cause analysis:** payment mode, reason, product and carrier breakdown; clearly labelled scenario analysis.

## Data model

One shipment-level fact table joins to four dimensions: Calendar, Warehouse, Carrier and Product. The calendar is created in DAX. Use one-to-many relationships from dimensions to the fact table with single-direction filtering. Avoid many-to-many relationships unless a documented business need exists.

## How to use

1. Clone/download this repository and open the CSV files in `04_Star_Schema_Datasets_INR/`.
2. Open Power BI Desktop and import the four CSV files.
3. Apply the Power Query transformation after updating its local file path, or replace the hard-coded path with a Power Query parameter.
4. Create the DAX calendar and measures using the supplied library. Create each measure separately; the library is a reference collection, not one single pasteable DAX expression.
5. Create and validate relationships, mark `Dim_Calendar[Date]` as the date table, and verify totals against the audit file.
6. Configure and test RLS in a development workspace before publishing. Sample email addresses use `example.com` and are placeholders, not real identities.
7. Record actual UAT outcomes only after executing tests in the completed Power BI report. The included workbook is a test plan, not proof of an executed test run.

## Repository quality notes

- No Power BI `.pbix` file is included; the repository contains the requirements, sample data, model artefacts, scripts and build instructions.
- All business outcomes and savings are hypotheses until tested with reliable operational data and a controlled pilot.
- Use the `DATA_QUALITY_AUDIT.md` as the source of truth for validation findings and limitations.

## Suggested interview walkthrough

1. Explain the business problem and stakeholders.
2. Show how each requirement maps to a KPI, visual and acceptance test.
3. Explain the grain of the fact table and the star-schema relationships.
4. Demonstrate data-quality checks and KPI reconciliation.
5. Present one insight as a hypothesis, then explain how you would validate impact through a pilot.

## Author

**Shruti Thacker** — Business Analyst portfolio case study.
