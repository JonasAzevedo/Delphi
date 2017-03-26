
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
  SCantWriteResourceStreamError = 'Não é possível gravar em um fluxo de recusos somente de leitura';
  SDuplicateReference = 'Objeto chamado duas vezes pela mesma instância';
  SClassMismatch = 'Arquivo de recursos %s é de classe incorreta';
  SInvalidTabIndex = 'Indexador de tabulação fora de faixa';
  SInvalidTabPosition = 'Posição da aba incompatível com Estilo da aba corrente';
  SInvalidTabStyle = 'Estilo da aba incompatível com a posição da aba corrente';
  SInvalidBitmap = 'Bitmap não é válido';
  SInvalidIcon = 'Ícone não é válido';
  SInvalidMetafile = 'Metafile não é válido';
  SInvalidPixelFormat = 'Formato de pixel inválido';
  SInvalidImage = 'Formato de fluxo inválido';
  SBitmapEmpty = 'Bitmap está vazio';
  SScanLine = 'Procura de indexador de linha fora de faixa';
  SChangeIconSize = 'Não é possível trocar o tamanho do ícone';
  SOleGraphic = 'Operação inválida em TOleGraphic';
  SUnknownExtension = 'Arquivo de imagem com extenção (.%s) ignorado';
  SUnknownClipboardFormat = 'Formato não suportado';
  SOutOfResources = 'Sistema sem recursos';
  SNoCanvasHandle = 'O canvas não esta permitindo desenhar';
  SInvalidImageSize = 'Tamanho de imagem inválido';
  STooManyImages = 'Muitas imagens';
  SDimsDoNotMatch = 'Dimensões da imagem diferente da lista de imagens';
  SInvalidImageList = 'ImageList inválido';
  SReplaceImage = 'Impossibilitado de trocar a imagem';
  SImageIndexError = 'Indexador do ImageList inválido';
  SImageReadFail = 'Falha ao ler os dados do ImageList para o fluxo';
  SImageWriteFail = 'Falha ao gravar dados no ImageList para o fluxo';
  SWindowDCError = 'Erro ao criar a janela de contexto do dispositivo';
  SClientNotSet = 'Cliente do TDrag não inicializado';
  SWindowClass = 'Erro criando a classe da janela';
  SWindowCreate = 'Erro criando a janela';
  SCannotFocus = 'Não é possível focar uma janela invisível ou não permitida';
  SParentRequired = 'Controle ''%s'' não tem antecessor na janela';
  SParentGivenNotAParent = 'Controle requerido não é um ancestral de ''%s''';
  SMDIChildNotVisible = 'Não é possível esconder um formulário filho MDI';
  SVisibleChanged = 'Não é possível trocar a propriedade Visible em OnShow ou OnHide';
  SCannotShowModal = 'Não é possível marcar uma janela visível como modal';
  SScrollBarRange = 'Propriedade Scrollbar fora de faixa';
  SPropertyOutOfRange = 'Propriedade %s fora de faixa';
  SMenuIndexError = 'Índice de menu fora de faixa';
  SMenuReinserted = 'Menu inserido duas vezes';
  SMenuNotFound = 'Sub-menu não está em um menu';
  SNoTimers = 'Não há timers suficientes';
  SNotPrinting = 'Impressora não está imprimindo agora';
  SPrinting = 'Impressão em progresso';
  SPrinterIndexError = 'Indice da impressora fora de faixa';
  SInvalidPrinter = 'Impressora selecionada não é válida';
  SDeviceOnPort = '%s em %s';
  SGroupIndexTooLow = 'GroupIndex não pode ser menor que o ítem de menu anterior ao GroupIndex';
  STwoMDIForms = 'Não é possível ter mais que um formulário MDI por aplicação';
  SNoMDIForm = 'Não é possível criar formulário. Não há formulários MDI ativos neste momento';
  SImageCanvasNeedsBitmap = 'Não é possível modificar um TImage que contém um bitmap';
  SControlParentSetToSelf = 'Um controle não pode ter ele mesmo como seu antecessor';
  SOKButton = 'OK';
  SCancelButton = 'Cancelar';
  SYesButton = '&Sim';
  SNoButton = '&Não';
  SHelpButton = '&Ajuda';
  SCloseButton = '&Fechar';
  SIgnoreButton = '&Ignorar';
  SRetryButton = '&Repetir';
  SAbortButton = 'Abortar';
  SAllButton = '&Todos';

  SCannotDragForm = 'Não é possível arrastar um formulário';
  SPutObjectError = 'PutObject não definido para ítem';
  SCardDLLNotLoaded = 'Não posso carregar CARDS.DLL';
  SDuplicateCardId = 'Encontrado uma duplicata de CardId';

  SDdeErr = 'Um erro retornado pelo DDE ($0%x)';
  SDdeConvErr = 'Erro no DDE - conversação não estabelecida ($0%x)';
  SDdeMemErr = 'Erro ocorrido quando DDE rodou sem memória ($0%x)';
  SDdeNoConnect = 'Incapaz de conectar conversação DDE';

  SFB = 'FB';
  SFG = 'FG';
  SBG = 'BG';
  SOldTShape = 'Não posso carregar uma versão antiga de TShape';
  SVMetafiles = 'Metafiles';
  SVEnhMetafiles = 'Metafiles realçado';
  SVIcons = 'Ícone';
  SVBitmaps = 'Bitmaps';
  SGridTooLarge = 'Grid muito larga para esta operação';
  STooManyDeleted = 'Muitas linhas ou colunas deletadas';
  SIndexOutOfRange = 'Índice do grid fora de faixa';
  SFixedColTooBig = 'Contador de colunas fixas deve ser menor ou igual que o número de colunas';
  SFixedRowTooBig = 'Contador de linhas fixas deve ser menor ou igual ao número de linhas';
  SInvalidStringGridOp = 'Não é possível inserir ou deletar linhas da grade';
  SInvalidEnumValue = 'Valor Enum inválido';
  SInvalidNumber = 'Valor numérico inválido';
  SOutlineIndexError = 'Índice de contorno não encontrado';
  SOutlineExpandError = 'Antecessor deve ser expandido';
  SInvalidCurrentItem = 'Valor inválido para o ítem corrente';
  SMaskErr = 'Valor de entrada inválido';
  SMaskEditErr = 'Valor de entrada inválido. Use a tecla Esc para abandonar as alterações';
  SOutlineError = 'Índice de contorno inválido';
  SOutlineBadLevel = 'Nível de transferência incorreto';
  SOutlineSelection = 'Seleção inválida';
  SOutlineFileLoad = 'Erro ao carregar arquivo';
  SOutlineLongLine = 'Linha muito longa';
  SOutlineMaxLevels = 'Máxima profundidade do contorno excedida';

  SMsgDlgWarning = 'Aviso';
  SMsgDlgError = 'Erro';
  SMsgDlgInformation = 'Informação';
  SMsgDlgConfirm = 'Confirmação';
  SMsgDlgYes = '&Sim';
  SMsgDlgNo = '&Não';
  SMsgDlgOK = 'OK';
  SMsgDlgCancel = 'Cancela';
  SMsgDlgHelp = '&Ajuda';
  SMsgDlgHelpNone = 'Ajuda não disponível';
  SMsgDlgHelpHelp = 'Ajuda';
  SMsgDlgAbort = '&Abortar';
  SMsgDlgRetry = '&Repetir';
  SMsgDlgIgnore = '&Ignorar';
  SMsgDlgAll = '&Todos';
  SMsgDlgNoToAll = 'N&ão para todos';
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

  SDateEncodeError = 'Arqumento inválido para decodificar data';
  SDefaultFilter = 'Todos os arquivos (*.*)|*.*';
  sAllFilter = 'Todos';
  SNoVolumeLabel = ': [ - sem rótulo - ]';
  SInsertLineError = 'Não é possível inserir linhas';

  SConfirmCreateDir = 'O diretório especificado não existe. Criá-lo?';
  SSelectDirCap = 'Selecione o diretório';
  SDirNameCap = 'Diretório &Nome:';
  SDrivesCap = 'D&rives:';
  SDirsCap = '&Diretorios:';
  SFilesCap = '&Arquivos: (*.*)';
  SNetworkCap = 'R&ede...';

  SColorPrefix = 'Cor';                 //!! obsolete - delete in 5.0
  SColorTags = 'ABCDEFGHIJKLMNOP';      //!! obsolete - delete in 5.0

  SInvalidClipFmt = 'Formato na área de transferência inválido';
  SIconToClipboard = 'Área de transferência não suporta ícones';
  SCannotOpenClipboard = 'Não posso abrir a área de transferência';

  SDefault = 'Padrão';

  SInvalidMemoSize = 'Texto excedeu a capacidade de 32K';
  SCustomColors = 'Personalizar Cores';
  SInvalidPrinterOp = 'Operação não suportada ao selecionar impressora';
  SNoDefaultPrinter = 'Esta impressora selecionada não é a default';

  SIniFileWriteError = 'Incapaz de gravar para %s';

  SBitsIndexError = 'Índice de Bits fora de faixa';

  SUntitled = '(Sem Título)';

  SInvalidRegType = 'Tipo de dado inválido para ''%s''';

  SUnknownConversion = 'Incapaz de converter arquivo de extenção (.%s) para RichEdit';
  SDuplicateMenus = 'Menu ''%s'' já está inicializado e usado por outro formulário';

  SPictureLabel = 'Imagem:';
  SPictureDesc = ' (%dx%d)';
  SPreviewLabel = 'Visualizar';

  SCannotOpenAVI = 'Não é possível abrir arquivo AVI';

  SNotOpenErr = 'Dispositivo MCI não aberto';
  SMPOpenFilter = 'Todos arquivos (*.*)|*.*|Arquivos wave (*.wav)|*.wav|Arquivos Midi (*.mid)|*.mid|Vídeo para Windows (*.avi)|*.avi';
  SMCINil = '';
  SMCIAVIVideo = 'AVIVídeo';
  SMCICDAudio = 'CDAudio';
  SMCIDAT = 'DAT';
  SMCIDigitalVideo = 'Vídeo Digital';
  SMCIMMMovie = 'MMMovie';
  SMCIOther = 'Outro';
  SMCIOverlay = 'Sobreposto';
  SMCIScanner = 'Scanner';
  SMCISequencer = 'Seqüência';
  SMCIVCR = 'VCR';
  SMCIVideodisc = 'Vídeo disco';
  SMCIWaveAudio = 'Áudio Wave';
  SMCIUnknownError = 'Código de erro desconhecido';

  SBoldItalicFont = 'Negrito Itálico';
  SBoldFont = 'Negrito';
  SItalicFont = 'Itálico';
  SRegularFont = 'Normal';

  SPropertiesVerb = 'Propriedades';

  SServiceFailed = 'Falha de serviço em %s: %s';
  SExecute = 'Executar';
  SStart = 'Iniciar';
  SStop = 'Parar';
  SPause = 'pausa';
  SContinue = 'continuar';
  SInterrogate = 'interrogar';
  SShutdown = 'Reiniciar';
  SCustomError = 'Falha de serviço sob a mensagem (%d): %s';
  SServiceInstallOK = 'Serviço instalado com sucesso';
  SServiceInstallFailed = 'Serviço "%s" falho ou instalado com erro: "%s"';
  SServiceUninstallOK = 'Serviço desinstalado com successo';
  SServiceUninstallFailed = 'Serviço "%s" falho ou desinstalado com erro: "%s"';

  SInvalidActionRegistration = 'Registo de ação inválido';
  SInvalidActionUnregistration = 'Ação inválida ao desregistrar';
  SInvalidActionEnumeration = 'Ação de enumeração inválida';
  SInvalidActionCreation = 'Ação de criação inválida';
  
  SDockedCtlNeedsName = 'O controle acoplado deve ter um conhecido';
  SDockTreeRemoveError = 'Erro removendo controle da árvore';
  SDockZoneNotFound = ' - Zona da doca não encontrada';
  SDockZoneHasNoCtl = ' - Zona da doca não tem controle';

  SAllCommands = 'Todos Comandos';

  SDuplicateItem = 'Lista não permite duplicados ($0%x)';

  STextNotFound = 'Texto não encontrado: "%s"';
  SBrowserExecError = 'Nenhum navegador padrão é especificado';

  SColorBoxCustomCaption = 'Customizar...';

  SMultiSelectRequired = 'Mode multiseleção deve be on for this feature';

  SKeyCaption = 'Chave';
  SValueCaption = 'Valor';
  SKeyConflict = 'Uma chave com o nome de "%s" já existe';
  SKeyNotFound = 'Chave "%s" não encontrada';
  SNoColumnMoving = 'goColMoving não é uma opção suportada';
  SNoEqualsInKey = 'Chave não pode conter sinal igual a ("=")';

  SSendError = 'Erro enviando email';
  SAssignSubItemError = 'Cannot assign a subitem to an actionbar when one of it''s parent''s is already assigned to an actionbar';
  SDeleteItemWithSubItems = 'Item %s possue subitens, apagar mesmo assim?';
  SDeleteNotAllowed = 'Você não tem permissão de apagar este item';
  SMoveNotAllowed = 'Item %s não tem permissão de ser movido';    
  SMoreButtons = 'Mais Botões';
  SErrorDownloadingURL = 'Erro carregando URL: %s';
  SUrlMonDllMissing = 'Impossível carregar %s';
  SAllActions = '(Todas as Ações)';
  SNoCategory = '(Sem Categoria)';
  SExpand = 'Expandir';
  SErrorSettingPath = 'Erro ajustando path: "%s"';
  SLBPutError = 'Attempting to put items into a virtual style listbox';
  SErrorLoadingFile = 'Erro carregando arquivo de ajustes salvos anteriormente: %s'#13'Você gostaria de apagá-lo?';
  SResetUsageData = 'Restaurar todos os dados usados?';
  SFileRunDialogTitle = 'Executar';
  SNoName = '(Sem Nome Name)';
  SErrorActionManagerNotAssigned = 'ActionManager deve primeiro ser atribuído';
  SAddRemoveButtons = '&Adiciona ou Remove Botões';
  SResetActionToolBar = 'Restaurar Toolbar';
  SCustomize = '&Customizar';
  SSeparator = 'Separador';
  SCirularReferencesNotAllowed = 'Referências circulares não permitidas';
  SCannotHideActionBand = '%s não permite esconder';
  SErrorSettingCount = 'Erro ajustando %s.Count';
  SListBoxMustBeVirtual = 'Listbox (%s) stilo deve ser virtual na ordem para ajustar Count';
  SUnableToSaveSettings = 'Impossível salvar ajustes';
  SRestoreDefaultSchedule = 'Você gostaria de restaurar para a Programação Prioritária padrão?';
  SNoGetItemEventHandler = 'Nemhum manipulador de evento OnGetItem atribuído';
  SInvalidColorMap = 'Invalid Colormap deste ActionBand requer ColorMaps do tipo TCustomActionBarColorMapEx';
  SDuplicateActionBarStyleName = 'Um estilo chamado %s já foi registrado';
  SStandardStyleActionBars = 'Estilo Standard';
  SXPStyleActionBars = 'Estilo XP';
  SActionBarStyleMissing = 'Unit sem nenhum estilo ActionBand presente na cláusula uses.'#13 +
    'Sua aplicação deve incluir qualquer XPStyleActnCtrls, StdStyleActnCtrls ou ' +
    'um componente ActionBand de terceiros presente na cláusula uses.';

implementation

end.
