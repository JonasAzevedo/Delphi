unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ZConnection, Grids, DBGrids, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, StdCtrls;

type
  TForm1 = class(TForm)
    zCon: TZConnection;
    zQryBusca: TZQuery;
    zQryBuscacodigo: TIntegerField;
    zQryBuscafacilityCircuitType: TStringField;
    zQryBuscaobjectID: TStringField;
    zQryBuscaidentificadorFacilidade: TStringField;
    zQryBuscaidentificadorLegado: TStringField;
    zQryBuscaidentificadorCircuitoCRM: TStringField;
    zQryBuscastatus: TStringField;
    zQryBuscacriadoPor: TStringField;
    zQryBuscadataCriacao: TStringField;
    zQryBuscacomentarios: TStringField;
    zQryBuscaservico: TStringField;
    zQryBuscacircuitoCompleto: TStringField;
    zQryBuscaportaLogicaCircuitoTDM: TStringField;
    zQryBuscaultimaAtualizacaoPorUsuario: TStringField;
    zQryBuscaultimaAtualizacao: TStringField;
    zQryBuscafilial: TStringField;
    zQryBuscaprocesso: TLargeintField;
    zQryBuscadataImportacao: TDateTimeField;
    zQryBuscastatusSAC: TStringField;
    zQryBuscatitularSAC: TStringField;
    zQryBuscatipoCircuitoSAC: TStringField;
    zQryBuscavelocidadeSAC: TStringField;
    zQryBuscadataCriacaoSAC: TDateTimeField;
    dsBusca: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    zQryAtualiza: TZQuery;
    zQryAtualizacodigo: TIntegerField;
    zQryAtualizafacilityCircuitType: TStringField;
    zQryAtualizaobjectID: TStringField;
    zQryAtualizaidentificadorFacilidade: TStringField;
    zQryAtualizaidentificadorLegado: TStringField;
    zQryAtualizaidentificadorCircuitoCRM: TStringField;
    zQryAtualizastatus: TStringField;
    zQryAtualizacriadoPor: TStringField;
    zQryAtualizadataCriacao: TStringField;
    zQryAtualizacomentarios: TStringField;
    zQryAtualizaservico: TStringField;
    zQryAtualizacircuitoCompleto: TStringField;
    zQryAtualizaportaLogicaCircuitoTDM: TStringField;
    zQryAtualizaultimaAtualizacaoPorUsuario: TStringField;
    zQryAtualizaultimaAtualizacao: TStringField;
    zQryAtualizafilial: TStringField;
    zQryAtualizaprocesso: TLargeintField;
    zQryAtualizadataImportacao: TDateTimeField;
    zQryAtualizastatusSAC: TStringField;
    zQryAtualizatitularSAC: TStringField;
    zQryAtualizatipoCircuitoSAC: TStringField;
    zQryAtualizavelocidadeSAC: TStringField;
    zQryAtualizadataCriacaoSAC: TDateTimeField;
    lblTotal: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  codNovo: Integer;
  tot: Integer;
begin
  tot := 0;
  lblTotal.Caption := IntToStr(tot);
  zCon.StartTransaction;
  try
    zQryBusca.Close;
    zQryBusca.SQL.Clear;
    zQryBusca.SQL.Add('SELECT * FROM circuitos ORDER BY codigo');
    zQryBusca.Open;
    zQryBusca.Refresh;
    zQryBusca.First;
    codNovo := 18243;
    while(not(zQryBusca.Eof))do
      begin
      zQryAtualiza.Close;
      zQryAtualiza.SQL.Clear;
      zQryAtualiza.SQL.Add('UPDATE circuitos SET codigo=:codNovo WHERE codigo=:cod ');
      zQryAtualiza.ParamByName('codNovo').AsInteger := codNovo;
      zQryAtualiza.ParamByName('cod').AsInteger := zQryBuscacodigo.AsInteger;
      zQryAtualiza.ExecSQL;

      inc(tot);
      inc(codNovo);
      lblTotal.Caption := IntToStr(tot);
      Application.ProcessMessages;
      zQryBusca.Next;
      end;
    zCon.Commit;
  except
    zCon.Rollback;
  end;     
end;

end.
