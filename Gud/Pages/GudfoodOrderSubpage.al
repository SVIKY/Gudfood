page 51505 "Gudfood Order Subpage"
{

    Caption = 'Gudfood Order Subpage';
    PageType = ListPart;
    SourceTable = "Gudfood Order Line";
    Editable = true;
    //  DelayInsert = true;
    MultipleNewLines = true;
    AutoSplitKey = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the item code.';
                    ApplicationArea = All;
                    ShowMandatory = true;

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

}
