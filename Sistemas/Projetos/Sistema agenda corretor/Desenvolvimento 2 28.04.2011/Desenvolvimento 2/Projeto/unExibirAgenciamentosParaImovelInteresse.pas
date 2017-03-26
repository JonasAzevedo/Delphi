unit unExibirAgenciamentosParaImovelInteresse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrid, DB, DBClient, StdCtrls,
  Buttons, DBGrids, ImgList, ComCtrls, AppEvnts, unFuncoes, ExtCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, AdvCircularProgress;

type
    TControlaFonteGride = record
      campo: String; //campo verifica se o valor é 'igual'
      isIgual: Boolean;
    end;  

type
  TfrmAgenciamentosParaImovelInteresse = class(TForm)
    dsAgenciamentos: TDataSource;
    cdsAgenciamentos: TClientDataSet;
    ImageList: TImageList;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    zQryImovInteresse: TZQuery;
    grpBxImovInteresse: TGroupBox;
    lblInfValorImovel: TLabel;
    lblInfCodigoImovInteresse: TLabel;
    lblCodigoImovInteresse: TLabel;
    lblInfAtivo: TLabel;
    lblAtivo: TLabel;
    lblValorImovel: TLabel;
    lblInfFinalidadeImovel: TLabel;
    lblFinalidadeImovel: TLabel;
    lblInfImovelDesejavel: TLabel;
    lblImovelDesejavel: TLabel;
    lblInfCondicaoPgto: TLabel;
    lblCondicaoPgto: TLabel;
    lblNomePessoa: TLabel;
    lblInfTipoImovel: TLabel;
    lblInfTipoPessoa: TLabel;
    lblTipoImovel: TLabel;
    lblTipoPessoa: TLabel;
    lblInfCaracteristicas: TLabel;
    lblCaracteristicas: TLabel;
    zQryImovInteresseCODIMOVINTERESSE: TIntegerField;
    zQryImovInteresseATIVO: TStringField;
    zQryImovInteresseFINALIDADE_IMOVEL: TStringField;
    zQryImovInteresseIMOVEL_DESEJAVEL: TStringField;
    zQryImovInteresseCONDICAO_PAGAMENTO: TStringField;
    zQryImovInteresseVALOR_IMOVEL: TFloatField;
    zQryImovInteresseCARACTERISTICASIMOVINTERESSE: TStringField;
    zQryImovInteresseTIPO_PESSOA: TStringField;
    zQryImovInteresseNOME_TIPO_PESSOA: TStringField;
    zQryImovInteresseNOMETIPOIMOVEL: TStringField;
    zQryRegiaoLocalidadeImovInteresse: TZQuery;
    zQryRegiaoLocalidadeImovInteresseCODIGO: TIntegerField;
    zQryRegiaoLocalidadeImovInteresseCOD_FK_IMOVEL_DE_INTERESSE: TIntegerField;
    zQryRegiaoLocalidadeImovInteresseCOD_FK_REGIAO_LOCALIDADE: TIntegerField;
    zQryRegiaoLocalidadeImovInteresseNOMEREGIAOLOCALIDADE: TStringField;
    lblInfRegiaoLocalidade: TLabel;
    lblRegiaoLocalidade: TLabel;
    pnlDivisao: TPanel;
    pnlAgenciamentos: TPanel;
    lblDescricaoTela: TLabel;
    dbGrdAgenciamento: TDBGrid;
    zQryCompletarAgenciamentos: TZQuery;
    zQryCompletarAgenciamentosCODIGO: TIntegerField;
    zQryCompletarAgenciamentosCONDICAO_PAGAMENTO: TStringField;
    zQryCompletarAgenciamentosVALOR_TOTAL: TFloatField;
    zQryCompletarAgenciamentosSITUACAO_DESEJAVEL: TStringField;
    zQryCompletarAgenciamentosDESCRICAO: TStringField;
    zQryCompletarAgenciamentosNOMETIPOIMOVEL: TStringField;
    zQryCompletarAgenciamentosNOMECIDADE: TStringField;
    zQryCompletarAgenciamentosNOMEBAIRRO: TStringField;
    lblAbrirExplicacaoRelevancia: TLabel;
    ckBxTipoImovelIgual: TCheckBox;
    ckBxSituacaoIgual: TCheckBox;
    ckBxCondPgtoIgual: TCheckBox;
    ckBxValorIgual: TCheckBox;
    ckBxCaracImovelIgual: TCheckBox;
    ckBxRegiaoLocalidadeIgual: TCheckBox;
    cdsAgenciamentosFixo: TClientDataSet;
    lblFiltrar: TLabel;
    lblTotalRegistros: TLabel;
    procedure dbGrdAgenciamentoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbGrdAgenciamentoDblClick(Sender: TObject);
    procedure dbGrdAgenciamentoTitleClick(Column: TColumn);
    procedure cdsAgenciamentosAfterScroll(DataSet: TDataSet);
    procedure lblAbrirExplicacaoRelevanciaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ckBxTipoImovelIgualClick(Sender: TObject);
    procedure ckBxSituacaoIgualClick(Sender: TObject);
    procedure ckBxCondPgtoIgualClick(Sender: TObject);
    procedure ckBxValorIgualClick(Sender: TObject);
    procedure ckBxCaracImovelIgualClick(Sender: TObject);
    procedure ckBxRegiaoLocalidadeIgualClick(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
    FnCodImovInteresse: Integer;
    FoControlaFonteGride: TControlaFonteGride;
    procedure LimparControlaFonteGride;

    procedure CriarDataSetAgenciamento;
    procedure ExibirDetalhesAgenciamento;
    procedure SelecionarMostrarDadosImovInteresse;
    procedure DetalharNecessidadesAtendidas;
    procedure PovoarDadosEmBracoDataSet;
    procedure FiltrarAgenciamentos;
    procedure CriarIndiceOrdenarPeso;
    procedure MostrarTotalRegistros;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant);
  end;

