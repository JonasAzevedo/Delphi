unit unRecibo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB, DBClient, Provider, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, unFuncoes, RLFilters, RLPDFFilter;

type
  TfrmRelRecibo = class(TForm)
    relRecibo: TRLReport;
    RLBand1: TRLBand;
    RLLabel1: TRLLabel;
    zQryCliente: TZQuery;
    dspCliente: TDataSetProvider;
    cdsCliente: TClientDataSet;
    cdsClienteCODIGO: TIntegerField;
    cdsClienteDATA_CADASTRO: TDateTimeField;
    cdsClienteNOME: TStringField;
    cdsClienteCPF: TStringField;
    cdsClienteIDENTIDADE: TStringField;
    cdsClienteCNPJ: TStringField;
    cdsClienteDATA_NASCIMENTO: TDateField;
    cdsClientePROFISSAO: TStringField;
    cdsClienteEMAIL: TStringField;
    cdsClienteTELEFONE_1: TStringField;
    cdsClienteTELEFONE_2: TStringField;
    cdsClienteESTADO: TStringField;
    cdsClienteCIDADE: TStringField;
    cdsClienteBAIRRO: TStringField;
    cdsClienteRUA: TStringField;
    cdsClienteNUMERO: TIntegerField;
    cdsClienteCEP: TStringField;
    cdsClienteCOMPLEMENTO: TStringField;
    zQryClienteCODIGO: TIntegerField;
    zQryClienteDATA_CADASTRO: TDateTimeField;
    zQryClienteNOME: TStringField;
    zQryClienteCPF: TStringField;
    zQryClienteIDENTIDADE: TStringField;
    zQryClienteCNPJ: TStringField;
    zQryClienteDATA_NASCIMENTO: TDateField;
    zQryClientePROFISSAO: TStringField;
    zQryClienteEMAIL: TStringField;
    zQryClienteTELEFONE_1: TStringField;
    zQryClienteTELEFONE_2: TStringField;
    zQryClienteESTADO: TStringField;
    zQryClienteCIDADE: TStringField;
    zQryClienteBAIRRO: TStringField;
    zQryClienteRUA: TStringField;
    zQryClienteNUMERO: TIntegerField;
    zQryClienteCEP: TStringField;
    zQryClienteCOMPLEMENTO: TStringField;
    rlMmTexto: TRLMemo;
    zQryClienteSEXO: TStringField;
    cdsClienteSEXO: TStringField;
    dsCliente: TDataSource;
    rlCidade: TRLLabel;
    rlData: TRLLabel;
    rlAssinatura: TRLLabel;
    rlValor: TRLLabel;
    RLDraw3: TRLDraw;
    RLLabel11: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel10: TRLLabel;
    RLDraw1: TRLDraw;
    RLLabel9: TRLLabel;
    RLLabel3: TRLLabel;
    RLDraw2: TRLDraw;
    RLLabel2: TRLLabel;
    RLPDFFilter: TRLPDFFilter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FoFuncoes: TFuncoes;
    FnTipoRecibo: Integer;
    FnCodCliente: Integer;
    FsValorRecibido: string;
    FnCodPedido: integer;
    FnNumeroParcela: integer;
    FsDtVcto: string;
    FsTpPgtoVista: string;

    procedure PesquisarDados;
    procedure MontarTextoRecibo;
    procedure PosicionarTexto;
  public
    procedure PassaParametro(const psParametro: string; const pvValor: OleVariant);
  end;

implementation

uses unDM, unConstantes;

{$R *.dfm}

{ TfrmRelRecibo }

