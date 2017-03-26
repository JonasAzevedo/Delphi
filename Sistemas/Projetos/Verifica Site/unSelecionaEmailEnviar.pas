unit unSelecionaEmailEnviar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls;

type
  TfrmSelecionaEmailEnviar = class(TForm)
    Panel1: TPanel;
    dbGrdEmails: TDBGrid;
    lblSite: TLabel;
    procedure FormShow(Sender: TObject);
    procedure dbGrdEmailsDblClick(Sender: TObject);
  private

  public
    codSite: Integer;
    nomeSite: String;
  end;

var
  frmSelecionaEmailEnviar: TfrmSelecionaEmailEnviar;

implementation

uses unDM;

{$R *.dfm}

procedure TfrmSelecionaEmailEnviar.FormShow(Sender: TObject);
begin
  lblSite.Caption := nomeSite;
end;

procedure TfrmSelecionaEmailEnviar.dbGrdEmailsDblClick(Sender: TObject);
begin
  if(MessageDlg('Deseja Enviar E-Mail para ' + DM.zQryEnviaEmailEMAIL_PARA.AsString + #13 + ' do site ' + nomeSite + ' ?',
     mtConfirmation,[mbYes,mbNo],0)=mrYes)then
       begin
       try
         DM.ZConnection.StartTransaction;
         DM.zQryEnviaEmailSite.Close;
         DM.zQryEnviaEmailSite.SQL.Clear;
         DM.zQryEnviaEmailSite.SQL.Add('INSERT INTO Envia_Email_Site(cod_site,cod_envia_email)VALUES(:coSi,:coEn)');
         DM.zQryEnviaEmailSite.ParamByName('coSi').AsInteger := Self.codSite;
         DM.zQryEnviaEmailSite.ParamByName('coEn').AsInteger := DM.zQryEnviaEmailCODIGO.AsInteger;
         DM.zQryEnviaEmailSite.ExecSQL;
         DM.ZConnection.Commit;
       except
         DM.ZConnection.Rollback;
         MessageDlg('E-Mail para ' + DM.zQryEnviaEmailEMAIL_PARA.AsString + 'não pode ser atribuído ao site ' + nomeSite,
                     mtInformation,[mbOK],0);
       end;
       end;
end;

end.
