codeunit 51503 GudfoodOrderLine
{
    TableNo = "Gudfood Order Line";

    trigger OnRun()
    begin
        AddPostedGudfoodOrderLine(Rec);
    end;

    local procedure AddPostedGudfoodOrderLine(GudfoodOrderLine: Record "Gudfood Order Line")
    var
        PostedGudfoodOrderLine: Record 51504;
        ErrorUnableToInsert: Label 'Can not insert this line of order.';
    begin
        PostedGudfoodOrderLine.INIT;
        PostedGudfoodOrderLine.TRANSFERFIELDS(GudfoodOrderLine);
        if not PostedGudfoodOrderLine.Insert(true) then
            message(ErrorUnableToInsert);
    end;


}
