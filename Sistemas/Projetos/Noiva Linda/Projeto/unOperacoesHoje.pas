unit unOperacoesHoje;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmOperacoesHoje = class(TForm)
    Label1: TLabel;
    lblTotalReservas: TLabel;
    mmReservasHoje: TMemo;
    Label2: TLabel;
    lblTotalLocacoes: TLabel;
    mmLocacoesDevolucao: TMemo;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOperacoesHoje: TfrmOperacoesHoje;

implementation

{$R *.dfm}

procedure TfrmOperacoesHoje.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key=#27)then
    Self.Close;
end;

end.
