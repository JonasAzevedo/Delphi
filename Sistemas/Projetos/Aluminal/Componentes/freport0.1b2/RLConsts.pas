{@unit RLConsts - Variáveis de internacionalização e variáveis de configuração. }
unit RLConsts;

interface

uses
  SysUtils;

const  
  CommercialVersion=0;
  ReleaseVersion   =6;

const
  {@const ScreenPPI - Resolução do monitor em pixels por polegada.
   Representa a quantidade de pixels por polegada do vídeo. O valor real varia de monitor para monitor mas,
   para facilitar cálculos e tornar os projetos independentes do terminal, essa valor é assumido como sendo 96. :/}
  ScreenPPI=96;

  {@const InchAsMM - Fator de conversão de polegada para milímetros.
   Este fator é utilizado em diversos pontos para conversões de coordenadas. :/}
  InchAsMM=254/10;

  {@const MMAsPixels - Fator de conversão de milímetros para pixels de tela.
   @links ScreenPPI, InchAsMM. :/}
  MMAsPixels=ScreenPPI/InchAsMM;

const
  CS_CopyrightStr   ='1999-2007 GPL';
  CS_ProductTitleStr='FortesReport';
  CS_URLStr         ='https://sourceforge.net/projects/freport';
  CS_AuthorNameStr  ='GPL Version';

