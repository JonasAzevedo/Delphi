{**************************************************************************}
{ TWebUpdate and TWebUpdateWizard demo                                     )
{ for Delphi 5,6,7 & C++Builder 5,6                                        }
{ version 1.6                                                              }
{                                                                          }
{ Copyright � 1998-2004                                                    }
{   TMS Software                                                           }
{   Email : info@tmssoftware.com                                           }
{   Web : http://www.tmssoftware.com                                       }
{**************************************************************************}


unit Utestapp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, WUpdate, WUpdateWiz, Menus
  {$IFDEF VER150}
  ,XPMan
  {$ENDIF}
  ;

type
  TForm1 = class(TForm)
    WebUpdateWizard1: TWebUpdateWizard;
    WebUpdate1: TWebUpdate;
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
begin
  webupdatewizard1.Execute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  webupdate1.DoUpdate;
end;

end.
