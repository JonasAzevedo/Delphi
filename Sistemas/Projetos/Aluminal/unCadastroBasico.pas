unit unCadastroBasico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ImgList, ComCtrls, ToolWin, StdCtrls, DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, unFuncoes, plsComboBox,
  Mask, plsTMaskEdit, plsMemo, plsEdit, unPesquisandoRegistro, DBClient,
  Provider, jpeg, ExtCtrls;

type
  TfrmCadastroBasico = class(TForm)
    StatusBar: TStatusBar;
    grpBxDados: TGroupBox;
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    tlBtnSeparador: TToolButton;
    listaImagens: TImageList;
    ApplicationEvents: TApplicationEvents;
    zQryDados: TZQuery;
    dsDados: TDataSource;
    dspDados: TDataSetProvider;
    cdsDados: TClientDataSet;
    pnlDicas: TPanel;
    lblDicas: TLabel;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FoNomeForm: TForm;

    //interceptando o ShortCut
    procedure Hot_Key(var Msg:TWMHotKey); message WM_HOTKEY;
    procedure RegistrandoHotKey();
    procedure LiberandoHotKey();
    procedure configurarComponenteEscreveDireitaParaEsquerda();
  public
    procedure iniciarTela(poForm: TForm); dynamic; //inicia a tela (constructor)
    procedure passarParametro(pTipo:String; pValores:OleVariant); dynamic; //passando parâmetros
  protected
    FiFuncaoRegistro: Integer;
    FbPodePesquisar: Boolean;
    FbPesquisouKeyEnter: Boolean; //se pesquisou e apertou enter para selecionar registro
    FoFuncoes: TFuncoes;
    FoPesquisa: TfrmPesquisandoRegistro;
    FnCampoPesquisou: Integer; //qual campo fez a pesquisa
    FbChamadaExternaInserirRegistro: Boolean; //verifica se a chamada para um novo registro veio de fora. Exemplo: ao estar selecionando um registro
    FiTelaExternaChamouInserirRegistro: Integer; //se FbChamadaExternaInserirRegistro=True, FiTelaExternaChamouInserirRegistro será a tela que chamou
    FbChamadaExternaEditarRegistro: Boolean; //verifica se a chamada para editar o registro veio de fora.
    FiTelaExternaChamouEditarRegistro: Integer; //se FbChamadaExternaEditarRegistro=True, FiTelaExternaChamouEditarRegistro será a tela que chamou

    procedure limparObjeto(); dynamic; //limpa o objeto que controla os dados
    procedure limparTela(poForm: TForm); dynamic; //limpar componentes de apresentação da tela
    procedure visibilidade(pnVisib: Integer); dynamic; //visibilidade dos componentes da tela
    //procedure limparPesqusa(poForm: TForm); dynamic; //limpar componentes de pesquisa

    procedure carregarObjeto(); dynamic; abstract; //carregar dados no objeto
    procedure carregarComponentesApresentacao(); dynamic; abstract; //carregar dados do objeto nos componentes de apresentação
    procedure selecionarTodosDados(); dynamic; abstract; //seleciona todos os dados da tabela
    function verificarHouveAlteracoes(): boolean; dynamic; abstract; //verifica se houve alterações no cadastro atual
    function verificarCamposObrigatorios(): boolean; dynamic; abstract; //verifica se os campos obrigatórios foram preenchidos
    function verificarRegistroJaExiste(): boolean; dynamic; abstract; //verifica se o registro já não foi cadastrado
    function verificarPodeDeletar(): boolean; dynamic; abstract; //verifica se o registro pode ser deletado 
    //function verificarCamposObrigatoriosPesquisa(): boolean; dynamic; abstract; //verifica se os campos obrigatórios de pesquisa foram preenchidos
    function outrasValidacoesAntesSalvar(): Boolean; dynamic; //realiza outras validações antes de salvar, deve ser sobrescrito nas classes que herdam esta
    procedure novo(); dynamic; //insere novo registro
    function salvar(): Boolean; dynamic; abstract; //salva dados
    function excluir(): Boolean; dynamic; abstract; //exclui registro
    procedure realizouPesquisa(piCodigo: Integer); dynamic; abstract; //pesquisa foi realizada, e selecionado registro com o codigo = piCodigo
    procedure verificarInseriuChamadaTelaExterna(); dynamic; abstract; //verifica se a solicitação para o novo registro, foi chamada por uma tela externa
    procedure MostrarHintCampos(psPesquisando, psNovoEditar:String;
     const pbGeneroMasculino:Boolean = True; const pnTipoInfCadastro:Integer = 1); dynamic;
  end;