var
  {@var LS_PrintingInProgressStr - Variável de internacionalização para "Imprimindo o relatório..." :/}
  LS_PrintingInProgressStr:string;
  {@var LS_FilterInProgressStr - Variável de internacionalização para "Salvando o relatório..." :/}
  LS_FilterInProgressStr  :string;
  {@var LS_PreparingReportStr - Variável de internacionalização para "Preparando o relatório..." :/}
  LS_PreparingReportStr   :string;
  {@var LS_PrinterNotFoundStr - Variável de internacionalização para "Nenhuma impressora encontrada" :/}
  LS_PrinterNotFoundStr   :string;
  {@var LS_NoPathToPrinterStr - Variável de internacionalização para "Caminho inválido para a impressora" :/}
  LS_NoPathToPrinterStr   :string;
  {@var LS_LoadDefaultConfigStr - Variável de internacionalização para "Será carregada a configuração padrão" :/}
  LS_LoadDefaultConfigStr :string;
  {@var LS_PrinterDriverErrorStr - Variável de internacionalização para "Erro no driver da impressora" :/}
  LS_PrinterDriverErrorStr:string;
  {@var LS_PageStr - Variável de internacionalização para "Página" :/}
  LS_PageStr              :string;
  {@var LS_PrepareErrorStr - Variável de internacionalização para "Erro durante a preparação do relatório" :/}
  LS_PrepareErrorStr      :string;
  {@var LS_PageBreakStr - Variável de internacionalização para "Continua..." :/}
  LS_PageBreakStr         :string;
  {@var LS_PageMendStr - Variável de internacionalização para "Continuação" :/}
  LS_PageMendStr          :string;
  {@var LS_ReportEndStr - Variável de internacionalização para "Fim" :/}
  LS_ReportEndStr         :string;
  {@var LS_FileNotFoundStr - Variável de internacionalização para "Arquivo não encontrado" :/}
  LS_FileNotFoundStr      :string;
  {@var LS_FileNameStr - Variável de internacionalização para "Nome do arquivo" :/}
  LS_FileNameStr          :string;
  {@var LS_AllFileTypesStr - Variável de internacionalização para "Todos os arquivos" :/}
  LS_AllFileTypesStr      :string;
  {@var LS_LoadReportStr - Variável de internacionalização para "Carregar relatório" :/}
  LS_LoadReportStr        :string;
  {@var LS_NotFoundStr - Variável de internacionalização para "Não encontrado" :/}
  LS_NotFoundStr          :string;
  {@var LS_WaitStr - Variável de internacionalização para "Aguarde..." :/}
  LS_WaitStr              :string;
  {@var LS_FinishedStr - Variável de internacionalização para "Concluído" :/}
  LS_FinishedStr          :string;
  {@var LS_CancelStr - Variável de internacionalização para "Cancelar" :/}
  LS_CancelStr            :string;
  {@var LS_CloseStr - Variável de internacionalização para "Fechar" :/}
  LS_CloseStr             :string;
  {@var LS_SaveStr - Variável de internacionalização para "Salvar" :/}
  LS_SaveStr              :string;
  {@var LS_SendStr - Variável de internacionalização para "Enviar" :/}
  LS_SendStr              :string;
  {@var LS_PrintStr - Variável de internacionalização para "Imprimir" :/}
  LS_PrintStr             :string;
  {@var LS_AboutTheStr - Variável de internacionalização para "Sobre o" :/}
  LS_AboutTheStr          :string;
  {@var LS_PreviewStr - Variável de internacionalização para "Pré-visualização" :/}
  LS_PreviewStr           :string;
  {@var LS_OfStr - Variável de internacionalização para "de" :/}
  LS_OfStr                :string;
  {@var LS_ZoomStr - Variável de internacionalização para "Zoom" :/}
  LS_ZoomStr              :string;
  {@var LS_FirstPageStr - Variável de internacionalização para "Primeira página" :/}
  LS_FirstPageStr         :string;
  {@var LS_PriorPageStr - Variável de internacionalização para "Página anterior" :/}
  LS_PriorPageStr         :string;
  {@var LS_NextPageStr - Variável de internacionalização para "Próxima página" :/}
  LS_NextPageStr          :string;
  {@var LS_LastPageStr - Variável de internacionalização para "Última página" :/}
  LS_LastPageStr          :string;
  {@var LS_EntirePageStr - Variável de internacionalização para "Página inteira" :/}
  LS_EntirePageStr        :string;
  {@var LS_EntireWidthStr - Variável de internacionalização para "Largura da página" :/}
  LS_EntireWidthStr       :string;
  {@var LS_MultiplePagesStr - Variável de internacionalização para "Várias páginas" :/}
  LS_MultiplePagesStr     :string;
  {@var LS_ConfigPrinterStr - Variável de internacionalização para "Configurar impressora" :/}
  LS_ConfigPrinterStr     :string;
  {@var LS_SaveToFileStr - Variável de internacionalização para "Salvar em disco" :/}
  LS_SaveToFileStr        :string;
  {@var LS_SendToStr - Variável de internacionalização para "Enviar para" :/}
  LS_SendToStr            :string;
  {@var LS_PrinterStr - Variável de internacionalização para "Impressora" :/}
  LS_PrinterStr           :string;
  {@var LS_NameStr - Variável de internacionalização para "Nome" :/}
  LS_NameStr              :string;
  {@var LS_PrintToFileStr - Variável de internacionalização para "Imprimir em arquivo" :/}
  LS_PrintToFileStr       :string;
  {@var LS_PrintInBackgroundStr - Variável de internacionalização para "Imprimir em segundo plano" :/}
  LS_PrintInBackgroundStr :string;
  {@var LS_SaveInBackground - Variável de internacionalização para "Salvar em segundo plano" :/}
  LS_SaveInBackground     :string;
  {@var LS_PageRangeStr - Variável de internacionalização para "Intervalo de páginas" :/}
  LS_PageRangeStr         :string;
  {@var LS_RangeFromStr - Variável de internacionalização para "de" :/}
  LS_RangeFromStr         :string;
  {@var LS_RangeToStr - Variável de internacionalização para "até" :/}
  LS_RangeToStr           :string;
  {@var LS_AllStr - Variável de internacionalização para "Tudo" :/}
  LS_AllStr               :string;
  {@var LS_PagesStr - Variável de internacionalização para "Páginas" :/}
  LS_PagesStr             :string;
  {@var LS_SelectionStr - Variável de internacionalização para "Seleção" :/}
  LS_SelectionStr         :string;
  {@var LS_CopiesStr - Variável de internacionalização para "Cópias" :/}
  LS_CopiesStr            :string;
  {@var LS_NumberOfCopiesStr - Variável de internacionalização para "Número de cópias" :/}
  LS_NumberOfCopiesStr    :string;
  {@var LS_OkStr - Variável de internacionalização para "Ok" :/}
  LS_OkStr                :string;
  {@var LS_DivideScreenStr - Variável de internacionalização para "Dividir a tela" :/}
  LS_DivideScreenStr      :string;
  {@var LS_InvalidNameStr - Variável de internacionalização para "Nome inválido" :/}
  LS_InvalidNameStr       :string;
  {@var LS_DuplicateNameStr - Variável de internacionalização para "Nome já utilizado" :/}
  LS_DuplicateNameStr     :string;
  {@var LS_UseFilterStr - Variável de internacionalização para "Usar Filtro" :/}
  LS_UseFilterStr         :string;
  {@var LS_WebPageStr - Variável de internacionalização para "Página da Web" :/}
  LS_WebPageStr           :string;
  {@var LS_RichFormatStr - Variável de internacionalização para "Formato RichText" :/}
  LS_RichFormatStr        :string;
  {@var LS_PDFFormatStr - Variável de internacionalização para "Documento PDF" :/}
  LS_PDFFormatStr         :string;
  {@var LS_XLSFormatStr - Variável de internacionalização para "Planilha Excel" :/}
  LS_XLSFormatStr         :string;
  {@var LS_AtStr - Variável de internacionalização para "em" :/}
  LS_AtStr                :string;
  {@var LS_FormStr - Variável de internacionalização para "Formulário" :/}
  LS_FormStr              :string;
  {@var LS_DefaultStr - Variável de internacionalização para "Padrão" :/}
  LS_DefaultStr           :string;
  {@var LS_ColsStr - Variável de internacionalização para "cols" :/}
  LS_ColsStr              :string;
  {@var LS_ZoomInStr - Variável de internacionalização para "Aumentar o zoom" :/}
  LS_ZoomInStr            :string;
  {@var LS_ZoomOutStr - Variável de internacionalização para "Diminuir o zoom" :/}
  LS_ZoomOutStr           :string;
  {@var LS_CopyStr - Variável de internacionalização para "Copiar" :/}
  LS_CopyStr              :string;
  {@var LS_EditStr - Variável de internacionalização para "Editar" :/}
  LS_EditStr              :string;
  {@var LS_FindCaptionStr - Variável de internacionalização para "Procurar" :/}
  LS_FindCaptionStr       :string;
  {@var LS_TextToFindStr - Variável de internacionalização para "Te&xto" :/}
  LS_TextToFindStr        :string;
  {@var LS_FindNextStr - &Variável de internacionalização para "Próxima" :/}
  LS_FindNextStr          :string;
  {@var LS_WholeWordsStr - Variável de internacionalização para "Palavras &inteiras" :/}
  LS_WholeWordsStr        :string;
  {@var LS_MatchCaseStr - Variável de internacionalização para "Diferenciar &maiúsculas de minúsculas" :/}
  LS_MatchCaseStr         :string;
  {@var LS_DirectionUpStr - Variável de internacionalização para "A&cima" :/}
  LS_DirectionUpStr       :string;
  {@var LS_DirectionDownStr - Variável de internacionalização para "A&baixo" :/}
  LS_DirectionDownStr     :string;
  {@var LS_DirectionCaptionStr - Variável de internacionalização para "Direção" :/}
  LS_DirectionCaptionStr  :string;

