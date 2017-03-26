unit unSelecionaRegistroSubGrupoBemNegociavel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, plsComboBox, plsEdit,
  ExtCtrls, Grids, DBGrids;

type
  TfrmSelecionaRegistroSubGrupoBemNegociavel = class(TfrmSelecionaRegistro)
  private
    { Private declarations }
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
  end;
var
  frmSelecionaRegistroSubGrupoBemNegociavel: TfrmSelecionaRegistroSubGrupoBemNegociavel;

implementation

{$R *.dfm}

{ TfrmSelecionaRegistroSubGrupoBemNegociavel }

procedure TfrmSelecionaRegistroSubGrupoBemNegociavel.passarParametro(pTipo: String;
  pValores: OleVariant);
begin
  inherited;

end;

end.
