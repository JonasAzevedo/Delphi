{********************************************************************}
{ TDBAdvNavigator DEMO application                                   }
{ version 1.2                                                        }
{ for Delphi 5.0,6.0,7.0 & C++Builder 5.0,6.0                        }
{                                                                    }
{ written by TMS Software                                            }
{            copyright © 2002-2004                                   }
{            Email : info@tmssoftware.com                            }
{            Website : http://www.tmssoftware.com                    }
{********************************************************************}


unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBAdvNavigator, AdvToolBtn, DB, DBTables, Grids,
  DBGrids, XPMan, StdCtrls;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    Table1: TTable;
    DataSource1: TDataSource;
    XPManifest1: TXPManifest;
    DBAdvNavigator1: TDBAdvNavigator;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


end.
