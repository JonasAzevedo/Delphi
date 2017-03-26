unit unCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, ComCtrls, ToolWin, StdCtrls, Buttons, ExtCtrls, Menus,
  AppEvnts, ImgList, Grids, DBGrids, Mask;

type
  TfrmCliente = class(TForm)
    ToolBar: TToolBar;
    tlBtnNovo: TToolButton;
    tlBtnEditar: TToolButton;
    tlBtnSalvar: TToolButton;
    tlBtnExcluir: TToolButton;
    tlBtnCancelar: TToolButton;
    imgLista: TImageList;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    pnlPesquisar: TPanel;
    lblPesquisar: TLabel;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    btBtnPesquisar: TBitBtn;
    dbGrdClientes: TDBGrid;
    grpBxDadosCliente: TGroupBox;
    lblDataFicha: TLabel;
    mEdDataFicha: TMaskEdit;
    StatusBar: TStatusBar;
    edPesquisa: TEdit;
    ppMnMostrarTodosClientes: TMenuItem;
    lblCodigoF: TLabel;
    edCodigo: TEdit;
    lblNomeF: TLabel;
    edNome: TEdit;
    lblEnderecoF: TLabel;
    lblCidadeF: TLabel;
    lblTelefoneF: TLabel;
    lblDataNascimentoF: TLabel;
    mEdDataNascimento: TMaskEdit;
    mEdTelefone: TMaskEdit;
    edCidade: TEdit;
    edEndereco: TEdit;
    lblCelularF: TLabel;
    mEdCelular: TMaskEdit;
    lblUFF: TLabel;
    edUF: TEdit;
    lblSexoF: TLabel;
    cbBxSexo: TComboBox;
    mEdCPF: TMaskEdit;
    lblCPFF: TLabel;
    mEdCEP: TMaskEdit;
    lblCEPF: TLabel;
    lblBairroF: TLabel;
    edBairro: TEdit;
    lblNaturalidadeF: TLabel;
    edNaturalidade: TEdit;
    lblRGF: TLabel;
    edIdentidade: TEdit;
    lblEstadoCivilF: TLabel;
    cbBxEstadoCivil: TComboBox;
    procedure tlBtnNovoClick(Sender: TObject);
    procedure tlBtnEditarClick(Sender: TObject);
    procedure tlBtnExcluirClick(Sender: TObject);
    procedure tlBtnCancelarClick(Sender: TObject);
    procedure dbGrdClientesCellClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure btBtnPesquisarClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ppMnMostrarTodosClientesClick(Sender: TObject);
    procedure rdBtnCodigoClick(Sender: TObject);
    procedure rdBtnNomeClick(Sender: TObject);
    procedure edPesquisaChange(Sender: TObject);
    procedure tlBtnSalvarClick(Sender: TObject);
    procedure edCidadeExit(Sender: TObject);
    procedure edPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure edCodigoEnter(Sender: TObject);
    procedure edCodigoExit(Sender: TObject);
    procedure edNomeExit(Sender: TObject);
    procedure edNomeEnter(Sender: TObject);
    procedure edEnderecoEnter(Sender: TObject);
    procedure edEnderecoExit(Sender: TObject);
    procedure edBairroExit(Sender: TObject);
    procedure edBairroEnter(Sender: TObject);
    procedure edCidadeEnter(Sender: TObject);
    procedure edUFEnter(Sender: TObject);
    procedure edUFExit(Sender: TObject);
    procedure mEdCEPExit(Sender: TObject);
    procedure mEdCEPEnter(Sender: TObject);
    procedure edNaturalidadeEnter(Sender: TObject);
    procedure edNaturalidadeExit(Sender: TObject);
    procedure mEdTelefoneExit(Sender: TObject);
    procedure mEdTelefoneEnter(Sender: TObject);
    procedure mEdCelularEnter(Sender: TObject);
    procedure mEdCelularExit(Sender: TObject);
    procedure cbBxSexoExit(Sender: TObject);
    procedure cbBxSexoEnter(Sender: TObject);
    procedure cbBxEstadoCivilEnter(Sender: TObject);
    procedure cbBxEstadoCivilExit(Sender: TObject);
    procedure mEdCPFExit(Sender: TObject);
    procedure mEdCPFEnter(Sender: TObject);
    procedure edIdentidadeEnter(Sender: TObject);
    procedure edIdentidadeExit(Sender: TObject);
    procedure mEdDataNascimentoExit(Sender: TObject);
    procedure mEdDataNascimentoEnter(Sender: TObject);
  private
    (*VARIÁVEIS DE CONTROLE*)
    Transacao: TTransactionDesc;//transações - deve-se adicionar a uses DBXpress
    opcaoSalvar: Integer; //modo de salvamento. 1=novo; 2=edição
    fechar: boolean; //se pode ou não fechar tela - casos de novo/editar, em que não pode fechar

    (*PROCEDURES DE CONTROLE*)
    procedure limpar();//limpar componentes
    function verificaSalva(): boolean; //verifica se os campos obrigatórios foram inseridos antes de salvar
    procedure visibilidade(opc: Integer);//quais componentes exibir/ocultar
    procedure iniciaTransacao();//dispara uma transação
    procedure carrega();//carrega dados da tabela Cliente para os componentes de apresentação
    procedure mostraTodosClientes();//exibe todos os Clientes
  public
   (*VARIÁVEIS DE CONTROLE*)
    operacao: String; //recebe valor para saber em que modo inicia a tela
  end;

