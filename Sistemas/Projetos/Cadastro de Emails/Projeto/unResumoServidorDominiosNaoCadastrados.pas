unit unResumoServidorDominiosNaoCadastrados;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmResumoServidorDominiosNaoCadastrados = class(TForm)
    lblAuxEmailsServidorDesconhecido: TLabel;
    lblAuxEmailsDominio2Desconhecido: TLabel;
    lblTotalEmailsDominio2Desconhecido: TLabel;
    lblAuxTotal: TLabel;
    lblTotalEmailsServidorDesconhecido: TLabel;
    lblTotalEmailsDominio1Desconhecido: TLabel;
    lblAuxEmailsDominio1Desconhecido: TLabel;
    lblTotalEmails: TLabel;
    lstBxEmailsServidorDesconhecido: TListBox;
    lstBxEmailsDominio1Desconhecido: TListBox;
    lstBxEmailsDominio2Desconhecido: TListBox;
    btBtnVerificar: TBitBtn;
    pnlOpcSelecionar: TPanel;
    rdBtnServidor: TRadioButton;
    rdBtnDominio1: TRadioButton;
    rdBtnDominio2: TRadioButton;
    zQryVerificar: TZQuery;
    zQryVerificarCODIGO: TIntegerField;
    zQryVerificarEMAIL: TStringField;
    zQryVerificarSERVIDOR_DO_EMAIL: TStringField;
    zQryVerificarDOMINIO_1: TStringField;
    zQryVerificarDOMINIO_2: TStringField;
    zQryVerificarNOME_PROPRIETARIO: TStringField;
    zQryVerificarCIDADE_PROPRIETARIO: TStringField;
    zQryVerificarESTADO_PROPRIETARIO: TStringField;
    zQryVerificarPAIS_PROPRIETARIO: TStringField;
    zQryVerificarMEIO_CAPTACAO: TStringField;
    zQryVerificarRELEVANCIA: TIntegerField;
    zQryVerificarDATA_INSERCAO: TDateTimeField;
    btBtnLimpar: TBitBtn;
    lstBxEmailsServidor: TListBox;
    lstBxEmailsDominio1: TListBox;
    lstBxEmailsDominio2: TListBox;
    btBtnDeletar: TBitBtn;
    btBtnValidarServidor: TBitBtn;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure btBtnVerificarClick(Sender: TObject);
    procedure btBtnLimparClick(Sender: TObject);
    procedure rdBtnServidorClick(Sender: TObject);
    procedure rdBtnDominio1Click(Sender: TObject);
    procedure rdBtnDominio2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btBtnDeletarClick(Sender: TObject);
    procedure btBtnValidarServidorClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    FnTotServidor: Integer;
    FnTotDominio1: Integer;
    FnTotDominio2: Integer;
    FnOpcPesquisa: Integer;

    procedure LimparTela;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant);
  end;

var
  frmResumoServidorDominiosNaoCadastrados: TfrmResumoServidorDominiosNaoCadastrados;

implementation

uses unConstantes, unDM, unFuncoes;

const
  nOPC_PESQUISA_SERVIDOR = 1;
  nOPC_PESQUISA_DOMINIO1 = 2;
  nOPC_PESQUISA_DOMINIO2 = 3;

{$R *.dfm}

procedure TfrmResumoServidorDominiosNaoCadastrados.LimparTela;
begin
  lblTotalEmailsServidorDesconhecido.Caption := '0';
  lblTotalEmailsDominio1Desconhecido.Caption := '0';
  lblTotalEmailsDominio2Desconhecido.Caption := '0';
  lblTotalEmails.Caption := '0';
  rdBtnServidor.Checked := True;
  rdBtnDominio1.Checked := False;
  rdBtnDominio2.Checked := False;
  FnOpcPesquisa := nOPC_PESQUISA_SERVIDOR;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.passarParametro(pTipo: String;
  pValores: OleVariant);
var
  oLstEmailsServidorDesconhecido: TStringList;
  oLstEmailsDominio1Desconhecido: TStringList;
  oLstEmailsDominio2Desconhecido: TStringList;
