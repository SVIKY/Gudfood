table 51502 "Gudfood Order Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            begin
                if Rec."No." <> xRec."No." then BEGIN
                    SalesReceivablesSetup.Get();
                    NoSeriesMgt.TestManual(SalesReceivablesSetup."Gudfood Order Nos.");
                    "No." := '';
                END;
            end;
        }
        field(2; "Sell- to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Customer";
            trigger OnValidate()
            var
                Customer: Record 18;
                ErrorFindUser: TextConst ENU = 'No such customer stored.',
                                        RUS = 'Такого пользователя нет в базе данных';
            begin
                IF Customer.Get("Sell- to Customer No.") then
                    "Sell- to Customer Name" := Customer.Name
                else begin
                    ;
                    Message(ErrorFindUser);
                    Rec."Sell- to Customer No." := xRec."Sell- to Customer No.";
                end;
            end;
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
            trigger OnValidate()
            begin
                if "Posting No." <> xRec."Posting No." then begin
                    SalesReceivablesSetup.Get();
                    NoSeriesMgt.TestManual(SalesReceivablesSetup."Posted Gudfood Order Nos.");
                    "Posting No." := '';
                end;
            end;
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
        field(9; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(10; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";
            trigger OnValidate()
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;

            trigger OnLookup()
            begin
                ShowDocDim();
            end;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        SalesReceivablesSetup: Record 311;
        NoSeriesMgt: Codeunit 396;
        DimMgt: Codeunit 408;

    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesReceivablesSetup.Get();
            SalesReceivablesSetup.TestField("Gudfood Order Nos.");
            NoSeriesMgt.InitSeries(SalesReceivablesSetup."Gudfood Order Nos.", xRec."No.", 0D, "No.", SalesReceivablesSetup."Gudfood Order Nos.");
        end;
        if "Posting No." = '' then begin
            SalesReceivablesSetup.Get();
            SalesReceivablesSetup.TESTFIELD("Posted Gudfood Order Nos.");
            NoSeriesMgt.InitSeries(SalesReceivablesSetup."Posted Gudfood Order Nos.", xRec."Posting No.", 0D, "Posting No.", SalesReceivablesSetup."Posted Gudfood Order Nos.");
        end;
        "Date Created" := Today;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        GudfoodOrderLine: Record 51503;
    begin
        GudfoodOrderLine.SetFilter("Order No.", '=%1', "No.");
        if not GudfoodOrderLine.FindSet() then
            exit;
        repeat
            GudfoodOrderLine.Delete(true);
        until GudfoodOrderLine.Next() = 0;
    end;

    trigger OnRename()
    begin

    end;

    procedure AssistEditNo(): Boolean
    begin
        SalesReceivablesSetup.Get();
        SalesReceivablesSetup.TestField("Gudfood Order Nos.");
        if NoSeriesMgt.SelectSeries(SalesReceivablesSetup."Gudfood Order Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;

    procedure AssistEditPostingNo(): Boolean
    begin
        SalesReceivablesSetup.Get();
        SalesReceivablesSetup.TestField("Posted Gudfood Order Nos.");
        if NoSeriesMgt.SelectSeries(SalesReceivablesSetup."Posted Gudfood Order Nos.", xRec."Posting No.", "Posting No.") THEN BEGIN
            NoSeriesMgt.SetSeries("Posting No.");
            exit(true);
        end;
    end;


    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "No." <> '' then
            Modify();

        if OldDimSetID <> "Dimension Set ID" then begin
            Modify();
            if OrderLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        END;
    end;


    procedure OrderLinesExist(): Boolean
    var
        GudfoodOrderLine: Record 51503;
    begin
        GudfoodOrderLine.SetRange("Order No.", "No.");
        exit(not GudfoodOrderLine.IsEmpty());
    end;


    procedure UpdateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
        IsHandled: Boolean;
        GudfoodOrderLine: Record 51503;
        DimensionChange: TextConst ENU = 'You may have changed a dimension.\\Do you want to update the lines?',
                                   RUS = 'Вы, возможно, изменили измерение. Обновить запись?';

    begin
        IsHandled := false;
        if IsHandled then
            exit;
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not GuiAllowed then
            if not Confirm(DimensionChange) then
                exit;

        GudfoodOrderLine.SetRange("Order No.", "No.");
        GudfoodOrderLine.LockTable();
        if GudfoodOrderLine.find('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(GudfoodOrderLine."Dimension Set ID", NewParentDimSetID, OldParentDimSetID);
                if GudfoodOrderLine."Dimension Set ID" <> NewDimSetID then begin
                    GudfoodOrderLine."Dimension Set ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                      GudfoodOrderLine."Dimension Set ID", GudfoodOrderLine."Shortcut Dimension 1 Code", GudfoodOrderLine."Shortcut Dimension 2 Code");
                    GudfoodOrderLine.MODIFY;
                end;
            until GudfoodOrderLine.Next() = 0;
    end;


    procedure ShowDocDim()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1', "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        if OldDimSetID <> "Dimension Set ID" then begin
            MODIFY;
            if OrderLinesExist then
                UpdateAllLineDim("Dimension Set ID", OldDimSetID);
        end;
    end;
}