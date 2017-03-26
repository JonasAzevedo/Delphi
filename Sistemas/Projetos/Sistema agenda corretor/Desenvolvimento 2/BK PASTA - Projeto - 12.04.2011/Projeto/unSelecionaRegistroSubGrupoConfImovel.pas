unit unSelecionaRegistroSubGrupoConfImovel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unSelecionaRegistro, DBClient, Provider, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls, Buttons, plsComboBox, plsEdit,
  ExtCtrls, Grids, DBGrids;

type
  TfrmSelecionaRegistroSubGrupoConfiguracaoImovel = class(TfrmSelecionaRegistro)
  private
    { Private declarations }
  public
    procedure passarParametro(pTipo:String; pValores:OleVariant); override;
  end;

var
  frmSelecionaRegistroSubGrupoConfiguracaoImovel: TfrmSelecionaRegistroSubGrupoConfiguracaoImovel;

implementation

{$R *.dfm}

{ TfrmSelecionaRegistroSubGrupoConfiguracaoImovel }

procedure TfrmSelecionaRegistroSubGrupoConfiguracaoImovel.passarParametro(pTipo: String;
  pValores: OleVariant);
begin
  inherited;

end;

end.
