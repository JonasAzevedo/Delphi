unit plsComboBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TPlsComboBox = class(TComboBox)
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

{ TPlsComboBox }

(* constructor *)
constructor TPlsComboBox.Create(AOwner: Tcomponent);
begin
  inherited;

  plsCorRecebeFoco := clGreen;
  plsCorPerdeFoco := clWindow;
  plsEnterMudaCampo := false;
end;

(* destructor *)
destructor TPlsComboBox.Destroy;
begin
  inherited;
end;

(* get's e set's *)
function TPlsComboBox.getColorRecebeFoco: TColor;
begin
  Result := colorRecebeFoco;
end;

function TPlsComboBox.getColorPerdeFoco: TColor;
begin
  Result := colorPerdeFoco;
end;

function TPlsComboBox.getEnterMudaCampo(): boolean;
begin
  Result := enterMudaCampo;
end;

procedure TPlsComboBox.setColorRecebeFoco(cor: TColor);
begin
  colorRecebeFoco := cor;
end;

procedure TPlsComboBox.setColorPerdeFoco(cor: TColor);
begin
  colorPerdeFoco := cor;
end;

procedure TPlsComboBox.setEnterMudaCampo(enter: boolean);
begin
  enterMudaCampo := enter;
end;

(* métodos insere cor no botão *)
procedure TPlsComboBox.DoEnter();
begin
  inherited;

  Self.Color := plsCorRecebeFoco;
end;

procedure TPlsComboBox.DoExit();
begin
  inherited;

  Self.Color := plsCorPerdeFoco;
end;

procedure TPlsComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

  if(Self.getEnterMudaCampo)then
  begin
    if(Key = VK_RETURN)then
      TControl(Owner).Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

(* registra componente na palheta PULSE *)
procedure Register;
begin
  RegisterComponents('Pulse', [TPlsComboBox]);
end;

end.
