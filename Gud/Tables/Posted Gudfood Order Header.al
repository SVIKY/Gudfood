table 51501 "Posted Gudfood Order Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Sell- to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Customer";
        }
        field(3; "Sell- to Customer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Order Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(5; "Posting No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Total Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Gudfood Order Line".Quantity where("Order No." = field("No.")));
            Editable = false;
        }
        field(8; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Gudfood Order Line".Amount where("Order No." = field("No.")));
            Editable = false;
        }
        field(9; "Posting Date"; Date)
        {
            Editable = false;
        }

        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
        }
        field(11; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
        }

        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;
}