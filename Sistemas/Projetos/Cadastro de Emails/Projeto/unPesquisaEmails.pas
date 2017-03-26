unit unPesquisaEmails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, plsMemo, plsComboBox, plsEdit, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Buttons, Grids, DBGrids,
  AdvGlowButton, AdvGlassButton;

type
  TfrmPesquisaEmails = class(TForm)
    grpBxOpcoesPesquisa: TGroupBox;
    lblEmail: TLabel;
    lblNome: TLabel;
    lblCidade: TLabel;
    lblEstado: TLabel;
    lblMeioCaptacao: TLabel;
    lblServidor: TLabel;
    lblDominio1: TLabel;
    lblDominio2: TLabel;
    lblRelevancia: TLabel;
    lblPais: TLabel;
    lblDadosEmail: TLabel;
    lblDadosProprietario: TLabel;
    lblDadosOrigem: TLabel;
    edEmail: TPlsEdit;
    edNome: TPlsEdit;
    edCidade: TPlsEdit;
    edEstado: TPlsEdit;
    edPais: TPlsEdit;
    cbBxRelevancia: TPlsComboBox;
    mmMeioCaptacao: TPlsMemo;
    cbBxServidor: TComboBox;
    cbBxDominio1: TComboBox;
    cbBxDominio2: TComboBox;
    bvlDivisao1: TBevel;
    bvlDivisao2: TBevel;
    zQryAux: TZQuery;
    zQryPesquisa: TZQuery;
    dsPesquisa: TDataSource;
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
    dbGrdEmails: TDBGrid;
    lblAuxTotalEmails: TLabel;
    bvlDivisao3: TBevel;
    lblAreasInteresse: TLabel;
    GroupBox1: TGroupBox;
    advBtnPesquisar: TAdvGlowButton;
    advBtnEditar: TAdvGlowButton;
    advBtnLimpar: TAdvGlowButton;
    advBtnMarcarParaEnviar: TAdvGlowButton;
    advBtnDeletarParaEnviar: TAdvGlowButton;
    procedure FormCreate(Sender: TObject);
    procedure advBtnPesquisarClick(Sender: TObject);
    procedure advBtnLimparClick(Sender: TObject);
    procedure advBtnEditarClick(Sender: TObject);
    procedure advBtnMarcarParaEnviarClick(Sender: TObject);
    procedure advBtnDeletarParaEnviarClick(Sender: TObject);
    procedure dbGrdEmailsDblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    procedure PopularComboBoxServidor;
    procedure PopularComboBoxDominio1;
    procedure PopularComboBoxDominio2;
    procedure LimparTela;
    procedure CriarAreasInteresse;
    procedure EditarEmail;
  end;

var
  frmPesquisaEmails: TfrmPesquisaEmails;

implementation

uses unDM, unConstantes, unEnviarEmail, unEditarEmail, Math;

const
  sTOTAL_EMAILS = 'Total Email''s: ';
  nIDX_TODOS = 0;

{$R *.dfm}

{ TfrmPesquisaEmails }

procedure TfrmPesquisaEmails.PopularComboBoxServidor;
begin
  cbBxServidor.Clear;
  zQryAux.Close;
  zQryAux.SQL.Clear;
  zQryAux.SQL.Add('SELECT DISTINCT(servidor_do_email) FROM email ORDER by servidor_do_email');
  zQryAux.Open;

  cbBxServidor.Items.Add(sTODOS_REGISTROS);
  if(zQryAux.RecordCount > NUMERO_NULO)then
  begin
    zQryAux.First;
    while not(zQryAux.Eof)do
    begin
      cbBxServidor.Items.Add(zQryAux.FieldByName('servidor_do_email').AsString);
      zQryAux.Next;
    end;
  end;
end;

procedure TfrmPesquisaEmails.PopularComboBoxDominio1;
begin
  cbBxDominio1.Clear;
  zQryAux.Close;
  zQryAux.SQL.Clear;
  zQryAux.SQL.Add('SELECT DISTINCT(dominio_1) FROM email ORDER by dominio_1');
  zQryAux.Open;

  cbBxDominio1.Items.Add(sTODOS_REGISTROS);
  if(zQryAux.RecordCount > NUMERO_NULO)then
  begin
    zQryAux.First;
    while not(zQryAux.Eof)do
    begin
      cbBxDominio1.Items.Add(zQryAux.FieldByName('dominio_1').AsString);
      zQryAux.Next;
    end;
  end;
end;

