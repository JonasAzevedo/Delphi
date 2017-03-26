unit ResourcePropertiesDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TdlgResourceProperties = class(TForm)
    Label1: TLabel;
    edIdentifier: TEdit;
    Label2: TLabel;
    cbLanguage: TComboBox;
    btnOK: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgResourceProperties: TdlgResourceProperties;

implementation

{$R *.DFM}

end.
