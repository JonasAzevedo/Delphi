unit unAjustarCadastroEmails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Buttons;

type
  TfrmAjustarCadastroEmails = class(TForm)
    grpBxRetirarDominio2: TGroupBox;
    lblTexto1: TLabel;
    lblTexto2: TLabel;
    btBtnPesquisarRetirarDominio2: TBitBtn;
    zQryPesquisa: TZQuery;
    zQryPesquisaCODIGO: TIntegerField;
    zQryPesquisaEMAIL: TStringField;
    zQryPesquisaSERVIDOR_DO_EMAIL: TStringField;
    zQryPesquisaDOMINIO_1: TStringField;
    zQryPesquisaDOMINIO_2: TStringField;
    zQryPesquisaNOME_PROPRIETARIO: TStringField;
    zQryPesquisaCIDADE_PROPRIETARIO: TStringField;
    zQryPesquisaESTADO_PROPRIETARIO: TStringField;
    zQryPesquisaPAIS_PROPRIETARIO: TStringField;
    zQryPesquisaMEIO_CAPTACAO: TStringField;
    zQryPesquisaRELEVANCIA: TIntegerField;
    zQryPesquisaDATA_INSERCAO: TDateTimeField;
    lstBxRetirarDominio2: TListBox;
    lblTituloTotal: TLabel;
    lblTotal: TLabel;
    btBtnAtualizarRetirarDominio2: TBitBtn;
    procedure btBtnPesquisarRetirarDominio2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btBtnAtualizarRetirarDominio2Click(Sender: TObject);
  private
    oLstCodigoEmailsRetirarDominio2: TStringList;
    oLstEmailsRetirarDominio2: TStringList;
    
    procedure CalcularPontos_RetirarDominio2(pnCodigo: Integer; psEmail: String;
      psDominio2: String);
  end;

var
  frmAjustarCadastroEmails: TfrmAjustarCadastroEmails;

implementation

uses unDM, unConstantes;

{$R *.dfm}

procedure TfrmAjustarCadastroEmails.CalcularPontos_RetirarDominio2(pnCodigo: Integer;
  psEmail: String; psDominio2: String);
var
  nTamanhoEmail: Integer;
  nIniciaArroba: Integer;
  sDepoisArroba: String;
  nTotalPontosDepoisArroba: Integer;

  function ContarNumeroPontosDepoisArroba(): Integer;
  const
    sPONTO = '.';
  var
    nPontos: Integer;
    nTamanhoDepoisArroba: Integer;
    n: Integer;
    sCharAtual: String;
  begin
    nPontos := NUMERO_NULO;
    nTamanhoDepoisArroba := NUMERO_NULO;

    nTamanhoDepoisArroba := Length(sDepoisArroba);
    for n:=1 to nTamanhoDepoisArroba do
    begin
      sCharAtual := Copy(sDepoisArroba,n,1);
      if(sCharAtual = sPONTO)then
        Inc(nPontos);
    end;

    Result := nPontos;
  end;

begin
  if(psDominio2 <> STRING_INDEFINIDO)then
  begin
    nTamanhoEmail := NUMERO_NULO;
    nIniciaArroba := NUMERO_NULO;
    sDepoisArroba := STRING_INDEFINIDO;

    nTamanhoEmail := Length(psEmail);
    nIniciaArroba := Pos('@', psEmail);
    if(nIniciaArroba > NUMERO_NULO)then
    begin
      sDepoisArroba := Copy(psEmail, nIniciaArroba+1, nTamanhoEmail);
      nTotalPontosDepoisArroba := ContarNumeroPontosDepoisArroba();
      if(nTotalPontosDepoisArroba < 2)then
      begin
        oLstCodigoEmailsRetirarDominio2.Add(IntToStr(pnCodigo));
        oLstEmailsRetirarDominio2.Add(psEmail);
      end;
    end;
  end;
end;

procedure TfrmAjustarCadastroEmails.btBtnPesquisarRetirarDominio2Click(Sender: TObject);
begin
  lblTotal.Caption := STRING_INDEFINIDO;
  oLstCodigoEmailsRetirarDominio2.Clear;
  oLstEmailsRetirarDominio2.Clear;

  zQryPesquisa.Close;
  zQryPesquisa.SQL.Clear;
  zQryPesquisa.SQL.Add('SELECT * FROM email WHERE dominio_2 IS NOT NULL');
  zQryPesquisa.Open;
  if(zQryPesquisa.Active)and(zQryPesquisa.RecordCount > NUMERO_NULO)then
  begin
    zQryPesquisa.First;
    while not(zQryPesquisa.Eof)do
    begin
      CalcularPontos_RetirarDominio2(zQryPesquisaCODIGO.AsInteger,
        zQryPesquisaEMAIL.AsString, zQryPesquisaDOMINIO_2.AsString);

      zQryPesquisa.Next;
    end;
  end;

  lblTotal.Caption := IntToStr(oLstEmailsRetirarDominio2.Count);
  lstBxRetirarDominio2.Items.AddStrings(oLstEmailsRetirarDominio2);
end;

procedure TfrmAjustarCadastroEmails.FormCreate(Sender: TObject);
begin
  oLstCodigoEmailsRetirarDominio2 := TStringList.Create;
  oLstEmailsRetirarDominio2 := TStringList.Create;
end;

procedure TfrmAjustarCadastroEmails.FormDestroy(Sender: TObject);
begin
  FreeAndNil(oLstCodigoEmailsRetirarDominio2);
  FreeAndNil(oLstEmailsRetirarDominio2);
end;

procedure TfrmAjustarCadastroEmails.btBtnAtualizarRetirarDominio2Click(
  Sender: TObject);
var
  sListaCodigos: String;
begin
  try
    sListaCodigos := oLstCodigoEmailsRetirarDominio2.CommaText;
    sListaCodigos := '5600,5601';
    DM.ZConnection.StartTransaction;
    zQryPesquisa.Close;
    zQryPesquisa.SQL.Clear;
    zQryPesquisa.SQL.Add('UPDATE email SET dominio_2 = :dominio2');
    zQryPesquisa.SQL.Add(' WHERE codigo IN (:codigos)');
    zQryPesquisa.ParamByName('dominio2').AsString := STRING_INDEFINIDO;
    zQryPesquisa.ParamByName('codigos').AsString := sListaCodigos;
    zQryPesquisa.ExecSQL;
    DM.ZConnection.Commit;
    MessageDlg('Domínio_2 atualizados.', mtInformation, [mbOK], 0);
  except
    DM.ZConnection.Rollback;
    MessageDlg('Domínio_2 não pode ser atualizado.', mtInformation, [mbOK], 0);
  end;
end;

end.
