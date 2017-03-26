unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmPrincipal = class(TForm)
    edCPF: TEdit;
    edCGC: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    btnCPF: TButton;
    btnCGC: TButton;
    lstBxValidos: TListBox;
    btnSuspender: TButton;
    btnProcuraCPFs: TButton;
    lblTotal: TLabel;
    procedure btnCPFClick(Sender: TObject);
    procedure btnCGCClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSuspenderClick(Sender: TObject);
    procedure btnProcuraCPFsClick(Sender: TObject);
  private
    fBProcessa: boolean;
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses unFuncoes;

{$R *.dfm}

procedure TfrmPrincipal.btnCPFClick(Sender: TObject);
begin
  if cpf(edCPF.Text) then
    ShowMessage('CPF valido!')
  else
    ShowMessage('CPF invalido!');
end;

procedure TfrmPrincipal.btnCGCClick(Sender: TObject);
begin
  if cgc(edCGC.Text) then
    ShowMessage('CGC valido!')
  else
    ShowMessage('CGC invalido!');
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  fBProcessa := False;
end;

procedure TfrmPrincipal.btnSuspenderClick(Sender: TObject);
begin
  fBProcessa := False;
end;

procedure TfrmPrincipal.btnProcuraCPFsClick(Sender: TObject);
var
  sNumCPF: String;
  i: Integer;
  bValido: boolean;
  iTotal: Integer;
begin
  fBProcessa := True;
  lstBxValidos.Clear;
  lblTotal.Caption := '';
  iTotal := 0;
  randomize();

  while fBProcessa do
  begin
    sNumCPF := '';
    for i:=1 to 11 do
      sNumCPF := sNumCPF + IntToStr(random(9));
    bValido := cpf(sNumCPF);
    if bValido then
    begin
      lstBxValidos.Items.Add(sNumCPF);
      Inc(iTotal);
      lblTotal.Caption := 'Total : ' + IntToStr(iTotal);
    end;
    Application.ProcessMessages;
  end;
end;

end.
