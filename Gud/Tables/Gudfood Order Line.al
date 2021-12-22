table 51503 "Gudfood Order Line"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gudfood Order Header";
            trigger OnValidate()
            var
                GudfoodOrderHeader: Record 51502;
                ErrorOrderNotExists: TextConst ENU = 'No such order stored.',
                                   RUS = 'Такого заказа нет в базе данных';
            begin
                if "Order No." = '' then begin
                    Rec."Order No." := xRec."Order No.";
                    exit;
                end;
                if GudfoodOrderHeader.Get("Order No.") then begin
                    "Sell- to Customer No." := GudfoodOrderHeader."Sell- to Customer No.";
                    "Date Created" := GudfoodOrderHeader."Date Created";
                    "Shortcut Dimension 1 Code" := GudfoodOrderHeader."Shortcut Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := GudfoodOrderHeader."Shortcut Dimension 2 Code";
                    "Dimension Set ID" := GudfoodOrderHeader."Dimension Set ID";
                end else begin
                    Message(ErrorOrderNotExists);
                    Rec."Order No." := xRec."Order No.";
                END;
                Amount := Quantity * "Unit Price";
            end;
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
            trigger OnValidate()
            var
                "Gudfood Item": Record 51500;
                ErrorItemNotExists: TextConst ENU = 'No such item stored.',
                                   RUS = 'Такого продукта нет в базе данных';
            begin
                if "Gudfood Item".GET("Item No.") then begin
                    Description := "Gudfood Item".Description;
                    "Unit Price" := "Gudfood Item"."Unit Price";
                    "Item Type" := "Gudfood Item".Type;
                    if "Gudfood Item"."Shelf Life" < Today then
                        MESSAGE(ErrorItemNotExists);
                end
                else begin
                    Message(ErrorItemNotExists);
                    Rec."Item No." := xRec."Item No.";
                end;
                Amount := Quantity * "Unit Price";
            end;
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
            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Price";
            end;
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
        key(Key1; "Order No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        DimMgt: Codeunit 408;

    trigger OnInsert()
    var
        GudfoodOrderHeader: Record 51502;
        ErrorOrderNotExists: TextConst ENU = 'No such order stored.',
                                   RUS = 'Такого заказа нет в базе данных';
    begin
        if "Order No." = '' then begin
            Rec."Order No." := xRec."Order No.";
            exit;
        end;
        if GudfoodOrderHeader.Get("Order No.") then begin
            "Sell- to Customer No." := GudfoodOrderHeader."Sell- to Customer No.";
            "Date Created" := GudfoodOrderHeader."Date Created";
            "Shortcut Dimension 1 Code" := GudfoodOrderHeader."Shortcut Dimension 1 Code";
            "Shortcut Dimension 2 Code" := GudfoodOrderHeader."Shortcut Dimension 2 Code";
            "Dimension Set ID" := GudfoodOrderHeader."Dimension Set ID";
        end else begin
            Message(ErrorOrderNotExists);
            Rec."Order No." := xRec."Order No.";
        END;
        Amount := Quantity * "Unit Price";
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