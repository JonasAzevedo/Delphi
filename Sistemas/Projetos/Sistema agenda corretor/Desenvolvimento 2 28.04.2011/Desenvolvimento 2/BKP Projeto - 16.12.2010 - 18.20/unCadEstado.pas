unit unCadEstado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unCadastroBasico, AppEvnts, ImgList, ComCtrls, ToolWin, StdCtrls,
  plsEdit, unObjEstado, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  plsComboBox, Mask, plsTMaskEdit, plsMemo, DBClient, Provider;

type
  TfrmCadEstado = class(TfrmCadastroBasico)
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblSigla: TLabel;
    plsEdCodigo: TPlsEdit;
    plsEdNome: TPlsEdit;
    plsEdSigla: TPlsEdit;
    zQryDadosCODIGO: TIntegerField;
    zQryDadosNOME: TStringField;
    zQryDadosSIGLA: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    Festado: TObjEstado;
    FiFuncaoRegistro: Integer;

    procedure carregarObjeto(); override;
    procedure carregarComponentesApresentacao(); override;
    procedure selecionarTodosDados(); override;
    procedure limparObjeto(); override;
    procedure limparTela(poForm: TForm); override;
    //procedure limparPesqusa(poForm: TForm); override;
    function verificarHouveAlteracoes(): boolean; override;
    function verificarCamposObrigatorios(): boolean; override;
    function verificarRegistroJaExiste(): boolean; override;
    //function verificarCamposObrigatoriosPesquisa(): boolean; override;
    procedure visibilidade(pnVisib: Integer); override;
    procedure novo(); override;
    function salvar(): boolean; override;
  public

  end;

var
  frmCadEstado: TfrmCadEstado;

implementation

uses unConstantes;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadEstado.limparObjeto();
begin
  if (Assigned(Festado)) then
  begin
    Festado.setCodigo(NUMERO_INDEFINIDO);
    Festado.setNome(STRING_INDEFINIDO);
    Festado.setSigla(STRING_INDEFINIDO);
  end
end;

procedure TfrmCadEstado.limparTela(poForm: TForm);
begin
inherited;

end;

{
procedure TfrmCadEstado.limparPesqusa(poForm: TForm);
begin
inherited;

end;
}

procedure TfrmCadEstado.carregarObjeto();
begin
  if ((zQryDados.Active) and (Assigned(Festado))) then
  begin
    Festado.setCodigo(zQryDadosCODIGO.AsInteger);
    Festado.setNome(zQryDadosNOME.AsString);
    Festado.setSigla(zQryDadosSIGLA.AsString);
  end
  else
  begin
    FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadEstado.carregarObjeto();','Acesso Indispon�vel');
  end;
end;

procedure TfrmCadEstado.carregarComponentesApresentacao();
begin
  if(Assigned(Festado))then
  begin
    if(Festado.getCodigo <> 0)then
      plsEdCodigo.Text := IntToStr(Festado.getCodigo)
    else
      plsEdCodigo.Clear;
    plsEdNome.Text := Festado.getNome;
    plsEdSigla.Text := Festado.getSigla;
  end;
end;

procedure TfrmCadEstado.selecionarTodosDados();
begin
  zQryDados.Filter := '';
  zQryDados.Filtered := False;
  zQryDados.Close;
  zQryDados.SQL.Clear;
  zQryDados.SQL.Add('SELECT * FROM estado ');
  zQryDados.SQL.Add(FoFuncoes.inserirCondicaoSelectNaoTrazerRegistroNulo());
  zQryDados.SQL.Add('ORDER BY e.sigla');
  zQryDados.Open;
  zQryDados.First;
end;

function TfrmCadEstado.verificarHouveAlteracoes(): boolean;
var
  sNome, sSigla: string;
  bAlteracao: boolean;
begin

  sNome := Trim(plsEdNome.Text);
  sSigla := Trim(plsEdSigla.Text);

  try
    bAlteracao := Festado.verificarDiferencaCadastro(sNome, sSigla);
  except
    bAlteracao := true;
  end;

  Result := bAlteracao;
end;

function TfrmCadEstado.verificarCamposObrigatorios(): boolean;
var
  bRetorno: boolean;
  compFoco: TWinControl;
  campos: string;
  sAux: string;
begin
  bRetorno := True;
  compFoco := nil;
  campos := '';
  sAux := '';


  if(Trim(plsEdNome.Text) = '')then
  begin
    campos := 'Nome';
    compFoco := plsEdNome;
  end;

  if(Trim(plsEdSigla.Text) = '')then
  begin
    if(campos <> '')then
      campos := campos + ', Sigla'
    else
    begin
      campos := 'Sigla';
      compFoco := plsEdSigla;
    end;
  end;

  if(campos <> '')then
  begin
    MessageDlg('Antes de salvar, verifique os campos: ' + campos + '.', mtInformation, [mbOK], 0);
    bRetorno := False;
  end;

  //setar foco no componente que n�o foi validado
  if((not(bRetorno))and(compFoco is TWinControl))then
    FoFuncoes.focarComponente(compFoco);

  Result := bRetorno;
end;


function TfrmCadEstado.verificarRegistroJaExiste(): boolean;
begin
  Result := False;
end;
{
function TfrmCadEstado.verificarCamposObrigatoriosPesquisa(): boolean;
begin

end;
}

procedure TfrmCadEstado.visibilidade(pnVisib: Integer);
begin
{  case pnVisib of
    OPC_TELA_INICIO: begin
                       FiFuncaoRegistro := FUNCAO_REGISTRO_NENHUM;
                       limparObjeto();
                       limparTela(frmCadEstado);
                       limparPesqusa(frmCadEstado);
                     end;
    OPC_NOVO:        begin
                       PageControl.ActivePageIndex := 1;
                       PageControl.Pages[1].Enabled := true;
                       frmImovelInteresseCliente.ActiveControl := grpBxCliente;
                       plsEdCliente.SetFocus;
                       fiFuncaoImovelCliente := FUNCAO_NOVO_REGISTRO;
                     end;
    OPC_EDITAR:      begin
                       PageControl.ActivePageIndex := 1;
                       PageControl.Pages[1].Enabled := true;
                       frmImovelInteresseCliente.ActiveControl := grpBxCliente;
                       plsCbBxFinalidadeImovel.SetFocus;
                       fiFuncaoImovelCliente := FUNCAO_EDITAR_REGISTRO;
                     end;
    OPC_SALVAR:      begin
                       visibilidadeImovelCliente(OPC_TELA_INICIO);
                     end;
    OPC_EXCLUIR:    begin
                       visibilidadeImovelCliente(OPC_TELA_INICIO);
                     end;
    OPC_CANCELAR:    begin
                       visibilidadeImovelCliente(OPC_TELA_INICIO);
                       end;
}end;

procedure TfrmCadEstado.novo();
begin

end;

function TfrmCadEstado.salvar(): boolean;
var
  bSalvou: boolean;
begin
  Result := bSalvou;
end;

(* fim - procedimentos de controle *)

procedure TfrmCadEstado.FormCreate(Sender: TObject);
begin
  Festado := TObjEstado.Create;

  inherited;
end;

end.
