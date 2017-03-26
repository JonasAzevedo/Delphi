unit unPagarRestante;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, AppEvnts, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TfrmPagarRestante = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    bvlDivisao: TBevel;
    Label3: TLabel;
    lblLocacao: TLabel;
    edValorPago: TEdit;
    BitBtn1: TBitBtn;
    StatusBar: TStatusBar;
    ApplicationEvents: TApplicationEvents;
    lblValorTotal: TLabel;
    Label5: TLabel;
    lblValorPago: TLabel;
    procedure edValorPagoEnter(Sender: TObject);
    procedure edValorPagoKeyPress(Sender: TObject; var Key: Char);
    procedure edValorPagoExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
  private

  public
    codLocacao: Integer;

  end;

var
  frmPagarRestante: TfrmPagarRestante;

implementation

uses unDM;

{$R *.dfm}

procedure TfrmPagarRestante.edValorPagoEnter(Sender: TObject);
begin
  edValorPago.Color := clMoneyGreen;
end;

procedure TfrmPagarRestante.edValorPagoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not(Key in['0'..'9',',',Chr(8)])then
    Key:= #0;
end;

procedure TfrmPagarRestante.edValorPagoExit(Sender: TObject);
begin
  if (edValorPago.Text = '') then
    edValorPago.Text := '0,00'
  else
    begin
    try
      edValorPago.Text := FormatFloat('#0.00',StrToFloat(edValorPago.Text));
    except
    end;
    end;
  edValorPago.Color := clWindow;
end;

procedure TfrmPagarRestante.BitBtn1Click(Sender: TObject);
var
  vlrPago: Real;
begin
  if ((StrToFloat(edValorPago.Text)>(StrToFloat(lblValorTotal.Caption)-StrToFloat(lblValorPago.Caption))))then
    begin
    ShowMessage('Valor Pago é maior que Valor Restante!');
    edValorPago.Text :=  FormatFloat('#0.00',(StrToFloat(lblValorTotal.Caption)-StrToFloat(lblValorPago.Caption)));
    end
  else
    begin
    try
      vlrPago := StrToFloat(lblValorPago.Caption) + StrToFloat(edValorPago.Text);
      DM.qryLocacao.Close;
      DM.qryLocacao.SQL.Clear;
      DM.qryLocacao.SQL.Add('UPDATE Locacao SET valor_pago=:valPag ');
      DM.qryLocacao.ParamByName('valPag').AsFloat := vlrPago;
      if (vlrPago = StrToFloat(lblValorTotal.Caption)) then
        DM.qryLocacao.SQL.Add(', pago=1 ');
      DM.qryLocacao.SQL.Add('WHERE codigo=:cod');
      DM.qryLocacao.ParamByName('cod').AsInteger := StrToInt(lblLocacao.Caption);
      DM.qryLocacao.Prepared := true;
      DM.qryLocacao.ExecSQL();
      MessageDlg('Valor Pago com sucesso!',mtInformation,[mbOK],0);
    except
      MessageDlg('Valor não pode ser pago!',mtInformation,[mbOK],0);
    end;
    end;

  Self.Close;
end;

procedure TfrmPagarRestante.ApplicationEventsException(Sender: TObject;
  E: Exception);
begin
  StatusBar.Panels[0].Text := Application.Hint;
end;

end.