begin
  if(pTipo = PRM_EMAIL_TELA_RESUMO_SERVIDOR_DOMINIOS_NAO_CADASTRADOS)then
  begin
    try
      oLstEmailsServidorDesconhecido := TStringList.Create;
      oLstEmailsDominio1Desconhecido := TStringList.Create;
      oLstEmailsDominio2Desconhecido := TStringList.Create;
      oLstEmailsServidorDesconhecido.CommaText := pValores[0];
      oLstEmailsDominio1Desconhecido.CommaText := pValores[1];
      oLstEmailsDominio2Desconhecido.CommaText := pValores[2];

      lstBxEmailsServidorDesconhecido.Items.AddStrings(oLstEmailsServidorDesconhecido);
      lstBxEmailsDominio1Desconhecido.Items.AddStrings(oLstEmailsDominio1Desconhecido);
      lstBxEmailsDominio2Desconhecido.Items.AddStrings(oLstEmailsDominio2Desconhecido);

      lblTotalEmailsServidorDesconhecido.Caption := IntToStr(oLstEmailsServidorDesconhecido.Count);
      lblTotalEmailsDominio1Desconhecido.Caption := IntToStr(oLstEmailsDominio1Desconhecido.Count);
      lblTotalEmailsDominio2Desconhecido.Caption := IntToStr(oLstEmailsDominio2Desconhecido.Count);

      FnTotServidor := oLstEmailsServidorDesconhecido.Count;
      FnTotDominio1 := oLstEmailsDominio1Desconhecido.Count;
      FnTotDominio2 := oLstEmailsDominio2Desconhecido.Count;

      lblTotalEmails.Caption := IntToStr(oLstEmailsServidorDesconhecido.Count +
        oLstEmailsDominio1Desconhecido.Count + oLstEmailsDominio2Desconhecido.Count);
    finally
      FreeAndNil(oLstEmailsServidorDesconhecido);
      FreeAndNil(oLstEmailsDominio1Desconhecido);
      FreeAndNil(oLstEmailsDominio2Desconhecido);
    end;
  end;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.btBtnVerificarClick(
  Sender: TObject);