procedure TfrmPesquisaEmails.PopularComboBoxDominio2;
begin
  cbBxDominio2.Clear;
  zQryAux.Close;
  zQryAux.SQL.Clear;
  zQryAux.SQL.Add('SELECT DISTINCT(dominio_2) FROM email ORDER by dominio_2');
  zQryAux.Open;

  cbBxDominio2.Items.Add(sTODOS_REGISTROS);
  if(zQryAux.RecordCount > NUMERO_NULO)then
  begin
    zQryAux.First;
    while not(zQryAux.Eof)do
    begin
      cbBxDominio2.Items.Add(zQryAux.FieldByName('dominio_2').AsString);
      zQryAux.Next;
    end;
  end;
end;

procedure TfrmPesquisaEmails.LimparTela;
begin
  edEmail.Clear;
  cbBxServidor.ItemIndex := nIDX_TODOS;
  cbBxDominio1.ItemIndex := nIDX_TODOS;
  cbBxDominio2.ItemIndex := nIDX_TODOS;
  edNome.Clear;
  edPais.Clear;
  edCidade.Clear;
  edEstado.Clear;
  mmMeioCaptacao.Clear;
  cbBxRelevancia.ItemIndex := -1;
end;

procedure TfrmPesquisaEmails.CriarAreasInteresse;
const
  nTOPO_LINHA_1 = 200;
  nTOPO_LINHA_2 = 220;
  nWIDTH_PADRAO = 97;
  nQTDE_CARACTERES_SEM_ALTERAR_WIDTH_PADRAO = 9;
  nACRESCENTA_WIDTH_POR_CARACTER = 7;
var
  oCheckBox: TCheckBox;
  nTotalLinhas: Integer;
  nLeft: Integer;
  nWidth: Integer;
  nAux: Integer;
begin
  DM.zQryAreasInteresse.Close;
  DM.zQryAreasInteresse.SQL.Clear;
  DM.zQryAreasInteresse.SQL.Add('SELECT * FROM areas_interesse');
  DM.zQryAreasInteresse.Open;

  if DM.zQryAreasInteresse.RecordCount > NUMERO_NULO then
  begin
    nTotalLinhas := 1;
    nLeft := 16;
    nWidth := nWIDTH_PADRAO;
    DM.zQryAreasInteresse.First;
    while not(DM.zQryAreasInteresse.Eof) do
    begin
      oCheckBox := TCheckBox.Create(Self);
      case nTotalLinhas of
        1: oCheckBox.Top := nTOPO_LINHA_1;
        2: oCheckBox.Top := nTOPO_LINHA_2;
      end;
      oCheckBox.Left := nLeft;
      oCheckBox.Parent := grpBxOpcoesPesquisa;
      oCheckBox.Caption := DM.zQryAreasInteresseNOME.AsString;
      oCheckBox.Name := 'ckBxAreasInteresse' + DM.zQryAreasInteresseCODIGO.AsString;
      oCheckBox.Enabled := True;
      oCheckBox.Visible := True;
      oCheckBox.Checked := False;
      oCheckBox.Tag := DM.zQryAreasInteresseCODIGO.AsInteger;
      oCheckBox.Font.Size := 8;
      oCheckBox.Font.Style := [];

      //calculando width
      if(Length(oCheckBox.Caption)>nQTDE_CARACTERES_SEM_ALTERAR_WIDTH_PADRAO)then
      begin
        nAux := Length(oCheckBox.Caption) - nQTDE_CARACTERES_SEM_ALTERAR_WIDTH_PADRAO;
        oCheckBox.Width := nWIDTH_PADRAO + (nACRESCENTA_WIDTH_POR_CARACTER * nAux);
      end
      else
        oCheckBox.Width := nWIDTH_PADRAO;

      if (oCheckBox.Width > nWidth)then
        nWidth := oCheckBox.Width;

      case nTotalLinhas of
        1: nTotalLinhas := 2;
        2: begin
             nTotalLinhas := 1;
             nLeft := nLeft + nWidth + 10;
             nWidth := nWIDTH_PADRAO;
           end;
      end;

      DM.zQryAreasInteresse.Next;
    end;
  end;
end;

procedure TfrmPesquisaEmails.EditarEmail;
begin
  if zQryPesquisa.RecordCount > 0 then
  begin
    Application.CreateForm(TfrmEditarEmail, frmEditarEmail);
    frmEditarEmail.PassarParametro(PRM_EDITAR_EMAIL, zQryPesquisaCODIGO.AsInteger);
    frmEditarEmail.ShowModal;
    FreeAndNil(frmEditarEmail);
  end;
end;

