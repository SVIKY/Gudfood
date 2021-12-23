page 51509 "Gudfood Orders List"
{
    Caption = 'Gudfood Orders List';
    PageType = ListPlus;
    SourceTable = "Gudfood Order Header";
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Post,Print,Export,Dimensions';
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = 51501;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                CaptionML = ENU = 'General',
                            RUS = 'Общие';
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
                ApplicationArea = All;
                Caption = 'Post';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;
                RunObject = codeunit 51502;
                Enabled = isPostingActive;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    Page.Run(51501);
                end;
            }

            action("Print")
            {
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
                ApplicationArea = All;
                Caption = 'Print all orders';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                RunObject = report 51501;
            }

            action("Print All Orders Lines")
            {
                ApplicationArea = All;
                Caption = 'Print all orders lines';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category5;
                RunObject = report 51502;
            }

            action("ExportOrder")
            {
                ApplicationArea = All;
                Caption = 'Export order';
                Image = XMLFile;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    Codeunit.Run(51501);
                end;
            }

            action("ExportAllOrder")
            {
                ApplicationArea = All;
                Caption = 'Export all orders';
                Image = XMLFile;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                RunObject = xmlport 51500;
            }

            action("Dimensions")
            {
                ApplicationArea = All;
                Caption = 'Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category7;
                trigger OnAction()
                begin
                    ShowDocDim;
                    CurrPage.SAVERECORD;
                end;
            }
        }
    }

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
        GudfoodOrderLine.SetFilter("Order No.", '=%1', "No.");
        isPostingActive := GudfoodOrderLine.FindFirst();
    end;
}
