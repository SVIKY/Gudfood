codeunit 51501 GudfoodOrderXmlPort
{
    TableNo = "Gudfood Order Header";

    trigger OnRun()
    begin
        RunXmlPort(Rec);
    end;

    local procedure RunXmlPort(GudfoodOrderHeader: Record "Gudfood Order Header")
    var
        GudfoodOrderXml: XmlPort 51500;
        GudfoodOrderLine: Record 51503;
    begin
        GudfoodOrderLine.Reset();
        GudfoodOrderLine.SetRange("Order No.", GudfoodOrderHeader."No.");
        GudfoodOrderXml.SetTableView(GudfoodOrderHeader);
        GudfoodOrderXml.SetTableView(GudfoodOrderLine);
        GudfoodOrderXml.Run();
    end;
}
