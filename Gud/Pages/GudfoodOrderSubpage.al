page 51505 "Gudfood Order Subpage"
{

    Caption = 'Gudfood Order Subpage';
    PageType = ListPart;
    SourceTable = "Gudfood Order Line";
    Editable = true;
    DelayedInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                CaptionML = ENU = 'General',
                            RUS = 'Общие';
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the item code.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Item Type"; Rec."Item Type")
                {
                    ToolTip = 'Specifies the item type.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the item description.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of item that wil be ordered.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price of item.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the cost of specified number of items.';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {

    }
}
