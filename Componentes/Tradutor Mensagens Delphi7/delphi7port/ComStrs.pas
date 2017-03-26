
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1996-2001 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit ComStrs;

interface

resourcestring
  sTabFailClear = 'Falha ao limpar controle de aba';
  sTabFailDelete = 'Falha ao deletar �ndice %d da aba';
  sTabFailRetrieve = 'Falha ao recuperar a aba no �ndice %d';
  sTabFailGetObject = 'Falha ao inicializar objeto no �ndice %d ';
  sTabFailSet = 'Falha ao ajustar a aba " %s " no �ndice %d ';
  sTabFailSetObject = 'Falha ao ajustar o objeto no �ndice %d ';
  sTabMustBeMultiLine = 'MultiLine deve ser verdadeiro quando TabPosition � tpLeft ou tpRight ';

  sInvalidLevel = 'N�vel de �tem atribu�do inv�lido';
  sInvalidLevelEx = 'N�vel inv�lido (%d) para o item " %s "';
  sInvalidIndex = '�ndice inv�lido';
  sInsertError = 'N�o � poss�vel introduzir um item';

  sInvalidOwner = 'Propriet�rio Inv�lido';
  sUnableToCreateColumn = 'N�o � poss�vel criar nova coluna';
  sUnableToCreateItem = 'N�o � poss�vel criar novo item';

  sRichEditInsertError = 'Erro inserindo linha no RichEdit';
  sRichEditLoadFail = 'Falha ao carregar Stream';
  sRichEditSaveFail = 'Falha ao salvar Stream';

  sTooManyPanels = 'Barra de status n�o pode ter mais de 64 pain�is';

  sHKError = 'Erro ao atribuir Hot-Key � %s. %s';
  sHKInvalid = 'Hot-Key inv�lida';
  sHKInvalidWindow = 'Janela inv�lida ou Janela filha';
  sHKAssigned = 'Hot-Key est� atribu�da a outra janela';

  sUDAssociated = '%s j� � associado com %s';

  sPageIndexError = '%d � um valor de �ndice de p�gina inv�lido. �ndice de p�gina deve ser ' +
    'entre 0 e %d';

  sInvalidComCtl32 = 'Este controle requer COMCTL32.DLL vers�o 4.70 ou superior';

  sDateTimeMax = 'Data excede o valor m�ximo de %s';
  sDateTimeMin = 'Data � menor que o valor m�nimo de %s';
  sNeedAllowNone = 'Voc� deve estar em modo de ShowCheckbox para fixar esta data';
  sFailSetCalDateTime = 'Falha ao ajustar a data ou a hora do calend�rio';
  sFailSetCalMaxSelRange = 'Falha ao ajustar a escala m�xima de sele��o';
  sFailSetCalMinMaxRange = 'Falha ao ajustar a escala m�xima do calend�rio';
  sCalRangeNeedsMultiSelect = 'A escala da data somente pode ser usada no modo multiselect';
  sFailsetCalSelRange = 'Falha ao ajustar a escala selecionada do calend�rio';

implementation

end.