var
  frmCliente: TfrmCliente;

implementation

uses unDataModule;


{$R *.dfm}

(*PROCEDURES DE CONTROLE*)

{carrega dados da tabela Cliente para os componentes de apresentação}
procedure TfrmCliente.carrega();
begin
  Self.limpar();

  DM.cdsCliente.Refresh;

  mEdDataFicha.Text := DM.cdsClienteDATA_FICHA.AsString;
  edCodigo.Text := DM.cdsClienteCODIGO.AsString;
  edNome.Text := DM.cdsClienteNOME.AsString;
  edEndereco.Text := DM.cdsClienteENDERECO.AsString;
  edBairro.Text := DM.cdsClienteBAIRRO.AsString;
  edCidade.Text := DM.cdsClienteCIDADE.AsString;
  edUF.Text := DM.cdsClienteUF.AsString;
  mEdCEP.Text := DM.cdsClienteCEP.AsString;
  edNaturalidade.Text := DM.cdsClienteNATURALIDADE.AsString;
  mEdTelefone.Text := DM.cdsClienteTELEFONE.AsString;
  mEdCelular.Text := DM.cdsClienteCELULAR.AsString;
  mEdCPF.Text := DM.cdsClienteCPF.AsString;
  edIdentidade.Text := DM.cdsClienteIDENTIDADE.AsString;
  mEdDataNascimento.Text := DM.cdsClienteDATA_NASCIMENTO.AsString;
  if (DM.cdsClienteSEXO.Text = 'MASCULINO')then
    cbBxSexo.ItemIndex := 0
  else if (DM.cdsClienteSEXO.Text = 'FEMININO')then
    cbBxSexo.ItemIndex := 1;
  if (DM.cdsClienteESTADO_CIVIL.Text = 'CASADO (A)')then
    cbBxEstadoCivil.ItemIndex := 0
  else if (DM.cdsClienteESTADO_CIVIL.Text = 'SEPARADO (A)')then
    cbBxEstadoCivil.ItemIndex := 1
  else if (DM.cdsClienteESTADO_CIVIL.Text = 'SOLTEIRO (A)')then
    cbBxEstadoCivil.ItemIndex := 2
  else if (DM.cdsClienteESTADO_CIVIL.Text = 'UNIÃO ESTÁVEL')then
    cbBxEstadoCivil.ItemIndex := 3
  else if (DM.cdsClienteESTADO_CIVIL.Text = 'VIÚVO (A)')then
    cbBxEstadoCivil.ItemIndex := 4;
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
  rdBtnCodigo.Checked := false;
  rdBtnNome.Checked := false;
  edPesquisa.Clear;

  mEdDataFicha.Clear;
  edCodigo.Clear;
  edNome.Clear;
  edEndereco.Clear;
  edBairro.Clear;
  edCidade.Clear;
  edUF.Clear;
  mEdCEP.Clear;
  edNaturalidade.Clear;
  mEdTelefone.Clear;
  mEdCelular.Clear;
  mEdCPF.Clear;
  edIdentidade.Clear;
  mEdDataNascimento.Clear;
  cbBxSexo.ItemIndex := 0;
  cbBxEstadoCivil.ItemIndex := 0;
