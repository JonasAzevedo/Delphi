unit UnboundSimpleDemoAbout;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, cxButtons, ComCtrls;

type
  TUnboundSimpleDemoAboutForm = class(TForm)
    imgIcon: TImage;
    lbDemoName: TLabel;
    lbCopyright: TLabel;
    bvBottom: TBevel;
    lbCompanyName: TLabel;
    reDemoInfo: TRichEdit;
    btnOK: TcxButton;
  end;

implementation

{$R *.dfm}

end.
