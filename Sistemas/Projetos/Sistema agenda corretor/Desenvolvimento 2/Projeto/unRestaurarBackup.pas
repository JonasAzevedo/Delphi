unit unRestaurarBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids,
  DBGrids, DBClient, Provider, unFuncoes, StdCtrls, Buttons, ExtCtrls;

type
  TfrmRestaurarBackup = class(TForm)
    dbGrdBackups: TDBGrid;
    zQryBackup: TZQuery;
    zQryBackupCODIGO: TIntegerField;
    zQryBackupDATA: TDateTimeField;
    zQryBackupPATH_BACKUP: TStringField;
    zQryBackupATIVO: TStringField;
    dspBackup: TDataSetProvider;
    cdsBackup: TClientDataSet;
    dsBackup: TDataSource;
    cdsBackupCODIGO: TIntegerField;
    cdsBackupDATA: TDateTimeField;
    cdsBackupPATH_BACKUP: TStringField;
    cdsBackupATIVO: TStringField;
    pnlOpcoes: TPanel;
    btBtnRestaurar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btBtnRestaurarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FoFuncoes: TFuncoes;
    procedure SelecionarTodosBackupAtivo;
  public
  end;

var
  frmRestaurarBackup: TfrmRestaurarBackup;

implementation

uses unDM, unConstantes, ShellAPI;

{$R *.dfm}

{ TfrmRestaurarBackup }

procedure TfrmRestaurarBackup.SelecionarTodosBackupAtivo;
begin
  cdsBackup.Close;
  zQryBackup.Close;
  zQryBackup.SQL.Clear;
  zQryBackup.SQL.Add('SELECT * FROM backup WHERE ativo='''+VLR_SIM+'''');
  zQryBackup.Open;
  cdsBackup.Open;
  if FoFuncoes.VerificarClientDataSetAtivo(cdsBackup)then
    btBtnRestaurar.Enabled := True
  else
    btBtnRestaurar.Enabled := False;
end;

procedure TfrmRestaurarBackup.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  SelecionarTodosBackupAtivo;
  FoFuncoes.AjustarLarguraColunasTDBGrid(dbGrdBackups);
end;

procedure TfrmRestaurarBackup.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmRestaurarBackup.btBtnRestaurarClick(Sender: TObject);
var
  sPathBD_Restaurado: String;
  sPathBD_Atual: String;

  function VerificarArquivosBancoDadosExistem: Boolean;
  begin
    if((FileExists(sPathBD_Atual))and(FileExists(sPathBD_Restaurado)))then
      Result := True
    else
      Result := False;
  end;

  function RenomearBancoDadosAtual: Boolean;
  var
    sNovoName:String;
    dDataHora: TDateTime;
    sDataHora: String;
  begin
    dDataHora := Now;
    sDataHora := DateTimeToStr(dDataHora);
    sDataHora := StringReplace(sDataHora, '/','.',[rfReplaceAll, rfIgnoreCase]);
    sDataHora := StringReplace(sDataHora, ' ','_',[rfReplaceAll, rfIgnoreCase]);
    sDataHora := StringReplace(sDataHora, ':','.',[rfReplaceAll, rfIgnoreCase]);
    sNovoName :=  ExtractFilePath(ParamStr(0)) + 'BD\BD_rest_'+sDataHora+'.FDB';
    //sNovoName := 'E:\Delphi\Sistemas\Meus Sistemas\Sistema agenda corretor\Desenvolvimento 2\BD\BD_rest_'+sDataHora+'.FDB';
    if RenameFile(sPathBD_Atual, sNovoName) then
      Result := True
    else
      Result := False;
  end;

  procedure CopiarBancoRestaurar(psPath:string);
  var
    Dados: TSHFileOpStruct;
    sDestino: String;
  begin
    //sDestino := 'E:\Delphi\Sistemas\Meus Sistemas\Sistema agenda corretor\Desenvolvimento 2\BD\BD.FDB';
    sDestino :=  ExtractFilePath(ParamStr(0)) + 'BD\BD.FDB';
    FillChar(Dados,SizeOf(Dados), 0);
    with Dados do
    begin
      wFunc := FO_COPY;
      pFrom := PChar(psPath);
      pTo   := PChar(sDestino);
      fFlags:= FOF_ALLOWUNDO;
    end;
    SHFileOperation(Dados);
  end;

begin
  if(MessageDlg('Tem certeza que deseja restaurar a base de dados?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
  begin
    DM.ZConnection.Connected := False;
    DM.ZConnection.Disconnect;

    sPathBD_Restaurado := cdsBackupPATH_BACKUP.AsString;
    //sPathBD_Atual := 'E:\Delphi\Sistemas\Meus Sistemas\Sistema agenda corretor\Desenvolvimento 2\BD\BD.FDB';
    sPathBD_Atual := ExtractFilePath(ParamStr(0)) + 'BD\BD.FDB';

    if VerificarArquivosBancoDadosExistem then
    begin
      if RenomearBancoDadosAtual then
      begin
        CopiarBancoRestaurar(cdsBackupPATH_BACKUP.AsString);
        MessageDlg('Sistema deve ser reiniciado para as alterações entrarem em vigor.',mtInformation,[mbOK],0);
        Application.Terminate;
      end;
    end
    else
      MessageDlg('             Arquivos não encontrados.'+#13+'Entre em contato com o administrador do sistema.',mtInformation,[mbOK],0);
  end;
end;

procedure TfrmRestaurarBackup.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key=#27)then
    Self.Close;
end;

end.
