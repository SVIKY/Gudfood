table 51500 "Gudfood Item"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = Code, Type, Description;
    fields
    {
        field(1; Code; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if Rec.Code <> xRec.Code then begin
                    SalesReceivablesSetup.Get();
                    NoSeriesMgt.TestManual(SalesReceivablesSetup."Gudfood Items Nos.");
                    Code := '';
                end;
            end;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            MinValue = 0.01;
        }
        field(4; Type; Option)
        {
            OptionMembers = "","Salat","Burger","Capcake","Drink";
            DataClassification = ToBeClassified;
        }

        field(5; "Qty. Ordered"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Posted Gudfood Order Line".Quantity WHERE("Item No." = field(Code)));
        }
        field(6; "Qty. in Order"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Gudfood Order Line".Quantity WHERE("Item No." = FIELD(Code)));
        }
        field(7; "Shelf Life"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Picture; Media)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup("DropDown"; Code, Description, "Unit Price", Type, "Shelf Life") { }
        fieldgroup("Brick"; Code, Type, Description, "Shelf Life", "Unit Price", Picture) { }
    }

    var
        SalesReceivablesSetup: Record 311;
        NoSeriesMgt: Codeunit 396;

    trigger OnInsert()
    begin
        if Code = '' then begin
            SalesReceivablesSetup.Get();
            SalesReceivablesSetup.TestField("Gudfood Items Nos.");
            NoSeriesMgt.InitSeries(SalesReceivablesSetup."Gudfood Items Nos.", xRec.Code, 0D, Code, SalesReceivablesSetup."Gudfood Items Nos.");
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        GudfoodOrderLine: Record "Gudfood Order Line";
        DeleteUsedItemsErr: Label 'This item is in order. Can not delete ordered item.';
    begin
        GudfoodOrderLine.SetRange("Item No.", Code);
        if (not GudfoodOrderLine.IsEmpty()) then
            exit;
        error(DeleteUsedItemsErr);
    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEdit(): Boolean
    begin
        SalesReceivablesSetup.Get();
        SalesReceivablesSetup.TestField("Gudfood Items Nos.");
        if NoSeriesMgt.SelectSeries(SalesReceivablesSetup."Gudfood Items Nos.", xRec.Code, Code) then begin
            NoSeriesMgt.SetSeries(Code);
            exit(TRUE);
        end;
    end;

}