procedure TfrmPesquisaEmails.FormCreate(Sender: TObject);
begin
  PopularComboBoxServidor;
  PopularComboBoxDominio1;
  PopularComboBoxDominio2;
  CriarAreasInteresse;
  LimparTela;
  advBtnPesquisarClick(Self);
end;

procedure TfrmPesquisaEmails.advBtnPesquisarClick(Sender: TObject);
var
  bUsouWhere: Boolean;
  lstAreasInteresse: TStringList;
  sAreasInteresse: String;

  procedure PegarAreasInteresse;
  var
    n: Integer;
  begin
    for n:=0 to frmPesquisaEmails.ComponentCount-1 do
    begin
      if(frmPesquisaEmails.Components[n] is TCheckBox)and
        ((frmPesquisaEmails.Components[n] as TCheckBox).Parent = grpBxOpcoesPesquisa)and
        ((frmPesquisaEmails.Components[n] as TCheckBox).Checked = True)then

        lstAreasInteresse.Add(IntToStr((frmPesquisaEmails.Components[n] as TCheckBox).Tag));
    end;
  end;

begin
  bUsouWhere := False;
  lstAreasInteresse := TStringList.Create;

  zQryPesquisa.Close;
  zQryPesquisa.SQL.Clear;
  zQryPesquisa.SQL.Add('SELECT * FROM email');
  if(Trim(edEmail.Text) <> STRING_INDEFINIDO)then
  begin
    zQryPesquisa.SQL.Add(' WHERE email LIKE ' + QuotedStr('%' + edEmail.Text + '%'));
    bUsouWhere := True;
  end;

  if(cbBxServidor.ItemIndex > nIDX_TODOS)then
  begin
    if not(bUsouWhere)then
      zQryPesquisa.SQL.Add('WHERE servidor_do_email = :servidor_do_email ')
    else
      zQryPesquisa.SQL.Add('AND servidor_do_email = :servidor_do_email ');

    zQryPesquisa.ParamByName('servidor_do_email').AsString := cbBxServidor.Text;
    bUsouWhere := True;
  end;

  if(cbBxDominio1.ItemIndex > nIDX_TODOS)then
  begin
    if not(bUsouWhere)then
      zQryPesquisa.SQL.Add('WHERE dominio_1 = :dominio_1 ')
    else
      zQryPesquisa.SQL.Add('AND dominio_1 = :dominio_1 ');

    zQryPesquisa.ParamByName('dominio_1').AsString := cbBxDominio1.Text;
    bUsouWhere := True;
  end;

  if(cbBxDominio2.ItemIndex > nIDX_TODOS)then
  begin
    if not(bUsouWhere)then
      zQryPesquisa.SQL.Add('WHERE dominio_2 = :dominio_2 ')
    else
      zQryPesquisa.SQL.Add('AND dominio_2 = :dominio_2 ');

    zQryPesquisa.ParamByName('dominio_2').AsString := cbBxDominio2.Text;
    bUsouWhere := True;
  end;

  if(Trim(edNome.Text) <> STRING_INDEFINIDO)then
  begin
    if not(bUsouWhere)then
      zQryPesquisa.SQL.Add(' WHERE nome_proprietario LIKE ' + QuotedStr('%' + Trim(edNome.Text) + '%'))
    else
      zQryPesquisa.SQL.Add(' AND nome_proprietario LIKE ' + QuotedStr('%' + Trim(edNome.Text) + '%'));
    bUsouWhere := True;
  end;

  if(Trim(edPais.Text) <> STRING_INDEFINIDO)then
  begin
    if not(bUsouWhere)then
      zQryPesquisa.SQL.Add(' WHERE pais_proprietario LIKE ' + QuotedStr('%' + Trim(edPais.Text) + '%'))
    else
      zQryPesquisa.SQL.Add(' AND pais_proprietario LIKE ' + QuotedStr('%' + Trim(edPais.Text) + '%'));
    bUsouWhere := True;
  end;

  if(Trim(edCidade.Text) <> STRING_INDEFINIDO)then
  begin
    if not(bUsouWhere)then
      zQryPesquisa.SQL.Add(' WHERE cidade_proprietario LIKE ' + QuotedStr('%' + Trim(edCidade.Text) + '%'))
    else
      zQryPesquisa.SQL.Add(' AND cidade_proprietario LIKE ' + QuotedStr('%' + Trim(edCidade.Text) + '%'));
    bUsouWhere := True;
  end;

  if(Trim(edEstado.Text) <> STRING_INDEFINIDO)then
  begin
    if not(bUsouWhere)then
      zQryPesquisa.SQL.Add(' WHERE estado_proprietario LIKE ' + QuotedStr('%' + Trim(edEstado.Text) + '%'))
    else
      zQryPesquisa.SQL.Add(' AND estado_proprietario LIKE ' + QuotedStr('%' + Trim(edEstado.Text) + '%'));
    bUsouWhere := True;
  end;

  if(Trim(mmMeioCaptacao.Text) <> STRING_INDEFINIDO)then
  begin
    if not(bUsouWhere)then
      zQryPesquisa.SQL.Add(' WHERE meio_captacao LIKE ' + QuotedStr('%' + Trim(mmMeioCaptacao.Text) + '%'))
    else
      zQryPesquisa.SQL.Add(' AND meio_captacao LIKE ' + QuotedStr('%' + Trim(mmMeioCaptacao.Text) + '%'));
    bUsouWhere := True;
  end;

  if(cbBxRelevancia.ItemIndex > -1)then
  begin
    if not(bUsouWhere)then
      zQryPesquisa.SQL.Add('WHERE relevancia = :relevancia ')
    else
      zQryPesquisa.SQL.Add('AND relevancia = :relevancia ');
    zQryPesquisa.ParamByName('relevancia').AsInteger := StrToInt(cbBxRelevancia.Text);
  end;

  PegarAreasInteresse;

  if(lstAreasInteresse.Count > NUMERO_NULO)then
  begin
    if not(bUsouWhere)then
      sAreasInteresse := ' WHERE '
    else
      sAreasInteresse := ' AND ';

    sAreasInteresse := sAreasInteresse + ' codigo IN(SELECT A.codigo_fk_email FROM associa_email_areas_interesse A ';
    sAreasInteresse := sAreasInteresse + 'WHERE A.codigo_fk_areas_interesse IN(';
    sAreasInteresse := sAreasInteresse + lstAreasInteresse.CommaText + '))';
    zQryPesquisa.SQL.Add(sAreasInteresse);
  end;

  zQryPesquisa.Open;
  if (zQryPesquisa.Active) and not(zQryPesquisa.IsEmpty) then
    zQryPesquisa.First;

  lblAuxTotalEmails.Caption := sTOTAL_EMAILS + IntToStr(zQryPesquisa.RecordCount);
  FreeAndNil(lstAreasInteresse);
