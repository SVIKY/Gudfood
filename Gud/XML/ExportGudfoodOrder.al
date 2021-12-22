xmlport 51500 "Export Gudfood Order"
{
    Caption = 'Export Gudfood Order';
    Direction = Export;
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(GudfoodOrderHeader; "Gudfood Order Header")
            {
                fieldelement(No; GudfoodOrderHeader."No.")
                {
                }
                textelement(Customer)
                {
                    fieldelement(SelltoCustomerNo; GudfoodOrderHeader."Sell- to Customer No.")
                    {
                    }
                    fieldelement(SelltoCustomerName; GudfoodOrderHeader."Sell- to Customer Name")
                    {
                    }
                }

                fieldelement(OrderDate; GudfoodOrderHeader."Order Date")
                {
                }
                fieldelement(PostingNo; GudfoodOrderHeader."Posting No.")
                {
                }
                fieldelement(DateCreated; GudfoodOrderHeader."Date Created")
                {
                }
                fieldelement(TotalQty; GudfoodOrderHeader."Total Qty")
                {
                }
                fieldelement(TotalAmount; GudfoodOrderHeader."Total Amount")
                {
                }

                textelement(Orderlines)
                {
                    tableelement(GudfoodOrderLine; "Gudfood Order Line")
                    {
                        LinkTable = GudfoodOrderHeader;
                        LinkFields = "Order No." = field("No.");
                        MinOccurs = Zero;
                    }
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
}
