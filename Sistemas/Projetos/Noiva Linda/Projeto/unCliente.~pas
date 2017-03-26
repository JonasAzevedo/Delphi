unit unCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ImgList, ComCtrls, StdCtrls, Mask, Grids,
  DBGrids, Buttons, ExtCtrls, ToolWin, DBXpress, FMTBcd, SqlExpr, Provider,
  DB, DBClient;

type
  TfrmCliente = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    dbGrdClientes: TDBGrid;
    grpBxDadosCliente: TGroupBox;
    lblDataFicha: TLabel;
    mEdDataFicha: TMaskEdit;
    StatusBar: TStatusBar;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosClientes: TMenuItem;
    edCodigo: TEdit;
    lblCodigo: TLabel;
    lblRua: TLabel;
    edRua: TEdit;
    lblNome: TLabel;
    edNome: TEdit;
    lblNroCasa: TLabel;
    edNroCasa: TEdit;
    edBairro: TEdit;
    lblBairro: TLabel;
    lblUF: TLabel;
    edUF: TEdit;
    edCidade: TEdit;
    lblCidade: TLabel;
    lblCEP: TLabel;
    mEdCEP: TMaskEdit;
    lblCPF: TLabel;
    mEdCPF: TMaskEdit;
    lblCelular: TLabel;
    mEdCelular: TMaskEdit;
    mEdTelefone: TMaskEdit;
    lblTelefone: TLabel;
    lblSexo: TLabel;
    cbBxSexo: TComboBox;
    lblEstadoCivil: TLabel;
    cbBxEstadoCivil: TComboBox;
    edLocalTrabalho: TEdit;
    lblLocalTrabalho: TLabel;
    cdsCidadesClientes: TClientDataSet;
    cdsCidadesClientesCIDADE: TStringField;
    dspCidadesClientes: TDataSetProvider;
    qryCidadesClientes: TSQLQuery;
    qryCidadesClientesCIDADE: TStringField;
    pnlPesquisar: TPanel;
    lblPesquisar: TLabel;
    Label1: TLabel;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    btBtnPesquisar: TBitBtn;
    edPesquisa: TEdit;
    cbBxCidades: TComboBox;
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ppMnMostrarTodosClientesClick(Sender: TObject);
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure edNroCasaKeyPress(Sender: TObject; var Key: Char);
    procedure edCodigoEnter(Sender: TObject);
    procedure edNomeEnter(Sender: TObject);
    procedure edRuaEnter(Sender: TObject);
    procedure edNroCasaEnter(Sender: TObject);
    procedure edBairroEnter(Sender: TObject);
    procedure edCidadeEnter(Sender: TObject);
    procedure edUFEnter(Sender: TObject);
    procedure mEdCEPEnter(Sender: TObject);
    procedure mEdCPFEnter(Sender: TObject);
    procedure mEdTelefoneEnter(Sender: TObject);
    procedure mEdCelularEnter(Sender: TObject);
    procedure cbBxSexoEnter(Sender: TObject);
    procedure cbBxEstadoCivilEnter(Sender: TObject);
    procedure edLocalTrabalhoEnter(Sender: TObject);
    procedure edLocalTrabalhoExit(Sender: TObject);
    procedure cbBxEstadoCivilExit(Sender: TObject);
    procedure cbBxSexoExit(Sender: TObject);
    procedure mEdCelularExit(Sender: TObject);
    procedure mEdTelefoneExit(Sender: TObject);
    procedure mEdCPFExit(Sender: TObject);
    procedure mEdCEPExit(Sender: TObject);
    procedure edUFExit(Sender: TObject);
    procedure edCidadeExit(Sender: TObject);
    procedure edBairroExit(Sender: TObject);
    procedure edNroCasaExit(Sender: TObject);
    procedure edRuaExit(Sender: TObject);
    procedure edNomeExit(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure edPesquisaExit(Sender: TObject);
    procedure edPesquisaEnter(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure dbGrdClientesCellClick(Column: TColumn);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure edPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbGrdClientesTitleClick(Column: TColumn);
    procedure cbBxCidadesChange(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    Transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    opcaoSalvar: Integer; //modo de salvamento. 1=novo; 2=edição
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar
    campoOrdenado: String; //campo que irá ordenar os clientes no dbGrid

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação
    procedure carrega();//carrega dados da tabela Cliente para os componentes de apresentação
    procedure mostraTodosClientes();//exibe todos os Clientes

    (*PROCEDURES ESPECÍFICAS*)
    procedure pegaCidades();//pega cidade dos clientes
  public
   (*VARIÁVEIS DE CONTROLE*)
    operacao: String; //recebe valor para saber em que modo inicia a tela
  end;

var
  frmCliente: TfrmCliente;

implementation

uses unDM;

{$R *.dfm}

(*PROCEDURES ESPECÍFICAS*)

//pega cidade dos clientes
procedure TfrmCliente.pegaCidades();
begin
  qryCidadesClientes.Close;
  qryCidadesClientes.SQL.Clear;
  qryCidadesClientes.SQL.Add('SELECT DISTINCT c.cidade FROM cliente c ORDER BY 1');
  qryCidadesClientes.Prepared := true;
  qryCidadesClientes.Open;
  cdsCidadesClientes.Open;
  cdsCidadesClientes.Refresh;

  cbBxCidades.Clear;
  cbBxCidades.Items.Add('TODAS');
  cdsCidadesClientes.First;
  while(not(cdsCidadesClientes.Eof))do
    begin
    cbBxCidades.Items.Add(cdsCidadesClientesCIDADE.AsString);
    cdsCidadesClientes.Next;
    end;
  cbBxCidades.ItemIndex := 0;
end;
(*FIM PROCEDURES ESPECÍFICAS*)

(*PROCEDURES DE CONTROLE*)

{carrega dados da tabela Cliente para os componentes de apresentação}
procedure TfrmCliente.carrega();
begin
  Self.limpar();

  mEdDataFicha.Text := DM.cdsClienteDATA_FICHA.AsString;

  edCodigo.Text := DM.cdsClienteCODIGO.AsString;
  edNome.Text := DM.cdsClienteNOME.AsString;
  edRua.Text := DM.cdsClienteRUA.AsString;
  edNroCasa.Text := DM.cdsClienteNUMERO_CASA.AsString;
  edBairro.Text := DM.cdsClienteBAIRRO.AsString;
  edCidade.Text := DM.cdsClienteCIDADE.AsString;
  edUF.Text := DM.cdsClienteUF.AsString;
  mEdCEP.Text := DM.cdsClienteCEP.AsString;
  mEdCPF.Text := DM.cdsClienteCPF.AsString;
  mEdTelefone.Text := DM.cdsClienteTELEFONE.AsString;
  mEdCelular.Text := DM.cdsClienteCELULAR.AsString;
  if(DM.cdsClienteSEXO.AsString='MASCULINO')then
    cbBxSexo.ItemIndex := 0
  else if(DM.cdsClienteSEXO.AsString='FEMININO')then
    cbBxSexo.ItemIndex := 1
  else
    cbBxSexo.ItemIndex := -1;
  if(DM.cdsClienteESTADO_CIVIL.AsString='CASADO (A)')then
    cbBxEstadoCivil.ItemIndex := 0
  else if(DM.cdsClienteESTADO_CIVIL.AsString='SEPARADO (A)')then
    cbBxEstadoCivil.ItemIndex := 1
  else if(DM.cdsClienteESTADO_CIVIL.AsString='SOLTEIRO (A)')then
    cbBxEstadoCivil.ItemIndex := 2
  else if(DM.cdsClienteESTADO_CIVIL.AsString='UNIÃO ESTÁVEL')then
    cbBxEstadoCivil.ItemIndex := 3
  else if(DM.cdsClienteESTADO_CIVIL.AsString='VIÚVO (A)')then
    cbBxEstadoCivil.ItemIndex := 4;
  cbBxEstadoCivil.Text := DM.cdsClienteESTADO_CIVIL.AsString;
  edLocalTrabalho.Text := DM.cdsClienteLOCAL_TRABALHO.AsString;
end;

{dispara uma transação}
procedure TfrmCliente.iniciaTransacao();
begin
  transacao.TransactionID := 1;
  transacao.IsolationLevel := xilREPEATABLEREAD;
end;

{limpar componentes}
procedure TfrmCliente.limpar();
begin
  mEdDataFicha.Clear;
  edCodigo.Clear;
  edNome.Clear;
  edRua.Clear;
  edNroCasa.Clear;
  edBairro.Clear;
  edCidade.Clear;
  edUF.Clear;
  mEdCEP.Clear;
  mEdCPF.Clear;
  mEdTelefone.Clear;
  mEdCelular.Clear;
  cbBxSexo.ItemIndex := 0;
  cbBxEstadoCivil.ItemIndex := 0;
  edLocalTrabalho.Clear;

  //cbBxCidades.ItemIndex := 0;
  edPesquisa.Clear;
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmCliente.verificaSalva(): boolean;
var
  campos: String;
  retorno: boolean;
begin

  campos := '';
  retorno := true;

  if (edNome.Text = '')then
    campos := 'Nome';

  if (cbBxSexo.ItemIndex=-1)then
    begin
    if (campos = '')then
      campos := 'Sexo'
    else
      campos := campos + ', Sexo';
    end;

  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    //mEdCPF.SetFocus;
    retorno := false;
    end

  else
    begin
    (*verificando se existe cliente com o nome já cadastrado*)
    if (opcaoSalvar = 1)then
      begin
      DM.qryPesquisaCliente.Close;
      DM.qryPesquisaCliente.SQL.Clear;
      DM.qryPesquisaCliente.SQL.Add('SELECT * FROM Cliente WHERE nome =:nom');
      DM.qryPesquisaCliente.ParamByName('nom').AsString := edNome.Text;
      DM.qryPesquisaCliente.Prepared := true;
      DM.qryPesquisaCliente.Open;
      DM.cdsPesquisaCliente.Open;
      DM.cdsPesquisaCliente.Refresh;
      if (DM.cdsPesquisaCliente.RecordCount <> 0) then
        begin
        retorno := false;
        if (MessageDlg('Cliente com este nome já cadastrado, deseja continuar?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
          retorno := true;
        end;
      end;
    end;

    Result := retorno;
end;

{exibe todos os Clientes}
procedure TfrmCliente.mostraTodosClientes();
begin
  cbBxCidades.ItemIndex := 0;
  DM.cdsCliente.Filter := '';
  DM.cdsCliente.Filtered := false;

  DM.qryCliente.Close;
  DM.qryCliente.SQL.Clear;
  DM.qryCliente.SQL.Add('SELECT * From Cliente c ');
  if(campoOrdenado<>'')then
    DM.qryCliente.SQL.Add('ORDER BY '+campoOrdenado);
  DM.qryCliente.Prepared := true;
  DM.qryCliente.Open;

  DM.cdsCliente.Open;
  DM.cdsCliente.Refresh;

  pegaCidades();
end;

{quais componentes exibir/ocultar}
 procedure TfrmCliente.visibilidade(opc: Integer);
begin

  {
  1 = novo
  11 = editar
  21 = salvar
  31 = excluir
  41 = cancelar
  }

  case opc of
    {novo}
    1: begin
       grpBxDadosCliente.Enabled := true;
       dbGrdClientes.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       mEdDataFicha.Text := DateToStr(Date);
       edNome.SetFocus;
       end;

    {editar}
    11: begin
       grpBxDadosCliente.Enabled := true;
       dbGrdClientes.Enabled := false;
       pnlPesquisar.Enabled := false;
       tlBtnNovo.Enabled := false;
       tlBtnEditar.Enabled := false;
       tlBtnSalvar.Enabled := true;
       tlBtnExcluir.Enabled := false;
       tlBtnCancelar.Enabled := true;
       edNome.SetFocus;       
       end;

    {salvar}
    21: begin
       grpBxDadosCliente.Enabled := false;
       dbGrdClientes.Enabled := true;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;

       mostraTodosClientes();
       if (DM.cdsCliente.RecordCount > 0) then
         begin
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;
       end;

    {excluir}
    31: begin
        grpBxDadosCliente.Enabled := false;
        pnlPesquisar.Enabled := true;
        tlBtnNovo.Enabled := true;
        tlBtnSalvar.Enabled := false;

        mostraTodosClientes();
        if (DM.cdsCliente.RecordCount > 0) then
          begin
          dbGrdClientes.Enabled := true;
          tlBtnEditar.Enabled := true;
          tlBtnExcluir.Enabled := true;
          end
        else
          begin
          dbGrdClientes.Enabled := false;
          tlBtnEditar.Enabled := false;
          tlBtnExcluir.Enabled := false;
          end;
        tlBtnCancelar.Enabled := false;
        end;

    {cancelar}
    41: begin
       grpBxDadosCliente.Enabled := false;
       pnlPesquisar.Enabled := true;
       tlBtnNovo.Enabled := true;
       tlBtnSalvar.Enabled := false;
       tlBtnCancelar.Enabled := false;

       mostraTodosClientes();
       if (DM.cdsCliente.RecordCount > 0) then
         begin
         dbGrdClientes.Enabled := true;
         tlBtnEditar.Enabled := true;
         tlBtnExcluir.Enabled := true;
         end
       else
         begin
         dbGrdClientes.Enabled := false;
         tlBtnEditar.Enabled := false;
         tlBtnExcluir.Enabled := false;
         end;
       end;

  end;//case


end;

(*FIM PROCEDURES DE CONTROLE*)

procedure TfrmCliente.ApplicationEventsHint(Sender: TObject);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

procedure TfrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (fechar = false) then
    begin
    MessageDlg('Salve ou cancele antes o processo que se encontra em operação!',mtInformation,[mbOK],0);
    Action := caNone;
    end

  else
  operacao := '';
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;  
  try
    mostraTodosClientes();
    DM.cdsCliente.First;
    carrega();
  except
  end;

  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
  Self.campoOrdenado := '';

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);
end;

procedure TfrmCliente.ppMnMostrarTodosClientesClick(Sender: TObject);
begin
  limpar();
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;
  cbBxCidades.ItemIndex := 0;
  mostraTodosClientes();
  DM.cdsCliente.Last;
  carrega();
end;

procedure TfrmCliente.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';
  visibilidade(1);
end;

procedure TfrmCliente.tlBtnEditarClick(Sender: TObject);
begin
  {preparando}
  visibilidade(11);
  edNome.SetFocus;
  opcaoSalvar := 2;//editar
  fechar := false;
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Edição';
end;

procedure TfrmCliente.tlBtnSalvarClick(Sender: TObject);
begin
  if (verificaSalva = true) then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryCliente.Close;
         DM.qryCliente.SQL.Clear;
         DM.qryCliente.SQL.Add('INSERT INTO Cliente (nome,rua,numero_casa,bairro,cidade,uf,cep,cpf,telefone,celular,sexo,estado_civil,local_trabalho,data_ficha) ');
         DM.qryCliente.SQL.Add('VALUES (:nom,:rua,:numCas,:bai,:cid,:uf,:cep,:cpf,:tel,:cel,:sex,:estCiv,:locTra,:datFic) ');

         DM.qryCliente.ParamByName('nom').AsString := edNome.Text;
         DM.qryCliente.ParamByName('rua').AsString := edRua.Text;
         if (edNroCasa.Text <> '') then
           DM.qryCliente.ParamByName('numCas').AsInteger := StrToInt(edNroCasa.Text)
         else
           DM.qryCliente.ParamByName('numCas').AsInteger := 0;
         DM.qryCliente.ParamByName('bai').AsString := edBairro.Text;
         DM.qryCliente.ParamByName('cid').AsString := edCidade.Text;
         DM.qryCliente.ParamByName('uf').AsString := edUF.Text;
         DM.qryCliente.ParamByName('cep').AsString := mEdCEP.Text;
         DM.qryCliente.ParamByName('cpf').AsString := mEdCPF.Text;
         DM.qryCliente.ParamByName('tel').AsString := mEdTelefone.Text;
         DM.qryCliente.ParamByName('cel').AsString := mEdCelular.Text;
         DM.qryCliente.ParamByName('sex').AsString := cbBxSexo.Text;
         DM.qryCliente.ParamByName('estCiv').AsString := cbBxEstadoCivil.Text;
         DM.qryCliente.ParamByName('locTra').AsString := edLocalTrabalho.Text;
         DM.qryCliente.ParamByName('datFic').AsDate := StrToDate(mEdDataFicha.Text);

         DM.qryCliente.Prepared := true;
         DM.qryCliente.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         MessageDlg('Cliente cadastrado com sucesso!',mtInformation,[mbOK],0);
         fechar := true;
         except
           MessageDlg('Cliente não pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

       2: begin //editar
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryCliente.Close;
         DM.qryCliente.SQL.Clear;

         DM.qryCliente.SQL.Add('UPDATE Cliente SET nome=:nom,rua=:rua,numero_casa=:numCas,bairro=:bai,cidade=:cid,uf=:uf,cep=:cep, ');
         DM.qryCliente.SQL.Add('cpf=:cpf,telefone=:tel,celular=:cel,sexo=:sex,estado_civil=:estCiv, ');
         DM.qryCliente.SQL.Add('local_trabalho=:locTra ');
         DM.qryCliente.SQL.Add('WHERE codigo=:cod');

         DM.qryCliente.ParamByName('nom').AsString := edNome.Text;
         DM.qryCliente.ParamByName('rua').AsString := edRua.Text;
         if (edNroCasa.Text <> '') then
           DM.qryCliente.ParamByName('numCas').AsInteger := StrToInt(edNroCasa.Text)
         else
           DM.qryCliente.ParamByName('numCas').AsInteger := 0;
         DM.qryCliente.ParamByName('bai').AsString := edBairro.Text;
         DM.qryCliente.ParamByName('cid').AsString := edCidade.Text;
         DM.qryCliente.ParamByName('uf').AsString := edUF.Text;
         DM.qryCliente.ParamByName('cep').AsString := mEdCEP.Text;
         DM.qryCliente.ParamByName('cpf').AsString := mEdCPF.Text;
         DM.qryCliente.ParamByName('tel').AsString := mEdTelefone.Text;
         DM.qryCliente.ParamByName('cel').AsString := mEdCelular.Text;
         DM.qryCliente.ParamByName('sex').AsString := cbBxSexo.Text;
         DM.qryCliente.ParamByName('estCiv').AsString := cbBxEstadoCivil.Text;
         DM.qryCliente.ParamByName('locTra').AsString := edLocalTrabalho.Text;
         DM.qryCliente.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);

         DM.qryCliente.Prepared := true;
         DM.qryCliente.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         MessageDlg('Cliente editado com sucesso!',mtInformation,[mbOK],0);
         fechar := true;
         except
           MessageDlg('Cliente não pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           fechar := true;           
           DM.SQLConnection.Rollback(transacao);
         end;

         end;

    end;//case
      {selecionando todos os Clientes}
      mostraTodosClientes();
      {atualizando ClientDataSet}
      DM.cdsCliente.Last;
      carrega();
      StatusBar.Panels[1].Text := 'OPERAÇÃO = Salvar';
      visibilidade(21);
      //caso tela auxiliar chamou cliente para fazer novo cadastro
      if (Self.operacao = 'novo') then
        Self.Close;
    end;//if
end;

procedure TfrmCliente.edNroCasaKeyPress(Sender: TObject; var Key: Char);
begin
    if not (Key in['0'..'9',Chr(8)])then
      Key := #0;
end;

procedure TfrmCliente.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMoneyGreen;
end;

procedure TfrmCliente.edNomeEnter(Sender: TObject);
begin
  edNome.Color := clMoneyGreen;
end;

procedure TfrmCliente.edRuaEnter(Sender: TObject);
begin
  edRua.Color := clMoneyGreen;
end;

procedure TfrmCliente.edNroCasaEnter(Sender: TObject);
begin
  edNroCasa.Color := clMoneyGreen;
end;

procedure TfrmCliente.edBairroEnter(Sender: TObject);
begin
  edBairro.Color := clMoneyGreen;
end;

procedure TfrmCliente.edCidadeEnter(Sender: TObject);
begin
  edCidade.Color := clMoneyGreen;
end;

procedure TfrmCliente.edUFEnter(Sender: TObject);
begin
  edUF.Color := clMoneyGreen;
end;

procedure TfrmCliente.mEdCEPEnter(Sender: TObject);
begin
  mEdCEP.Color := clMoneyGreen;
end;

procedure TfrmCliente.mEdCPFEnter(Sender: TObject);
begin
  mEdCPF.Color := clMoneyGreen;
end;

procedure TfrmCliente.mEdTelefoneEnter(Sender: TObject);
begin
  mEdTelefone.Color := clMoneyGreen;
end;

procedure TfrmCliente.mEdCelularEnter(Sender: TObject);
begin
  mEdCelular.Color := clMoneyGreen;
end;

procedure TfrmCliente.cbBxSexoEnter(Sender: TObject);
begin
  cbBxSexo.Color := clMoneyGreen;
end;

procedure TfrmCliente.cbBxEstadoCivilEnter(Sender: TObject);
begin
  cbBxEstadoCivil.Color := clMoneyGreen;
end;

procedure TfrmCliente.edLocalTrabalhoEnter(Sender: TObject);
begin
  edLocalTrabalho.Color := clMoneyGreen;
end;

procedure TfrmCliente.edLocalTrabalhoExit(Sender: TObject);
begin
  edLocalTrabalho.Color := clWindow;
end;

procedure TfrmCliente.cbBxEstadoCivilExit(Sender: TObject);
begin
  cbBxEstadoCivil.Color := clWindow;
end;

procedure TfrmCliente.cbBxSexoExit(Sender: TObject);
begin
  cbBxSexo.Color := clWindow;
end;

procedure TfrmCliente.mEdCelularExit(Sender: TObject);
begin
  mEdCelular.Color := clWindow;
end;

procedure TfrmCliente.mEdTelefoneExit(Sender: TObject);
begin
  mEdTelefone.Color := clWindow;
end;

procedure TfrmCliente.mEdCPFExit(Sender: TObject);
begin
  mEdCPF.Color := clWindow;
end;

procedure TfrmCliente.mEdCEPExit(Sender: TObject);
begin
  mEdCEP.Color := clWindow;
end;

procedure TfrmCliente.edUFExit(Sender: TObject);
begin
  edUF.Color := clWindow;
end;

procedure TfrmCliente.edCidadeExit(Sender: TObject);
begin
  edCidade.Color := clWindow;
end;

procedure TfrmCliente.edBairroExit(Sender: TObject);
begin
  edBairro.Color := clWindow;
end;

procedure TfrmCliente.edNroCasaExit(Sender: TObject);
begin
  edNroCasa.Color := clWindow;
end;

procedure TfrmCliente.edRuaExit(Sender: TObject);
begin
  edRua.Color := clWindow;
end;

procedure TfrmCliente.edNomeExit(Sender: TObject);
begin
  edNome.Color := clWindow;
end;

procedure TfrmCliente.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmCliente.edPesquisaExit(Sender: TObject);
begin
  edPesquisa.Color := clWindow;
end;

procedure TfrmCliente.edPesquisaEnter(Sender: TObject);
begin
  edPesquisa.Color := clMoneyGreen;
end;

procedure TfrmCliente.rdBtnCodigoClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmCliente.rdBtnNomeClick(Sender: TObject);
begin
  edPesquisa.Enabled := true;
  edPesquisa.Clear;
  edPesquisa.SetFocus;
  btBtnPesquisar.Enabled := false;
  StatusBar.Panels[1].Text := 'Pesquisar';
end;

procedure TfrmCliente.edPesquisaChange(Sender: TObject);
begin
  if (edPesquisa.Text = '')then
    btBtnPesquisar.Enabled := false;

  if(edPesquisa.Text <> '')then
    begin
    if((rdBtnCodigo.Checked = true)or(rdBtnNome.Checked = true))then
      btBtnPesquisar.Enabled := true
    else
      btBtnPesquisar.Enabled := false;
    end;
end;

procedure TfrmCliente.edPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmCliente.tlBtnExcluirClick(Sender: TObject);
var
  codigo: Integer;
begin
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Excluir';

  if (MessageDlg('Deseja deletar o Cliente ' +#13 + DM.cdsClienteNOME.AsString + '?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
    begin
    try
      codigo := StrToInt(edCodigo.Text);

      iniciaTransacao();
      DM.SQLConnection.StartTransaction(transacao);
      (*deletando*)
      DM.qryCliente.Close;
      DM.qryCliente.SQL.Clear;
      DM.qryCliente.SQL.Add('DELETE FROM Cliente WHERE codigo = :cod');
      DM.qryCliente.ParamByName('cod').AsInteger := codigo;
      DM.qryCliente.Prepared := true;
      DM.qryCliente.ExecSQL();

      DM.SQLConnection.Commit(transacao);

      {selecionando todos os Clientes}
      mostraTodosClientes();
      {atualizando ClientDataSet}
      DM.cdsCliente.Last;
      carrega();
      StatusBar.Panels[1].Text := '';
      visibilidade(31);

    except
      MessageDlg('Cliente não pode ser deletado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
      DM.SQLConnection.Rollback(transacao);
    end;

    end

  else
    begin
    {selecionando todos os Clientes}
    mostraTodosClientes();
    {atualizando ClientDataSet}
    DM.cdsCliente.Last;
    carrega();
    StatusBar.Panels[1].Text := '';
    visibilidade(41);
    end;

end;

procedure TfrmCliente.tlBtnCancelarClick(Sender: TObject);
begin
  limpar();
  mostraTodosClientes();
  DM.cdsCliente.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
  //caso tela auxiliar chamou cliente para fazer novo cadastro  
  if (Self.operacao = 'novo') then
    Self.Close;
end;

procedure TfrmCliente.dbGrdClientesCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';

  tlBtnNovo.Enabled := true;
  tlBtnSalvar.Enabled := false;
  tlBtnCancelar.Enabled := false;
end;

procedure TfrmCliente.btBtnPesquisarClick(Sender: TObject);
begin
  {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryCliente.Close;
    DM.qryCliente.SQL.Clear;
    DM.qryCliente.SQL.Add('SELECT * FROM Cliente WHERE codigo=:cod ');
    if(cbBxCidades.ItemIndex <> 0)then
      begin
      DM.qryCliente.SQL.Add('AND cidade=:cid');
      DM.qryCliente.ParamByName('cid').AsString := cbBxCidades.Text;
      end;
    DM.qryCliente.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryCliente.Prepared := true;
    DM.qryCliente.Open;

    DM.cdsCliente.Open;
    DM.cdsCliente.Refresh;

    if (DM.cdsCliente.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Cliente encontrado com o código '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosClientes();
      end;
    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.qryCliente.Close;
    DM.qryCliente.SQL.Clear;
    DM.qryCliente.SQL.Add('SELECT * FROM Cliente WHERE nome LIKE '+QuotedStr('%'+edPesquisa.Text+'%'));
    if(cbBxCidades.ItemIndex <> 0)then
      begin
      DM.qryCliente.SQL.Add('AND cidade=:cid');
      DM.qryCliente.ParamByName('cid').AsString := cbBxCidades.Text;
      end;    
    if(campoOrdenado<>'')then
      DM.qryCliente.SQL.Add('ORDER BY '+campoOrdenado);
    DM.qryCliente.Prepared := true;
    DM.qryCliente.Open;

    DM.cdsCliente.Open;
    DM.cdsCliente.Refresh;

    if (DM.cdsCliente.RecordCount = 0) then
      begin
      MessageDlg('Nenhum Cliente encontrado com o nome '+edPesquisa.Text+' !',mtError,[mbOK],0);
      edPesquisa.Clear;
      mostraTodosClientes();
      end;
    end;

  DM.cdsCliente.Last;
  carrega();

  StatusBar.Panels[1].Text := '';   
end;

procedure TfrmCliente.edPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=13) then
    btBtnPesquisarClick(Sender);
end;

procedure TfrmCliente.dbGrdClientesTitleClick(Column: TColumn);
var
  campo: string;
begin
  campo:=column.fieldname; // campo recebe o nome da coluna clicada
  application.processmessages; // para considerar algo que aconteça no dbgrid durante a entrada nesta procedure
  DM.qryCliente.Close;
  DM.qryCliente.SQL.Clear;
  DM.qryCliente.SQL.Add('SELECT * FROM Cliente ORDER BY '+campo);
  DM.qryCliente.Prepared := true;
  DM.qryCliente.Open;
  DM.cdsCliente.Open;
  DM.cdsCliente.Refresh;

  //column.Font.color:=clblue; // COLOCAR A COLUNA NA COR DESEJADA
  campoOrdenado := campo;
end;

procedure TfrmCliente.cbBxCidadesChange(Sender: TObject);
begin
  {cidade}
  if(cbBxCidades.ItemIndex<>0)then
    begin
    DM.cdsCliente.Filter := 'cidade='+QuotedStr(cbBxCidades.Text);
    DM.cdsCliente.Filtered := true;
    end
  else
    begin
    DM.cdsCliente.Filter := '';
    DM.cdsCliente.Filtered := false;
    limpar();
    mostraTodosClientes();
    end;

  DM.cdsCliente.First;
  carrega();
end;

end.