var
  nTotalItensLstBx: Integer;
  nInsercoes: Integer;

  procedure AdiocionarCondicoes;
  var
    i: Integer;
  begin
    nInsercoes := NUMERO_NULO;

    case FnOpcPesquisa of
    nOPC_PESQUISA_SERVIDOR:
    //condição = '%@uola%'
    begin
      nTotalItensLstBx := lstBxEmailsServidorDesconhecido.Count;
      for i:=0 to nTotalItensLstBx-1 do
      begin
        if lstBxEmailsServidorDesconhecido.Selected[i] then
        begin
          lstBxEmailsServidorDesconhecido.ItemIndex := i;
          if(nInsercoes = NUMERO_NULO)then
          begin
            zQryVerificar.SQL.Add('WHERE e.email LIKE ' + QuotedStr('%@' + lstBxEmailsServidorDesconhecido.Items.Strings[i] + '%'));
            inc(nInsercoes);
          end
          else
          begin
            zQryVerificar.SQL.Add('OR e.email LIKE ' + QuotedStr('%@' + lstBxEmailsServidorDesconhecido.Items.Strings[i] + '%'));
            inc(nInsercoes);
          end;
        end;
      end;
    end;

    nOPC_PESQUISA_DOMINIO1:
    //condição = '%.comas%'
    begin
      nTotalItensLstBx := lstBxEmailsDominio1Desconhecido.Count;
      for i:=0 to nTotalItensLstBx-1 do
      begin
        if lstBxEmailsDominio1Desconhecido.Selected[i] then
        begin
          lstBxEmailsDominio1Desconhecido.ItemIndex := i;
          if(nInsercoes = NUMERO_NULO)then
          begin
            zQryVerificar.SQL.Add('WHERE e.email LIKE ' + QuotedStr('%.' + lstBxEmailsDominio1Desconhecido.Items.Strings[i] + '%'));
            inc(nInsercoes);
          end
          else
          begin
            zQryVerificar.SQL.Add('OR e.email LIKE ' + QuotedStr('%.' + lstBxEmailsDominio1Desconhecido.Items.Strings[i] + '%'));
            inc(nInsercoes);
          end;
        end;
      end;
    end;

    nOPC_PESQUISA_DOMINIO2:
    //condição = '%bx'
    begin
      nTotalItensLstBx := lstBxEmailsDominio2Desconhecido.Count;
      for i:=0 to nTotalItensLstBx-1 do
      begin
        if lstBxEmailsDominio2Desconhecido.Selected[i] then
        begin
          lstBxEmailsDominio2Desconhecido.ItemIndex := i;
          if(nInsercoes = NUMERO_NULO)then
          begin
            zQryVerificar.SQL.Add('WHERE e.email LIKE ' + QuotedStr('%.' + lstBxEmailsDominio2Desconhecido.Items.Strings[i]));
            inc(nInsercoes);
          end
          else
          begin
            zQryVerificar.SQL.Add('OR e.email LIKE ' + QuotedStr('%.' + lstBxEmailsDominio2Desconhecido.Items.Strings[i]));
            inc(nInsercoes);
          end;
        end;
      end;
    end
    end; //fim case

    if (nInsercoes = NUMERO_NULO) then
    begin
      MessageDlg('Selecione pelo menos um item para pesquisar.', mtInformation, [mbOK], 0);
      Abort;
    end;
  end;

  procedure PrepararListParaResultados;
  var
    i: Integer;
    nTotalItens: Integer;
  begin
    case FnOpcPesquisa of
    nOPC_PESQUISA_SERVIDOR:
      lstBxEmailsServidor.Clear;

    nOPC_PESQUISA_DOMINIO1:
      lstBxEmailsDominio1.Clear;

    nOPC_PESQUISA_DOMINIO2:
      lstBxEmailsDominio2.Clear;
    end; //fim - case
  end;

  procedure AdiocionarResultados;
  begin
    case FnOpcPesquisa of
      nOPC_PESQUISA_SERVIDOR:
       lstBxEmailsServidor.Items.Add(zQryVerificarEMAIL.Text);
      nOPC_PESQUISA_DOMINIO1:
        lstBxEmailsDominio1.Items.Add(zQryVerificarEMAIL.Text);
      nOPC_PESQUISA_DOMINIO2:
        lstBxEmailsDominio2.Items.Add(zQryVerificarEMAIL.Text);
    end;
  end;

begin
  if not(FnOpcPesquisa IN [nOPC_PESQUISA_SERVIDOR,nOPC_PESQUISA_DOMINIO1,
    nOPC_PESQUISA_DOMINIO2])then
  begin
    MessageDlg('Selecione uma opção de pesquisa.', mtInformation, [mbOK], 0);
    Abort;
  end;

  zQryVerificar.Close;
  zQryVerificar.SQL.Clear;
  zQryVerificar.SQL.Add('SELECT e.* ');
  zQryVerificar.SQL.Add('FROM email e ');
  AdiocionarCondicoes;
  zQryVerificar.Open;
  if(zQryVerificar.Active)and(zQryVerificar.RecordCount > NUMERO_NULO)then
  begin
    zQryVerificar.First;
    PrepararListParaResultados;
    while not(zQryVerificar.Eof)do
    begin
      AdiocionarResultados;
      zQryVerificar.Next;
    end;
  end;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.btBtnLimparClick(
  Sender: TObject);
var
  i, nTotalItensLstBx: Integer;