const
  RLFILEEXT='.rpf';

procedure DetectLocale;
procedure LoadPortugueseStrings;
procedure LoadEnglishStrings;
procedure LoadFrenchStrings;
procedure LoadSpanishStrings;

{/@unit}

implementation

procedure LoadPortugueseStrings;
begin
  LS_PrintingInProgressStr:='Imprimindo o relatório...';
  LS_FilterInProgressStr  :='Salvando o relatório...';
  LS_PreparingReportStr   :='Preparando o relatório...';
  LS_PrinterNotFoundStr   :='Nenhuma impressora encontrada';
  LS_NoPathToPrinterStr   :='Caminho inválido para a impressora';
  LS_LoadDefaultConfigStr :='Será carregada a configuração padrão';
  LS_PrinterDriverErrorStr:='Erro no driver da impressora';
  LS_PageStr              :='Página';
  LS_PrepareErrorStr      :='Erro durante a preparação do relatório';
  LS_PageBreakStr         :='Continua...';
  LS_PageMendStr          :='Continuação';
  LS_ReportEndStr         :='Fim';
  LS_FileNotFoundStr      :='Arquivo não encontrado';
  LS_FileNameStr          :='Nome do arquivo';
  LS_AllFileTypesStr      :='Todos os arquivos';
  LS_LoadReportStr        :='Carregar relatório';
  LS_NotFoundStr          :='Não encontrado';
  LS_WaitStr              :='Aguarde...';
  LS_FinishedStr          :='Concluído';
  LS_CancelStr            :='Cancelar';
  LS_CloseStr             :='Fechar';
  LS_SaveStr              :='Salvar';
  LS_SendStr              :='Enviar';
  LS_PrintStr             :='Imprimir';
  LS_AboutTheStr          :='Sobre o';
  LS_PreviewStr           :='Pré-visualização';
  LS_OfStr                :='de';
  LS_ZoomStr              :='Zoom';
  LS_FirstPageStr         :='Primeira página';
  LS_PriorPageStr         :='Página anterior';
  LS_NextPageStr          :='Próxima página';
  LS_LastPageStr          :='Última página';
  LS_EntirePageStr        :='Página inteira';
  LS_EntireWidthStr       :='Largura da página';
  LS_MultiplePagesStr     :='Várias páginas';    
  LS_ConfigPrinterStr     :='Configurar impressora';
  LS_SaveToFileStr        :='Salvar em disco';
  LS_SendToStr            :='Enviar para';
  LS_PrinterStr           :='Impressora';
  LS_NameStr              :='Nome';
  LS_PrintToFileStr       :='Imprimir em arquivo';
  LS_PrintInBackgroundStr :='Imprimir em segundo plano';
  LS_SaveInBackground     :='Salvar em segundo plano';
  LS_PageRangeStr         :='Intervalo de páginas';
  LS_RangeFromStr         :='de';
  LS_RangeToStr           :='até';
  LS_AllStr               :='Tudo';
  LS_PagesStr             :='Páginas';
  LS_SelectionStr         :='Seleção';
  LS_CopiesStr            :='Cópias';
  LS_NumberOfCopiesStr    :='Número de cópias';
  LS_OkStr                :='Ok';
  LS_DivideScreenStr      :='Dividir a tela';
  LS_InvalidNameStr       :='Nome inválido';
  LS_DuplicateNameStr     :='Nome já utilizado';
  LS_UseFilterStr         :='Usar Filtro';
  LS_WebPageStr           :='Página da Web';
  LS_RichFormatStr        :='Formato RichText';
  LS_PDFFormatStr         :='Documento PDF';
  LS_XLSFormatStr         :='Planilha Excel';
  LS_AtStr                :='em';
  LS_FormStr              :='Formulário';
  LS_DefaultStr           :='Padrão';
  LS_ColsStr              :='cols';
  LS_ZoomInStr            :='Aumentar o zoom';
  LS_ZoomOutStr           :='Diminuir o zoom';
  LS_CopyStr              :='Copiar';
  LS_EditStr              :='Editar';
  LS_FindCaptionStr       :='Procurar';
  LS_TextToFindStr        :='Te&xto';
  LS_FindNextStr          :='&Próxima';
  LS_WholeWordsStr        :='Palavras &inteiras';
  LS_MatchCaseStr         :='Diferenciar &maiúsculas de minúsculas';
  LS_DirectionUpStr       :='A&cima';
  LS_DirectionDownStr     :='A&baixo';
  LS_DirectionCaptionStr  :='Direção';
