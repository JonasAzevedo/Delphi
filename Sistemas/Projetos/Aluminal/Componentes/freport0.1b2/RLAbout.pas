unit RLAbout;

interface

uses
  SysUtils, Classes,
{$ifdef Win32}
  Windows, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
{$endif}
{$ifdef CF}
  Windows, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Buttons,
{$endif}

{$ifdef CLX}
  Types,
  Qt, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QButtons,
{$endif}
  RLReport, RLConsts, RLUtils;

type
  TfrmRLAbout = class(TForm)
    imgLogo: TImage;
    lblTitle: TLabel;
    lblVersion: TLabel;
    lblHome: TLabel;
    lblCopyright: TLabel;
    bbtOk: TBitBtn;
  private
    { Private declarations }
    procedure   Init;
  protected
    { Protected declarations }
    fAuthorKey:string;
    //
    procedure   KeyDown(var Key:Word; Shift:TShiftState); override;
  public
    { Public declarations }
    constructor Create(aOwner:TComponent); override;
  end;

var
  frmRLAbout: TfrmRLAbout;

implementation

{$R *.dfm}
constructor TfrmRLAbout.Create(aOwner:TComponent);
begin
  fAuthorKey:='';
  //
  inherited CreateNew(aOwner);
  //
  Init;
end;

procedure TfrmRLAbout.KeyDown(var Key:Word; Shift:TShiftState);
const
  authorkey='TEAM';
begin
  inherited;
  if (ssCtrl in Shift) and (Key>=65) and (Key<=90) then
  begin
    fAuthorKey:=fAuthorKey+Char(Key);
    if Length(fAuthorKey)>Length(authorkey) then
      Delete(fAuthorKey,1,1);
    if fAuthorKey=authorkey then
      Caption:='Autor: '+CS_AuthorNameStr;
  end;
{$ifdef CLX}
  if Key=key_escape then
    bbtOk.Click;
{$endif}
{$ifdef Win32}
  if Key=vk_escape then
    bbtOk.Click;
{$endif}
{$ifdef CF}
  if Key=vk_escape then
    bbtOk.Click;
{$endif}
end;

