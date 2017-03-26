unit unDicas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, plsMemo, Buttons, DB, Provider, DBClient,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmDicas = class(TForm)
    plsMmDicas: TPlsMemo;
    lblTituloCadastroPor: TLabel;
    btBtnProximo: TBitBtn;
    btBtnAnterior: TBitBtn;
    zQryDicas: TZQuery;
    cdsDicas: TClientDataSet;
    dspDicas: TDataSetProvider;
    zQryDicasCODIGO: TIntegerField;
    zQryDicasCOD_FK_USUARIO: TIntegerField;
    zQryDicasTELA: TStringField;
    zQryDicasDICA: TStringField;
    zQryDicasDATA_CADASTRO: TDateTimeField;
    zQryDicasNOME: TStringField;
    cdsDicasCODIGO: TIntegerField;
    cdsDicasCOD_FK_USUARIO: TIntegerField;
    cdsDicasTELA: TStringField;
    cdsDicasDICA: TStringField;
    cdsDicasDATA_CADASTRO: TDateTimeField;
    cdsDicasNOME: TStringField;
    lblCadastradoPor: TLabel;
    lblCountDicas: TLabel;
    procedure btBtnAnteriorClick(Sender: TObject);
    procedure btBtnProximoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FnTelaDicas: Integer;
    procedure FormatarTelaDicas;
    procedure MontarExecutarSelect;
    procedure MostrarPrimeiroRegistro;
    procedure MostrarDados;
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant);
    function VerificarExisteRegistro: Boolean;    
  end;

var
  frmDicas: TfrmDicas;

implementation

uses unConstantes, unDM;

{$R *.dfm}

procedure TfrmDicas.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = PRM_DEFINE_TELA_DICAS)then
  begin
    if(VarIsNumeric(pValores))then
    begin
      FnTelaDicas := pValores;
      FormatarTelaDicas;
      MontarExecutarSelect;
      MostrarPrimeiroRegistro;
    end;
  end
  else if(pTipo = PRM_FORM_DICAS_VISIBLE_TRUE)then
    frmDicas.Visible := True;
end;

procedure TfrmDicas.FormatarTelaDicas;
begin
  case FnTelaDicas of
    FORM_CAD_CIDADE: frmDicas.Caption := 'Dicas --> Cidade';
    FORM_CAD_BAIRRO: frmDicas.Caption := 'Dicas --> Bairro';
    FORM_CAD_RUA: frmDicas.Caption := 'Dicas --> Rua';
    FORM_CAD_REGIAO_LOCALIDADE: frmDicas.Caption := 'Dicas --> Região Localidade';
    FORM_CAD_CONSTUTORA: frmDicas.Caption := 'Dicas --> Construtora';
    FORM_CAD_PROFISSAO: frmDicas.Caption := 'Dicas --> Profissão';
    FORM_CAD_MEIO_CAPTACAO: frmDicas.Caption := 'Dicas --> Meio de Captação';
    FORM_CAD_GRUPO_CONFIGURACAO_IMOVEL: frmDicas.Caption := 'Dicas --> Grupo de Configuração do Imóvel';
    FORM_CAD_SUB_GRUPO_CONF_IMOVEL: frmDicas.Caption := 'Dicas --> Sub-Grupo de Configuração do Imóvel';
  end;
end;

procedure TfrmDicas.MontarExecutarSelect;
begin
  cdsDicas.Close;
  zQryDicas.Close;
  zQryDicas.SQL.Clear;
  zQryDicas.SQL.Add('SELECT d.codigo,d.cod_fk_usuario,d.tela,d.dica,d.data_cadastro, ');
  zQryDicas.SQL.Add('u.nome ');
  zQryDicas.SQL.Add('FROM dicas d ');
  zQryDicas.SQL.Add('JOIN usuario u ON d.cod_fk_usuario=u.codigo ');
  zQryDicas.SQL.Add('WHERE d.tela = :tela');
  zQryDicas.SQL.Add('ORDER BY d.codigo');
  case FnTelaDicas of
    FORM_CAD_CIDADE: zQryDicas.ParamByName('tela').AsString := 'CIDADE';
    FORM_CAD_BAIRRO: zQryDicas.ParamByName('tela').AsString := 'BAIRRO';
    FORM_CAD_RUA: zQryDicas.ParamByName('tela').AsString := 'RUA';
    FORM_CAD_REGIAO_LOCALIDADE: zQryDicas.ParamByName('tela').AsString := 'REGIAO LOCALIDADE';
    FORM_CAD_CONSTUTORA: zQryDicas.ParamByName('tela').AsString := 'CONSTRUTORA';
    FORM_CAD_PROFISSAO: zQryDicas.ParamByName('tela').AsString := 'PROFISSÃO';
    FORM_CAD_MEIO_CAPTACAO: zQryDicas.ParamByName('tela').AsString := 'MEIO DE CAPTAÇÃO';
    FORM_CAD_GRUPO_CONFIGURACAO_IMOVEL: zQryDicas.ParamByName('tela').AsString := 'GRUPO DE CONFIGURAÇÃO DO IMÓVEL';
    FORM_CAD_SUB_GRUPO_CONF_IMOVEL: zQryDicas.ParamByName('tela').AsString := 'SUB-GRUPO DE CONFIGURAÇÃO DO IMÓVEL';
  end;
  zQryDicas.Open;
  cdsDicas.Open;
end;

function TfrmDicas.VerificarExisteRegistro: Boolean;
var
  bRetorno: Boolean;
begin
  bRetorno := True;
  if(cdsDicas.RecordCount <= NUMERO_INDEFINIDO)then
  begin
    MessageDlg('Não há dicas para esta tela.', mtInformation, [mbOK], 0);
    bRetorno := False;
  end;

  Result := bRetorno;
end;

procedure TfrmDicas.MostrarPrimeiroRegistro;
begin
  if(cdsDicas.Active)and(cdsDicas.RecordCount > NUMERO_INDEFINIDO)then
  begin
    cdsDicas.First;
    MostrarDados;
  end;
end;

procedure TfrmDicas.MostrarDados;
begin
  plsMmDicas.Text := cdsDicasDICA.AsString;
  lblCadastradoPor.Caption := cdsDicasNOME.AsString;

  lblCountDicas.Caption := IntToStr(cdsDicas.RecNo) + ' de ' + IntToStr(cdsDicas.RecordCount);
end;

procedure TfrmDicas.btBtnAnteriorClick(Sender: TObject);
begin
  cdsDicas.Prior;
  MostrarDados;
end;

procedure TfrmDicas.btBtnProximoClick(Sender: TObject);
begin
  cdsDicas.Next;
  MostrarDados;
end;

procedure TfrmDicas.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key=#27)then
    Self.Close;
end;

end.
