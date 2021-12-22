page 51504 "Gudfood Picture ReadOnly"
{
    ApplicationArea = All;
    Caption = 'Gudfood Picture';
    PageType = CardPart;
    SourceTable = "Gudfood Item";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the picture of the item.';
            }
        }
    }
    actions
    {
    }
}