var
  frmAgenciamentosParaImovelInteresse: TfrmAgenciamentosParaImovelInteresse;

implementation

uses unConstantes,unExibeDadosAgenciamento, unDM, unExplicacao;

{$R *.dfm}

{ TfrmAgenciamentosParaImovelInteresse }

(* procedimentos de controle *)

procedure TfrmAgenciamentosParaImovelInteresse.passarParametro(
  pTipo: String; pValores: OleVariant);
var
  cdsAux: TClientDataSet;
begin
  if(pTipo = PRM_PASSAR_CODIGO_IMOVEL_INTERESSE)then
  begin
    if(VarIsNumeric(pValores))then
      FnCodImovInteresse := pValores
    else
      FnCodImovInteresse := NUMERO_INDEFINIDO;
    SelecionarMostrarDadosImovInteresse;
  end

  else if(pTipo = PRM_PASSAR_DATA_SET)then
  begin
    try
      cdsAux := TClientDataSet.Create(nil);
      cdsAux.Data := pValores;
      CriarDataSetAgenciamento;
      if(cdsAux.Active)and(cdsAux.RecordCount > NUMERO_INDEFINIDO)then
      begin
        cdsAux.First;
        while not(cdsAux.Eof)do
        begin
          cdsAgenciamentos.Append;
          cdsAgenciamentos.FieldByName('CODIGO').AsInteger := cdsAux.FieldByName('CODIGO').AsInteger;
          cdsAgenciamentos.FieldByName('IGUAL_TIPO_IMOVEL').AsInteger := cdsAux.FieldByName('IGUAL_TIPO_IMOVEL').AsInteger;
          cdsAgenciamentos.FieldByName('VALOR_TIPO_IMOVEL').AsString := cdsAux.FieldByName('VALOR_TIPO_IMOVEL').AsString;
          cdsAgenciamentos.FieldByName('IGUAL_SITUACAO').AsInteger := cdsAux.FieldByName('IGUAL_SITUACAO').AsInteger;
          cdsAgenciamentos.FieldByName('VALOR_SITUACAO').AsString := cdsAux.FieldByName('VALOR_SITUACAO').AsString;
          cdsAgenciamentos.FieldByName('IGUAL_CONDICAO_PAGAMENTO').AsInteger := cdsAux.FieldByName('IGUAL_CONDICAO_PAGAMENTO').AsInteger;
          cdsAgenciamentos.FieldByName('VALOR_CONDICAO_PAGAMENTO').AsString := cdsAux.FieldByName('VALOR_CONDICAO_PAGAMENTO').AsString;
          cdsAgenciamentos.FieldByName('IGUAL_VALOR').AsInteger := cdsAux.FieldByName('IGUAL_VALOR').AsInteger;
          cdsAgenciamentos.FieldByName('VALOR_VALOR').AsString := cdsAux.FieldByName('VALOR_VALOR').AsString;
          cdsAgenciamentos.FieldByName('IGUAL_CARACTERISTICAS_IMOVEL').AsInteger := cdsAux.FieldByName('IGUAL_CARACTERISTICAS_IMOVEL').AsInteger;
          cdsAgenciamentos.FieldByName('VALOR_CARACTERISTICAS_IMOVEL').AsString := cdsAux.FieldByName('VALOR_CARACTERISTICAS_IMOVEL').AsString;
          cdsAgenciamentos.FieldByName('IGUAL_REGIAO_LOCALIDADE').AsInteger := cdsAux.FieldByName('IGUAL_REGIAO_LOCALIDADE').AsInteger;
          cdsAgenciamentos.FieldByName('VALOR_REGIAO_LOCALIDADE').AsString := cdsAux.FieldByName('VALOR_REGIAO_LOCALIDADE').AsString;
          cdsAgenciamentos.FieldByName('PESO').AsInteger := cdsAux.FieldByName('PESO').AsInteger;
          cdsAgenciamentos.Post;
          cdsAux.Next;
        end;
        PovoarDadosEmBracoDataSet;
        FoFuncoes.FormatarValorMonetarioEmBloco(cdsAgenciamentos,'VALOR_VALOR');
        //FoFuncoes.AjustarLarguraColunasTDBGrid(dbGrdAgenciamento);
        cdsAgenciamentosFixo.Data := cdsAgenciamentos.Data;
        CriarIndiceOrdenarPeso;
        MostrarTotalRegistros;
        cdsAgenciamentos.First;
      end;
    finally
      FreeAndNil(cdsAux);
    end;
  end;
