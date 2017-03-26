{ Este arquivo foi automaticamente criado pelo Lazarus. não edite!
Este fonte é usado somente para compilar e instalar o pacote.
 }

unit ACBr_LCL; 

interface

uses
  ACBrCHQ, ACBrBase, ACBrDIS, ACBrExtenso, ACBrGAV, ACBrLCB, ACBrValidador, 
     ACBrReg, ACBrECF, ACBrTroco, ACBrBAL, ACBrCMC7, ACBrTER, ACBrFala, 
     ACBrGIF, LazarusPackageIntf; 

implementation

procedure Register; 
begin
  RegisterUnit('ACBrReg', @ACBrReg.Register); 
end; 

initialization
  RegisterPackage('ACBr_LCL', @Register); 
end.
