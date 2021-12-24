codeunit 51500 Gudfood
{
    trigger OnRun()
    begin
    end;

    procedure RunOrder(GudfoodOrderHeader: Record "Gudfood Order Header")
    var
        GudfoodOrder: Report "Gudfood Order";
    begin
        GudfoodOrderHeader.SetRecFilter();
        GudfoodOrder.SetTableView(GudfoodOrderHeader);
        GudfoodOrder.Run();
    end;

    procedure DeleteGudfoodOrderHeader(VAR GudfoodOrderHeader: Record "Gudfood Order Header")
    var
        UnableToDeleteErr: Label 'Can not delete this order header.';
    begin
        if not GudfoodOrderHeader.Delete(true) then
            Message(UnableToDeleteErr);
    end;

    procedure AddPostedGudfoodOrderHeader(GudfoodOrderHeader: Record "Gudfood Order Header")
    var
        PostedGudfoodOrderHeader: Record "Posted Gudfood Order Header";
        GudfoodOrderLine: Record "Gudfood Order Line";
        UnableToInsertErr: Label 'Can not insert this header of order.';
    begin
        PostedGudfoodOrderHeader.Init();
        PostedGudfoodOrderHeader.TransferFields(GudfoodOrderHeader);
        PostedGudfoodOrderHeader."Posting Date" := TODAY();
        PostedGudfoodOrderHeader."No." := GudfoodOrderHeader."Posting No.";
        if not PostedGudfoodOrderHeader.INSERT() then begin
            Message(UnableToInsertErr);
            exit;
        END;
        GudfoodOrderLine.SetRange("Order No.", GudfoodOrderHeader."No.");
        if GudfoodOrderLine.FindSet() then
            repeat
                AddPostedGudfoodOrderLine(GudfoodOrderLine);
            until GudfoodOrderLine.Next() = 0;
    end;

    procedure AddPostedGudfoodOrderLine(GudfoodOrderLine: Record "Gudfood Order Line")
    var
        PostedGudfoodOrderLine: Record "Posted Gudfood Order Line";
        UnableToInsertErr: Label 'Can not insert this line of order.';
    begin
        PostedGudfoodOrderLine.INIT();
        PostedGudfoodOrderLine.TRANSFERFIELDS(GudfoodOrderLine);
        if not PostedGudfoodOrderLine.Insert(true) then
            message(UnableToInsertErr);
    end;

    procedure RunXmlPort(GudfoodOrderHeader: Record "Gudfood Order Header")
    var
        GudfoodOrderLine: Record "Gudfood Order Line";
        ExportGudfoodOrder: XmlPort "Export Gudfood Order";
    begin
        GudfoodOrderLine.Reset();
        GudfoodOrderLine.SetRange("Order No.", GudfoodOrderHeader."No.");
        ExportGudfoodOrder.SetTableView(GudfoodOrderHeader);
        ExportGudfoodOrder.SetTableView(GudfoodOrderLine);
        ExportGudfoodOrder.Run();
    end;
}
