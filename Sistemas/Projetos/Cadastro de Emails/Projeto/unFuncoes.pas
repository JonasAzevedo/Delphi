unit unFuncoes;

interface

procedure AdicionarItemNaLista(psValor: string; var psDestino:string; const psSeparador:string = ', ');

implementation

uses
  unConstantes;

//adiciona na variável psDestino o valor contido em psValor, sendo que um valor
//de outro será separado pela contante psSeparador.
procedure AdicionarItemNaLista(psValor: string; var psDestino:string; const psSeparador:string);
begin
  if psDestino = STRING_INDEFINIDO then
    psDestino := psValor
  else
    psDestino := psDestino + psSeparador + psValor;
end;

end.
