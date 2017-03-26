
{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{                                                       }
{  Copyright (c) 1995-2001 Borland Software Corporation }
{                                                       }
{*******************************************************}

unit Consts;

interface

resourcestring

  SOpenFileTitle = 'Abrir';
  SCantWriteResourceStreamError = 'N�o � poss�vel gravar em um fluxo de recusos somente de leitura';
  SDuplicateReference = 'Objeto chamado duas vezes pela mesma inst�ncia';
  SClassMismatch = 'Arquivo de recursos %s � de classe incorreta';
  SInvalidTabIndex = 'Indexador de tabula��o fora de faixa';
  SInvalidTabPosition = 'Posi��o da aba incompat�vel com Estilo da aba corrente';
  SInvalidTabStyle = 'Estilo da aba incompat�vel com a posi��o da aba corrente';
  SInvalidBitmap = 'Bitmap n�o � v�lido';
  SInvalidIcon = '�cone n�o � v�lido';
  SInvalidMetafile = 'Metafile n�o � v�lido';
  SInvalidPixelFormat = 'Formato de pixel inv�lido';
  SInvalidImage = 'Formato de fluxo inv�lido';
  SBitmapEmpty = 'Bitmap est� vazio';
  SScanLine = 'Procura de indexador de linha fora de faixa';
  SChangeIconSize = 'N�o � poss�vel trocar o tamanho do �cone';
  SOleGraphic = 'Opera��o inv�lida em TOleGraphic';
  SUnknownExtension = 'Arquivo de imagem com exten��o (.%s) ignorado';
  SUnknownClipboardFormat = 'Formato n�o suportado';
  SOutOfResources = 'Sistema sem recursos';
  SNoCanvasHandle = 'O canvas n�o esta permitindo desenhar';
  SInvalidImageSize = 'Tamanho de imagem inv�lido';
  STooManyImages = 'Muitas imagens';
  SDimsDoNotMatch = 'Dimens�es da imagem diferente da lista de imagens';
  SInvalidImageList = 'ImageList inv�lido';
  SReplaceImage = 'Impossibilitado de trocar a imagem';
  SImageIndexError = 'Indexador do ImageList inv�lido';
  SImageReadFail = 'Falha ao ler os dados do ImageList para o fluxo';
  SImageWriteFail = 'Falha ao gravar dados no ImageList para o fluxo';
  SWindowDCError = 'Erro ao criar a janela de contexto do dispositivo';
  SClientNotSet = 'Cliente do TDrag n�o inicializado';
  SWindowClass = 'Erro criando a classe da janela';
  SWindowCreate = 'Erro criando a janela';
  SCannotFocus = 'N�o � poss�vel focar uma janela invis�vel ou n�o permitida';
  SParentRequired = 'Controle ''%s'' n�o tem antecessor na janela';
  SParentGivenNotAParent = 'Controle requerido n�o � um ancestral de ''%s''';
  SMDIChildNotVisible = 'N�o � poss�vel esconder um formul�rio filho MDI';
  SVisibleChanged = 'N�o � poss�vel trocar a propriedade Visible em OnShow ou OnHide';
  SCannotShowModal = 'N�o � poss�vel marcar uma janela vis�vel como modal';
  SScrollBarRange = 'Propriedade Scrollbar fora de faixa';
  SPropertyOutOfRange = 'Propriedade %s fora de faixa';
  SMenuIndexError = '�ndice de menu fora de faixa';
  SMenuReinserted = 'Menu inserido duas vezes';
  SMenuNotFound = 'Sub-menu n�o est� em um menu';
  SNoTimers = 'N�o h� timers suficientes';
  SNotPrinting = 'Impressora n�o est� imprimindo agora';
  SPrinting = 'Impress�o em progresso';
  SPrinterIndexError = 'Indice da impressora fora de faixa';
  SInvalidPrinter = 'Impressora selecionada n�o � v�lida';
  SDeviceOnPort = '%s em %s';
  SGroupIndexTooLow = 'GroupIndex n�o pode ser menor que o �tem de menu anterior ao GroupIndex';
  STwoMDIForms = 'N�o � poss�vel ter mais que um formul�rio MDI por aplica��o';
  SNoMDIForm = 'N�o � poss�vel criar formul�rio. N�o h� formul�rios MDI ativos neste momento';
  SImageCanvasNeedsBitmap = 'N�o � poss�vel modificar um TImage que cont�m um bitmap';
  SControlParentSetToSelf = 'Um controle n�o pode ter ele mesmo como seu antecessor';
  SOKButton = 'OK';
  SCancelButton = 'Cancelar';
  SYesButton = '&Sim';
  SNoButton = '&N�o';
  SHelpButton = '&Ajuda';
  SCloseButton = '&Fechar';
  SIgnoreButton = '&Ignorar';
  SRetryButton = '&Repetir';
  SAbortButton = 'Abortar';
  SAllButton = '&Todos';

  SCannotDragForm = 'N�o � poss�vel arrastar um formul�rio';
  SPutObjectError = 'PutObject n�o definido para �tem';
  SCardDLLNotLoaded = 'N�o posso carregar CARDS.DLL';
  SDuplicateCardId = 'Encontrado uma duplicata de CardId';

  SDdeErr = 'Um erro retornado pelo DDE ($0%x)';
  SDdeConvErr = 'Erro no DDE - conversa��o n�o estabelecida ($0%x)';
  SDdeMemErr = 'Erro ocorrido quando DDE rodou sem mem�ria ($0%x)';
  SDdeNoConnect = 'Incapaz de conectar conversa��o DDE';

  SFB = 'FB';
  SFG = 'FG';
  SBG = 'BG';
  SOldTShape = 'N�o posso carregar uma vers�o antiga de TShape';
  SVMetafiles = 'Metafiles';
  SVEnhMetafiles = 'Metafiles real�ado';
  SVIcons = '�cone';
  SVBitmaps = 'Bitmaps';
  SGridTooLarge = 'Grid muito larga para esta opera��o';
  STooManyDeleted = 'Muitas linhas ou colunas deletadas';
  SIndexOutOfRange = '�ndice do grid fora de faixa';
  SFixedColTooBig = 'Contador de colunas fixas deve ser menor ou igual que o n�mero de colunas';
  SFixedRowTooBig = 'Contador de linhas fixas deve ser menor ou igual ao n�mero de linhas';
  SInvalidStringGridOp = 'N�o � poss�vel inserir ou deletar linhas da grade';
  SInvalidEnumValue = 'Valor Enum inv�lido';
  SInvalidNumber = 'Valor num�rico inv�lido';
  SOutlineIndexError = '�ndice de contorno n�o encontrado';
  SOutlineExpandError = 'Antecessor deve ser expandido';
  SInvalidCurrentItem = 'Valor inv�lido para o �tem corrente';
  SMaskErr = 'Valor de entrada inv�lido';
  SMaskEditErr = 'Valor de entrada inv�lido. Use a tecla Esc para abandonar as altera��es';
  SOutlineError = '�ndice de contorno inv�lido';
  SOutlineBadLevel = 'N�vel de transfer�ncia incorreto';
  SOutlineSelection = 'Sele��o inv�lida';
  SOutlineFileLoad = 'Erro ao carregar arquivo';
  SOutlineLongLine = 'Linha muito longa';
  SOutlineMaxLevels = 'M�xima profundidade do contorno excedida';

  SMsgDlgWarning = 'Aviso';
  SMsgDlgError = 'Erro';
  SMsgDlgInformation = 'Informa��o';
  SMsgDlgConfirm = 'Confirma��o';
  SMsgDlgYes = '&Sim';
  SMsgDlgNo = '&N�o';
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = 'Cancela';
  SMsgDlgHelp = '&Ajuda';
  SMsgDlgHelpNone = 'Ajuda n�o dispon�vel';
  SMsgDlgHelpHelp = 'Ajuda';
  SMsgDlgAbort = '&Abortar';
  SMsgDlgRetry = '&Repetir';
  SMsgDlgIgnore = '&Ignorar';
  SMsgDlgAll = '&Todos';
  SMsgDlgNoToAll = 'N&�o para todos';
  SMsgDlgYesToAll = 'S&im para todos';

  SmkcBkSp = 'BkSp';
  SmkcTab = 'Tab';
  SmkcEsc = 'Esc';
  SmkcEnter = 'Enter';
  SmkcSpace = 'Space';
  SmkcPgUp = 'PgUp';
  SmkcPgDn = 'PgDn';
  SmkcEnd = 'End';
  SmkcHome = 'Home';
  SmkcLeft = 'Left';
  SmkcUp = 'Up';
  SmkcRight = 'Right';
  SmkcDown = 'Down';
  SmkcIns = 'Ins';
  SmkcDel = 'Del';
  SmkcShift = 'Shift+';
  SmkcCtrl = 'Ctrl+';
  SmkcAlt = 'Alt+';

  srUnknown = '(Ignorado)';
  srNone = '(Nenhum)';
  SOutOfRange = 'Valor deve estar entre %d e %d';

  SDateEncodeError = 'Arqumento inv�lido para decodificar data';
  SDefaultFilter = 'Todos os arquivos (*.*)|*.*';
  sAllFilter = 'Todos';
  SNoVolumeLabel = ': [ - sem r�tulo - ]';
  SInsertLineError = 'N�o � poss�vel inserir linhas';

  SConfirmCreateDir = 'O diret�rio especificado n�o existe. Cri�-lo?';
  SSelectDirCap = 'Selecione o diret�rio';
  SDirNameCap = 'Diret�rio &Nome:';
  SDrivesCap = 'D&rives:';
  SDirsCap = '&Diretorios:';
  SFilesCap = '&Arquivos: (*.*)';
  SNetworkCap = 'R&ede...';

  SColorPrefix = 'Cor';                 //!! obsolete - delete in 5.0
  SColorTags = 'ABCDEFGHIJKLMNOP';      //!! obsolete - delete in 5.0

  SInvalidClipFmt = 'Formato na �rea de transfer�ncia inv�lido';
  SIconToClipboard = '�rea de transfer�ncia n�o suporta �cones';
  SCannotOpenClipboard = 'N�o posso abrir a �rea de transfer�ncia';

  SDefault = 'Padr�o';

  SInvalidMemoSize = 'Texto excedeu a capacidade de 32K';
  SCustomColors = 'Personalizar Cores';
  SInvalidPrinterOp = 'Opera��o n�o suportada ao selecionar impressora';
  SNoDefaultPrinter = 'Esta impressora selecionada n�o � a default';

  SIniFileWriteError = 'Incapaz de gravar para %s';

  SBitsIndexError = '�ndice de Bits fora de faixa';

  SUntitled = '(Sem T�tulo)';

  SInvalidRegType = 'Tipo de dado inv�lido para ''%s''';

  SUnknownConversion = 'Incapaz de converter arquivo de exten��o (.%s) para RichEdit';
  SDuplicateMenus = 'Menu ''%s'' j� est� inicializado e usado por outro formul�rio';

  SPictureLabel = 'Imagem:';
  SPictureDesc = ' (%dx%d)';
  SPreviewLabel = 'Visualizar';

  SCannotOpenAVI = 'N�o � poss�vel abrir arquivo AVI';

  SNotOpenErr = 'Dispositivo MCI n�o aberto';
  SMPOpenFilter = 'Todos arquivos (*.*)|*.*|Arquivos wave (*.wav)|*.wav|Arquivos Midi (*.mid)|*.mid|V�deo para Windows (*.avi)|*.avi';
  SMCINil = '';
  SMCIAVIVideo = 'AVIV�deo';
  SMCICDAudio = 'CDAudio';
  SMCIDAT = 'DAT';
  SMCIDigitalVideo = 'V�deo Digital';
  SMCIMMMovie = 'MMMovie';
  SMCIOther = 'Outro';
  SMCIOverlay = 'Sobreposto';
  SMCIScanner = 'Scanner';
  SMCISequencer = 'Seq��ncia';
  SMCIVCR = 'VCR';
  SMCIVideodisc = 'V�deo disco';
  SMCIWaveAudio = '�udio Wave';
  SMCIUnknownError = 'C�digo de erro desconhecido';

  SBoldItalicFont = 'Negrito It�lico';
  SBoldFont = 'Negrito';
  SItalicFont = 'It�lico';
  SRegularFont = 'Normal';

  SPropertiesVerb = 'Propriedades';

  SServiceFailed = 'Falha de servi�o em %s: %s';
  SExecute = 'Executar';
  SStart = 'Iniciar';
  SStop = 'Parar';
  SPause = 'pausa';
  SContinue = 'continuar';
  SInterrogate = 'interrogar';
  SShutdown = 'Reiniciar';
  SCustomError = 'Falha de servi�o sob a mensagem (%d): %s';
  SServiceInstallOK = 'Servi�o instalado com sucesso';
  SServiceInstallFailed = 'Servi�o "%s" falho ou instalado com erro: "%s"';
  SServiceUninstallOK = 'Servi�o desinstalado com successo';
  SServiceUninstallFailed = 'Servi�o "%s" falho ou desinstalado com erro: "%s"';

  SInvalidActionRegistration = 'Registo de a��o inv�lido';
  SInvalidActionUnregistration = 'A��o inv�lida ao desregistrar';
  SInvalidActionEnumeration = 'A��o de enumera��o inv�lida';
  SInvalidActionCreation = 'A��o de cria��o inv�lida';
  
  SDockedCtlNeedsName = 'O controle acoplado deve ter um conhecido';
  SDockTreeRemoveError = 'Erro removendo controle da �rvore';
  SDockZoneNotFound = ' - Zona da doca n�o encontrada';
  SDockZoneHasNoCtl = ' - Zona da doca n�o tem controle';

  SAllCommands = 'Todos Comandos';

  SDuplicateItem = 'Lista n�o permite duplicados ($0%x)';

  STextNotFound = 'Texto n�o encontrado: "%s"';
  SBrowserExecError = 'Nenhum navegador padr�o � especificado';

  SColorBoxCustomCaption = 'Customizar...';

  SMultiSelectRequired = 'Mode multisele��o deve be on for this feature';

  SKeyCaption = 'Chave';
  SValueCaption = 'Valor';
  SKeyConflict = 'Uma chave com o nome de "%s" j� existe';
  SKeyNotFound = 'Chave "%s" n�o encontrada';
  SNoColumnMoving = 'goColMoving n�o � uma op��o suportada';
  SNoEqualsInKey = 'Chave n�o pode conter sinal igual a ("=")';

  SSendError = 'Erro enviando email';
  SAssignSubItemError = 'Cannot assign a subitem to an actionbar when one of it''s parent''s is already assigned to an actionbar';
  SDeleteItemWithSubItems = 'Item %s possue subitens, apagar mesmo assim?';
  SDeleteNotAllowed = 'Voc� n�o tem permiss�o de apagar este item';
  SMoveNotAllowed = 'Item %s n�o tem permiss�o de ser movido';    
  SMoreButtons = 'Mais Bot�es';
  SErrorDownloadingURL = 'Erro carregando URL: %s';
  SUrlMonDllMissing = 'Imposs�vel carregar %s';
  SAllActions = '(Todas as A��es)';
  SNoCategory = '(Sem Categoria)';
  SExpand = 'Expandir';
  SErrorSettingPath = 'Erro ajustando path: "%s"';
  SLBPutError = 'Attempting to put items into a virtual style listbox';
  SErrorLoadingFile = 'Erro carregando arquivo de ajustes salvos anteriormente: %s'#13'Voc� gostaria de apag�-lo?';
  SResetUsageData = 'Restaurar todos os dados usados?';
  SFileRunDialogTitle = 'Executar';
  SNoName = '(Sem Nome Name)';
  SErrorActionManagerNotAssigned = 'ActionManager deve primeiro ser atribu�do';
  SAddRemoveButtons = '&Adiciona ou Remove Bot�es';
  SResetActionToolBar = 'Restaurar Toolbar';
  SCustomize = '&Customizar';
  SSeparator = 'Separador';
  SCirularReferencesNotAllowed = 'Refer�ncias circulares n�o permitidas';
  SCannotHideActionBand = '%s n�o permite esconder';
  SErrorSettingCount = 'Erro ajustando %s.Count';
  SListBoxMustBeVirtual = 'Listbox (%s) stilo deve ser virtual na ordem para ajustar Count';
  SUnableToSaveSettings = 'Imposs�vel salvar ajustes';
  SRestoreDefaultSchedule = 'Voc� gostaria de restaurar para a Programa��o Priorit�ria padr�o?';
  SNoGetItemEventHandler = 'Nemhum manipulador de evento OnGetItem atribu�do';
  SInvalidColorMap = 'Invalid Colormap deste ActionBand requer ColorMaps do tipo TCustomActionBarColorMapEx';
  SDuplicateActionBarStyleName = 'Um estilo chamado %s j� foi registrado';
  SStandardStyleActionBars = 'Estilo Standard';
  SXPStyleActionBars = 'Estilo XP';
  SActionBarStyleMissing = 'Unit sem nenhum estilo ActionBand presente na cl�usula uses.'#13 +
    'Sua aplica��o deve incluir qualquer XPStyleActnCtrls, StdStyleActnCtrls ou ' +
    'um componente ActionBand de terceiros presente na cl�usula uses.';

implementation

end.