end;

procedure LoadEnglishStrings;
begin
  LS_PrintingInProgressStr:='Printing in progress...';
  LS_FilterInProgressStr  :='Saving report...';
  LS_PreparingReportStr   :='Preparing report...';
  LS_PrinterNotFoundStr   :='Printer not found';
  LS_NoPathToPrinterStr   :='Invalid printer path';
  LS_LoadDefaultConfigStr :='Load default configuration';
  LS_PrinterDriverErrorStr:='Printer driver error';
  LS_PageStr              :='Page';
  LS_PrepareErrorStr      :='Error while preparing report';
  LS_PageBreakStr         :='Continues...';
  LS_PageMendStr          :='Continuation';
  LS_ReportEndStr         :='End';
  LS_FileNotFoundStr      :='File not found';
  LS_FileNameStr          :='File Name';
  LS_AllFileTypesStr      :='All files';
  LS_LoadReportStr        :='Load report';
  LS_NotFoundStr          :='Not found';
  LS_WaitStr              :='Wait...';
  LS_FinishedStr          :='Finished';
  LS_CancelStr            :='Cancel';
  LS_CloseStr             :='Close';
  LS_SaveStr              :='Save';
  LS_SendStr              :='Send';
  LS_PrintStr             :='Print';
  LS_AboutTheStr          :='About';
  LS_PreviewStr           :='Preview';
  LS_OfStr                :='of';
  LS_ZoomStr              :='Zoom';
  LS_FirstPageStr         :='First page';
  LS_PriorPageStr         :='Prior page';
  LS_NextPageStr          :='Next page';
  LS_LastPageStr          :='Last page';
  LS_EntirePageStr        :='Entire page';
  LS_EntireWidthStr       :='Entire width';
  LS_MultiplePagesStr     :='Multiple pages';
  LS_ConfigPrinterStr     :='Configure printer';
  LS_SaveToFileStr        :='Save to file';
  LS_SendToStr            :='Send to';
  LS_PrinterStr           :='Printer';
  LS_NameStr              :='Name';
  LS_PrintToFileStr       :='Print to file';
  LS_PrintInBackgroundStr :='Print in background';
  LS_SaveInBackground     :='Save in background';
  LS_PageRangeStr         :='Page range';
  LS_RangeFromStr         :='from';
  LS_RangeToStr           :='to';
  LS_AllStr               :='All';
  LS_PagesStr             :='Pages';
  LS_SelectionStr         :='Selection';
  LS_CopiesStr            :='Copies';
  LS_NumberOfCopiesStr    :='Number of copies';
  LS_OkStr                :='Ok';
  LS_DivideScreenStr      :='Divide the screen';
  LS_InvalidNameStr       :='Invalid name';
  LS_DuplicateNameStr     :='Name already in use';
  LS_UseFilterStr         :='Use filter';
  LS_WebPageStr           :='Web page';
  LS_RichFormatStr        :='RichText Format';
  LS_PDFFormatStr         :='PDF Document';
  LS_XLSFormatStr         :='Excel spreadsheet';
  LS_AtStr                :='at';
  LS_FormStr              :='Form';
  LS_DefaultStr           :='Default';
  LS_ColsStr              :='cols';
  LS_ZoomInStr            :='Increase zoom';
  LS_ZoomOutStr           :='Decrease zoom';
  LS_CopyStr              :='Copy';
  LS_EditStr              :='Edit';
  LS_FindCaptionStr       :='Find';
  LS_TextToFindStr        :='Te&xt';
  LS_FindNextStr          :='Find &Next';
  LS_WholeWordsStr        :='&Whole words only';
  LS_MatchCaseStr         :='&Match Case';
  LS_DirectionUpStr       :='&Up';
  LS_DirectionDownStr     :='&Down';
  LS_DirectionCaptionStr  :='Direction';
