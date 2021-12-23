codeunit 51502 GudfoodOrderHeader
{
    TableNo = "Gudfood Order Header";

    trigger OnRun()
    begin
        AddPostedGudfoodOrderHeader(Rec);
        DeleteGudfoodOrderHeader(Rec);
    end;

    local procedure DeleteGudfoodOrderHeader(VAR GudfoodOrderHeader: Record "Gudfood Order Header")
    var
        ErrorUnableToDelete: Label 'Can not delete this order header.';
    begin
        if not GudfoodOrderHeader.Delete(true) then
            Message(ErrorUnableToDelete);
    end;

    local procedure AddPostedGudfoodOrderHeader(GudfoodOrderHeader: Record "Gudfood Order Header")
    var
        PostedGudfoodOrderHeader: Record 51501;
        GudfoodOrderLine: Record 51503;
        ErrorUnableToInsert: Label 'Can not insert this header of order.';
    begin
        PostedGudfoodOrderHeader.Init();
        ;
        PostedGudfoodOrderHeader.TransferFields(GudfoodOrderHeader);
        PostedGudfoodOrderHeader."Posting Date" := TODAY();
        if not PostedGudfoodOrderHeader.INSERT() then begin
            Message(ErrorUnableToInsert);
            exit;
        END;
        GudfoodOrderLine.SetRange("Order No.", GudfoodOrderHeader."No.");
        if GudfoodOrderLine.FindSet() then begin
            repeat
                Codeunit.Run(51503, GudfoodOrderLine);
            until GudfoodOrderLine.Next() = 0;
        end;
    end;
}
