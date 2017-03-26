
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
  sTabFailDelete = 'Falha ao deletar índice %d da aba';
  sTabFailRetrieve = 'Falha ao recuperar a aba no índice %d';
  sTabFailGetObject = 'Falha ao inicializar objeto no índice %d ';
  sTabFailSet = 'Falha ao ajustar a aba " %s " no índice %d ';
  sTabFailSetObject = 'Falha ao ajustar o objeto no índice %d ';
  sTabMustBeMultiLine = 'MultiLine deve ser verdadeiro quando TabPosition é tpLeft ou tpRight ';

  sInvalidLevel = 'Nível de ítem atribuído inválido';
  sInvalidLevelEx = 'Nível inválido (%d) para o item " %s "';
  sInvalidIndex = 'Índice inválido';
  sInsertError = 'Não é possível introduzir um item';

  sInvalidOwner = 'Proprietário Inválido';
  sUnableToCreateColumn = 'Não é possível criar nova coluna';
  sUnableToCreateItem = 'Não é possível criar novo item';

  sRichEditInsertError = 'Erro inserindo linha no RichEdit';
  sRichEditLoadFail = 'Falha ao carregar Stream';
  sRichEditSaveFail = 'Falha ao salvar Stream';

  sTooManyPanels = 'Barra de status não pode ter mais de 64 painéis';

  sHKError = 'Erro ao atribuir Hot-Key à %s. %s';
  sHKInvalid = 'Hot-Key inválida';
  sHKInvalidWindow = 'Janela inválida ou Janela filha';
  sHKAssigned = 'Hot-Key está atribuída a outra janela';

  sUDAssociated = '%s já é associado com %s';

  sPageIndexError = '%d é um valor de índice de página inválido. Índice de página deve ser ' +
    'entre 0 e %d';

  sInvalidComCtl32 = 'Este controle requer COMCTL32.DLL versão 4.70 ou superior';

  sDateTimeMax = 'Data excede o valor máximo de %s';
  sDateTimeMin = 'Data é menor que o valor mínimo de %s';
  sNeedAllowNone = 'Você deve estar em modo de ShowCheckbox para fixar esta data';
  sFailSetCalDateTime = 'Falha ao ajustar a data ou a hora do calendário';
  sFailSetCalMaxSelRange = 'Falha ao ajustar a escala máxima de seleção';
  sFailSetCalMinMaxRange = 'Falha ao ajustar a escala máxima do calendário';
  sCalRangeNeedsMultiSelect = 'A escala da data somente pode ser usada no modo multiselect';
  sFailsetCalSelRange = 'Falha ao ajustar a escala selecionada do calendário';

implementation

end.
