# Power BI Implementation Guide & Decision Framework

> **Portfolio scenario:** Hypothetical Flipkart-style operation; synthetic data only. This is not a company-endorsed report. The project is a build specification, not a completed `.pbix` deliverable.

## 1. Import and prepare data

1. In Power BI Desktop, select **Get data → Text/CSV** and import the fact CSV plus the three supplied dimension CSVs.
2. In Power Query, update the path in `02_PowerQuery_M_ETL_Transformation.pq` or replace it with a parameter. Use `QuoteStyle.Csv` so quoted text is parsed correctly.
3. Confirm data types, date parsing, row counts, null keys, duplicate IDs and the `Year_Month_Mismatch` flag.
4. Resolve data-quality exceptions before publishing. Do not silently remove valid records to make totals match.

## 2. Create the model

- Create `Dim_Calendar` from the DAX library, then mark `Dim_Calendar[Date]` as the date table.
- Relationships: `Dim_Calendar[Date]` → fact `[Order_Date]`; `Dim_Warehouses[Warehouse_ID]` → fact; `Dim_Courier_Carriers[Carrier_ID]` → fact; `Dim_Products[Product_ID]` → fact.
- Set each relationship to **one-to-many**, active, with single-direction filtering from dimension to fact.
- Verify each dimension key is unique and all fact keys match a dimension key.
- Create each measure as an individual measure. Do not paste the entire `.dax` file into one measure editor.

## 3. Suggested page design

### Page 1 — Executive overview
KPI cards: Booked GMV, realized revenue, contribution profit, OTIF rate and RTO rate. Add a monthly trend, warehouse/state comparison and a clear date filter.

### Page 2 — Warehouse operations
Hub table/matrix with shipment count, average dispatch hours, target hours, OTIF and RTO. Add conditional formatting and a drill-through detail table.

### Page 3 — Carrier scorecard
Compare shipment volume, OTIF rate, RTO rate and logistics cost per shipment. Show contract targets only as reference values from the supplied synthetic dimension; do not imply actual vendor performance.

### Page 4 — RTO and root causes
Break down RTO by reason, payment method, warehouse, carrier and product. If adding a what-if scenario, show assumptions, eligible shipment count, estimated cost base and scenario percentage. Label the output **illustrative cost avoidance**, not profit or guaranteed savings.

## 4. Security and governance

1. In **Modeling → Manage roles**, create `Regional_Zone_Manager_RLS` on `Dim_Warehouses` with:
   `Dim_Warehouses[RLS_Manager_Email] = USERPRINCIPALNAME()`
2. Placeholder identities use `example.com`; they are not real users.
3. Test allowed and disallowed users with **View as** and then in Power BI Service. A role definition is not proof that security has been validated.
4. Use separate executive/admin roles where needed, and document any unrestricted access explicitly.

## 5. Data validation checklist

- Fact row count and unique `Shipment_ID` count match.
- No blank primary/foreign keys; dimension keys are unique.
- Fact foreign keys all resolve to dimensions.
- `Year_Month` agrees with `Order_Date` month.
- `Is_On_Time_Flag` agrees with promised vs actual transit days, subject to business definition.
- `Is_OTIF_Flag` is zero for non-delivered statuses.
- Financial measures reconcile to the raw CSV with the stated KPI definitions.
- Any unusual business rules (for example, treatment of inventory/COGS on RTO) are documented, not guessed.

## 6. Decision framework — hypotheses to validate

- **Address and delivery confirmation:** Investigate the largest RTO reason categories and test address validation/customer confirmation in a controlled pilot.
- **Carrier allocation:** Compare carrier results after controlling for service type, geography, product mix and shipment value before reallocating volume.
- **Dispatch wave design:** Compare order cut-off, dispatch time and OTIF by hub/day before changing staffing or line-haul schedules.
- **Payment method:** COD and UPI rates are observational. Do not claim a payment nudge causes lower RTO without an experiment and cost-benefit analysis.

For each action, define owner, baseline, intervention, comparison group, measurement window, guardrail metrics and a decision threshold before launch.

## 7. Interview talking points

Explain requirements elicitation, metric definitions, data model grain, ETL controls, reconciliation, RLS, UAT traceability and how you would turn descriptive patterns into testable hypotheses. Be explicit that the dataset is synthetic and the report still needs to be built and tested in Power BI Desktop.
