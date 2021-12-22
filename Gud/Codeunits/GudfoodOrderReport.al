codeunit 51500 GudfoodOrderReport
{
    TableNo = "Gudfood Order Header";

    trigger OnRun()
    begin
        RunOrder(Rec);
    end;

    local procedure RunOrder(GudfoodOrderHeader: Record "Gudfood Order Header")
    var
        GudfoodOrder: Report 51500;
        GudfoodOrderLine: Record 51503;
    begin
        GudfoodOrderLine.Reset();
        GudfoodOrderLine.SetRange("Order No.", GudfoodOrderHeader."No.");
        GudfoodOrder.SetTableView(GudfoodOrderHeader);
        GudfoodOrder.SetTableView(GudfoodOrderLine);
        GudfoodOrder.Run();
    end;
}
