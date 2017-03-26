{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo: JvEnterTab.PAS    http://jvcl.sourceforge.net   }                                             
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/10/2004: Primeira Versao
|*    Daniel Simoes de Almeida
******************************************************************************}

{$I ACBr.inc}

unit ACBrEnterTabCLX;

interface

uses
 ACBrBase,
 Classes, SysUtils, QControls, QForms, QStdCtrls;

type
  TACBrEnterTab = class ( TACBrComponent )
  private
    FAllowDefault: Boolean;
    FEnterAsTab: Boolean;
    FOldKeyPreview : Boolean ;
    FOldOnKeyPress : TKeyPressEvent ; 
    procedure SetEnterAsTab(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent ); override ;
    destructor Destroy ; override ;
    
    procedure DoEnterAsTab(AForm : TObject; var Key: Char);
  published
    property EnterAsTab: Boolean read FEnterAsTab write SetEnterAsTab
       default false ;
    property AllowDefault: Boolean read FAllowDefault write FAllowDefault
       default true ;
  end;

{ Fun�oes extraidas e adaptadas de QControls.pas }
function _FindNextControl(AParent, CurControl: TWidgetControl;
  GoForward, CheckTabStop, CheckParent: Boolean): TWidgetControl;
function _SelectNext(AParent, CurControl: TWidgetControl;
  GoForward, CheckTabStop: Boolean): Boolean;

implementation

function _SelectNext(AParent, CurControl: TWidgetControl;
  GoForward, CheckTabStop: Boolean): Boolean;
begin
  CurControl := _FindNextControl(AParent, CurControl, GoForward,
    CheckTabStop, not CheckTabStop);
  Result := (CurControl <> nil);
  if Result then
    CurControl.SetFocus;
end;

function _FindNextControl(AParent, CurControl: TWidgetControl;
  GoForward, CheckTabStop, CheckParent: Boolean): TWidgetControl;
var
  I, StartIndex: Integer;
  List: TList;
begin
  Result := nil;
  List := TList.Create;
  try
    AParent.GetTabOrderList(List);
    if List.Count > 0 then
    begin
      StartIndex := List.IndexOf(CurControl);
      if StartIndex = -1 then
        if GoForward then StartIndex := List.Count - 1 else StartIndex := 0;
      I := StartIndex;
      repeat
        if GoForward then
        begin
          Inc(I);
	  if I = List.Count then I := 0;
        end else
        begin
          if I = 0 then I := List.Count;
          Dec(I);
        end;
        CurControl := List[I];
        if CurControl.CanFocus and
          (not CheckTabStop or CurControl.TabStop) and
          (not CheckParent or (CurControl.Parent = AParent)) then
          Result := CurControl;
      until (Result <> nil) or (I = StartIndex);
    end;
  finally
    List.Free;
  end;
end;

{ TACBrEnterTab }
constructor TACBrEnterTab.Create( AOwner: TComponent );
begin
  if not ( AOwner is TForm ) then
     raise Exception.Create('"Owner" do componente ACBrEnterTab deve ser do tipo TForm');

  inherited Create( AOwner );
  FEnterAsTab   := false ;
  FAllowDefault := True ;

  { Salvando estado das Propriedades do Form, que serao modificadas }
  with TForm( Owner ) do
  begin
     FOldKeyPreview := KeyPreview ;
     FOldOnKeyPress := OnKeyPress ;
  end ;
end;


destructor TACBrEnterTab.Destroy;
begin
  { Restaurando estado das propriedades de Form modificadas }
  if Assigned( Owner ) then
     if not (csFreeNotification in Owner.ComponentState) then
        with TForm( Owner ) do
        begin
           KeyPreview := FOldKeyPreview ;
           OnKeyPress := FOldOnKeyPress ;
        end ;

  inherited Destroy ;
end;

procedure TACBrEnterTab.DoEnterAsTab(AForm: TObject; var Key: Char);
begin
  try
     if not (AForm is TForm) then
        exit ;

     If Key = #13 Then
     begin
        if (TForm(AForm).ActiveControl is TButtonControl) and FAllowDefault then
        begin
           TButtonControl( TForm(AForm).ActiveControl ).AnimateClick ;
           exit ;
        end ;

        with TForm(AForm) do
        begin
           if ActiveControl is TWidgetControl then
           begin
              _SelectNext(TForm(AForm), TWidgetControl(ActiveControl),True, True );
           end ;
        end;
     end ;
  finally
     if Assigned( FOldOnKeyPress ) then
        FOldOnKeyPress( AForm, Key ) ;

     If Key = #13 Then
        Key := #0;
  end ;
end;

procedure TACBrEnterTab.SetEnterAsTab(const Value: Boolean);
begin
  if Value = FEnterAsTab then exit ;

  if not (csDesigning in ComponentState) then
  begin
     with TForm( Owner ) do
     begin
        if Value then
         begin
           KeyPreview := true ;
           OnKeyPress := DoEnterAsTab ;
         end
        else
         begin
           KeyPreview := FOldKeyPreview ;
           OnKeyPress := FOldOnKeyPress ;
         end ;
     end ;
  end ;

  FEnterAsTab := Value;
end;

end.