procedure TfrmRelRecibo.PassaParametro(const psParametro: string; const pvValor: OleVariant);
begin
  if (psParametro = sPRM_TIPO_RECIBO) and (not VarIsNull(pvValor)) then
    FnTipoRecibo := pvValor

  else if (psParametro = sPRM_CLIENTE_RECIBO) and (not VarIsNull(pvValor)) then
    FnCodCliente := pvValor

  else if (psParametro = sPRM_VALOR_RECIBO) then
    FsValorRecibido := FoFuncoes.FormatarValorMonetario(pvValor)

  else if (psParametro = sPRM_CODIGO_PEDIDO) then
    FnCodPedido := pvValor

  else if (psParametro = sPRM_NUMERO_PARCELA) then
    FnNumeroParcela := pvValor

  else if (psParametro = sPRM_DATA_VENCIMENTO) then
    FsDtVcto := pvValor

  //'� vista' ou 'da entrada'.
  else if (psParametro = sPRM_TIPO_PGTO_VISTA) then
    FsTpPgtoVista := pvValor

  else if (psParametro = sPRM_BUSCAR_DADOS_RECIBO) then
  begin
    if FnTipoRecibo = NUMERO_INDEFINIDO then
      Exit;

    PesquisarDados;
    MontarTextoRecibo;
    PosicionarTexto;
  end;
end;

procedure TfrmRelRecibo.PesquisarDados;
begin
  cdsCliente.Close;
  zQryCliente.Close;
  zQryCliente.SQL.Clear;
  zQryCliente.SQL.Add('SELECT * FROM cliente WHERE codigo = :codigo');
  zQryCliente.ParamByName('codigo').AsInteger := FnCodCliente;
  zQryCliente.Open;
  cdsCliente.Open;
end;

procedure TfrmRelRecibo.MontarTextoRecibo;
var
  sTexto: string;

  procedure MontarTextoTipoRecibo;
  begin
    if (FnTipoRecibo = nTP_RECIBO_PGTO_VISTA) then
    begin
      sTexto := sTexto + ' correspondente ao pagamento ' + FsTpPgtoVista + ', ';
      sTexto := sTexto + ' referente ao pedido de n� ' + IntToStr(FnCodPedido) + '.';
    end

    else if (FnTipoRecibo = nTP_RECIBO_PARCELA) then
    begin
      sTexto := sTexto + ' correspondente ao pagamento da parcela n� ' + IntToStr(FnNumeroParcela);
      sTexto := sTexto + ' com vencimento em ' + FsDtVcto + ',';
      sTexto := sTexto + ' referente ao pedido de n� ' + IntToStr(FnCodPedido) + '.';
    end;
  end;

begin
  //verifica se � pessoa jur�dica.
  if (cdsCliente.FieldByName('cnpj').AsString <> STRING_INDEFINIDO) then
  begin
    sTexto := 'Recibi de ';
  end

  //� pessoa f�sica.
  else
  begin
    if (cdsCliente.FieldByName('sexo').AsString = 'FEMININO') then
      sTexto := 'Recibi da Sra. '
    else
      sTexto := 'Recibi do Sr. ';
  end;

  sTexto := sTexto + cdsCliente.FieldByName('nome').AsString;
  sTexto := sTexto + ' a import�ncia de R$ ' + FsValorRecibido;

  MontarTextoTipoRecibo;

  sTexto := sTexto + #13 + #13;
  //sTexto := sTexto + 'E para maior clareza afirmo o presente.';
  sTexto := sTexto + 'Por ser verdade, firmamos o presente.';

  rlValor.Caption := 'R$ ' + FsValorRecibido;
  rlMmTexto.Lines.Text := sTexto;
  rlData.Caption := FormatDateTime('dddd, dd "de" mmmm "de" yyyy', Now);
end;

procedure TfrmRelRecibo.PosicionarTexto;
begin
  rlCidade.Top := rlMmTexto.Top + rlMmTexto.Height + 30;
  rlData.Top := rlCidade.Top;
  rlAssinatura.Top := rlCidade.Top + rlCidade.Height + 60;
end;

procedure TfrmRelRecibo.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  FnTipoRecibo := NUMERO_INDEFINIDO;
  FnCodCliente := NUMERO_INDEFINIDO;
  FsValorRecibido := STRING_INDEFINIDO;
  FnCodPedido := NUMERO_INDEFINIDO;
  FnNumeroParcela := NUMERO_INDEFINIDO;
  FsDtVcto := STRING_INDEFINIDO;
  FsTpPgtoVista := STRING_INDEFINIDO;
end;

procedure TfrmRelRecibo.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

end.
