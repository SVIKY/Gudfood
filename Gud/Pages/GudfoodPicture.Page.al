page 51503 "Gudfood Picture"
{
    ApplicationArea = All;
    Caption = 'Gudfood Picture';
    PageType = CardPart;
    SourceTable = "Gudfood Item";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the picture of the item.';
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Import Picture")
            {
                ApplicationArea = All;
                Caption = 'Import picture';
                Image = Import;
                Promoted = false;
                ToolTip = 'Import a picture of an item.';
                Enabled = DeleteExportEnabled;
                trigger OnAction()
                var
                    FileManagement: Codeunit 419;
                    FileName: Text;
                    ClientFileName: Text;
                    OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
                    SelectPictureTxt: Label 'Select a picture to upload';
                begin
                    Rec.TestField(Rec.Code);
                    if Rec.Picture.HASVALUE then
                        if NOT CONFIRM(OverrideImageQst) then
                            Exit;

                    FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
                    if FileName = '' then
                        EXIT;
                    Clear(Rec.Picture);
                    Rec.Picture.ImportFile(FileName, ClientFileName);
                    if not Rec.Modify(true) then
                        rec.Insert(true);
                    if FileManagement.DeleteServerFile(FileName) then;
                end;
            }

            action("Export File")
            {
                ApplicationArea = All;
                Caption = 'Export file';
                Image = Export;
                Promoted = false;
                Enabled = DeleteExportEnabled;
                ToolTip = 'Export a picture of an item.';
                trigger OnAction()
                var
                    DummyPictureEntity: Record 5468;
                    FileManagement: Codeunit 419;
                    ToFile: Text;
                    ExportPath: Text;
                begin
                    Rec.TestField(Rec.Code);
                    Rec.TestField(Rec.Type);
                    ToFile := DummyPictureEntity.GetDefaultMediaDescription(Rec);
                    ExportPath := TemporaryPath + Code + Format(Picture.MEDIAID);
                    Picture.ExportFile(ExportPath);
                    FileManagement.ExportImage(ExportPath, ToFile);
                end;
            }

            action("Delete Picture")
            {
                ApplicationArea = All;
                Caption = 'Delete picture';
                Image = Delete;
                Promoted = false;
                ToolTip = 'Delete a picture of an item.';
                trigger OnAction()
                var
                    DeleteImageQst: Label 'Are you sure you want to delete the picture?';
                begin
                    Rec.TestField(Code);
                    if not Confirm(DeleteImageQst) then
                        exit;
                    Clear(Rec.Picture);
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetEditableOnPictureActions();
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Picture.HASVALUE;
    end;

    var
        DeleteExportEnabled: Boolean;


}
