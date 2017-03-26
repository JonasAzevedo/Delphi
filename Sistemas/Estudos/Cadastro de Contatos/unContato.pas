unit unContato;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, plsEdit, plsMemo, Mask, plsTMaskEdit;

type
  TForm2 = class(TForm)
    lblCodigo: TLabel;
    lblNome: TLabel;
    lblDataNascimento: TLabel;
    lblProfissao: TLabel;
    lblEmpresa: TLabel;
    lblDescricao: TLabel;
    lblDataCadastro: TLabel;
    plsEdCodigo: TPlsEdit;
    plsEdNome: TPlsEdit;
    plsEdProfissao: TPlsEdit;
    plsEdEmpresa: TPlsEdit;
    plsMmDescricao: TPlsMemo;
    plsMedDataCadastro: TPlsMaskEdit;
    plsMedDataNascimento: TPlsMaskEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

end.