begin
  nTotalItensLstBx := lstBxEmailsServidorDesconhecido.Count;
  for i:=0 to nTotalItensLstBx-1 do
    lstBxEmailsServidorDesconhecido.Selected[i] := False;

  nTotalItensLstBx := lstBxEmailsDominio1Desconhecido.Count;
  for i:=0 to nTotalItensLstBx-1 do
    lstBxEmailsDominio1Desconhecido.Selected[i] := False;

  nTotalItensLstBx := lstBxEmailsDominio2Desconhecido.Count;
  for i:=0 to nTotalItensLstBx-1 do
    lstBxEmailsDominio2Desconhecido.Selected[i] := False;

  lstBxEmailsServidor.Clear;
  lstBxEmailsDominio1.Clear;
  lstBxEmailsDominio2.Clear;

  rdBtnServidor.Checked := True;
  FnOpcPesquisa := nOPC_PESQUISA_SERVIDOR;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.rdBtnServidorClick(
  Sender: TObject);
begin
  FnOpcPesquisa := nOPC_PESQUISA_SERVIDOR;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.rdBtnDominio1Click(
  Sender: TObject);
begin
  FnOpcPesquisa := nOPC_PESQUISA_DOMINIO1;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.rdBtnDominio2Click(
  Sender: TObject);
begin
  FnOpcPesquisa := nOPC_PESQUISA_DOMINIO2;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.FormShow(
  Sender: TObject);
begin
  LimparTela;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.btBtnDeletarClick(
  Sender: TObject);

  procedure AdiocionarCondicoes;
  var
    i: Integer;
    nTotalItensLstBx: Integer;
    nDelecoes: Integer;
  begin
    nDelecoes := NUMERO_NULO;

    case FnOpcPesquisa of
    nOPC_PESQUISA_SERVIDOR:
    begin
      nTotalItensLstBx := lstBxEmailsServidor.Count;
      for i:=0 to nTotalItensLstBx-1 do
      begin
        if lstBxEmailsServidor.Selected[i] then
        begin
          lstBxEmailsServidor.ItemIndex := i;
          if(nDelecoes = NUMERO_NULO)then
          begin
            zQryVerificar.SQL.Add('WHERE e.email = ' + QuotedStr(lstBxEmailsServidor.Items.Strings[i]));
            inc(nDelecoes);
          end
          else
          begin
            zQryVerificar.SQL.Add('OR e.email LIKE = ' + QuotedStr(lstBxEmailsServidor.Items.Strings[i]));
            inc(nDelecoes);
          end;
        end;
      end;
    end;

    nOPC_PESQUISA_DOMINIO1:
    begin
      nTotalItensLstBx := lstBxEmailsDominio1.Count;
      for i:=0 to nTotalItensLstBx-1 do
      begin
        if lstBxEmailsDominio1.Selected[i] then
        begin
          lstBxEmailsDominio1.ItemIndex := i;
          if(nDelecoes = NUMERO_NULO)then
          begin
            zQryVerificar.SQL.Add('WHERE e.email = ' + QuotedStr(lstBxEmailsDominio1.Items.Strings[i]));
            inc(nDelecoes);
          end
          else
          begin
            zQryVerificar.SQL.Add('OR e.email LIKE = ' + QuotedStr(lstBxEmailsDominio1.Items.Strings[i]));
            inc(nDelecoes);
          end;
        end;
      end;
    end;

    nOPC_PESQUISA_DOMINIO2:
    begin
      nTotalItensLstBx := lstBxEmailsDominio2.Count;
      for i:=0 to nTotalItensLstBx-1 do
      begin
        if lstBxEmailsDominio2.Selected[i] then
        begin
          lstBxEmailsDominio2.ItemIndex := i;
          if(nDelecoes = NUMERO_NULO)then
          begin
            zQryVerificar.SQL.Add('WHERE e.email = ' + QuotedStr(lstBxEmailsDominio2.Items.Strings[i]));
            inc(nDelecoes);
          end
          else
          begin
            zQryVerificar.SQL.Add('OR e.email LIKE = ' + QuotedStr(lstBxEmailsDominio2.Items.Strings[i]));
            inc(nDelecoes);
          end;
        end;
      end;
    end;
    end; //fim case

    if (nDelecoes = NUMERO_NULO) then
    begin
      MessageDlg('Selecione pelo menos um item para deletar.', mtInformation, [mbOK], 0);
      Abort;
    end;
  end;

