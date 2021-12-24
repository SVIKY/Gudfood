page 51509 "Gudfood Orders List"
{
    Caption = 'Gudfood Orders List';
    PageType = ListPlus;
    SourceTable = "Gudfood Order Header";
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Post,Print,Export,Dimensions';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Gudfood Order";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Sell- to Customer No."; Rec."Sell- to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell- to Customer No. field.';
                    ApplicationArea = All;
                }
                field("Sell- to Customer Name"; Rec."Sell- to Customer Name")
                {
                    ToolTip = 'Specifies the value of the Sell- to Customer Name field.';
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the value of the Order Date field.';
                    ApplicationArea = All;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ToolTip = 'Specifies the value of the Posting No. field.';
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ToolTip = 'Specifies the value of the Date Created field.';
                    ApplicationArea = All;
                }
                field("Total Qty"; Rec."Total Qty")
                {
                    ToolTip = 'Specifies the value of the Total Qty field.';
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part("Order Lines"; "Gudfood Order Subpage ReadOnly")
            {
                ApplicationArea = All;
                SubPageLink = "Order No." = field("No.");
                Editable = false;
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Post")
            {
                ToolTip = 'Post record.';
                ApplicationArea = All;
                Caption = 'Post';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                Enabled = isPostingActive;
                trigger OnAction()
                var
                    GudfoodCodeUnit: Codeunit Gudfood;
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    GudfoodCodeUnit.AddPostedGudfoodOrderHeader(Rec);
                    GudfoodCodeUnit.DeleteGudfoodOrderHeader(Rec);
                    Rec.Reset();
                    Page.Run(51501);
                end;
            }

            action("Print")
            {
                ToolTip = 'Print record.';
                ApplicationArea = All;
                Caption = 'Print';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    Codeunit.Run(51500);
                end;
            }
            action("Print All Orders")
            {
                ToolTip = 'Print all orders.';
                ApplicationArea = All;
                Caption = 'Print all orders';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                RunObject = report "Gudfood Each Customer Order";
            }

            action("Print All Orders Lines")
            {
                ToolTip = 'Print all orders lines.';
                ApplicationArea = All;
                Caption = 'Print all orders lines';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                RunObject = report "Gudfood All Report";
            }

            action("ExportOrder")
            {
                ToolTip = 'Export orders.';
                ApplicationArea = All;
                Caption = 'Export order';
                Image = XMLFile;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    GudfoodCodeUnit: Codeunit Gudfood;
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    GudfoodCodeUnit.RunXmlPort(Rec);
                    Rec.Reset();
                end;
            }

            action("ExportAllOrder")
            {
                ToolTip = 'Export all Orders.';
                ApplicationArea = All;
                Caption = 'Export all orders';
                Image = XMLFile;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                RunObject = xmlport "Export Gudfood Order";
            }

            action("Dimensions")
            {
                ToolTip = 'Dimensions.';
                ApplicationArea = All;
                Caption = 'Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;
                trigger OnAction()
                begin
                    ShowDocDim();
                    CurrPage.SAVERECORD();
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Page.Run(51509);
    end;

    trigger OnAfterGetRecord()
    begin
        CheckPostingActive();
    end;

    var
        isPostingActive: Boolean;

    local procedure CheckPostingActive()
    var
        GudfoodOrderLine: Record 51503;
    begin
        GudfoodOrderLine.SetRange("Order No.", "No.");
        isPostingActive := Not GudfoodOrderLine.IsEmpty();
    end;
}