end;

{verifica se os campos obrigatórios foram inseridos antes de salvar}
function TfrmCliente.verificaSalva(): boolean;
var
  campos: String;
begin

  campos := '';

  if (edNome.Text = '')then
    campos := 'Nome';
  if (campos <> '') then
    begin
    MessageDlg('Verifique os seguintes campos: ' + campos, mtInformation,[mbOK],0);
    Result := false;
    end
  else
    Result := true;
end;

{exibe todos os Clientes}
procedure TfrmCliente.mostraTodosClientes();
begin
  DM.qryCliente.Close;
  DM.qryCliente.SQL.Clear;
  DM.qryCliente.SQL.Add('SELECT * From Cliente c ORDER BY c.codigo');
  DM.qryCliente.Prepared := true;
  DM.qryCliente.Open;

  DM.cdsCliente.Refresh;
end;

{quais componentes exibir/ocultar}
 procedure TfrmCliente.visibilidade(opc: Integer);
begin
//cuidar na visibilidade - caso pessoa jurídica e física

  {a seqüência númerica pula de 10 em 10 - 1,2,3....11,12,13...
  1 = novo inicial
  11 = editar
  21 = salvar
  31 = excluir
  41 = cancelar
  }

  case opc of
    {novo inicial}
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


procedure TfrmCliente.tlBtnNovoClick(Sender: TObject);
begin
  {preparando}
  limpar();
  fechar := false;
  opcaoSalvar := 1;//novo
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Novo';

  visibilidade(1);
  edNome.SetFocus;
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
      DM.cdsCliente.Refresh;
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
    DM.cdsCliente.Refresh;
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
  DM.cdsCliente.Refresh;
  DM.cdsCliente.Last;
  carrega();
  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);
end;

procedure TfrmCliente.dbGrdClientesCellClick(Column: TColumn);
begin
  carrega();
  StatusBar.Panels[1].Text := 'OPERAÇÃO = Navegação';

  tlBtnNovo.Enabled := true;
  tlBtnSalvar.Enabled := false;
  tlBtnCancelar.Enabled := false;
end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  limpar();
  try
    mostraTodosClientes();
    DM.cdsCliente.First;
    carrega();
  except
  end;

  StatusBar.Panels[1].Text := '';
  fechar := true;
  visibilidade(41);

  if (operacao = 'novo') then
    tlBtnNovoClick(Sender);
end;

