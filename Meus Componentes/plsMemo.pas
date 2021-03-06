unit plsMemo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TPlsMemo = class(TMemo)
  private
    colorRecebeFoco: TColor;
    colorPerdeFoco: TColor;
    enterMudaCampo: boolean;
    caracteresMaiusculo: boolean;

    procedure setColorRecebeFoco(cor: TColor);
    procedure setColorPerdeFoco(cor: TColor);
    procedure setEnterMudaCampo(enter: boolean);
    procedure setCaracteresMaiusculo(caracMaiusculo: boolean);
    function getColorRecebeFoco: TColor;
    function getColorPerdeFoco: TColor;
    function getEnterMudaCampo(): boolean;
    function getCaracteresMaiusculo(): boolean;
  protected
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
  public
    constructor Create(AOwner: Tcomponent);override;
    destructor Destroy; override;
  published
    property plsCorRecebeFoco: TColor read getColorRecebeFoco write setColorRecebeFoco default clGreen;
    property plsCorPerdeFoco: TColor read getColorPerdeFoco write setColorPerdeFoco default clWindow;
    property plsEnterMudaCampo: boolean read getEnterMudaCampo write setEnterMudaCampo default false;
    property plsCaractresMaiusculo: boolean read getCaracteresMaiusculo write setCaracteresMaiusculo default false;
  end;

procedure Register;

implementation

{ TPlsMemo }

(* constructor *)
constructor TPlsMemo.Create(AOwner: Tcomponent);
begin
  inherited;

  plsCorRecebeFoco := clGreen;
  plsCorPerdeFoco := clWindow;
  plsEnterMudaCampo := false;
  plsCaractresMaiusculo := false;
end;

(* destructor *)
destructor TPlsMemo.Destroy;
begin
  inherited;
end;

(* get's e set's *)
function TPlsMemo.getColorRecebeFoco: TColor;
begin
  Result := colorRecebeFoco;
end;

function TPlsMemo.getColorPerdeFoco: TColor;
begin
  Result := colorPerdeFoco;
end;

function TPlsMemo.getEnterMudaCampo(): boolean;
begin
  Result := enterMudaCampo;
end;

function TPlsMemo.getCaracteresMaiusculo(): boolean;
begin
  Result := caracteresMaiusculo;
end;

procedure TPlsMemo.setColorRecebeFoco(cor: TColor);
begin
  colorRecebeFoco := cor;
end;

procedure TPlsMemo.setColorPerdeFoco(cor: TColor);
begin
  colorPerdeFoco := cor;
end;

procedure TPlsMemo.setEnterMudaCampo(enter: boolean);
begin
  enterMudaCampo := enter;
end;

procedure TPlsMemo.setCaracteresMaiusculo(caracMaiusculo: boolean);
begin
  caracteresMaiusculo := caracMaiusculo;
end;

(* m�todos insere cor no bot�o *)
procedure TPlsMemo.DoEnter();
begin
  inherited;

  Self.Color := plsCorRecebeFoco;
end;

procedure TPlsMemo.DoExit();
begin
  inherited;

  Self.Color := plsCorPerdeFoco;
end;

procedure TPlsMemo.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

  if(getEnterMudaCampo)then
  begin
    if (Key = VK_RETURN) then
      TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TPlsMemo.KeyPress(var Key: Char);
begin
  inherited;

  if(plsCaractresMaiusculo)then
    Key := UpCase(key);
end;

(* registra componente na palheta PULSE *)
procedure Register;
begin
  RegisterComponents('Pulse', [TPlsMemo]);
end;

end.
