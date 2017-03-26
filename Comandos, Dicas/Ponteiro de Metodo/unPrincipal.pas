unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TipoPonteiroMetodo = procedure(psMsg: String)  of object;  

type
  TfrmPrincipal = class(TForm)
    edMensagem: TEdit;
    btnMostrarMensagem: TButton;
    btnAssociarPonteiroMetodo: TButton;
    btnChamarPonteiroMetodo: TButton;
    procedure btnMostrarMensagemClick(Sender: TObject);
    procedure btnAssociarPonteiroMetodoClick(Sender: TObject);
    procedure btnChamarPonteiroMetodoClick(Sender: TObject);
  private
    oPonteiroMetodo: TipoPonteiroMetodo;
  public
    procedure MetodoMensagem(psMensagem: String);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmPrincipal.MetodoMensagem(psMensagem: String);
begin
  ShowMessage(psMensagem);
end;

procedure TfrmPrincipal.btnMostrarMensagemClick(Sender: TObject);
begin
  MetodoMensagem(edMensagem.Text);
end;

procedure TfrmPrincipal.btnAssociarPonteiroMetodoClick(Sender: TObject);
begin
  oPonteiroMetodo := MetodoMensagem;
end;

procedure TfrmPrincipal.btnChamarPonteiroMetodoClick(Sender: TObject);
begin
  oPonteiroMetodo(edMensagem.Text);
end;

end.
 