end;

procedure TfrmAgenciamentosParaImovelInteresse.LimparControlaFonteGride;
begin
  FoControlaFonteGride.campo := STRING_INDEFINIDO;
  FoControlaFonteGride.isIgual := False;
end;

procedure TfrmAgenciamentosParaImovelInteresse.CriarDataSetAgenciamento;
begin
  if cdsAgenciamentos.Active then
    cdsAgenciamentos.EmptyDataSet;
  cdsAgenciamentos.FieldDefs.Add('CODIGO', ftInteger, 0, True); //código do agenciamento
  cdsAgenciamentos.FieldDefs.Add('IGUAL_TIPO_IMOVEL', ftInteger, 0, False); //tipo do imóvel igual
  cdsAgenciamentos.FieldDefs.Add('VALOR_TIPO_IMOVEL', ftString, 60, False); //valor do tipo do imóvel
  cdsAgenciamentos.FieldDefs.Add('IGUAL_SITUACAO', ftInteger, 0, False); //situação do imóvel igual
  cdsAgenciamentos.FieldDefs.Add('VALOR_SITUACAO', ftString, 20, False); //valor da situação
  cdsAgenciamentos.FieldDefs.Add('IGUAL_CONDICAO_PAGAMENTO', ftInteger, 0, False); //condição de pagamento igual
  cdsAgenciamentos.FieldDefs.Add('VALOR_CONDICAO_PAGAMENTO', ftString, 20, False); //valor da condição de pagamento
  cdsAgenciamentos.FieldDefs.Add('IGUAL_VALOR', ftInteger, 0, False); //valor igual
  cdsAgenciamentos.FieldDefs.Add('VALOR_VALOR', ftString, 20, False); //valor do valor
  cdsAgenciamentos.FieldDefs.Add('IGUAL_CARACTERISTICAS_IMOVEL', ftInteger, 0, False); //características do imóvel igual
  cdsAgenciamentos.FieldDefs.Add('VALOR_CARACTERISTICAS_IMOVEL', ftString, 500, False); //valor das características do imóvel
  cdsAgenciamentos.FieldDefs.Add('IGUAL_REGIAO_LOCALIDADE', ftInteger, 0, False); //região localidade do imóvel igual
  cdsAgenciamentos.FieldDefs.Add('VALOR_REGIAO_LOCALIDADE', ftString, 500, False); //valor das regiões localidades do imóvel
  cdsAgenciamentos.FieldDefs.Add('PESO', ftInteger, 0, False); //peso do agenciamento
  cdsAgenciamentos.CreateDataSet;
end;

procedure TfrmAgenciamentosParaImovelInteresse.ExibirDetalhesAgenciamento;
begin
  try
    Application.CreateForm(TfrmExibeDadosAgenciamento,frmExibeDadosAgenciamento);
    frmExibeDadosAgenciamento.passarParametro(PRM_PESQUISAR_AGENCIAMENTO,cdsAgenciamentos.FieldByName('CODIGO').AsInteger);
    frmExibeDadosAgenciamento.ShowModal;
  finally
    FreeAndNil(frmExibeDadosAgenciamento);
  end;
end;