procedure TfrmRLAbout.Init;
begin
  Left := 250;
  Top := 223;
  ActiveControl := bbtOk;
{$ifdef Win32}
  BorderStyle := bsDialog;
{$endif};
{$ifdef CF}
  BorderStyle := bsDialog;
{$endif};
{$ifdef CLX}
  BorderStyle := fbsDialog;
{$endif};
  Caption := LS_AboutTheStr+' '+CS_ProductTitleStr;
  ClientHeight := 155;
  ClientWidth := 373;
  Color := clWhite;
  Font.Color := clWindowText;
  Font.Height := 11;
  Font.Name := 'MS Sans Serif';
  Font.Pitch := fpVariable;
  Font.Style := [];
  Position := poScreenCenter;
  Scaled := False;
  PixelsPerInch := 96;
  KeyPreview := True;
  Scaled := False;
  AutoScroll := False;
  //
  imgLogo:=TImage.Create(Self);
  with imgLogo do
  begin
    Name := 'imgLogo';
    Parent := Self;
    Left := 12;
    Top := 12;
    Width := 32;
    Height := 32;
    AutoSize := True;
    Picture.Graphic := HexToGraphic(
      '07544269746D617076020000424D760200000000000076000000280000002000'+
      '000020000000010004000000000000020000120B0000120B0000100000001000'+
      '000000000000000080000080000000808000800000008000800080800000C0C0'+
      'C000808080000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF'+
      'FF00FFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFF'+
      'FFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF99FFFFFFFFF'+
      'FFFFFFFFFFFFFFFFFFFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF99FFFFFFFFFF'+
      'FFFFFFFFFFFFFFFFFFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFF999FFFFFFFFFFF'+
      'FFFFFFFFFFFFFFFFFF99FFFFFFFFFFFFFFFFFFFFFFFFFFFFF999FFFFFFFFFFFF'+
      'FFFFFFFFFFFF99FFF999FFFFFFFFFFFFFFFFFFFFFF99FFFF999FFFFFFFFFFFFF'+
      'FFFFFFFF999FFFFF999FFFFFFFFFFFFFFFFFFFF9999FFFF9999FFFFFFFFFFFFF'+
      'FFFFFF9999FFFFF9999FFFFFFFFFFFFFFFFFF99999FFFFF9999FFFFFFFFFFFFF'+
      'FFFFF99999FFFF99999FFFFFFFFFFFFFFFFFF99999FFFF99999FFFFFFFFFFFFF'+
      'FFFFF999999FFF99999FFFFFFFFFFFFFFFFFFF999999FF99999FFFFFFFFFFFFF'+
      'FFFFFFF999999F99999FFFFFFFFFFFFFFFFFFFFFF9999999999FFFFFFFFFFFFF'+
      'FFFFFFFFFFF999999999FFFFFFFFFFFFFFFFFFFFFFFFF9999999FFFFFFFFFFFF'+
      'FFFFFFFFFFFFFF9999999FFFFFFFFF999FFFFF9999FFFFF999999999999999FF'+
      'FFFFF999999FFFFF99999999999FFFFFFFFFF999999FFFFFF999999FFFFFFFFF'+
      'FFFFF999999FFFFFFF9999999FFFFFFFFFFFF999999FFFFFFFFF99999999FFFF'+
      '999FFF9999FFFFFFFFFFFF99999999999FFFFFFFFFFFFFFFFFFFFFFFF9999FFF'+
      'FFFF');
  end;
  //
  lblTitle:=TLabel.Create(Self);
  with lblTitle do
  begin
    Name := 'lblTitle';
    Parent := Self;
    Left := 52;
    Top := 12;
    Width := 101;
    Height := 19;
    Caption := CS_ProductTitleStr;
    Font.Name := 'helvetica';
    Font.Color := clBlack;
    Font.Height := 19;
    Font.Pitch := fpVariable;
    Font.Style := [fsBold];
    ParentFont := False;
  end;
  //
  lblVersion:=TLabel.Create(Self);
  with lblVersion do
  begin
    Name := 'lblVersion';
    Parent := Self;
    Left := 52;
    Top := 32;
    Width := 65;
    Height := 13;
{$ifdef Win32}
    Caption := IntToStr(CommercialVersion)+'.'+IntToStr(ReleaseVersion)+' VCL';
{$endif}
{$ifdef CF}
    Caption := IntToStr(CommercialVersion)+'.'+IntToStr(ReleaseVersion)+' VCL';
{$endif}
{$ifdef CLX}
    Caption := IntToStr(CommercialVersion)+'.'+IntToStr(ReleaseVersion)+' CLX';
{$endif}
    Font.Name := 'helvetica';
    Font.Color := clBlack;
    Font.Height := 13;
    Font.Pitch := fpVariable;
    Font.Style := [];
    ParentFont := False;
  end;
  //
  lblHome:=TLabel.Create(Self);
  with lblHome do
  begin
    Name := 'lblHome';
    Parent := Self;
    Left := 52;
    Top := 72;
    Width := 169;
    Height := 14;
    Caption := CS_URLStr;
    Font.Name := 'helvetica';
    Font.Color := clBlue;
    Font.Height := -11;
    Font.Pitch := fpVariable;
    Font.Style := [fsUnderline];
    ParentFont := False;
  end;
  //
  lblCopyright:=TLabel.Create(Self);
  with lblCopyright do
  begin
    Name := 'lblCopyright';
    Parent := Self;
    Left := 52;
    Top := 56;
    Width := 211;
    Height := 14;
    Caption := CS_CopyrightStr;
    Font.Name := 'helvetica';
    Font.Color := clBlack;
    Font.Height := -11;
    Font.Pitch := fpVariable;
    Font.Style := [];
    ParentFont := False;
  end;
  //
  bbtOk:=TBitBtn.Create(Self);
  with bbtOk do
  begin
    Name := 'bbtOk';
    Parent := Self;
    Left := 256;
    Top := 112;
    Width := 99;
    Height := 26;
    Caption := '&Ok';
    TabOrder := 0;
    Kind := bkOK;
  end;
end;

end.
