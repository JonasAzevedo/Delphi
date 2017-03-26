unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  //ponteiro para a estrutura
  ptrPessoa = ^TPessoa;

  //estrutura para pessoa
  TPessoa = record
    nome: String;
    email: String;
  end;

  TfrmPrincipal = class(TForm)
    edNome: TEdit;
    edEmail: TEdit;
    lblNome: TLabel;
    lblItensAdicionados: TLabel;
    lblEmail: TLabel;
    btnAdicionar: TButton;
    btnModificar: TButton;
    btnMostrar: TButton;
    btnExcluir: TButton;
    btnConferir: TButton;
    lstBxItensAdicionados: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnMostrarClick(Sender: TObject);
    procedure btnConferirClick(Sender: TObject);
  private

  public
    //var do tipo ponteiro da estrutura
    ponteiro: ptrPessoa;
    //classe TList armazenará nosso objetos
    listaDeCadastrados: TList;
    procedure operacao(aFlag: boolean);
    procedure emptyTList(var aList: TList);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.DFM}

{ TfrmPrincipal }

procedure TfrmPrincipal.emptyTList(var aList: TList);
var
  intContador: Integer;
begin
  for intContador:=(aList.Count-1) downto 0 do
  begin
    Dispose(aList.Items[intContador]);
    aList.Delete(intContador);
  end;
end;

procedure TfrmPrincipal.operacao(aFlag: boolean);
begin
    //se for verdadeiro, adiciona os dados na estrutura
    if(aFlag)then
    begin
      //quando for trabalhar com ponteiro, é importante
      //usar o new para alocar espaço na memória
      ponteiro := new(ptrPessoa);
      ponteiro^.nome := edNome.Text;
      ponteiro^.email := edEmail.Text;
      //adiciona ao ListBox os dados que foram armazenados
      //na estrutura e o ponteiro que foi guardado no TList
      lstBxItensAdicionados.Items.Add(IntToStr(listaDeCadastrados.Add(ponteiro))
                                     + ' - ' + IntToStr(Integer(ponteiro))
                                     + ' - ' + ponteiro^.nome
                                     + ' - ' + ponteiro^.email);
    end
    //se for falso altera um item
    else
    begin
      ponteiro^.nome := edNome.Text;
      ponteiro^.email := edEmail.Text;
      lstBxItensAdicionados.Items.Strings[lstBxItensAdicionados.ItemIndex] :=
                                     IntToStr(listaDeCadastrados.IndexOf(ponteiro))
                                     + ' - ' + IntToStr(Integer(ponteiro))
                                     + ' - ' + ponteiro^.nome
                                     + ' - ' + ponteiro^.email;
    end;
    edNome.Text := EmptyStr;
    edEmail.Text := EmptyStr;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  listaDeCadastrados := TList.Create;
end;

procedure TfrmPrincipal.btnAdicionarClick(Sender: TObject);
begin
  //indica que está adicionando item
  operacao(True);
end;

procedure TfrmPrincipal.btnExcluirClick(Sender: TObject);
begin
  try
    listaDeCadastrados.Delete(lstBxItensAdicionados.ItemIndex);
    lstBxItensAdicionados.Items.Delete(lstBxItensAdicionados.ItemIndex);
  except
    on E: Exception do
      Abort;
  end;
end;

procedure TfrmPrincipal.btnModificarClick(Sender: TObject);
begin
  //indica que está alterando um item
  operacao(False);
  btnModificar.Visible := false;
end;

procedure TfrmPrincipal.btnMostrarClick(Sender: TObject);
begin
  btnModificar.Visible := true;
  try
    //a variável ponteiro recebe o endereço de memória
    ///da estrutura guardada no TList
    ponteiro := listaDeCadastrados.Items[lstBxItensAdicionados.ItemIndex];
    edNome.Text := ponteiro^.nome;
    edEmail.Text := ponteiro^.email;
  except
    ShowMessage('Selecione um item');
  end;
end;

procedure TfrmPrincipal.btnConferirClick(Sender: TObject);
var
  i: Integer;
begin
    for i:=0 to listaDeCadastrados.Count-1 do
    begin
      ponteiro := listaDeCadastrados.Items[i];
      ShowMessage(IntToStr(listaDeCadastrados.IndexOf(ponteiro))
                 + ' - ' + IntToStr(Integer(ponteiro))
                 + ' - ' + ponteiro^.nome
                 + ' - ' + ponteiro^.email);
    end;
end;

end.