procedure TfrmAgenciamentosParaImovelInteresse.SelecionarMostrarDadosImovInteresse;
  //dados das região localidade do imóvel de interesse
  procedure SelecionarMostrarRegiaoLocalidade;
  var
    sRegioes: string;
  begin
    sRegioes := STRING_INDEFINIDO;
    zQryRegiaoLocalidadeImovInteresse.Close;
    zQryRegiaoLocalidadeImovInteresse.SQL.Clear;
    zQryRegiaoLocalidadeImovInteresse.SQL.Add('SELECT i.codigo,i.cod_fk_imovel_de_interesse,i.cod_fk_regiao_localidade,');
    zQryRegiaoLocalidadeImovInteresse.SQL.Add('r.nome AS nomeRegiaoLocalidade ');
    zQryRegiaoLocalidadeImovInteresse.SQL.Add('FROM imov_interesse_regiao_local i ');
    zQryRegiaoLocalidadeImovInteresse.SQL.Add('JOIN regiao_localidade r ON i.cod_fk_regiao_localidade=r.codigo ');
    zQryRegiaoLocalidadeImovInteresse.SQL.Add('WHERE i.cod_fk_imovel_de_interesse=:codigo');
    zQryRegiaoLocalidadeImovInteresse.ParamByName('codigo').AsInteger := FnCodImovInteresse;
    zQryRegiaoLocalidadeImovInteresse.Open;
    if(zQryRegiaoLocalidadeImovInteresse.Active)and(zQryRegiaoLocalidadeImovInteresse.RecordCount > NUMERO_INDEFINIDO)then
    begin
      zQryRegiaoLocalidadeImovInteresse.First;
      while not(zQryRegiaoLocalidadeImovInteresse.Eof)do
      begin
        if(sRegioes <> STRING_INDEFINIDO)then
          sRegioes := sRegioes + ', ';
        sRegioes := sRegioes + zQryRegiaoLocalidadeImovInteresseNOMEREGIAOLOCALIDADE.AsString;
        zQryRegiaoLocalidadeImovInteresse.Next;
      end;
    end;
    lblRegiaoLocalidade.Caption := sRegioes;
  end;
  
begin
  if(FnCodImovInteresse <> NUMERO_INDEFINIDO)then
  begin
    //dados do imóvel de interesse
    zQryImovInteresse.Close;
    zQryImovInteresse.SQL.Clear;
    zQryImovInteresse.SQL.Add('SELECT i.codigo AS codImovInteresse,i.ativo,');
    zQryImovInteresse.SQL.Add('i.finalidade_imovel,i.imovel_desejavel,');
    zQryImovInteresse.SQL.Add('i.condicao_pagamento,i.valor_imovel,');
    zQryImovInteresse.SQL.Add('i.caracteristicas AS caracteristicasImovInteresse,');
    zQryImovInteresse.SQL.Add('i.tipo_pessoa,');
    zQryImovInteresse.SQL.Add('CASE WHEN i.tipo_pessoa =''FÍSICA'' THEN pf.nome ');
    zQryImovInteresse.SQL.Add('WHEN i.tipo_pessoa = ''JURÍDICA'' THEN pj.nome ');
    zQryImovInteresse.SQL.Add('ELSE ''NENHUMA'' END AS NOME_TIPO_PESSOA,');
    zQryImovInteresse.SQL.Add('t.nome AS nomeTipoImovel ');
    zQryImovInteresse.SQL.Add('FROM imovel_de_interesse i ');
    zQryImovInteresse.SQL.Add('JOIN tipo_imovel t ON i.cod_fk_tipo_imovel=t.codigo ');
    zQryImovInteresse.SQL.Add('LEFT JOIN agenc_pessoa_fisica pf ON i.cod_fk_cliente_pessoa_fisica = pf.codigo ');
    zQryImovInteresse.SQL.Add('LEFT JOIN agenc_pessoa_juridica pj ON i.cod_fk_cliente_pessoa_juridica = pj.codigo ');
    zQryImovInteresse.SQL.Add('WHERE i.codigo = :codigo');
    zQryImovInteresse.ParamByName('codigo').AsInteger := FnCodImovInteresse;
    zQryImovInteresse.Open;
    if(zQryImovInteresse.Active)and(zQryImovInteresse.RecordCount = 1)then
    begin
      lblCodigoImovInteresse.Caption := zQryImovInteresseCODIMOVINTERESSE.AsString;
      lblAtivo.Caption := zQryImovInteresseATIVO.AsString;
      lblCondicaoPgto.Caption := zQryImovInteresseCONDICAO_PAGAMENTO.AsString;
      lblValorImovel.Caption := FoFuncoes.formatarValorMonetario(zQryImovInteresseVALOR_IMOVEL.AsString);
      lblTipoImovel.Caption := zQryImovInteresseNOMETIPOIMOVEL.AsString;
      lblFinalidadeImovel.Caption := zQryImovInteresseFINALIDADE_IMOVEL.AsString;
      lblImovelDesejavel.Caption := zQryImovInteresseIMOVEL_DESEJAVEL.AsString;
      lblTipoPessoa.Caption := zQryImovInteresseTIPO_PESSOA.AsString;
      lblNomePessoa.Caption := zQryImovInteresseNOME_TIPO_PESSOA.AsString;
      lblCaracteristicas.Caption := zQryImovInteresseCARACTERISTICASIMOVINTERESSE.AsString;
      SelecionarMostrarRegiaoLocalidade;
    end;
  end;