end;

procedure LoadFrenchStrings;
begin
  LS_PrintingInProgressStr:='Impression du rapport...';
  LS_FilterInProgressStr  :='Sauver le rapport...';
  LS_PreparingReportStr   :='Préparation du rapport...';
  LS_PrinterNotFoundStr   :='Imprimante non trouvée';
  LS_NoPathToPrinterStr   :='Invalid printer path';
  LS_LoadDefaultConfigStr :='Chargement de la configuration standard';
  LS_PrinterDriverErrorStr:='Erreur dans le driver d''impression';
  LS_PageStr              :='Page';
  LS_PrepareErrorStr      :='Erreur durant la prépartaion du rapport';
  LS_PageBreakStr         :='Saut de page...';
  LS_PageMendStr          :='A suivre';
  LS_ReportEndStr         :='Fin';
  LS_FileNotFoundStr      :='Fichier non trouvé';
  LS_FileNameStr          :='Nom de Fichier';
  LS_AllFileTypesStr      :='Tous les fichiers';
  LS_LoadReportStr        :='Ouvrir rapport';
  LS_NotFoundStr          :='Non trouvé';
  LS_WaitStr              :='Patientez...';
  LS_FinishedStr          :='Fini';
  LS_CancelStr            :='Annulé';
  LS_CloseStr             :='Fermé';
  LS_SaveStr              :='Sauver';
  LS_SendStr              :='Envoyez';
  LS_PrintStr             :='Imprimer';
  LS_AboutTheStr          :='A propos de';
  LS_PreviewStr           :='Aperçu avant impression';
  LS_OfStr                :='de';
  LS_ZoomStr              :='Zoom';
  LS_FirstPageStr         :='Première page';
  LS_PriorPageStr         :='Page précédente';
  LS_NextPageStr          :='Page suivante';
  LS_LastPageStr          :='Dernière page';
  LS_EntirePageStr        :='Page entière';
  LS_EntireWidthStr       :='Pleine largeur';
  LS_MultiplePagesStr     :='Plusieurs pages';
  LS_ConfigPrinterStr     :='Configuration de l''imprimante';
  LS_SaveToFileStr        :='Enregistrer sous';
  LS_SendToStr            :='Envoyez à';
  LS_PrinterStr           :='Imprimante';
  LS_NameStr              :='Nom';
  LS_PrintToFileStr       :='Imprimer dans un fichier';
  LS_PrintInBackgroundStr :='Imprimer dans background';
  LS_SaveInBackground     :='Enregistrer dans background';
  LS_PageRangeStr         :='Intervalle de pages';
  LS_RangeFromStr         :='de';
  LS_RangeToStr           :='à';
  LS_AllStr               :='Tout';
  LS_PagesStr             :='Pages';
  LS_SelectionStr         :='Sélection';
  LS_CopiesStr            :='Copies';
  LS_NumberOfCopiesStr    :='Nombre de copies';
  LS_OkStr                :='Ok';
  LS_DivideScreenStr      :='Dividir a tela';
  LS_InvalidNameStr       :='Nom inadmissible';
  LS_DuplicateNameStr     :='Nom reproduit';
  LS_UseFilterStr         :='Use filter';
  LS_WebPageStr           :='Page de Web';
  LS_RichFormatStr        :='Formato RichText';
  LS_PDFFormatStr         :='Documento PDF';
  LS_XLSFormatStr         :='Excel tableur';
  LS_AtStr                :='à';
  LS_FormStr              :='Formulaire';
  LS_DefaultStr           :='Défaut';
  LS_ColsStr              :='cols';
  LS_ZoomInStr            :='Grandir zoom';
  LS_ZoomOutStr           :='Réduire zoom';
  LS_CopyStr              :='Copier';
  LS_EditStr              :='Edit';
  LS_FindCaptionStr       :='Trouvaille';
  LS_TextToFindStr        :='Te&xte';
  LS_FindNextStr          :='A&près';
  LS_WholeWordsStr        :='Mots &entiers seulement';
  LS_MatchCaseStr         :='Cas d''allu&mette';
  LS_DirectionUpStr       :='Le &Haut';
  LS_DirectionDownStr     :='Le &bas';
  LS_DirectionCaptionStr  :='Direction';
