unit unRegistrarSistema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, plsEdit, unFuncoes;

type
  TfrmRegistroSistema = class(TForm)
    lblCodigo: TLabel;
    lblChave: TLabel;
    lblInfo1: TLabel;
    lblInfoContato1: TLabel;
    bvlDivisao: TBevel;
    Image: TImage;
    btBtnRegistrar: TBitBtn;
    lblInfoContato2: TLabel;
    lblInfoContato0: TLabel;
    plsEdCodigo: TPlsEdit;
    plsEdChave: TPlsEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnRegistrarClick(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
  public
  end;

implementation

uses
  unConstantes, unDM;

{$R *.dfm}

procedure TfrmRegistroSistema.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
end;

procedure TfrmRegistroSistema.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmRegistroSistema.FormShow(Sender: TObject);
var
  sSerie: String;
begin
  sSerie := FoFuncoes.GetSerialNum(sDRIVER_C);
  plsEdCodigo.Text := FoFuncoes.GetSerieFormatada(sSerie);

  plsEdChave.Clear;
  plsEdChave.SetFocus;
end;

procedure TfrmRegistroSistema.btBtnRegistrarClick(Sender: TObject);
begin
  if (FoFuncoes.VerificarChaveValida(plsEdCodigo.Text,plsEdChave.Text))then
  begin
    //gravando chave de valida��o
    try
      DM.ZConnection.StartTransaction;
      DM.zQryParametrosSistema.Close;
      DM.zQryParametrosSistema.SQL.Clear;
      DM.zQryParametrosSistema.SQL.Add('UPDATE parametros_sistema SET serial=:serial,chave=:chave WHERE codigo=:codigo');
      DM.zQryParametrosSistema.ParamByName('serial').AsString := plsEdCodigo.Text;
      DM.zQryParametrosSistema.ParamByName('chave').AsString := plsEdChave.Text;
      DM.zQryParametrosSistema.ParamByName('codigo').AsInteger := 1;
      DM.zQryParametrosSistema.ExecSQL;
      DM.ZConnection.Commit;
      MessageDlg('Sistema licenciado com sucesso.'+#13+'Reinicie o sistema.',mtInformation,[mbOK],0);
      Application.Terminate;
    except
      DM.ZConnection.Rollback;
      MessageDlg('Erro ao gravar chave de valida��o do sistema.', mtInformation, [mbOK], 0);
    end;
  end
  else
    MessageDlg('Chave incorreta.',mtInformation,[mbOk],0);
end;

end.
