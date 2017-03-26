unit unExibirMeiosCaptacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmExibirMeiosCaptacao = class(TForm)
    grpBxSelecioneMeioCaptacao: TGroupBox;
    lstBxMeiosCaptacao: TListBox;
    btBtnSelecionarMeioCaptacao: TBitBtn;
    zQryMeiosCaptacao: TZQuery;
    zQryMeiosCaptacaoMEIO_CAPTACAO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btBtnSelecionarMeioCaptacaoClick(Sender: TObject);
    procedure lstBxMeiosCaptacaoDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure LimparTela;
    procedure ListarMeiosCaptacao;
    procedure SelecionouMeioCaptacao;
  end;

var
  frmExibirMeiosCaptacao: TfrmExibirMeiosCaptacao;

implementation

uses unDM, unConstantes, unPrincipal;

{$R *.dfm}

{ TfrmExibirMeiosCaptacao }

procedure TfrmExibirMeiosCaptacao.LimparTela;
begin
  lstBxMeiosCaptacao.Clear;
end;

procedure TfrmExibirMeiosCaptacao.ListarMeiosCaptacao;
begin
  zQryMeiosCaptacao.Close;
  zQryMeiosCaptacao.SQL.Clear;
  zQryMeiosCaptacao.SQL.Add('SELECT DISTINCT(meio_captacao) FROM email');
  zQryMeiosCaptacao.Open;
  if(zQryMeiosCaptacao.Active)and(zQryMeiosCaptacao.RecordCount > NUMERO_NULO)then
  begin
    zQryMeiosCaptacao.First;
    while not(zQryMeiosCaptacao.Eof) do
    begin
      lstBxMeiosCaptacao.Items.Add(zQryMeiosCaptacaoMEIO_CAPTACAO.AsString);
      zQryMeiosCaptacao.Next;
    end;
    lstBxMeiosCaptacao.ItemIndex := 0;
  end;
end;

procedure TfrmExibirMeiosCaptacao.SelecionouMeioCaptacao;
begin
  frmCadastroEmails.PassarParametro(PRM_SELECIONOU_MEIO_CAPTACAO,
    lstBxMeiosCaptacao.Items.Strings[lstBxMeiosCaptacao.ItemIndex]);
  Self.Close;
end;

procedure TfrmExibirMeiosCaptacao.FormCreate(Sender: TObject);
begin
  LimparTela;
  ListarMeiosCaptacao;
end;

procedure TfrmExibirMeiosCaptacao.btBtnSelecionarMeioCaptacaoClick(
  Sender: TObject);
begin
  SelecionouMeioCaptacao;
end;

procedure TfrmExibirMeiosCaptacao.lstBxMeiosCaptacaoDblClick(
  Sender: TObject);
begin
  SelecionouMeioCaptacao;
end;

procedure TfrmExibirMeiosCaptacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if(Key = 27)then //esc
    Self.Close;

  if(Key = 13)then //enter
    SelecionouMeioCaptacao;
end;

end.