var
  frmCadastroBasico: TfrmCadastroBasico;

implementation

uses unDM, unConstantes, Math; //, unDicas;

{$R *.dfm}

(* procedimentos de controle *)

procedure TfrmCadastroBasico.Hot_Key(var Msg:TWMHotKey);
begin
  //vê qual ShorCut foi pressionado
//  if Msg.HotKey = 1 then
//    tlBtnNovoClick(tlBtnNovo);
end;

procedure TfrmCadastroBasico.RegistrandoHotKey();
//const
//  VK_A = 65;
begin
//  RegisterHotKey(Handle, 1, MOD_CONTROL, VK_A); CTRL+A
end;

procedure TfrmCadastroBasico.LiberandoHotKey();
begin
//  UnregisterHotKey(Handle, 1);
end;

procedure TfrmCadastroBasico.iniciarTela(poForm: TForm);
begin
  Self.FoNomeForm := poForm;
  Self.configurarComponenteEscreveDireitaParaEsquerda();
end;

//passando parâmetros
procedure TfrmCadastroBasico.passarParametro(pTipo:String; pValores:OleVariant);
begin
  if(pTipo = sPRM_INICIAR_TELA)then
  begin
    Self.configurarComponenteEscreveDireitaParaEsquerda();
  end;

  if(pTipo = sPRM_PESQUISOU)then
    Self.FbPesquisouKeyEnter := True;
end;

procedure TfrmCadastroBasico.configurarComponenteEscreveDireitaParaEsquerda();
var
  i: Integer;
  OldSysLocal: TSysLocale;
begin
  for i:= 0 to Self.FoNomeForm.ComponentCount-1 do
  begin
    if(Self.FoNomeForm.Components[i] is TPlsEdit)then
    begin
      if(TPlsEdit(Self.FoNomeForm.Components[i]).plsEntraCaracteres = direitaEsquerda)then
      begin
        OldSysLocal := SysLocale;
        SysLocale.MiddleEast := True;
        TPlsEdit(Self.FoNomeForm.Components[i]).BiDiMode := bdRightToLeft;
      end;
    end;
  end;
end;

procedure TfrmCadastroBasico.novo();
begin
  Self.visibilidade(OPC_TELA_INICIO);
  Self.FiFuncaoRegistro := FUNCAO_REGISTRO_NOVO;
end;

procedure TfrmCadastroBasico.limparObjeto();
begin

end;

procedure TfrmCadastroBasico.limparTela(poForm: TForm);
var
  n: Integer;
  nTotComponentes: integer;
begin
  nTotComponentes := poForm.ComponentCount;
  try
    for n:=0 to nTotComponentes-1 do
    begin
      try
        if(poForm.Components[n] is TPlsEdit)then
        begin
          //if((poForm.Components[n] as TPlsEdit).CanFocus)then
            (poForm.Components[n] as TPlsEdit).Clear;
        end
        else if(poForm.Components[n] is TPlsMemo)then
        begin
          //if((poForm.Components[n] as TPlsMemo).CanFocus)then
            (poForm.Components[n] as TPlsMemo).Clear;
        end
        else if (poForm.Components[n] is TPlsMaskEdit)then
        begin
          //if((poForm.Components[n] as TPlsMaskEdit).CanFocus)then
            (poForm.Components[n] as TPlsMaskEdit).Clear
        end
        else if (poForm.Components[n] is TPlsComboBox)then
        begin
          //if((poForm.Components[n] as TPlsComboBox).CanFocus)then
            (poForm.Components[n] as TPlsComboBox).ItemIndex := -1;
        end;
      except
        //Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadastroBasico.limparTela(poForm: TForm);', 'Erro');
      end;
    end;
  except
    //Self.FoFuncoes.gravaMensagemSistemaDiversos('procedure TfrmCadastroBasico.limparTela(poForm: TForm);', 'Erro');
  end;
end;

