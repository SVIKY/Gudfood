report 51502 "Gudfood All Report"
{
    Caption = 'Gudfood All Report';
    RDLCLayout = '.\Gud\Reports\gudfoodAllReport.rdl';
    DefaultLayout = RDLC;
    dataset
    {
        dataitem(GudfoodItem; "Gudfood Item")
        {
            column(Code; "Code")
            {
                IncludeCaption = true;
            }
            column(Description; Description)
            {
                IncludeCaption = true;
            }
            column(UnitPrice; "Unit Price")
            {
                IncludeCaption = true;
            }
            column(Type; "Type")
            {
                IncludeCaption = true;
            }
            dataitem(GudfoodOrderLine; "Gudfood Order Line")
            {
                DataItemLink = "Item No." = field(Code);

                column(Quantity; Quantity)
                {
                    IncludeCaption = true;
                }

                column(Amount; Amount)
                {
                    IncludeCaption = true;
                }
            }
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }

    labels
    {
        UserId = 'User ID';
        TotalSum = 'Total sum';
    }
}