end;

procedure LoadSpanishStrings;
begin
  LS_PrintingInProgressStr:='Impresión en marcha...';
  LS_FilterInProgressStr  :='Guardando el informe...';
  LS_PreparingReportStr   :='Preparación del informe...';
  LS_PrinterNotFoundStr   :='Impresora no encontrada';
  LS_NoPathToPrinterStr   :='Caminho inválido para a impressora';
  LS_LoadDefaultConfigStr :='Cargar la configuración estándar';
  LS_PrinterDriverErrorStr:='Error en driver de la impresora';
  LS_PageStr              :='Página';
  LS_PrepareErrorStr      :='Un error ocurrió mientras se preparaba el informe';
  LS_PageBreakStr         :='Continúa...';
  LS_PageMendStr          :='Continuación';
  LS_ReportEndStr         :='Extremo';
  LS_FileNotFoundStr      :='Archivo no encontrado';
  LS_FileNameStr          :='Nombre del Archivo';
  LS_AllFileTypesStr      :='Todos los archivos';
  LS_LoadReportStr        :='Cargar el informe';
  LS_NotFoundStr          :='No encontrado';
  LS_WaitStr              :='Espera...';
  LS_FinishedStr          :='Finalizado';
  LS_CancelStr            :='Cancelar';
  LS_CloseStr             :='Cerrar';
  LS_SaveStr              :='Guardar';
  LS_SendStr              :='Enviar';
  LS_PrintStr             :='Imprimir';
  LS_AboutTheStr          :='Sobre';
  LS_PreviewStr           :='Ver';
  LS_OfStr                :='de';
  LS_ZoomStr              :='Zoom';
  LS_FirstPageStr         :='Primera página';
  LS_PriorPageStr         :='Página anterior';
  LS_NextPageStr          :='Página siguiente';
  LS_LastPageStr          :='Última página';
  LS_EntirePageStr        :='Página entera';
  LS_EntireWidthStr       :='Ancho completo';
  LS_MultiplePagesStr     :='Varias páginas';
  LS_ConfigPrinterStr     :='Configurar la impresora';
  LS_SaveToFileStr        :='Guardar en un archivo';
  LS_SendToStr            :='Envíar a';
  LS_PrinterStr           :='Impresora';
  LS_NameStr              :='Nombre';
  LS_PrintToFileStr       :='Imprimir a un archivo';
  LS_PrintInBackgroundStr :='Imprimir en background';
  LS_SaveInBackground     :='Guardar en background';
  LS_PageRangeStr         :='Intervalo de páginas';
  LS_RangeFromStr         :='de';
  LS_RangeToStr           :='a';
  LS_AllStr               :='Todas';
  LS_PagesStr             :='Páginas';
  LS_SelectionStr         :='Selección';
  LS_CopiesStr            :='Copias';
  LS_NumberOfCopiesStr    :='Número de copias';
  LS_OkStr                :='Ok';
  LS_DivideScreenStr      :='Dividir la pantalla';
  LS_InvalidNameStr       :='Nombre inválido';
  LS_DuplicateNameStr     :='Nombre ya en uso';
  LS_UseFilterStr         :='Usar Filtro';
  LS_WebPageStr           :='Página Web';
  LS_RichFormatStr        :='Formato RichText';
  LS_PDFFormatStr         :='Documento PDF';
  LS_XLSFormatStr         :='Planilha Excel';
  LS_AtStr                :='en';
  LS_FormStr              :='Formulario';
  LS_DefaultStr           :='Estándar';
  LS_ColsStr              :='cols';
  LS_ZoomInStr            :='Aumentar zoom';
  LS_ZoomOutStr           :='Disminuir zoom';
  LS_CopyStr              :='Copiar';
  LS_EditStr              :='Editar';
  LS_FindCaptionStr       :='Buscar';
  LS_TextToFindStr        :='Te&xto';
  LS_FindNextStr          :='&Siguiente';
  LS_WholeWordsStr        :='Palabras &completas sólamente';
  LS_MatchCaseStr         :='Diferenciar &mayúsculas y minúsculas';
  LS_DirectionUpStr       :='En&cima';
  LS_DirectionDownStr     :='&Abajo';
  LS_DirectionCaptionStr  :='Dirección';
end;

procedure DetectLocale;
{$ifdef LINUX}
var
  dlct:string;
{$endif}
begin
{$ifdef LINUX}
  dlct:=AnsiUpperCase(Copy(GetEnvironmentVariable('LANG'),1,2));
  if dlct='PT' then
    LoadPortugueseStrings
  else if dlct='EN' then
    LoadEnglishStrings
  else if dlct='ES' then
    LoadSpanishStrings
  else if dlct='FR' then
    LoadFrenchStrings
  else
    LoadEnglishStrings;
{$else}
  case SysLocale.PriLangID of
    $16 {LANG_PORTUGUESE}: LoadPortugueseStrings;
    $09 {LANG_ENGLISH}   : LoadEnglishStrings;
    $0a {LANG_SPANISH}   : LoadSpanishStrings;
    $0c {LANG_FRENCH}    : LoadFrenchStrings;
  else
    LoadEnglishStrings;
  end;
{$endif}
end;

initialization
  DetectLocale;

end.

