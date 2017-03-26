unit unSobre;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls,unFuncoes;

type
  TfrmSobre = class(TForm)
    Panel1: TPanel;
    imgIcone: TImage;
    lblSistema: TLabel;
    lblVersao: TLabel;
    lblDesenvolvidoPor: TLabel;
    lblUltimaAtualizacao: TLabel;
    OKButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FoFuncoes: TFuncoes;
  public
  end;

var
  frmSobre: TfrmSobre;

implementation


{$R *.dfm}

procedure TfrmSobre.FormCreate(Sender: TObject);
begin
  FoFuncoes := TFuncoes.Create;
  lblVersao.Caption := 'Versão: ' + FoFuncoes.getVersao();
end;

procedure TfrmSobre.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FoFuncoes);
end;

procedure TfrmSobre.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if(Key=#27)then
    Close;
end;

end.
 
