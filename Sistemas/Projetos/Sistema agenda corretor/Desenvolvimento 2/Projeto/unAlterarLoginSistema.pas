unit unAlterarLoginSistema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, plsTMaskEdit, StdCtrls, Buttons, plsEdit;

type
  TfrmAlterarLoginSistema = class(TForm)
    grpBxLoginSenhaAtuais: TGroupBox;
    lblLoginAtual: TLabel;
    lblSenhaAtual: TLabel;
    plsEdLoginAtual: TPlsEdit;
    btBtnConfirmarLoginSenhaAtual: TBitBtn;
    plsMedSenhaAtual: TPlsMaskEdit;
    grpBxLoginSenhaNovos: TGroupBox;
    lblLoginNovo: TLabel;
    lblSenhaNovo: TLabel;
    plsEdLoginNovo: TPlsEdit;
    plsMedSenhaNovo: TPlsMaskEdit;
    plsMedSenhaConfirmacaoNovo: TPlsMaskEdit;
    Label1: TLabel;
    btBtnSalvarLoginSenhaNovos: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure btBtnConfirmarLoginSenhaAtualClick(Sender: TObject);
    procedure btBtnSalvarLoginSenhaNovosClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FsLogin: String;
    FsSenha: String;
    procedure pegarLoginSenhaAtuais;
  public
  end;

var
  frmAlterarLoginSistema: TfrmAlterarLoginSistema;

implementation

uses unDM, unConstantes;

{$R *.dfm}

procedure TfrmAlterarLoginSistema.pegarLoginSenhaAtuais;
begin
  DM.zQryUsuario.Close;
  DM.zQryUsuario.SQL.Clear;
  DM.zQryUsuario.SQL.Add('SELECT * FROM usuario WHERE codigo=1');
  DM.zQryUsuario.Open;
  if(DM.zQryUsuario.RecordCount=1)then
  begin
    FsLogin := DM.zQryUsuarioLOGIN.AsString;
    FsSenha := DM.zQryUsuarioSENHA.AsString;
  end
  else
  begin
    MessageDlg('Sistema não possui usuário administrador.',mtWarning,[mbOK],0);
    grpBxLoginSenhaAtuais.Enabled := False;
    grpBxLoginSenhaNovos.Enabled := False;
  end;
end;

procedure TfrmAlterarLoginSistema.FormShow(Sender: TObject);
begin
  Self.pegarLoginSenhaAtuais();
end;

procedure TfrmAlterarLoginSistema.btBtnConfirmarLoginSenhaAtualClick(
  Sender: TObject);
begin
  if(plsEdLoginAtual.Text = FsLogin)and(plsMedSenhaAtual.Text=FsSenha)then
  begin
    grpBxLoginSenhaAtuais.Enabled := False;
    grpBxLoginSenhaNovos.Visible := True;
    grpBxLoginSenhaNovos.Enabled := True;
    plsEdLoginNovo.Clear;
    plsMedSenhaNovo.Clear;
    plsMedSenhaConfirmacaoNovo.Clear;
    plsEdLoginNovo.SetFocus;
  end
  else
  begin
    MessageDlg('O login atual não confere.', mtWarning, [mbOK],0);
    plsEdLoginAtual.SetFocus;
  end;
end;

procedure TfrmAlterarLoginSistema.btBtnSalvarLoginSenhaNovosClick(
  Sender: TObject);
begin
  if(plsMedSenhaNovo.Text = plsMedSenhaConfirmacaoNovo.Text)then
  begin
    DM.ZConnection.StartTransaction;
    try
      DM.zQryUsuario.Close;
      DM.zQryUsuario.SQL.Clear;
      DM.zQryUsuario.SQL.Add('UPDATE usuario SET login=:login,senha=:senha ');
      DM.zQryUsuario.SQL.Add('WHERE codigo=:codigo');
      DM.zQryUsuario.ParamByName('login').AsString := Trim(plsEdLoginNovo.Text);
      DM.zQryUsuario.ParamByName('senha').AsString := Trim(plsMedSenhaNovo.Text);
      DM.zQryUsuario.ParamByName('codigo').AsInteger := 1;
      DM.zQryUsuario.ExecSQL();
      DM.ZConnection.Commit;
      MessageDlg('Realize logoff para utilizar o novo login.', mtInformation, [mbOK], 0);
      Self.Close;
    except
      DM.ZConnection.Rollback;
      MessageDlg('O novo login não pode ser salvo.', mtWarning, [mbOK], 0);      
    end;
  end
  else
  begin
    MessageDlg('A nova senha não confere.', mtWarning, [mbOK],0);
    plsMedSenhaConfirmacaoNovo.SetFocus;
  end;
end;

procedure TfrmAlterarLoginSistema.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if(Key=#27)then
    Self.Close;
end;

end.
