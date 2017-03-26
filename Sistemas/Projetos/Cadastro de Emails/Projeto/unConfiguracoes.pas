unit unConfiguracoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExeInfo, frmshape, FolderDialog, StdCtrls, Buttons,
  plsEdit, ExtCtrls, IniFiles;

type
  TfrmConfiguracoes = class(TForm)
    grpBxBancoDados: TGroupBox;
    OpenDialog: TOpenDialog;
    lblInfCaminhoBD: TLabel;
    lblCaminhoBD: TLabel;
    pnlBotoes: TPanel;
    btBtnSalvar: TBitBtn;
    procedure lblInfCaminhoBDClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnSalvarClick(Sender: TObject);
  private
    oIniConf: TIniFile;//arquivo .INI
    procedure CarregarConfiguracoes;
    function VerificarCamposObrigatorios: boolean;
    procedure AlterarBD;
  public
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

uses unConstantes, unIniciarConiguracoes;

{$R *.dfm}

procedure TfrmConfiguracoes.CarregarConfiguracoes;
begin
  //abrindo arquivo .INI
  if (FileExists(ExtractFilePath(ParamStr(0))+ sARQUIVO_INI_CONFIGURACOES)) then //pega diretório do executável + arquivo .INI
  begin
    oIniConf := TIniFile.Create(ExtractFilePath(ParamStr(0))+ sARQUIVO_INI_CONFIGURACOES);
    lblCaminhoBD.Caption := oIniConf.ReadString('BD','path','');
    oIniConf.Free;
  end
  else
    MessageDlg('Arquivo de Configurações não encontrado.',mtInformation,[mbOK],0);
end;

function TfrmConfiguracoes.VerificarCamposObrigatorios: boolean;
var
  sCampos: String;
  bRetorno: Boolean;
begin
  bRetorno := True;
  sCampos := STRING_INDEFINIDO;
  if (Trim(lblCaminhoBD.Caption) = STRING_INDEFINIDO)then
  begin
    sCampos := 'Caminho BD';
    bRetorno := False;
  end;

  if(sCampos <> STRING_INDEFINIDO)then
    MessageDlg('Verifique os campos: ' + sCampos, mtInformation, [mbOK], 0);

  Result := bRetorno;
end;

procedure TfrmConfiguracoes.lblInfCaminhoBDClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    lblCaminhoBD.Caption := OpenDialog.FileName;
end;

procedure TfrmConfiguracoes.FormShow(Sender: TObject);
begin
  CarregarConfiguracoes;
end;

procedure TfrmConfiguracoes.btBtnSalvarClick(Sender: TObject);
begin
  if VerificarCamposObrigatorios then
  begin
    try
      //abrindo arquivo .INI
      if (FileExists(ExtractFilePath(ParamStr(0))+ sARQUIVO_INI_CONFIGURACOES)) then //pega diretório do executável + arquivo .INI
      begin
        oIniConf := TIniFile.Create(ExtractFilePath(ParamStr(0))+ sARQUIVO_INI_CONFIGURACOES);
        oIniConf.WriteString('BD','path',lblCaminhoBD.Caption);
        oIniConf.Free;
        AlterarBD;
      end
      else
        MessageDlg('Arquivo de Configurações não encontrado.',mtInformation,[mbOK],0);
    except
      MessageDlg('Ocorreu um erro ao atualizar as configurações.',mtWarning,[mbOK],0);
    end;
  end;
end;

procedure TfrmConfiguracoes.AlterarBD;
var
  oConf: TIniciarConfiguracoes;
begin
  oConf := TIniciarConfiguracoes.Create;
  try
    if not oConf.ConfigurarBD then
    begin
      oConf.Destroy;
      MessageDlg('Ocorreu um erro ao alterar o BD.',mtWarning,[mbOK],0);
    end;
  finally
    oConf.Destroy;
  end;
end;

end.