end;

procedure TfrmAgenciamentosParaImovelInteresse.DetalharNecessidadesAtendidas;

  function GetColor(sCampo:String): TColor;
  begin
    Result := clBlack; //default
    if(cdsAgenciamentos.FieldByName(sCampo).AsString = '1')then
      Result := clRed;
  end;

  function GetFontStyle(sCampo:string): TFontStyle;
  begin
//    Result := ; //default
    if(cdsAgenciamentos.FieldByName(sCampo).AsString = '1')then
      Result := fsBold;
  end;

begin
  lblTipoImovel.Font.Color := GetColor('IGUAL_TIPO_IMOVEL');
  lblTipoImovel.Font.Style := [GetFontStyle('IGUAL_TIPO_IMOVEL')];

  lblImovelDesejavel.Font.Color := GetColor('IGUAL_SITUACAO');
  lblImovelDesejavel.Font.Style := [GetFontStyle('IGUAL_SITUACAO')];

  lblCondicaoPgto.Font.Color := GetColor('IGUAL_CONDICAO_PAGAMENTO');
  lblCondicaoPgto.Font.Style := [GetFontStyle('IGUAL_CONDICAO_PAGAMENTO')];

  lblValorImovel.Font.Color := GetColor('IGUAL_VALOR');
  lblValorImovel.Font.Style := [GetFontStyle('IGUAL_VALOR')];

  lblCaracteristicas.Font.Color := GetColor('IGUAL_CARACTERISTICAS_IMOVEL');
  lblCaracteristicas.Font.Style := [GetFontStyle('IGUAL_CARACTERISTICAS_IMOVEL')];

  lblRegiaoLocalidade.Font.Color := GetColor('IGUAL_REGIAO_LOCALIDADE');
  lblRegiaoLocalidade.Font.Style := [GetFontStyle('IGUAL_REGIAO_LOCALIDADE')];
end;

procedure TfrmAgenciamentosParaImovelInteresse.PovoarDadosEmBracoDataSet;
var
  sCodAgenciamentos: String;
  sCondicaoAgenciamento: String;
