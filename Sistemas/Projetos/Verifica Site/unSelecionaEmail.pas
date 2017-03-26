unit unSelecionaEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AppEvnts, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids,
  DBGrids;

type
  TForm1 = class(TForm)
    grpBxClientes: TGroupBox;
    DBGridClientes: TDBGrid;
    btBtnNovoCliente: TBitBtn;
    grpBxPesquisa: TGroupBox;
    rdBtnCodigo: TRadioButton;
    rdBtnNome: TRadioButton;
    edPesquisa: TEdit;
    btBtnPesquisar: TBitBtn;
    pnlDivisao: TPanel;
    StatusBar: TStatusBar;
    btBtnSelecionarCliente: TBitBtn;
    ApplicationEvents: TApplicationEvents;
    PopupMenu: TPopupMenu;
    ppMnMostrarTodosClientes: TMenuItem;
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