procedure TfrmCliente.btBtnPesquisarClick(Sender: TObject);
begin
  {código}
  if (rdBtnCodigo.Checked = true) then
    begin
    DM.qryCliente.Close;
    DM.qryCliente.SQL.Clear;
    DM.qryCliente.SQL.Add('SELECT * FROM Cliente WHERE codigo = :cod');
    DM.qryCliente.ParamByName('cod').AsInteger := StrToInt(edPesquisa.Text);
    DM.qryCliente.Prepared := true;
    DM.qryCliente.Open;

    DM.cdsCliente.Refresh;

    if(DM.cdsCliente.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Cliente encontrado com o código ' + edPesquisa.Text + '!', mtError,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosClientes();
      end;
    end;

  {nome}
  if (rdBtnNome.Checked = true) then
    begin
    DM.qryCliente.Close;
    DM.qryCliente.SQL.Clear;
    DM.qryCliente.SQL.Add('SELECT * FROM Cliente WHERE nome LIKE  ' + QuotedStr('%' + edPesquisa.Text + '%'));
    DM.qryCliente.Prepared := true;
    DM.qryCliente.Open;

    DM.cdsCliente.Refresh;

    if(DM.cdsCliente.RecordCount = 0)then
      begin
      MessageDlg('Nenhum Cliente encontrado com os caracteres ' + edPesquisa.Text + '!', mtInformation,[mbOk],0);
      edPesquisa.Clear;
      mostraTodosClientes();
      end;
    end;

  DM.cdsCliente.Refresh;
  DM.cdsCliente.Last;
  carrega();

  StatusBar.Panels[1].Text := '';
end;       

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

procedure TfrmCliente.ppMnMostrarTodosClientesClick(Sender: TObject);
begin
  limpar();
  mostraTodosClientes();
  DM.cdsCliente.Refresh;
  DM.cdsCliente.Last;
  carrega();
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

procedure TfrmCliente.tlBtnSalvarClick(Sender: TObject);
var
  salvar: boolean;
begin
  salvar := true;

  if (verificaSalva = true) then
  begin
  (*verificando se existe cliente com o nome já cadastrado*)
  if (opcaoSalvar = 1)then
    begin
    DM.qryCliente.Close;
    DM.qryCliente.SQL.Clear;
    DM.qryCliente.SQL.Add('SELECT * FROM Cliente WHERE nome =:nom');
    DM.qryCliente.ParamByName('nom').AsString := edNome.Text;
    DM.qryCliente.Prepared := true;
    DM.qryCliente.Open;

    DM.cdsCliente.Refresh;
    if (DM.cdsCliente.RecordCount <> 0) then
      begin
      salvar := false;
        if (MessageDlg('Cliente com este nome já cadastrado, deseja continuar?',mtConfirmation,[mbYes,mbNo],0)=mrYes)then
          salvar := true;
      end;
      end;

  if (salvar = false) then
    begin
    mostraTodosClientes();
    {atualizando ClientDataSet}
    DM.cdsCliente.Last;
    carrega();
    visibilidade(41);
    end;


  if (salvar=true)then
    begin
    case opcaoSalvar of
      1: begin //novo
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryCliente.Close;
         DM.qryCliente.SQL.Clear;
         DM.qryCliente.SQL.Add('INSERT INTO Cliente (nome,endereco,bairro,cidade,uf,cep,naturalidade,telefone,celular,cpf,identidade,data_nascimento,sexo,estado_civil,data_ficha) ');
         DM.qryCliente.SQL.Add('VALUES (:nome,:end,:bai,:cid,:uf,:cep,:nat,:tel,:cel,:cpf,:ide,:datNas,:sex,:estCiv,:datFic) ');

         DM.qryCliente.ParamByName('nome').AsString := edNome.Text;
         DM.qryCliente.ParamByName('end').AsString := edEndereco.Text;
         DM.qryCliente.ParamByName('bai').AsString := edBairro.Text;
         DM.qryCliente.ParamByName('cid').AsString := edCidade.Text;
         DM.qryCliente.ParamByName('uf').AsString := edUF.Text;
         DM.qryCliente.ParamByName('cep').AsString := mEdCEP.Text;
         DM.qryCliente.ParamByName('nat').AsString := edNaturalidade.Text;
         DM.qryCliente.ParamByName('tel').AsString := mEdTelefone.Text;
         DM.qryCliente.ParamByName('cel').AsString := mEdCelular.Text;
         DM.qryCliente.ParamByName('cpf').AsString := mEdCPF.Text;
         DM.qryCliente.ParamByName('ide').AsString := edIdentidade.Text;
         if (mEdDataNascimento.Text = '  /  /    ')then
           DM.qryCliente.ParamByName('datNas').AsDate := StrToDate('01/01/1900')
         else
           DM.qryCliente.ParamByName('datNas').AsDate := StrToDate(mEdDataNascimento.Text);
         DM.qryCliente.ParamByName('sex').AsString := cbBxSexo.Text;
         DM.qryCliente.ParamByName('estCiv').AsString := cbBxEstadoCivil.Text;
         DM.qryCliente.ParamByName('datFic').AsDate := StrToDate(mEdDataFicha.Text);

         DM.qryCliente.Prepared := true;
         DM.qryCliente.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         fechar := true;
         except
           MessageDlg('Cliente não pode ser salvo!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
           DM.SQLConnection.Rollback(transacao);
         end;
         end;

       2: begin //editar
         try
         iniciaTransacao();
         DM.SQLConnection.StartTransaction(transacao);

         DM.qryCliente.Close;
         DM.qryCliente.SQL.Clear;

         DM.qryCliente.SQL.Add('UPDATE Cliente SET nome=:nome,endereco=:end,bairro=:bai,cidade=:cid,uf=:uf,cep=:cep, ');
         DM.qryCliente.SQL.Add('naturalidade=:nat,telefone=:tel,celular=:cel,cpf=:cpf,identidade=:ide, ');
         DM.qryCliente.SQL.Add('data_nascimento=:datNas,sexo=:sex,estado_civil=:estCiv,data_ficha=:datFic ');
         DM.qryCliente.SQL.Add('WHERE codigo=:cod');

         DM.qryCliente.ParamByName('nome').AsString := edNome.Text;
         DM.qryCliente.ParamByName('end').AsString := edEndereco.Text;
         DM.qryCliente.ParamByName('bai').AsString := edBairro.Text;
         DM.qryCliente.ParamByName('cid').AsString := edCidade.Text;
         DM.qryCliente.ParamByName('uf').AsString := edUF.Text;
         DM.qryCliente.ParamByName('cep').AsString := mEdCEP.Text;
         DM.qryCliente.ParamByName('nat').AsString := edNaturalidade.Text;
         DM.qryCliente.ParamByName('tel').AsString := mEdTelefone.Text;
         DM.qryCliente.ParamByName('cel').AsString := mEdCelular.Text;
         DM.qryCliente.ParamByName('cpf').AsString := mEdCPF.Text;
         DM.qryCliente.ParamByName('ide').AsString := edIdentidade.Text;
         DM.qryCliente.ParamByName('datNas').AsDate := StrToDate(mEdDataNascimento.Text);
         DM.qryCliente.ParamByName('sex').AsString := cbBxSexo.Text;
         DM.qryCliente.ParamByName('estCiv').AsString := cbBxEstadoCivil.Text;
         DM.qryCliente.ParamByName('datFic').AsDate := StrToDate(mEdDataFicha.Text);
         DM.qryCliente.ParamByName('cod').AsInteger := StrToInt(edCodigo.Text);
         DM.qryCliente.Prepared := true;
         DM.qryCliente.ExecSQL();

         DM.SQLConnection.Commit(transacao);
         fechar := true;
       except
         MessageDlg('Cliente não pode ser editado!' +#13+ 'Verifique o erro!',mtError,[mbOk],0);
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
  end;//if

  end;

end;


procedure TfrmCliente.edCidadeExit(Sender: TObject);
begin
  edNaturalidade.Text := edCidade.Text;

  edCidade.Color := clWindow;
end;

procedure TfrmCliente.edPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if (rdBtnCodigo.Checked = true) then
    begin
    if not (Key in['0'..'9',Chr(8)])then
      Key:= #0;
    end;
end;

procedure TfrmCliente.edCodigoEnter(Sender: TObject);
begin
  edCodigo.Color := clMedGray;
end;

procedure TfrmCliente.edCodigoExit(Sender: TObject);
begin
  edCodigo.Color := clWindow;
end;

procedure TfrmCliente.edNomeExit(Sender: TObject);
begin
  edNome.Color := clWindow;
end;

procedure TfrmCliente.edNomeEnter(Sender: TObject);
begin
  edNome.Color := clMedGray;
end;

procedure TfrmCliente.edEnderecoEnter(Sender: TObject);
begin
  edEndereco.Color := clMedGray;
end;

procedure TfrmCliente.edEnderecoExit(Sender: TObject);
begin
  edEndereco.Color := clWindow;
end;

procedure TfrmCliente.edBairroExit(Sender: TObject);
begin
  edBairro.Color := clWindow;
end;

procedure TfrmCliente.edBairroEnter(Sender: TObject);
begin
  edBairro.Color := clMedGray;
end;

procedure TfrmCliente.edCidadeEnter(Sender: TObject);
begin
  edCidade.Color := clMedGray;
end;

procedure TfrmCliente.edUFEnter(Sender: TObject);
begin
  edUF.Color := clMedGray;
end;

procedure TfrmCliente.edUFExit(Sender: TObject);
begin
  edUF.Color := clWindow;
end;

procedure TfrmCliente.mEdCEPExit(Sender: TObject);
begin
  mEdCEP.Color := clWindow;
end;

procedure TfrmCliente.mEdCEPEnter(Sender: TObject);
begin
  mEdCEP.Color := clMedGray;
end;

procedure TfrmCliente.edNaturalidadeEnter(Sender: TObject);
begin
  edNaturalidade.Color := clMedGray;
end;

procedure TfrmCliente.edNaturalidadeExit(Sender: TObject);
begin
  edNaturalidade.Color := clWindow;
end;

procedure TfrmCliente.mEdTelefoneExit(Sender: TObject);
begin
  mEdTelefone.Color := clWindow;
end;

procedure TfrmCliente.mEdTelefoneEnter(Sender: TObject);
begin
  mEdTelefone.Color := clMedGray;
end;

procedure TfrmCliente.mEdCelularEnter(Sender: TObject);
begin
  mEdCelular.Color := clMedGray;
end;

procedure TfrmCliente.mEdCelularExit(Sender: TObject);
begin
  mEdCelular.Color := clWindow;
end;

procedure TfrmCliente.cbBxSexoExit(Sender: TObject);
begin
  cbBxSexo.Color := clWindow;
end;

procedure TfrmCliente.cbBxSexoEnter(Sender: TObject);
begin
  cbBxSexo.Color := clMedGray;
end;

procedure TfrmCliente.cbBxEstadoCivilEnter(Sender: TObject);
begin
  cbBxEstadoCivil.Color := clMedGray;
end;

procedure TfrmCliente.cbBxEstadoCivilExit(Sender: TObject);
begin
  cbBxEstadoCivil.Color := clWindow;
end;

procedure TfrmCliente.mEdCPFExit(Sender: TObject);
begin
  mEdCPF.Color := clWindow;
end;

procedure TfrmCliente.mEdCPFEnter(Sender: TObject);
begin
  mEdCPF.Color := clMedGray;
end;

procedure TfrmCliente.edIdentidadeEnter(Sender: TObject);
begin
  edIdentidade.Color := clMedGray;
end;

procedure TfrmCliente.edIdentidadeExit(Sender: TObject);
begin
  edIdentidade.Color := clWindow;
end;

procedure TfrmCliente.mEdDataNascimentoExit(Sender: TObject);
begin
  mEdDataNascimento.Color := clWindow;
end;

procedure TfrmCliente.mEdDataNascimentoEnter(Sender: TObject);
begin
  mEdDataNascimento.Color := clMedGray;
end;

end.
