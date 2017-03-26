unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, BaseGrid, AdvGrid, DBAdvGrid, ImgList, DB, ADODB;

type
  TForm5 = class(TForm)
    DBAdvGrid1: TDBAdvGrid;
    ADOTable1: TADOTable;
    DataSource1: TDataSource;
    ImageList1: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

end.
