unit unPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dbClient;

type
  TfrmPrincipal = class(TForm)
    btnCriaClientDataSet: TButton;
    procedure btnCriaClientDataSetClick(Sender: TObject);
  private
    tbDados: TClientDataSet;
  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.DFM}

procedure TfrmPrincipal.btnCriaClientDataSetClick(Sender: TObject);
begin
  tbDados := TClientDataSet.Create(nil);
  try
    //cria campos
    tbDados.FieldDefs.Add( 'codigo', ftInteger);
    tbDados.FieldDefs.Add('nome',ftString,100);
    tbDados.FieldDefs.Add('cidade',ftString,80);
    //confirma��o e cria��o da estrutura DataSet
    tbDados.CreateDataSet;
    //inser��o de dados
    tbDados.InsertRecord([1, 'Jonas', 'Florian�polis']);
    tbDados.InsertRecord([2, 'Juliano', 'Capinzal']);
    tbDados.InsertRecord([3, 'Renato', 'Curitiba']);
    //salvando os dados em mem�ria no formato bin�rio
    tbDados.SaveToFile('registros.dat',dfBinary);
  finally
    FreeAndNil(tbDados);
  end;
end;

end.
