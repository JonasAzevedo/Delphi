unit AboutBoxForm;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TfmNTAboutBox = class(TForm)
    OKBtn: TButton;
    icoProduct: TImage;
    stProduct: TLabel;
    stVersion: TLabel;
    stCopyright: TLabel;
    Label1: TLabel;
    stLicense1: TLabel;
    stLicense2: TLabel;
    Bevel1: TBevel;
    stMemAvail: TLabel;
    procedure FormShow(Sender: TObject);
  private
    procedure GetRegistrationInformation (isNT : boolean; var owner, organization : string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNTAboutBox: TfmNTAboutBox;

implementation

uses Registry;

{$R *.DFM}

procedure TfmNTAboutBox.GetRegistrationInformation (isNT : boolean; var owner, organization : string);
var
  product : string;
  p : Integer;
begin
  with TRegistry.Create do
  try
    product := ExtractFileName (Application.ExeName);
    p := Pos ('.', product);
    if p > 0 then Delete (product, p, Length (product));
    RootKey := HKEY_LOCAL_MACHINE;
    OpenKey (Format ('Software\Woozle\%s\CurrentVersion', [product]), True);
    if ValueExists ('RegisteredOwner') and ValueExists ('RegisteredOrganization') then
    begin
      owner := ReadString ('RegisteredOwner');
      organization := ReadString ('RegisteredOrganization')
    end
    else
    begin
      owner := 'Owner';
      organization := 'Organization';
      with TRegistry.Create do
      try
        RootKey := HKEY_LOCAL_MACHINE;
        if isNT then
          product := 'Windows NT'
        else
          product := 'Windows';

        OpenKey (Format ('Software\Microsoft\%s\CurrentVersion', [product]), False);
        owner := ReadString ('RegisteredOwner');
        organization := ReadString ('RegisteredOrganization');
        Free
      except
        Free
      end;
      WriteString ('RegisteredOwner', owner);
      WriteString ('RegisteredOrganization', organization);
    end
  finally
    free
  end
end;

procedure TfmNTAboutBox.FormShow(Sender: TObject);
var
  info : TOSVersionInfo;
  memInfo : TMemoryStatus;
  os, owner, organization : string;
begin
  with info do
  begin
    dwOSVersionInfoSize := sizeof (info);
    if GetVersionEx (info) then
    begin
      GlobalMemoryStatus (memInfo);
      Caption := 'About ' + Application.Title;
      if Assigned (Application.Icon) then
        icoProduct.Picture.Icon := Application.Icon;
      stProduct.Caption := Application.Title;

      case dwPlatformId of
      	VER_PLATFORM_WIN32s	: os := 'Windows 3.1';
        VER_PLATFORM_WIN32_WINDOWS : os := 'Windows 95';
		VER_PLATFORM_WIN32_NT : os := 'Windows NT'
      end;

      GetRegistrationInformation (dwPlatformId = VER_PLATFORM_WIN32_NT, owner, organization);
      stLicense1.Caption := owner;
      stLicense2.Caption := organization;
      stVersion.Caption := Format ('%s Version %d.%d  (Build %d: %s)', [os, dwMajorVersion, dwMinorVersion, dwBuildNumber, szCSDVersion]);
      stMemAvail.Caption := Format ('Physical Memory Available to Windows: %10.0n KB', [memInfo.dwTotalPhys / 1024]);
    end
  end

end;

end.