procedure TfrmCadastroBasico.visibilidade(pnVisib: Integer);
begin
  case pnVisib of
    OPC_TELA_INICIO: begin
                       Self.limparTela(Self.FoNomeForm);
                       Self.limparObjeto();
                       Self.selecionarTodosDados();
                       tlBtnNovo.Enabled :=  True;
                       tlBtnEditar.Enabled := False;
                       tlBtnSalvar.Enabled := False;
                       tlBtnExcluir.Enabled := False;
                       tlBtnCancelar.Enabled := False;
                       Self.FbPodePesquisar := True;
                       FnCampoPesquisou := NUMERO_INDEFINIDO;
                     end;
    OPC_NOVO:        begin
                       Self.limparTela(Self.FoNomeForm);
                       Self.limparObjeto();
                       tlBtnNovo.Enabled :=  False;
                       tlBtnEditar.Enabled := False;
                       tlBtnSalvar.Enabled := True;
                       tlBtnExcluir.Enabled := False;
                       tlBtnCancelar.Enabled := True;
                       Self.FbPodePesquisar := False;
                     end;
    OPC_EDITAR:      begin
                       Self.limparTela(Self.FoNomeForm);
                       Self.limparObjeto();
                       Self.carregarObjeto();
                       Self.carregarComponentesApresentacao();
                       tlBtnNovo.Enabled :=  False;
                       tlBtnEditar.Enabled := False;
                       tlBtnSalvar.Enabled := True;
                       tlBtnExcluir.Enabled := True;
                       tlBtnCancelar.Enabled := True;
                       Self.FbPodePesquisar := False;
                     end;
    OPC_SALVAR:      begin
                       Self.visibilidade(OPC_TELA_INICIO);
                     end;
    OPC_EXCLUIR:     begin
                       Self.visibilidade(OPC_TELA_INICIO);
                     end;
    OPC_CANCELAR:    begin
                       Self.visibilidade(OPC_TELA_INICIO);
                     end;
    OPC_PESQUISOU:   begin
                       Self.limparTela(Self.FoNomeForm);
                       Self.limparObjeto();
                       Self.carregarObjeto();
                       Self.carregarComponentesApresentacao();
                       tlBtnNovo.Enabled :=  True;
                       tlBtnEditar.Enabled := True;
                       tlBtnSalvar.Enabled := False;
                       tlBtnExcluir.Enabled := True;
                       tlBtnCancelar.Enabled := True;
                       Self.FbPodePesquisar := True;
                     end;
  end; //fim - case
end;

//realiza outras validações antes de salvar, deve ser sobrescrito nas classes que herdam esta
function TfrmCadastroBasico.outrasValidacoesAntesSalvar(): Boolean;
begin
  Result := True;
end;

{
procedure TfrmCadastroBasico.limparPesqusa(poForm: TForm);
begin

end;
}


procedure TfrmCadastroBasico.MostrarHintCampos(psPesquisando, psNovoEditar:String;
 const pbGeneroMasculino:Boolean = True; const pnTipoInfCadastro:Integer = 1);

 function GetGenero: String;
 begin
   if pbGeneroMasculino then
     Result := ' o '
   else
     Result := ' a ';
 end;

 function GetTipoInfCadastro:String;
 begin
   //pnTipoInfCadastro = 1 = 'Digite'
   case pnTipoInfCadastro of
     1: Result := 'Digite';
     2: Result := 'Selecione';
     else Result := 'Digite';
   end;
 end;

begin
  if (Self.FbPodePesquisar)and(not(Self.FbPesquisouKeyEnter))and(psPesquisando <> STRING_INDEFINIDO) then
    StatusBar.Panels[0].Text := 'Pesquisando ' + psPesquisando

  else if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_NOVO)and(psNovoEditar <> STRING_INDEFINIDO)then
    StatusBar.Panels[0].Text := GetTipoInfCadastro + GetGenero +psNovoEditar+ ' que está cadastrando'
  else if(Self.FiFuncaoRegistro = FUNCAO_REGISTRO_EDITAR)and(psNovoEditar <> STRING_INDEFINIDO)then
    StatusBar.Panels[0].Text := GetTipoInfCadastro + GetGenero +psNovoEditar+ ' que está editando';
end;

(* fim - procedimentos de controle *)

procedure TfrmCadastroBasico.ApplicationEventsHint(Sender: TObject);
begin
  Self.StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmCadastroBasico.FormCreate(Sender: TObject);
begin
  Self.FoFuncoes := TFuncoes.Create;
  Self.FbChamadaExternaInserirRegistro := False;
  Self.FiTelaExternaChamouInserirRegistro := NUMERO_INDEFINIDO;
  Self.FbChamadaExternaEditarRegistro := False;
  Self.FiTelaExternaChamouEditarRegistro := NUMERO_INDEFINIDO;
  Self.RegistrandoHotKey();
  Self.FbPesquisouKeyEnter := False;
  FnCampoPesquisou := NUMERO_INDEFINIDO;
  zQryDados.Open;
end;

