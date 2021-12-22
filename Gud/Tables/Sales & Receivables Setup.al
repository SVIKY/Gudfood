tableextension 51520 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(51500; "Gudfood Items Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(51501; "Gudfood Order Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;

        }
        field(51502; "Posted Gudfood Order Nos."; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;

        }
    }
}