begin
  sCodAgenciamentos := STRING_INDEFINIDO;
  sCondicaoAgenciamento := STRING_INDEFINIDO;

  if(cdsAgenciamentos.Active)and(cdsAgenciamentos.RecordCount > NUMERO_INDEFINIDO)then
  begin
    //pegando código dos agenciamentos
    cdsAgenciamentos.First;
    while not(cdsAgenciamentos.Eof)do
    begin
      if(sCodAgenciamentos <> STRING_INDEFINIDO)then
        sCodAgenciamentos := sCodAgenciamentos + ',';
      sCodAgenciamentos := sCodAgenciamentos + cdsAgenciamentos.FieldByName('CODIGO').AsString;
      cdsAgenciamentos.Next;
    end;
    sCondicaoAgenciamento := 'AND a.codigo IN (' +sCodAgenciamentos+ ')';

    //selecionando agenciamentos
    zQryCompletarAgenciamentos.Close;
    zQryCompletarAgenciamentos.SQL.Clear;
    zQryCompletarAgenciamentos.SQL.Add('SELECT a.codigo,a.condicao_pagamento,a.valor_total,');
    zQryCompletarAgenciamentos.SQL.Add('i.situacao_desejavel,i.descricao,t.nome AS nomeTipoImovel,');
    zQryCompletarAgenciamentos.SQL.Add('c.nome AS nomeCidade,b.nome AS nomeBairro ');
    zQryCompletarAgenciamentos.SQL.Add('FROM agenciamentos a ');
    zQryCompletarAgenciamentos.SQL.Add('JOIN imovel i ON a.cod_fk_imovel=i.codigo ');
    zQryCompletarAgenciamentos.SQL.Add('JOIN tipo_imovel t ON i.cod_fk_tipo_imovel=t.codigo ');
    zQryCompletarAgenciamentos.SQL.Add('JOIN cidade c ON i.cod_fk_cidade=c.codigo ');
    zQryCompletarAgenciamentos.SQL.Add('JOIN bairro b ON i.cod_fk_bairro=b.codigo ');
    zQryCompletarAgenciamentos.SQL.Add(sCondicaoAgenciamento);
    zQryCompletarAgenciamentos.Open;

    //povoando o clientDataSet cdsAgenciamentos
    if(zQryCompletarAgenciamentos.Active)and(zQryCompletarAgenciamentos.RecordCount > NUMERO_INDEFINIDO)then
    begin
      zQryCompletarAgenciamentos.First;
      while not(zQryCompletarAgenciamentos.Eof)do
      begin
        cdsAgenciamentos.First;
        if(cdsAgenciamentos.Locate('CODIGO',zQryCompletarAgenciamentosCODIGO.AsInteger,[]))then
        begin
          cdsAgenciamentos.Edit;
          if(cdsAgenciamentos.FieldByName('IGUAL_TIPO_IMOVEL').AsInteger = VLR_DESLIGADO)then
            cdsAgenciamentos.FieldByName('VALOR_TIPO_IMOVEL').AsString := zQryCompletarAgenciamentosNOMETIPOIMOVEL.AsString;
          if(cdsAgenciamentos.FieldByName('IGUAL_SITUACAO').AsInteger = VLR_DESLIGADO)then
            cdsAgenciamentos.FieldByName('VALOR_SITUACAO').AsString := zQryCompletarAgenciamentosSITUACAO_DESEJAVEL.AsString;
          if(cdsAgenciamentos.FieldByName('IGUAL_CONDICAO_PAGAMENTO').AsInteger = VLR_DESLIGADO)then
            cdsAgenciamentos.FieldByName('VALOR_CONDICAO_PAGAMENTO').AsString := zQryCompletarAgenciamentosCONDICAO_PAGAMENTO.AsString;
          if(cdsAgenciamentos.FieldByName('IGUAL_VALOR').AsInteger = VLR_DESLIGADO)then
            cdsAgenciamentos.FieldByName('VALOR_VALOR').AsString := zQryCompletarAgenciamentosVALOR_TOTAL.AsString;
          if(cdsAgenciamentos.FieldByName('IGUAL_CARACTERISTICAS_IMOVEL').AsInteger = VLR_DESLIGADO)then
            cdsAgenciamentos.FieldByName('VALOR_CARACTERISTICAS_IMOVEL').AsString := zQryCompletarAgenciamentosDESCRICAO.AsString;
          if(cdsAgenciamentos.FieldByName('IGUAL_REGIAO_LOCALIDADE').AsInteger = VLR_DESLIGADO)then
            cdsAgenciamentos.FieldByName('VALOR_REGIAO_LOCALIDADE').AsString := zQryCompletarAgenciamentosNOMECIDADE.AsString + ' - ' + zQryCompletarAgenciamentosNOMEBAIRRO.AsString;
          cdsAgenciamentos.Post;
        end;                    
        zQryCompletarAgenciamentos.Next;
      end;
    end;
  end;
end;

procedure TfrmAgenciamentosParaImovelInteresse.FiltrarAgenciamentos;
var
  bTipoImovel,bSituacao,bCondPgto,bValor,bCaracImovel,bRegiaoLocal: Boolean;

  function Filtrar:Boolean;
  begin
    (*if(bTipoImovel)or(bSituacao)or(bCondPgto)or(bValor)or(bCaracImovel)or(bRegiaoLocal)then
      Result := True
    else
      Result := False;
    *)
    Result := True;      
  end;

