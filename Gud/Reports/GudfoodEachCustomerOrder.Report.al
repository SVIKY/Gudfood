report 51501 "Gudfood Each Customer Order"
{
    Caption = 'Gudfood Each Customer Order';
    RDLCLayout = '.\Gud\Reports\gudfoodEachCustomerReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(GudfoodOrderHeader; "Gudfood Order Header")
        {
            column(No; "No.")
            {
                IncludeCaption = true;
            }
            column(SelltoCustomerNo; "Sell- to Customer No.")
            {
                IncludeCaption = true;
            }
            column(SelltoCustomerName; "Sell- to Customer Name")
            {
                IncludeCaption = true;
            }
            column(DateCreated; "Date Created")
            {
                IncludeCaption = true;
            }
            column(TotalAmount; "Total Amount")
            {
                IncludeCaption = true;
            }
            dataitem(GudfoodOrderLine; "Gudfood Order Line")
            {
                DataItemLink = "Order No." = field("No.");
                column(ItemNo; "Item No.")
                {
                    IncludeCaption = true;
                }
                column(ItemType; "Item Type")
                {
                    IncludeCaption = true;
                }
                column(Description; Description)
                {
                    IncludeCaption = true;
                }

                column(Quantity; Quantity)
                {
                    IncludeCaption = true;
                }
                column(UnitPrice; "Unit Price")
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
    }

}
