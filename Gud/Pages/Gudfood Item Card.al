page 51502 "Gudfood Item Card"
{
    ApplicationArea = All;
    Caption = 'Gudfood Item Card';
    PageType = Card;
    SourceTable = "Gudfood Item";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the item.';
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
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
                field("Shelf Life"; Rec."Shelf Life")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the shelf life of item.';
                }
            }
            group(Order)
            {
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
            }
        }

        area(FactBoxes)
        {
            part("Item Picture"; "Gudfood Picture")
            {
                ApplicationArea = All;
                SubPageLink = Code = field(Code);
            }
        }
    }

}