begin
  bTipoImovel := ckBxTipoImovelIgual.Checked;
  bSituacao := ckBxSituacaoIgual.Checked;
  bCondPgto := ckBxCondPgtoIgual.Checked;
  bValor := ckBxValorIgual.Checked;
  bCaracImovel := ckBxCaracImovelIgual.Checked;
  bRegiaoLocal := ckBxRegiaoLocalidadeIgual.Checked;

  if Filtrar then
  begin
    cdsAgenciamentos.DisableControls;
    cdsAgenciamentos.IndexDefs.Clear;
    cdsAgenciamentos.IndexName := STRING_INDEFINIDO;
    cdsAgenciamentos.Close;

    cdsAgenciamentos.Data := cdsAgenciamentosFixo.Data;
    cdsAgenciamentos.First;
    while not(cdsAgenciamentos.Eof)do
    begin
      if(bTipoImovel)then
      begin
        if(cdsAgenciamentos.FieldByName('IGUAL_TIPO_IMOVEL').AsInteger = VLR_DESLIGADO)then
        begin
          cdsAgenciamentos.Delete;
          Continue;
        end;
      end;
      if(bSituacao)then
      begin
        if(cdsAgenciamentos.FieldByName('IGUAL_SITUACAO').AsInteger = VLR_DESLIGADO)then
        begin
          cdsAgenciamentos.Delete;
          Continue;
        end;
      end;
      if(bCondPgto)then
      begin
        if(cdsAgenciamentos.FieldByName('IGUAL_CONDICAO_PAGAMENTO').AsInteger = VLR_DESLIGADO)then
        begin
          cdsAgenciamentos.Delete;
          Continue;
        end;
      end;
      if(bValor)then
      begin
        if(cdsAgenciamentos.FieldByName('IGUAL_VALOR').AsInteger = VLR_DESLIGADO)then
        begin
          cdsAgenciamentos.Delete;
          Continue;
        end;
      end;
      if(bCaracImovel)then
      begin
        if(cdsAgenciamentos.FieldByName('IGUAL_CARACTERISTICAS_IMOVEL').AsInteger = VLR_DESLIGADO)then
        begin
          cdsAgenciamentos.Delete;
          Continue;
        end;
      end;
      if(bRegiaoLocal)then
      begin
        if(cdsAgenciamentos.FieldByName('IGUAL_REGIAO_LOCALIDADE').AsInteger = VLR_DESLIGADO)then
        begin
          cdsAgenciamentos.Delete;
          Continue;
        end;
      end;
      cdsAgenciamentos.Next;
    end;
    cdsAgenciamentos.EnableControls;
    MostrarTotalRegistros;
    CriarIndiceOrdenarPeso;
  end;
end;

//criando o índice para ordenar os dados pelo PESO
//cdsAgenciamentos.IndexFieldNames := 'PESO';
procedure TfrmAgenciamentosParaImovelInteresse.CriarIndiceOrdenarPeso;
var
  sIndexName: String;
  options: TIndexOptions;
begin
  sIndexName := 'PESO_DESC';
  options := [ixDescending];
  cdsAgenciamentos.IndexDefs.Update;
  cdsAgenciamentos.AddIndex(sIndexName, 'PESO', options);
  cdsAgenciamentos.IndexName := sIndexName;
  //cdsAgenciamentosFixo.IndexDefs.Update;
  //cdsAgenciamentosFixo.AddIndex(sIndexName, 'PESO', options);
  //cdsAgenciamentosFixo.IndexName := sIndexName;
end;

procedure TfrmAgenciamentosParaImovelInteresse.MostrarTotalRegistros;
begin
  if(cdsAgenciamentos.Active)then
  begin
    lblTotalRegistros.Visible := True;
    lblTotalRegistros.Caption := 'Total Registros: ' + IntToStr(cdsAgenciamentos.RecordCount);
  end
  else
  begin
    lblTotalRegistros.Visible := False;
  end;
end;

(* fim - procedimentos de controle *)

procedure TfrmAgenciamentosParaImovelInteresse.dbGrdAgenciamentoDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  sColuna: String;

  function GetColunaIgual: String;
  begin
    if Column.FieldName='IGUAL_TIPO_IMOVEL' then
      Result := 'IGUAL_TIPO_IMOVEL'
    else if Column.FieldName='IGUAL_SITUACAO' then
      Result := 'IGUAL_SITUACAO'
    else if Column.FieldName='IGUAL_CONDICAO_PAGAMENTO' then
      Result := 'IGUAL_CONDICAO_PAGAMENTO'
    else if Column.FieldName='IGUAL_VALOR' then
      Result := 'IGUAL_VALOR'
    else if Column.FieldName='IGUAL_CARACTERISTICAS_IMOVEL' then
      Result := 'IGUAL_CARACTERISTICAS_IMOVEL'
    else if Column.FieldName='IGUAL_REGIAO_LOCALIDADE' then
      Result := 'IGUAL_REGIAO_LOCALIDADE'
    else
      Result := STRING_INDEFINIDO;
  end;

  function GetColunaValor: Boolean;
  var
    bRetorno: Boolean;
  begin
    bRetorno := False;
    if (Column.FieldName='VALOR_TIPO_IMOVEL')and(FoControlaFonteGride.campo='IGUAL_TIPO_IMOVEL') then
      bRetorno := True
    else if (Column.FieldName='VALOR_SITUACAO')and(FoControlaFonteGride.campo='IGUAL_SITUACAO') then
      bRetorno := True
    else if (Column.FieldName='VALOR_CONDICAO_PAGAMENTO')and(FoControlaFonteGride.campo='IGUAL_CONDICAO_PAGAMENTO') then
      bRetorno := True
    else if (Column.FieldName='VALOR_VALOR')and(FoControlaFonteGride.campo='IGUAL_VALOR') then
      bRetorno := True
    else if (Column.FieldName='VALOR_CARACTERISTICAS_IMOVEL')and(FoControlaFonteGride.campo='IGUAL_CARACTERISTICAS_IMOVEL') then
      bRetorno := True
    else if (Column.FieldName='VALOR_REGIAO_LOCALIDADE')and(FoControlaFonteGride.campo='IGUAL_REGIAO_LOCALIDADE') then
      bRetorno := True;

    Result := bRetorno;
  end;

