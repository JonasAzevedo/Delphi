procedure AjustaForm;
//
// Ajusta a visualiza��o de um formul�rio de maneira 
// correta independente da resolu��o do monitor o qual
// roda nossa aplica��o.
//
// deve ser colocada na unit do form que se deseja fazer o ajuste
//
// Declare-a na clausula private da unit:
//
// Private
// procedure AjustaForm;
//
// depois inicialize-a na unit assim:
//
// procedure TForm1.AjustaForm;
//
Const
nTamOriginal = 640; // Ser� o 100% da escala
Var
nEscala : Double; // Vai me dar o percentual de Transforma��o escalar
nPorcento : Integer; // Vai me dar em percentual inteiro o valor
begin
With Formulario do
begin
if nTamOriginal <> Screen.Width then
   begin
   nEscala := ((Screen.Width-nTamOriginal)/nTamOriginal);
   nPorcento := Round((nEscala*100) + 100);
   Self.Width := Round(Self.Width * (nEscala+1));
   Self.Height := Round(Self.Height * (nEscala+1));
   Self.ScaleBy(nPorcento,100);
   end;
end;
end;