end;

procedure TfrmPesquisaEmails.advBtnLimparClick(Sender: TObject);
begin
  LimparTela;
end;

procedure TfrmPesquisaEmails.advBtnEditarClick(Sender: TObject);
begin
  EditarEmail;
end;

procedure TfrmPesquisaEmails.advBtnMarcarParaEnviarClick(Sender: TObject);
var
  n: Integer;
  oBookmark: TBookmarkStr;
  oBookmarkList: TBookmarkList;
begin
  //armazena a posiçao atual
  oBookmark := zQryPesquisa.Bookmark;
  try
    //pega as linhas selecionadas da gride
    oBookmarkList := dbGrdEmails.SelectedRows;
    for n:=0 to oBookmarkList.Count-1 do
    begin
      //move o cursor da query para cada registro selecionado na gride
      zQryPesquisa.Bookmark := oBookmarkList[n];
      frmEnviarEmail.AdicionarEmailNaLista(zQryPesquisa.FieldByName('email').AsString);
    end;
  finally
    //volta para o registro inicial
    zQryPesquisa.Bookmark := oBookmark;
  end;
end;

procedure TfrmPesquisaEmails.advBtnDeletarParaEnviarClick(Sender: TObject);
var
  n: Integer;
  oBookmark: TBookmarkStr;
  oBookmarkList: TBookmarkList;
begin
  //armazena a posiçao atual
  oBookmark := zQryPesquisa.Bookmark;
  try
    //pega as linhas selecionadas da gride
    oBookmarkList := dbGrdEmails.SelectedRows;
    for n:=0 to oBookmarkList.Count-1 do
    begin
      //move o cursor da query para cada registro selecionado na gride
      zQryPesquisa.Bookmark := oBookmarkList[n];
      frmEnviarEmail.DeletarEmailDaLista(zQryPesquisa.FieldByName('email').AsString);
    end;
  finally
    //volta para o registro inicial
    zQryPesquisa.Bookmark := oBookmark;
  end;
end;

procedure TfrmPesquisaEmails.dbGrdEmailsDblClick(Sender: TObject);
begin
  EditarEmail;
end;          

procedure TfrmPesquisaEmails.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #27) then
    Close;
end;

end.
