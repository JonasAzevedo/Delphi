unit plsTMaskEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask;

type
  TPlsMaskEdit = class(TMaskEdit)
  private
    colorRecebeFoco: TColor;
    colorPerdeFoco: TColor;
    enterMudaCampo: boolean;

    procedure setColorRecebeFoco(cor: TColor);
    procedure setColorPerdeFoco(cor: TColor);
    procedure setEnterMudaCampo(enter: boolean);
    function getColorRecebeFoco: TColor;
    function getColorPerdeFoco: TColor;
    function getEnterMudaCampo(): boolean;
  protected
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: Tcomponent);override;
    destructor Destroy; override;
  published
    property plsCorRecebeFoco: TColor read getColorRecebeFoco write setColorRecebeFoco default clGreen;
    property plsCorPerdeFoco: TColor read getColorPerdeFoco write setColorPerdeFoco default clWindow;
    property plsEnterMudaCampo: boolean read getEnterMudaCampo write setEnterMudaCampo default false;
  end;

procedure Register;

implementation

{ TPlsMaskEdit }

(* constructor *)
constructor TPlsMaskEdit.Create(AOwner: Tcomponent);
begin
  inherited;

  plsCorRecebeFoco := clGreen;
  plsCorPerdeFoco := clWindow;
  plsEnterMudaCampo := false;
end;

(* destructor *)
destructor TPlsMaskEdit.Destroy;
begin
  inherited;
end;

(* get's e set's *)
function TPlsMaskEdit.getColorRecebeFoco: TColor;
begin
  Result := colorRecebeFoco;
end;

function TPlsMaskEdit.getColorPerdeFoco: TColor;
begin
  Result := colorPerdeFoco;
end;

function TPlsMaskEdit.getEnterMudaCampo(): boolean;
begin
  Result := enterMudaCampo;
end;

procedure TPlsMaskEdit.setColorRecebeFoco(cor: TColor);
begin
  colorRecebeFoco := cor;
end;

procedure TPlsMaskEdit.setColorPerdeFoco(cor: TColor);
begin
  colorPerdeFoco := cor;
end;

procedure TPlsMaskEdit.setEnterMudaCampo(enter: boolean);
begin
  enterMudaCampo := enter;
end;

(* m�todos insere cor no bot�o *)
procedure TPlsMaskEdit.DoEnter();
begin
  inherited;

  Self.Color := plsCorRecebeFoco;
end;
  
procedure TPlsMaskEdit.DoExit();
begin
  inherited;

  Self.Color := plsCorPerdeFoco;
end;

procedure TPlsMaskEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

  if(getEnterMudaCampo)then
  begin
    if (Key = VK_RETURN) then
      TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

(* registra componente na palheta PULSE *)
procedure Register;
begin
  RegisterComponents('Pulse', [TPlsMaskEdit]);
end;

end.
 