begin
  sColuna := GetColunaIgual;
  if sColuna <> STRING_INDEFINIDO then //tenta tratar 1º a coluna do campo igual
  begin
    dbGrdAgenciamento.Canvas.FillRect(Rect);
    //desenha o quadrado
    ImageList.Draw(dbGrdAgenciamento.Canvas,Rect.Left+10,Rect.Top+1,0);
    //desenha o check sobre o quadrado quando ativo
    if (cdsAgenciamentos.FieldByName(sColuna).AsString=IntToStr(VLR_LIGADO)) then //cadastro está ativo
    begin
      ImageList.Draw(dbGrdAgenciamento.Canvas,Rect.Left+10,Rect.Top+1,1);
      FoControlaFonteGride.isIgual := True;
    end;
    FoControlaFonteGride.campo := sColuna; //controla a fonte do valor do campo
  end

  else //trata a coluna do campo do valor
  begin
    if GetColunaValor then
    begin
      if FoControlaFonteGride.isIgual = True then
        FoFuncoes.PintarCelulaGride(dbGrdAgenciamento,Rect,DataCol,Column,State,clNone,clGreen,True);
    end;
    LimparControlaFonteGride;
  end;
end;

procedure TfrmAgenciamentosParaImovelInteresse.ApplicationEventsHint(
  Sender: TObject);
begin
  Self.StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmAgenciamentosParaImovelInteresse.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  FnCodImovInteresse := NUMERO_INDEFINIDO;
  LimparControlaFonteGride
end;

procedure TfrmAgenciamentosParaImovelInteresse.FormDestroy(
  Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmAgenciamentosParaImovelInteresse.dbGrdAgenciamentoDblClick(
  Sender: TObject);
begin
  if(cdsAgenciamentos.Active)and(cdsAgenciamentos.RecordCount > NUMERO_INDEFINIDO)then
    ExibirDetalhesAgenciamento;
end;

procedure TfrmAgenciamentosParaImovelInteresse.dbGrdAgenciamentoTitleClick(
  Column: TColumn);
begin
  FoFuncoes.CriarIndiceOrdenarDadosColuna(cdsAgenciamentos,Column);
end;


procedure TfrmAgenciamentosParaImovelInteresse.cdsAgenciamentosAfterScroll(
  DataSet: TDataSet);
begin
  DetalharNecessidadesAtendidas;
end;

procedure TfrmAgenciamentosParaImovelInteresse.lblAbrirExplicacaoRelevanciaClick(
  Sender: TObject);
var
  oForm: TfrmExplicacao;
begin
  try
    Application.CreateForm(TfrmExplicacao,oForm);
    oForm.passarParametro(PRM_ABRIR_EXPLICACAO_PESO_AGENCIAMENTO_ENCONTRADO,null);
    oForm.ShowModal;
  finally
    FreeAndNil(oForm);
  end;
end;

procedure TfrmAgenciamentosParaImovelInteresse.FormKeyPress(
  Sender: TObject; var Key: Char);
begin
  if(Key=#27)then
    Self.Close;
end;

procedure TfrmAgenciamentosParaImovelInteresse.ckBxTipoImovelIgualClick(
  Sender: TObject);
begin
  FiltrarAgenciamentos;
end;

procedure TfrmAgenciamentosParaImovelInteresse.ckBxSituacaoIgualClick(
  Sender: TObject);
begin
  FiltrarAgenciamentos;
end;

procedure TfrmAgenciamentosParaImovelInteresse.ckBxCondPgtoIgualClick(
  Sender: TObject);
begin
  FiltrarAgenciamentos;
end;

procedure TfrmAgenciamentosParaImovelInteresse.ckBxValorIgualClick(
  Sender: TObject);
begin
  FiltrarAgenciamentos;
end;

procedure TfrmAgenciamentosParaImovelInteresse.ckBxCaracImovelIgualClick(
  Sender: TObject);
begin
  FiltrarAgenciamentos;
end;

procedure TfrmAgenciamentosParaImovelInteresse.ckBxRegiaoLocalidadeIgualClick(
  Sender: TObject);
begin
  FiltrarAgenciamentos;
end;

end.

