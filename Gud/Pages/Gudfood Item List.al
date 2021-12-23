page 51500 "Gudfood Item List"
{

    ApplicationArea = All;
    Caption = 'Gudfood Item List';
    PageType = List;
    SourceTable = "Gudfood Item";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                CaptionML = ENU = 'General',
                            RUS = 'Общие';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the item.';
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of the item.';
                }
                field("Unit price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price of the item.';
                }
                field("Type"; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the item.';
                }
                field("Quantity ordered"; Rec."Qty. Ordered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of already ordered items.';
                }
                field("Quantity in order"; Rec."Qty. in Order")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity of items that are in customers order lists.';
                }
                field("Shelf Life"; Rec."Shelf Life")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shelf life of item.';
                }
            }
        }

        area(FactBoxes)
        {
            part("Item Picture"; "Gudfood Picture ReadOnly")
            {
                ApplicationArea = All;
                SubPageLink = Code = field(Code);
            }
        }
    }

}
