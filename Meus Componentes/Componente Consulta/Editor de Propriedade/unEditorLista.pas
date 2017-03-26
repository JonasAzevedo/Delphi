unit unEditorLista;

interface

uses
  DsgnIntf, //editores de propriedades padrões do Delphi
  Classes; //TList

  type
    TListaProperty = class(TPropertyEditor)
      private
        lista: TStringItemList;
      public
        function getValue(): string; override;
        procedure setValue(const value: string); override;
      end;

    procedure Register;

implementation

function TListaProperty.GetValue : string;
begin
  Result := 'a';
end;

procedure TListaProperty.setValue(const value: string);
begin

end;

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(String),nil,'',TListaProperty);
end;



end.
