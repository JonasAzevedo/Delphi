unit unFuncoes;

interface

uses
  plsComboBox, Controls;

  type TFuncoes = class
    private
    public
      procedure InserirItensComboBox(psListaItens:String; poPlsComboBox:TPlsComboBox);
      procedure MostrarMensagem(pnTipo:Integer;const poValor:OleVariant);
      procedure FocarComponente(poComp: TWinControl);
  end;

implementation

uses
  unConstantes, SysUtils, Dialogs;

{ TFuncoes }

{ TFuncoes }

procedure TFuncoes.InserirItensComboBox(psListaItens: String;
  poPlsComboBox: TPlsComboBox);
var
  i: Integer;
  nTotCaracteres: Integer;
  sItemAtual: String;

  function FormatarItemInserir(psItem:String): String;
  var
    s:String;
  begin
    s := StringReplace(psItem, ',', '', [rfReplaceAll, rfIgnoreCase]);
    Result := s;
  end;

begin
  poPlsComboBox.Items.Clear;
  sItemAtual := STRING_INDEFINIDO;

  psListaItens := Trim(psListaItens);
  nTotCaracteres := length(psListaItens);

  for i:=1 to nTotCaracteres do
  begin
    //adiciona item ao comboBox
    if(psListaItens[i] = sCARACTER_SEPARADOR_ITENS_ARQUIVO_INI)or(i>nTotCaracteres)then
    begin
      poPlsComboBox.Items.Add(FormatarItemInserir(sItemAtual));
      sItemAtual := STRING_INDEFINIDO;
    end
    else
      sItemAtual := sItemAtual + psListaItens[i];
  end;

  //adicionar o último item
  if(sItemAtual <> STRING_INDEFINIDO)then
    poPlsComboBox.Items.Add(FormatarItemInserir(sItemAtual));
end;

procedure TFuncoes.MostrarMensagem(pnTipo:Integer;const poValor:OleVariant);
begin
  if(pnTipo = nCAMPO_OBRIGATORIO)then
  begin
    MessageDlg('Campo obrigatório não informado: ' + poValor, mtInformation, [mbOK], 0);
  end;
end;

procedure TFuncoes.FocarComponente(poComp: TWinControl);
begin
  try
    if poComp is TWinControl then
      TWinControl(poComp).SetFocus;
  except
  end;
end;


end.
