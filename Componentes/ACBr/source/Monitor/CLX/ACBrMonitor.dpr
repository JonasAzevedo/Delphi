{******************************************************************************}
{ Projeto: ACBr Monitor                                                        }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para }
{ criar uma interface de comunica��o com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2006 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na p�gina do Projeto ACBr     }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Este programa � software livre; voc� pode redistribu�-lo e/ou modific�-lo   }
{ sob os termos da Licen�a P�blica Geral GNU, conforme publicada pela Free     }
{ Software Foundation; tanto a vers�o 2 da Licen�a como (a seu crit�rio)       }
{ qualquer vers�o mais nova.                                                   }
{                                                                              }
{  Este programa � distribu�do na expectativa de ser �til, mas SEM NENHUMA     }
{ GARANTIA; nem mesmo a garantia impl�cita de COMERCIALIZA��O OU DE ADEQUA��O A}
{ QUALQUER PROP�SITO EM PARTICULAR. Consulte a Licen�a P�blica Geral GNU para  }
{ obter mais detalhes. (Arquivo LICENCA.TXT ou LICENSE.TXT)                    }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral GNU junto com este}
{ programa; se n�o, escreva para a Free Software Foundation, Inc., 59 Temple   }
{ Place, Suite 330, Boston, MA 02111-1307, USA. Voc� tamb�m pode obter uma     }
{ copia da licen�a em:  http://www.opensource.org/licenses/gpl-license.php     }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

program ACBrMonitor;

uses
  QForms,
  {$IFDEF MSWINDOWS}
   Windows,
  {$ENDIF}
  SysUtils,
  ACBrMonitor1 in 'ACBrMonitor1.pas' {FrmACBrMonitor},
  QTrayIcon in 'QTrayIcon.pas',
  Sobre in 'Sobre.pas' {frmSobre},
  DoECFUnit in 'DoECFUnit.pas',
  DoGAVUnit in 'DoGAVUnit.pas',
  DoCHQUnit in 'DoCHQUnit.pas',
  DoDISUnit in 'DoDISUnit.pas',
  DoLCBUnit in 'DoLCBUnit.pas',
  ConfiguraSerial in 'ConfiguraSerial.pas' {frConfiguraSerial},
  CmdUnit in 'CmdUnit.pas',
  DoECFBemafi32 in 'DoECFBemafi32.pas',
  DoECFObserver in 'DoECFObserver.pas';

{$IFNDEF MSWINDOWS}
var
    FHandle, N    : Integer ;
    ArqFlagAberto : String ;
    Buffer        : Pointer ;
    B             : Byte ;
{$ENDIF}

{$R *.res}

begin
  {$IFDEF MSWINDOWS}
   CreateMutex(nil, True, 'ACBrMonitor');
   if GetLastError = ERROR_ALREADY_EXISTS then
   begin
      Application.MessageBox('O programa ACBrMonitor j� est� em execu��o',
                             'ATEN��O !!',[smbOK],smsWarning) ;
      Application.Terminate ;
   end;
  {$ELSE}
   FHandle := 0 ;
  {$ENDIF}
  Application.Initialize;
  Application.Title := 'ACBrMonitor';

  {$IFNDEF MSWINDOWS}
  try
     try
       { Tenta criar arquivo em modo Exclusivo, se NAO conseguir j� est� rodando }
       B        := 65 ;
       Buffer   := @B ;
       ArqFlagAberto := ExtractFilePath(Application.ExeName) + 'ACBrMonitor_Aberto.tmp' ;

       if FileExists( ArqFlagAberto ) then
          FHandle := FileOpen( ArqFlagAberto, fmOpenReadWrite + fmShareExclusive )
       else
          FHandle := FileCreate( ArqFlagAberto, fmOpenReadWrite + fmShareExclusive );
       if FHandle < 0 then
          raise Exception.Create('Erro abrindo');
       N := FileSeek( FHandle, 0, 0 )  ;
       if N < 0 then
          raise Exception.Create('Erro seek');
       N := FileWrite(Fhandle, Buffer^, 1) ;
       if N < 0 then
          raise Exception.Create('Erro ao escrever');

     except
         if Application.MessageBox('O programa ACBrMonitor j� est� em execu��o'+
                                   'Deseja realmente abrir novamente o ACBrMonitor ?',
                                   'ATEN��O !!',[smbYes,smbNo],smsWarning) <> smbYes then
            raise
         else
            SysUtils.DeleteFile(ArqFlagAberto);
     end;
  {$ENDIF}
  Application.CreateForm(TFrmACBrMonitor, FrmACBrMonitor);
  Application.Run;
  {$IFNDEF MSWINDOWS}
  finally
    FileClose( FHandle );
    if FHandle > 0 then
       SysUtils.DeleteFile(ArqFlagAberto);
  end ;
  {$ENDIF}
end.

