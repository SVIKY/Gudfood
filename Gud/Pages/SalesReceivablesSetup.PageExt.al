pageextension 51520 "Sales&ReceivablesSetup" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Gudfood Items Nos."; Rec."Gudfood Items Nos.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code for the number series that will be used to assign numbers to gudfood items.';
            }

            field("Gudfood Order Nos."; Rec."Gudfood Order Nos.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code for the number series that will be used to assign numbers to gudfood orders.';
            }

            field("Posted Gudfood Order Nos."; Rec."Posted Gudfood Order Nos.")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the code for the number series that will be used to assign numbers to posted gudfood orders.';
            }
        }
    }
    actions
    {
    }
}