begin
  if not(FnOpcPesquisa IN [nOPC_PESQUISA_SERVIDOR,nOPC_PESQUISA_DOMINIO1,
    nOPC_PESQUISA_DOMINIO2])then
  begin
    MessageDlg('Selecione uma opção de pesquisa.', mtInformation, [mbOK], 0);
    Abort;
  end;

  if(zQryVerificar.Active = False)or(zQryVerificar.RecordCount <= NUMERO_NULO)then
  begin
    MessageDlg('Não há registros para serem deletados.', mtInformation, [mbOK], 0);
    Abort;
  end;

  try
    DM.ZConnection.StartTransaction;
    zQryVerificar.Close;
    zQryVerificar.SQL.Clear;
    zQryVerificar.SQL.Add('DELETE ');
    zQryVerificar.SQL.Add('FROM email e ');
    AdiocionarCondicoes;
    zQryVerificar.ExecSQL;
    DM.ZConnection.Commit;
  except
    MessageDlg('Registros não puderam ser deletados.', mtError, [mbOK], 0);
    DM.ZConnection.Rollback;
  end;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.btBtnValidarServidorClick(
  Sender: TObject);
var
  i: integer;
  bTudoOk: Boolean;
  sServidoresValidados: String;

  function SelecionouServidorParaValidar: Boolean;
  begin
    Result := lstBxEmailsServidorDesconhecido.SelCount > 0;
  end;

  procedure DeletarDoListBoxServidoresInseridos;
  var
    y: integer;
  begin
    for y:=lstBxEmailsServidorDesconhecido.Count-1 downto 0 do
    begin
      if lstBxEmailsServidorDesconhecido.Selected[y] then
        lstBxEmailsServidorDesconhecido.Items.Delete(y);
    end;
  end;

begin
  if not(SelecionouServidorParaValidar)then
  begin
    MessageDlg('Selecione pelo menos um servidor acima para torná-lo válido.', mtInformation, [mbOK], 0);
    Exit;
  end;

  bTudoOk := true;
  sServidoresValidados := STRING_INDEFINIDO;
  DM.ZConnection.StartTransaction;

  //percorrendo servidores
  for i:=0 to lstBxEmailsServidorDesconhecido.Count-1 do
  begin
    //se estiver selecionado
    if lstBxEmailsServidorDesconhecido.Selected[i] then
    begin
      try
        //insere como sendo um servidor válido
        DM.zQryServidor.Close;
        DM.zQryServidor.SQL.Clear;
        DM.zQryServidor.SQL.Add('INSERT INTO servidor(nome) VALUES (:nome)');
        DM.zQryServidor.ParamByName('nome').AsString := lstBxEmailsServidorDesconhecido.Items.Strings[i];
        DM.zQryServidor.ExecSQL;
        AdicionarItemNaLista(lstBxEmailsServidorDesconhecido.Items.Strings[i],sServidoresValidados);
      except
        bTudoOk := False;
      end;
    end;
  end;

  if bTudoOk then
  begin
    DM.ZConnection.Commit;
    DeletarDoListBoxServidoresInseridos;
    MessageDlg('Os seguintes servidores foram validados com sucesso: ' + #13 +
      sServidoresValidados, mtInformation, [mbOK], 0);
  end
  else
    DM.ZConnection.Rollback;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.FormKeyPress(
  Sender: TObject; var Key: Char);
