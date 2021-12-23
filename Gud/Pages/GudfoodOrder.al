page 51501 "Gudfood Order"
{

    Caption = 'Gudfood Order';
    PageType = Document;
    SourceTable = "Gudfood Order Header";
    PromotedActionCategories = 'New,Process,Report,Post,Print,Export,Dimensions';
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                CaptionML = ENU = 'General',
                            RUS = 'Общие';
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if AssistEditNo then
                            CurrPage.Update();
                    end;
                }
                field("Sell- to Customer No."; Rec."Sell- to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell- to Customer No. field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
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
                    ShowMandatory = true;
                }
                field("Posting No."; Rec."Posting No.")
                {
                    ToolTip = 'Specifies the value of the Posting No. field.';
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        if AssistEditNo then
                            CurrPage.Update();
                    end;
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
            group(Lines)
            {
                Caption = 'Order lines';
                part("Order Lines"; "Gudfood Order Subpage")
                {
                    ApplicationArea = All;
                    SubPageLink = "Order No." = field("No.");
                    UpdatePropagation = Both;
                    Editable = true;
                }
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
                RunObject = codeunit 51500;
            }

            action("ExportOrder")
            {
                ApplicationArea = All;
                Caption = 'ExportOrder';
                Image = XMLFile;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                RunObject = codeunit 51501;
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

    var
        isPostingActive: Boolean;

    trigger OnDeleteRecord(): Boolean
    begin
        Page.Run(51501);
    end;

    trigger OnAfterGetRecord()
    begin
        CheckPostingActive();
    end;

    local procedure CheckPostingActive()
    var
        GudfoodOrderLine: Record 51503;
    begin
        GudfoodOrderLine.SetFilter("Order No.", '=%1', "No.");
        isPostingActive := GudfoodOrderLine.FindFirst();
    end;
}
