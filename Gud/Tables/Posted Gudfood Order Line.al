table 51504 "Posted Gudfood Order Line"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gudfood Order Header";
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Sell- to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(4; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(5; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Gudfood Item";
        }

        field(6; "Item Type"; Option)
        {
            OptionMembers = "","Salat","Burger","Capcake","Drink";
            FieldClass = FlowField;
            CalcFormula = Lookup("Gudfood Item".Type where(Code = field("Item No.")));
            Editable = false;
        }

        field(7; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(8; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 1;
            MinValue = 1;
            NotBlank = true;
        }

        field(9; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            Editable = false;
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
            Editable = false;
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
        key(Key1; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        DimMgt: Codeunit 408;

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

    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1', "Order No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;
}