// Power Query M — fact table transformation
// Update the relative source path to your local clone, or use a repository parameter.
let
    Source = Csv.Document(
        File.Contents("C:\REPLACE_WITH_LOCAL_PATH\04_Star_Schema_Datasets_INR\Fact_Order_Shipments_3600.csv"),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    TypedColumns = Table.TransformColumnTypes(PromotedHeaders, {
        {"Shipment_ID", type text}, {"Order_Date", type date}, {"Year_Month", type text},
        {"Warehouse_ID", type text}, {"Carrier_ID", type text}, {"Product_ID", type text},
        {"Payment_Mode", type text}, {"Order_Qty", Int64.Type}, {"Dispatch_Time_Hours", type number},
        {"Promised_SLA_Days", Int64.Type}, {"Actual_Transit_Days", Int64.Type},
        {"Delivery_Status", type text}, {"Is_On_Time_Flag", Int64.Type}, {"Is_OTIF_Flag", Int64.Type},
        {"Delay_or_RTO_Reason", type text}, {"Gross_Booked_GMV_INR", Currency.Type},
        {"Realized_Revenue_INR", Currency.Type}, {"COGS_INR", Currency.Type},
        {"Forward_Shipping_Cost_INR", Currency.Type}, {"RTO_and_SLA_Penalty_INR", Currency.Type},
        {"Total_Logistics_Cost_INR", Currency.Type}, {"Net_Contribution_Profit_INR", Currency.Type}
    }, "en-IN"),
    CleanTextKeys = Table.TransformColumns(TypedColumns, {
        {"Shipment_ID", each if _ = null then null else Text.Trim(_), type text},
        {"Warehouse_ID", each if _ = null then null else Text.Trim(_), type text},
        {"Carrier_ID", each if _ = null then null else Text.Trim(_), type text},
        {"Product_ID", each if _ = null then null else Text.Trim(_), type text}
    }),
    RemoveInvalidShipmentIDs = Table.SelectRows(CleanTextKeys, each [Shipment_ID] <> null and [Shipment_ID] <> ""),
    AddTransitSLABucket = Table.AddColumn(RemoveInvalidShipmentIDs, "Transit_SLA_Bucket", each
        if [Delivery_Status] = "RTO (Undelivered Return)" then "RTO / Undelivered"
        else if [Delivery_Status] = "Damaged in Transit" then "Damaged in Transit"
        else if [Actual_Transit_Days] <= [Promised_SLA_Days] then "On time / within SLA"
        else if [Actual_Transit_Days] - [Promised_SLA_Days] = 1 then "Delayed by 1 day"
        else "Delayed by 2+ days", type text),
    AddYearMonthCheck = Table.AddColumn(AddTransitSLABucket, "Year_Month_Check", each Date.ToText([Order_Date], "yyyy-MM"), type text),
    FlagYearMonthMismatch = Table.AddColumn(AddYearMonthCheck, "Year_Month_Mismatch", each [Year_Month] <> [Year_Month_Check], type logical)
in
    FlagYearMonthMismatch
