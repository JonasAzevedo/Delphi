unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

const
  CM_Inserir = CM_BASE + 500;
  CM_Excluir = CM_BASE + 501;
  CM_Gravar = CM_BASE + 502;
  CM_Editar = CM_BASE + 503;

type
  TfrmPrincipal = class(TForm)
    btNovo: TButton;
    btEditar: TButton;
    btDeletar: TButton;
    btGravar: TButton;
    procedure btNovoClick(Sender: TObject);
    procedure btDeletarClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  frmPrincipal: TfrmPrincipal;
  //variável global que irá armazenar o handle da janela que pesquisaremos
  //com a função FindWindow
  recebeMsgWin: THandle;

implementation

{$R *.DFM}

procedure TfrmPrincipal.btNovoClick(Sender: TObject);
begin
  if (recebeMsgWin > 0) then
    SendMessage(recebeMsgWin, CM_Inserir, 0, 0);
end;

procedure TfrmPrincipal.btDeletarClick(Sender: TObject);
begin
  if (recebeMsgWin > 0) then
    SendMessage(recebeMsgWin, CM_Excluir, 0, 0);
end;

procedure TfrmPrincipal.btGravarClick(Sender: TObject);
begin
  if (recebeMsgWin > 0) then
    SendMessage(recebeMsgWin, CM_Gravar, 0, 0);
end;

procedure TfrmPrincipal.btEditarClick(Sender: TObject);
begin
  if (recebeMsgWin > 0) then
    SendMessage(recebeMsgWin, CM_Editar, 0, 0);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(recebeMsgWin);
end;

procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  recebeMsgWin := FindWindow('TfrmRecebeMensagem','Recebe Mensagem');
end;

end.