procedure TfrmCadastroBasico.FormShow(Sender: TObject);
begin
  Self.visibilidade(OPC_TELA_INICIO);
  Self.FiFuncaoRegistro := FUNCAO_REGISTRO_NENHUM;
  if(Self.FbChamadaExternaInserirRegistro)then
    Self.novo();
end;

procedure TfrmCadastroBasico.FormDestroy(Sender: TObject);
begin
  Self.LiberandoHotKey();
  FreeAndNil(Self.FoFuncoes);
  FreeAndNil(Self.FoPesquisa);
end;

procedure TfrmCadastroBasico.tlBtnNovoClick(Sender: TObject);
begin
  Self.novo();
end;

procedure TfrmCadastroBasico.tlBtnEditarClick(Sender: TObject);
begin
  Self.visibilidade(OPC_EDITAR);
  Self.FiFuncaoRegistro := FUNCAO_REGISTRO_EDITAR;
end;

procedure TfrmCadastroBasico.tlBtnSalvarClick(Sender: TObject);
begin
  ActiveControl := nil;
  if Self.verificarCamposObrigatorios then
  begin //1
    if not(Self.verificarRegistroJaExiste)then
    begin //2
      if(Self.outrasValidacoesAntesSalvar)then
      begin //3
        if Self.salvar then
        begin //4\
          if(not(Self.FbChamadaExternaInserirRegistro))then
          begin //5
            MessageDlg('Registro salvo.', mtInformation, [mbOK], 0);
            Self.visibilidade(OPC_SALVAR);
            Self.FiFuncaoRegistro := FUNCAO_REGISTRO_NENHUM;
          end; //5
        end //4
        else
          MessageDlg('Registro não pode ser salvo.', mtWarning, [mbOK], 0);
      end  //3
    end; //2
  end; //1
end;

procedure TfrmCadastroBasico.tlBtnExcluirClick(Sender: TObject);
begin
  ActiveControl := nil; //caso não seja confirmada a exclusão, não abrir a tela de pesquisa  
  if(MessageDlg('Deseja deletar o registro?', mtConfirmation, [mbYes, mbNo], 0)=mrYes)then
  begin
    if(self.verificarPodeDeletar())then
    begin
      if(Self.excluir())then
      begin
        Self.visibilidade(OPC_EXCLUIR);
        Self.FiFuncaoRegistro := FUNCAO_REGISTRO_NENHUM;
      end;
    end;
  end;
end;

procedure TfrmCadastroBasico.tlBtnCancelarClick(Sender: TObject);
begin
  if(not(Self.FbChamadaExternaInserirRegistro))and(not(Self.FbChamadaExternaEditarRegistro))then
  begin
    Self.visibilidade(OPC_CANCELAR);
    Self.FiFuncaoRegistro := FUNCAO_REGISTRO_NENHUM;
  end
  else
    Self.Close;
end;

procedure TfrmCadastroBasico.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if(not(Self.FbChamadaExternaInserirRegistro))and(not(Self.FbChamadaExternaEditarRegistro))then
  begin
    if(FiFuncaoRegistro IN[FUNCAO_REGISTRO_NOVO, FUNCAO_REGISTRO_EDITAR])then
    begin
      if(MessageDlg('Deseja fechar a tela?', mtConfirmation, [mbYes, mbNo], 0)=mrNo)then
        Action := caNone;
    end;
  end;
end;

procedure TfrmCadastroBasico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (chr(Key) in ['n', 'N']) then
  begin
    if(tlBtnNovo.Visible)and(tlBtnNovo.Enabled)then
      tlBtnNovoClick(tlBtnNovo);
  end;

  if (ssCtrl in Shift) and (chr(Key) in ['d', 'D', 'e', 'E']) then
  begin
    if(tlBtnEditar.Visible)and(tlBtnEditar.Enabled)then
      tlBtnEditarClick(tlBtnEditar);
  end;

  if (ssCtrl in Shift) and (chr(Key) in ['s', 'S']) then
  begin
    if(tlBtnSalvar.Visible)and(tlBtnSalvar.Enabled)then
      tlBtnSalvarClick(tlBtnSalvar);
  end;

  if (ssCtrl in Shift) and (chr(Key) in ['x', 'X']) THEN
  begin
    if(tlBtnExcluir.Visible)and(tlBtnExcluir.Enabled)then
      tlBtnExcluirClick(tlBtnExcluir);
  end;

  if (ssCtrl in Shift) and (chr(Key) in ['r', 'R']) then
  begin
    if(tlBtnCancelar.Visible)and(tlBtnCancelar.Enabled)then
      tlBtnCancelarClick(tlBtnCancelar);
  end;
end;

end.