begin
  if(Key = #27)then
    Close;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.BitBtn1Click(
  Sender: TObject);
var
  i: integer;
  bTudoOk: Boolean;
  sDominio1Validados: String;

  function SelecionouDominio1ParaValidar: Boolean;
  begin
    Result := lstBxEmailsDominio1Desconhecido.SelCount > 0;
  end;

  procedure DeletarDoListBoxDominio1Inseridos;
  var
    y: integer;
  begin
    for y:=lstBxEmailsDominio1Desconhecido.Count-1 downto 0 do
    begin
      if lstBxEmailsDominio1Desconhecido.Selected[y] then
        lstBxEmailsDominio1Desconhecido.Items.Delete(y);
    end;
  end;

begin
  if not(SelecionouDominio1ParaValidar)then
  begin
    MessageDlg('Selecione pelo menos um domínio 1 acima para torná-lo válido.', mtInformation, [mbOK], 0);
    Exit;
  end;

  bTudoOk := true;
  sDominio1Validados := STRING_INDEFINIDO;
  DM.ZConnection.StartTransaction;

  //percorrendo domínios 1
  for i:=0 to lstBxEmailsDominio1Desconhecido.Count-1 do
  begin
    //se estiver selecionado
    if lstBxEmailsDominio1Desconhecido.Selected[i] then
    begin
      try
        //insere como sendo um domínio 1 válido
        DM.zQryDominio1.Close;
        DM.zQryDominio1.SQL.Clear;
        DM.zQryDominio1.SQL.Add('INSERT INTO dominio_1(nome) VALUES (:nome)');
        DM.zQryDominio1.ParamByName('nome').AsString := lstBxEmailsDominio1Desconhecido.Items.Strings[i];
        DM.zQryDominio1.ExecSQL;
        AdicionarItemNaLista(lstBxEmailsDominio1Desconhecido.Items.Strings[i],sDominio1Validados);
      except
        bTudoOk := False;
      end;
    end;
  end;

  if bTudoOk then
  begin
    DM.ZConnection.Commit;
    DeletarDoListBoxDominio1Inseridos;
    MessageDlg('Os seguintes domínios 1 foram validados com sucesso: ' + #13 +
      sDominio1Validados, mtInformation, [mbOK], 0);
  end
  else
    DM.ZConnection.Rollback;
end;

procedure TfrmResumoServidorDominiosNaoCadastrados.BitBtn2Click(
  Sender: TObject);
var
  i: integer;
  bTudoOk: Boolean;
  sDominio2Validados: String;

  function SelecionouDominio2ParaValidar: Boolean;
  begin
    Result := lstBxEmailsDominio2Desconhecido.SelCount > 0;
  end;

  procedure DeletarDoListBoxDominio2Inseridos;
  var
    y: integer;
  begin
    for y:=lstBxEmailsDominio2Desconhecido.Count-1 downto 0 do
    begin
      if lstBxEmailsDominio2Desconhecido.Selected[y] then
        lstBxEmailsDominio2Desconhecido.Items.Delete(y);
    end;
  end;

begin
  if not(SelecionouDominio2ParaValidar)then
  begin
    MessageDlg('Selecione pelo menos um domínio 2 acima para torná-lo válido.', mtInformation, [mbOK], 0);
    Exit;
  end;

  bTudoOk := true;
  sDominio2Validados := STRING_INDEFINIDO;
  DM.ZConnection.StartTransaction;

  //percorrendo domínios 2
  for i:=0 to lstBxEmailsDominio2Desconhecido.Count-1 do
  begin
    //se estiver selecionado
    if lstBxEmailsDominio2Desconhecido.Selected[i] then
    begin
      try
        //insere como sendo um domínio 2 válido
        DM.zQryDominio2.Close;
        DM.zQryDominio2.SQL.Clear;
        DM.zQryDominio2.SQL.Add('INSERT INTO dominio_2(nome) VALUES (:nome)');
        DM.zQryDominio2.ParamByName('nome').AsString := lstBxEmailsDominio2Desconhecido.Items.Strings[i];
        DM.zQryDominio2.ExecSQL;
        AdicionarItemNaLista(lstBxEmailsDominio2Desconhecido.Items.Strings[i],sDominio2Validados);
      except
        bTudoOk := False;
      end;
    end;
  end;

  if bTudoOk then
  begin
    DM.ZConnection.Commit;
    DeletarDoListBoxDominio2Inseridos;
    MessageDlg('Os seguintes domínios 2 foram validados com sucesso: ' + #13 +
      sDominio2Validados, mtInformation, [mbOK], 0);
  end
  else
    DM.ZConnection.Rollback;
end;

end.
