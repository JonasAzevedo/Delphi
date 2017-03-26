      *-----------------------------------------------------------------
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    ECFACBR.
       AUTHOR.	      BALTAZAR-AGUIA.
       DATE-WRITTEN.  09.05.2007.
       SECURITY.      *************************************************
                      *  ECF - Emissor de Cupom Fiscal - Varios       *
                      *        -  Software ACBrMonitor  -             *
                      *************************************************
      *-----------------------------------------------------------------
      *
      * Informativo:
      *	     Este programa utiliza o Software ACBrMonitor, integrante
      *	     do Projeto ACBr, do colega Daniel Simões e Comunidade.
      *
      * Procedimentos:
      *	     - Instalar o ACBrMoniotr no Micro
      *	     - Configuracao
      *	       - Orelha -> Monitor
      *		 - Marcar Arquivo TXT
      *		   Entrada: C:\TEMP\ENT.TXT
      *		   Saida  : C:\TEMP\SAI.TXT
      *		 - Intervalo: 015
      *	       - Orelha -> ECF
      *		 - Modelo  : EcfSweda
      *		 - Porta   : COM1
      *		 - Time Out: 3
      *	     - O programa ACBrMonitor trabalhara com 2 arquivos:
      *	       - ENT.TXT - Este arquivo e utilizado para enviar
      *			   os comandos para a Impressora
      *	       - SAI.TXT - Este arquivo e utilizado para receber
      *			   os retornos da impressora
      *	     - Campos numericos, usar ponto (.) para separar casas
      *	       decimais (nao separar casas de milhar)
      *	     - Campos de Descontos TEM QUE vir com um Hifen (-)
      *	       antes do Valor
      *
      * 02.09.2006 - W-WORKAR (09:01) = 0-Emitir Cupom Fiscal
      *					1-Cancelar Cupom Anterior
      *					2-Leitura X
      *					3-Fechamento Z
      *					4-Emissao Cheques
      *
      * Nota geral: 1 - Foi testado no WinXP com ECF Sweda IF 9000-III.
      *		    2 - Win98 ainda em testes.
      *		    3 - ...
      *
      *
      * Obs. geral: O autor deste programa, bem como, sua SoftHouse, não
      *		    se responsabiliza pela a execução dos comandos e as
      *		    rotinas aqui implementadas.
      *
      * Convenção: Fica aqui conveniado que, todo aquele programador que
      *		   elaborar outro programa ou implementar melhoras neste
      *		   aqui, disponibilizar para o colega Sergio Rodrigues
      *		   (progus@terra.com.br), afim de, criar um pacote de
      *		   programas exemplos (modelos), compartilhando assim
      *		   entre a comunidade CobolACBr.
      *
      *-----------------------------------------------------------------
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL. SELECT CADNFS ASSIGN TO DISK
                            ORGANIZATION  IS INDEXED
                            ACCESS MODE   IS DYNAMIC
                            RECORD  KEY   IS KEYNFS
                            ALTERNATE RECORD KEY IS KEYNFS1 =
                                                    NFSDTM
                                                    NFSNNF
                                      WITH DUPLICATES
                            ALTERNATE RECORD KEY IS KEYNFS2 =
                                                    NFSCLI
                                                    NFSDTM
                                                    NFSNNF
                                      WITH DUPLICATES
                            LOCK MODE     IS AUTOMATIC
                            WITH LOCK     ON RECORD
                            FILE STATUS   IS ERRO.
                     SELECT CADNSI ASSIGN TO DISK
                            ORGANIZATION  IS INDEXED
                            ACCESS MODE   IS DYNAMIC
                            RECORD  KEY   IS KEYNSI
                            ALTERNATE RECORD KEY IS KEYNSI1 =
                                                    NSICLI
                                                    NSIDTM
                                                    NSINNF
                                                    NSISEQ
                                      WITH DUPLICATES
                            ALTERNATE RECORD KEY IS KEYNSI2 =
                                                    NSIPRO
                                                    NSIDTM
                                                    NSINNF
                                                    NSISEQ
                                      WITH DUPLICATES
                            LOCK MODE     IS AUTOMATIC
                            WITH LOCK     ON RECORD
                            FILE STATUS   IS ERRO.
                     SELECT CADMOV ASSIGN TO DISK
                            ORGANIZATION  IS INDEXED
                            ACCESS MODE   IS DYNAMIC
                            RECORD  KEY   IS KEYMOV
                            ALTERNATE RECORD KEY IS KEYMOV1 =
                                                    MOVDTM
                                                    MOVCUP
                                      WITH DUPLICATES
                            LOCK MODE     IS AUTOMATIC
                            WITH LOCK     ON RECORD
                            FILE STATUS   IS ERRO.
                     SELECT CADBCO ASSIGN TO DISK
                            ORGANIZATION  IS INDEXED
                            ACCESS MODE   IS DYNAMIC
                            RECORD  KEY   IS KEYBCO
                            ALTERNATE RECORD KEY IS KEYBCO1 =
                                                    BCOCOG
                                                    BCOCOD
                                                    BCOAGE
                                      WITH DUPLICATES
                            LOCK MODE     IS AUTOMATIC
                            FILE STATUS   IS ERRO.
                     SELECT CADEMP ASSIGN TO DISK
                            ORGANIZATION  IS INDEXED
                            ACCESS MODE   IS DYNAMIC
                            RECORD  KEY   IS KEYEMP
                            LOCK MODE     IS AUTOMATIC
                            FILE STATUS   IS ERRO.
                     SELECT CADCEP ASSIGN TO DISK
                            ORGANIZATION  IS INDEXED
                            ACCESS MODE   IS RANDOM
                            RECORD  KEY   IS KEYCEP
                            ALTERNATE RECORD KEY IS KEYCEP1 =
                                                    CEPMUN
                                                    CEPCOD
                                      WITH DUPLICATES
                            LOCK MODE     IS AUTOMATIC
                            FILE STATUS   IS ERRO.
                     SELECT CADENT ASSIGN TO DISK
                            ORGANIZATION  IS LINE SEQUENTIAL
                            ACCESS MODE   IS SEQUENTIAL
                            FILE STATUS   IS ERRO.
                     SELECT CADSAI ASSIGN TO DISK
                            ORGANIZATION  IS LINE SEQUENTIAL
                            ACCESS MODE   IS SEQUENTIAL
                            FILE STATUS   IS ERRO.

       DATA DIVISION.
       FILE SECTION.

       COPY FDNFS.BOK.
       COPY FDNSI.BOK.
       COPY FDMOV.BOK.
       COPY FDBCO.BOK.
       COPY FDEMP.BOK.
       COPY FDCEP.BOK.

       FD            CADENT 
                     VALUE OF FILE-ID IS W-FDENT.
       01            REGENT            PIC X(128).

       FD            CADSAI 
                     VALUE OF FILE-ID IS W-FDSAI.
       01            REGSAI.
                     02 W-RETOR        PIC X(04).
                     02 W-RET          PIC X(124).
                     02 W-RETX         REDEFINES  W-RET.
                        03 W-RE        OCCURS 124 TIMES
                                       PIC X(01).

       WORKING-STORAGE SECTION.
       77            W-FDNFS           PIC X(50) VALUE SPACES.
       77            W-FDNSI           PIC X(50) VALUE SPACES.
       77            W-FDAGU           PIC X(50) VALUE SPACES.
       77            W-FDMOV           PIC X(50) VALUE SPACES.
       77            W-FDBCO           PIC X(50) VALUE SPACES.
       77            W-FDEMP           PIC X(50) VALUE SPACES.
       77            W-FDCEP           PIC X(50) VALUE SPACES.
       77            W-FDENT           PIC X(50) VALUE SPACES.
       77            W-FDSAI           PIC X(50) VALUE SPACES.
       77            W-VOLTA           PIC X(50) VALUE SPACES.
       77            W-DRA             PIC X(01) VALUE " ".
       77            W-DRP             PIC X(01) VALUE " ".
       77            W-DIR             PIC X(08).
       77            W-TEL             PIC 9(01) VALUE 0.
       77            W-STG             PIC 9(01) VALUE 0.
       77            W-TEC             PIC 9(02). 
       77            W-SEN             PIC 9(06).
       77            W-TPS             PIC 9(01).
       77            ERRA              PIC 9(01).                   

       01            MODULOS. 
                     02 W-TEL1         PIC X(10).
                     02 W-TEL2         PIC X(40).
                     02 W-TEL3         PIC X(17).
                     02 W-TEL4         PIC 9(02).

       01            W-FDMOVER.
                     02 DRISEQ         PIC X(49).

      *01            ERRO              PIC X(02).
       01            TRACO             PIC X(80) VALUE ALL "-".
       01            BCO               PIC X(59) VALUE ALL " ".

       01            TRABALHO.
                     02 REGISTROS      PIC 9(02) VALUE 0.
                     02 VEZ            PIC 9(01) VALUE 1.
                     02 W-STS          PIC 9(01).
                     02 Z-DTAHOR.
                        03 Z-DD        PIC 9(02).
                        03 FILLER      PIC X(01) VALUE "/".
                        03 Z-MM        PIC 9(02).
                        03 FILLER      PIC X(01) VALUE "/".
                        03 Z-AA        PIC 9(02).
                        03 FILLER      PIC X(01) VALUE " ".
                        03 Z-HH        PIC 9(02).
                        03 FILLER      PIC X(01) VALUE "/".
                        03 Z-MI        PIC 9(02).
                     02 W-QTD          PIC 9(04).
                     02 W-VLR          PIC 9(08)V99.
                     02 W-VLRX         REDEFINES  W-VLR.
                        03 W-VR1       PIC 9(08).
                        03 W-VR2       PIC 9(02).
                     02 W-ECF          PIC 9(06).
                     02 W-DTM          PIC 9(08).
                     02 W-DTMX         REDEFINES W-DTM.
                        03 W-DD        PIC 9(02).
                        03 W-MM        PIC 9(02).
                        03 W-AA        PIC 9(04).
                     02 W-ALI          PIC X(03).
                     02 I              PIC 9(03).
                     02 W-REGENT       PIC X(50).

      *              02 COD-STATUS     PIC 9(02) COMP-X.
      *              02 W-VEL          PIC X(15).
      *              02 W-NOV          PIC X(15).

       01            DTACPU.
                     02 CAN            PIC 9(02).
                     02 CME            PIC 9(02).
                     02 CDI            PIC 9(02).

       01            HRSCPU.
                     02 HHMMSS.
                        03 CHR         PIC 9(02).
                        03 CMI         PIC 9(02).
                        03 CSE         PIC 9(02).
                     02 FILLLER        PIC X(02).

       01            SYMEMP.
                     02 EMP1           PIC 9(04).

       01            SYMCEP.
                     02 CEP1           PIC 9(08).

       01            SYMNFS.
                     02 NFS1           PIC 9(08).

       01            SYMNSI.
                     02 NSI1           PIC 9(08).
                     02 NSI2           PIC 9(03).

       01            SYMMOV.
                     02 MOV1           PIC 9(08).

       01            SYMBCO.
                     02 BCO1           PIC 9(05).
                     02 BCO2           PIC 9(05).

       01            AUXILIARES.
                     03 ERRO                    PIC X(02).
                     03 FILLER REDEFINES ERRO.
                        05  WSTA-1              PIC X(01).
                        05  WSTA-2              PIC X(01).
                     03 WSTA-R REDEFINES ERRO   PIC 9(04) COMP.
                     03 WST2B                   PIC 9(03).
                     03 WSTA-AUX                PIC X(02).

       01            REG-TELA.
                     02 T-CUP          PIC 9(08).
                     02 T-VLR          PIC 9(06)V99.
                     02 T-VLRX         PIC ZZZ.ZZ9,99.
      *
      * -----------  Linhas de Comandos 
      *
                     02 T-VENDE-ITEM.
                        03 FILLER      PIC X(13) VALUE
                                                 "ECF.VendeItem".
                        03 FILLER      PIC X(01) VALUE "(".
                        03 T-PRO       PIC 9(13).                       NSIPRO
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-NOM       PIC X(24).                       NSIDES
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-ICM       PIC X(03).                       Cod = T00 ... T15
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-QTD       PIC X(08).                       NSIQTD              
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-PRU       PIC X(11).                       NSIPRU
                        03 FILLER      PIC X(01) VALUE ")".

                     02 T-SUB-TOTALIZA-CUPOM.
                        03 FILLER      PIC X(20) VALUE
                                                 "ECF.SubTotalizaCupom".
                        03 FILLER      PIC X(01) VALUE "(".
                        03 T-VRD       PIC X(11).                       MOVDES
                        03 FILLER      PIC X(01) VALUE ")".

                     02 T-EFETUA-PAGAMENTO.
                        03 FILLER      PIC X(19) VALUE
                                                 "ECF.EfetuaPagamento".
                        03 FILLER      PIC X(01) VALUE "(".
                        03 T-FPG       PIC 9(02).
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-VRT       PIC X(11).    
                        03 FILLER      PIC X(01) VALUE ")".

                     02 T-IMPRIME-CHEQUE.
                        03 FILLER      PIC X(17) VALUE
                                                 "ECF.ImprimeCheque".
                        03 FILLER      PIC X(01) VALUE "(".
                        03 T-BNU       PIC 9(03).
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-VCH       PIC X(11).    
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-FAV       PIC X(40).
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-MUN       PIC X(25).
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-DTA       PIC X(14).
                        03 FILLER      PIC X(01) VALUE ",".
                        03 T-OBS       PIC X(25).
                        03 FILLER      PIC X(01) VALUE ")".

                     02 T-OP1          PIC 9(01).
                     02 T-OP2          PIC 9(01).
                     02 T-OP           PIC X(01).
                     02 T-MEN          PIC X(70).

       COPY CPMENS.                                                     Mensagens Aguia

       COPY CPSEND.

       COPY CPBOXF.

       LINKAGE SECTION.

       01            W-WORKAR          PIC  X(050).

       SCREEN SECTION.
       01            WS-TELA.
                     02 LINE 05 COLUMN 01 VALUE
                                "Op‡Æo: [ ] S-ECF Ligado".
                     02 LINE 06 COLUMN 01 VALUE
                                "           N-ECF Desligado".

       01            WS-TELA1.
                     02 BLANK SCREEN.

       01            WS-TELA2.
                     02 LINE 05 COLUMN 25 VALUE
                        "ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 06 COLUMN 25 VALUE
                        "º     FORMA DE PAGAMENTO        º"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 07 COLUMN 25 VALUE
                        "º                               º"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 08 COLUMN 25 VALUE
                        "º    Opcao: [ ] 1-Dinheiro      º"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 09 COLUMN 25 VALUE
                        "º               2-Cheque        º"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 10 COLUMN 25 VALUE
                        "º               3-Cartao        º"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 11 COLUMN 25 VALUE
                        "º               4-Duplicata     º"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 12 COLUMN 25 VALUE
                        "º               5-Boleto        º"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 13 COLUMN 25 VALUE
                        "º                               º"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 14 COLUMN 25 VALUE
                        "º    Cupom: [        ]          º"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.
                     02 LINE 15 COLUMN 25 VALUE
                        "ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼"
                                                 BACKGROUND-COLOR 04
                                                 FOREGROUND-COLOR 15.

       PROCEDURE DIVISION USING W-WORKAR.

       000 SECTION.
      *
      * -----------  ROTINA PRINCIPAL   --------------------------------
      *
       005.          PERFORM 100.

                     GO TO   200.

       010.          CLOSE CADEMP  CADNFS  CADNSI  CADMOV  CADBCO
                           CADCEP  CADENT  CADSAI.
       
                     GOBACK.
      *
      *              EXIT PROGRAM.
      *
      * -----------  ABERTURA DOS ARQUIVOS   ---------------------------
      *
       100.          MOVE "\ADL000\CADEMP.ADL" TO DRISEQ.
                     MOVE W-FDMOVER            TO W-FDEMP.

                     OPEN INPUT  CADEMP.
                          IF ERRO NOT = "00"
                             MOVE "CADEMP -" TO W-ARQ
                             MOVE "Erro n§ " TO W-ERF
                             MOVE ERRO       TO W-ERC
                             MOVE 01         TO W-ERRO
                             MOVE 1          TO W-NMS
                             PERFORM 865
                             EXIT PROGRAM.

                     MOVE 0001   TO EMP1.
                     MOVE SYMEMP TO KEYEMP.
                     READ CADEMP INVALID KEY 
                          DISPLAY (22, 11) "EMPRESA 0001 N CADASTR"
                          STOP RUN.

                     MOVE EMPDIR  TO  W-DIR.

                     CLOSE CADEMP.
      *
      * -----------  Abre CADEMP do Terminal / Diretorio indicado no W-DIR
      *
                     MOVE "C:"         TO DRISEQ(1:2)
                     MOVE W-DIR        TO DRISEQ(3:8)
                     MOVE "CADEMP.ADL" TO DRISEQ(11:10).
                     MOVE W-FDMOVER    TO W-FDEMP.

                     OPEN INPUT  CADEMP.
                          IF ERRO NOT = "00"
                             MOVE "CADEMP -" TO W-ARQ
                             MOVE "Erro n§ " TO W-ERF
                             MOVE ERRO       TO W-ERC
                             MOVE 01         TO W-ERRO
                             MOVE 1          TO W-NMS
                             PERFORM 865
                             EXIT PROGRAM.

                     MOVE 0001   TO EMP1.
                     MOVE SYMEMP TO KEYEMP.
                     READ CADEMP INVALID KEY 
                          DISPLAY (22, 11) "EMPRESA 0001 N CADASTR"
                          STOP RUN.

                     MOVE EMPALI  TO  W-ALI.
      *
      * -----------
      *
                     MOVE W-DIR   TO  DRISEQ.

                     MOVE "CADNFS.ADL" TO DRISEQ(9:10).
                     MOVE W-FDMOVER    TO W-FDNFS.

                     OPEN INPUT  CADNFS.
                          IF ERRO NOT = "00"
                             MOVE "CADNFS -" TO W-ARQ
                             MOVE "Erro n§ " TO W-ERF
                             MOVE ERRO       TO W-ERC
                             MOVE 01         TO W-ERRO
                             MOVE 1          TO W-NMS
                             PERFORM 865
                             EXIT PROGRAM.

                     MOVE "CADNSI.ADL" TO DRISEQ(9:10).
                     MOVE W-FDMOVER    TO W-FDNSI.
       
                     OPEN INPUT  CADNSI.
                          IF ERRO NOT = "00"
                             MOVE "CADNSI -" TO W-ARQ
                             MOVE "Erro n§ " TO W-ERF
                             MOVE ERRO       TO W-ERC
                             MOVE 01         TO W-ERRO
                             MOVE 1          TO W-NMS
                             PERFORM 865
                             EXIT PROGRAM.

                     MOVE "CADMOV.ADL" TO DRISEQ(9:10).
                     MOVE W-FDMOVER    TO W-FDMOV.
       
                     OPEN I-O    CADMOV.
                          IF ERRO NOT = "00"
                             MOVE "CADMOV -" TO W-ARQ
                             MOVE "Erro n§ " TO W-ERF
                             MOVE ERRO       TO W-ERC
                             MOVE 01         TO W-ERRO
                             MOVE 1          TO W-NMS
                             PERFORM 865
                             EXIT PROGRAM.

                     MOVE "CADBCO.ADL" TO DRISEQ(9:10).
                     MOVE W-FDMOVER    TO W-FDBCO.

                     OPEN INPUT  CADBCO.
                          IF ERRO NOT = "00"
                             MOVE "CADBCO -" TO W-ARQ
                             MOVE "Erro n§ " TO W-ERF
                             MOVE ERRO       TO W-ERC
                             MOVE 01         TO W-ERRO
                             MOVE 1          TO W-NMS
                             PERFORM 865
                             EXIT PROGRAM.

                     MOVE "\AGUIA\CADCEP.AGU" TO DRISEQ.
                     MOVE W-FDMOVER           TO W-FDCEP.

                     OPEN I-O    CADCEP.
                          IF ERRO NOT = "00"
                             MOVE "CADCEP -" TO W-ARQ
                             MOVE "Erro n§ " TO W-ERF
                             MOVE ERRO       TO W-ERC
                             MOVE 01         TO W-ERRO
                             MOVE 1          TO W-NMS
                             PERFORM 865
                             EXIT PROGRAM.
      *
      * -----------  TELA   --------------------------------------------
      *
       200.          MOVE 0  TO ERRA.

                     MOVE "\MODULOS\MODTEL" TO DRISEQ.
                     MOVE W-FDMOVER         TO W-VOLTA.

                     MOVE "* ACBrMonitor *"                   TO W-TEL1.
                     MOVE "ECF - Emissor de Cupom Fiscal"     TO W-TEL2.
                     MOVE 1                                   TO W-TEL4.

                     CALL W-VOLTA USING  W-TEL1 W-TEL2 
                                         W-TEL3 W-TEL4 ERRA.

                     CANCEL W-VOLTA.

                     MOVE W-WORKAR (09:01) TO T-OP1.                    T-OP1 = Vem do Programa

                     MOVE SPACES TO W-MSD (1) W-MSD (2)
                                    W-MSD (3) W-MSD (4).
                     MOVE 99     TO W-NMS. 
                     MOVE ZEROS  TO W-SEM.

       210.          IF   T-OP1 = 0        PERFORM 300 THRU 309         Impressao Cupom / Venda
                                           GO TO   010.

       211.          IF   T-OP1 = 1
                          MOVE "Teclar <Enter> para Imprimir o Cancelame
      -                        "nto do Cupom !!"          TO W-MSD (1)
                          PERFORM 865
                          PERFORM 400                                   Criar ENT.TXT / Ativar Cupom
                          MOVE "ECF.Ativar"   TO REGENT WRITE REGENT
                          PERFORM 450 THRU 490                          Ler retorno
                          PERFORM 400                                   Criar ENT.TXT / Ativar Cupom
                          MOVE "ECF.CancelaCupom" TO REGENT WRITE REGENT
                          PERFORM 450 THRU 490.                         Ler retorno

       212.          IF   T-OP1 = 2
                          MOVE "Teclar <Enter> para Imprimir a Leitura X
      -                        "   !!!         "          TO W-MSD (1)
                          PERFORM 865
                          PERFORM 400                                   Criar ENT.TXT / Ativar Cupom
                          MOVE "ECF.Ativar"   TO REGENT WRITE REGENT
                          PERFORM 450 THRU 490                          Ler retorno
                          PERFORM 400                                   Criar ENT.TXT / Ativar Cupom
                          MOVE "ECF.LeituraX"     TO REGENT WRITE REGENT
                          PERFORM 450 THRU 490.                          Ler retorno

       213.          IF   T-OP1 = 3
                          MOVE "Teclar <Enter> para Imprimir a Reducao Z
      -                        " !!!           "          TO W-MSD (1)
                          PERFORM 865
                          PERFORM 400                                   Criar ENT.TXT / Ativar Cupom
                          MOVE "ECF.Ativar"   TO REGENT WRITE REGENT
                          PERFORM 450 THRU 490                          Ler retorno
                          PERFORM 400                                   Criar ENT.TXT / Ativar Cupom
                          MOVE "ECF.ReducaoZ"     TO REGENT WRITE REGENT
                          PERFORM 450 THRU 490.                          Ler retorno

       214.          IF   T-OP1 = 4
                          MOVE 2 TO T-OP2
                          PERFORM 400                                   Criar ENT.TXT / Ativar Cupom
                          MOVE "ECF.Ativar"   TO REGENT WRITE REGENT
                          PERFORM 450 THRU 490                          Ler retorno
                          PERFORM 400                                   Criar ENT.TXT / Ativar Cupom
                          PERFORM 310 THRU 319.                         Preencher Cheques

                     GO TO   010.
      *
      * ===========  VENDAS DOS ITENS   ================================
      *
       300.          DISPLAY WS-TELA2.

                     MOVE "Digite a Op‡Æo Desejada  "      TO T-MEN.
                     PERFORM 999.
                     ACCEPT (08, 38) T-OP2 WITH PROMPT AUTO-SKIP.

                     ACCEPT W-TEC FROM ESCAPE KEY

                            IF W-TEC = "01"         GO TO 010.

                            IF T-OP2 < 1  OR
                               T-OP2 > 5            GO TO 300.

       301.          MOVE W-WORKAR (01:08) TO NFS1.
                     DISPLAY (14, 38) NFS1.

                     MOVE SYMNFS TO KEYNFS.
                     READ CADNFS INVALID KEY
                             MOVE SPACES TO W-MSD (1) W-MSD (2)
                                            W-MSD (3) W-MSD (4)
                             MOVE 99     TO W-NMS 
                             MOVE ZEROS  TO W-SEM
                             MOVE "Cupom Nao Encontrado, Verificar   !!!
      -                           "                  " TO W-MSD (1)
                             MOVE "Teclar <Enter> para Encerrar   !!!
      -                           "                  " TO W-MSD (3)
                             PERFORM 865
                             GO TO   010.

                     MOVE NFS1   TO MOV1.
                     MOVE SYMMOV TO KEYMOV.
                     READ CADMOV INVALID KEY
                             MOVE SPACES TO W-MSD (1) W-MSD (2)
                                            W-MSD (3) W-MSD (4)
                             MOVE 99     TO W-NMS 
                             MOVE ZEROS  TO W-SEM
                             MOVE "Este Cupom Nao esta Efetivado, Verifi
      -                           "car   !!!         " TO W-MSD (1)
                             MOVE "Teclar <Enter> para Encerrar   !!!
      -                           "                  " TO W-MSD (3)
                             PERFORM 865
                             GO TO   010.

                     MOVE MOVREC TO T-VLR.
      *
      * -----------  ABERTURA DO CUPOM   -------------------------------
      *
                     PERFORM 400.                                       Criar ENT.TXT / Ativar Cupom
                     MOVE "ECF.Ativar"   TO REGENT WRITE REGENT.
                     PERFORM 450 THRU 490.                              Ler retorno

                     PERFORM 400.                                       Criar ENT.TXT / Ativar Cupom
                     MOVE "ECF.AbreCupom" TO REGENT     WRITE REGENT.
                     PERFORM 450 THRU 490.                              Ler retorno
      *
      * -----------  VENDA DOS ITENS   ----------------------------------
      *
                     MOVE NFS1  TO NSINNF.
                     MOVE ZEROS TO NSISEQ.

                     START CADNSI KEY > KEYNSI                      
                          INVALID KEY
                             MOVE SPACES TO W-MSD (1) W-MSD (2)
                                            W-MSD (3) W-MSD (4)
                             MOVE 99     TO W-NMS 
                             MOVE ZEROS  TO W-SEM
                             MOVE "Esta Cupom nao tem Itens, Verificar 
      -                           " !!!!!!           " TO W-MSD (1)
                             MOVE "Encerrar, Corrigir e Emitir o Cupom 
      -                           "novamente !!!     " TO W-MSD (2)
                             MOVE "Teclar <Enter> para Cancelar      
      -                           "                  " TO W-MSD (4)
                             PERFORM 865
                             GO TO   010.

       302.          READ CADNSI NEXT RECORD AT END GO TO   303.

                     IF   NSINNF > NFS1             GO TO   303.

                     MOVE NSIPRO  TO T-PRO.
                     MOVE NSIDES  TO T-NOM.
                     MOVE W-ALI   TO T-ICM.

                     MOVE NSIQT1  TO W-QTD.
                     MOVE W-QTD   TO T-QTD (01:04).
                     MOVE "."     TO T-QTD (05:01).
                     MOVE NSIQT2  TO T-QTD (06:03).

                     MOVE "0"     TO T-PRU (01:01).
                     MOVE NSIPU1  TO T-PRU (02:07).
                     MOVE "."     TO T-PRU (09:01).
                     MOVE NSIPU2  TO T-PRU (10:02).

                     PERFORM 400.                                       Criar ENT.TXT / Ativar Cupom
                     MOVE T-VENDE-ITEM   TO REGENT    WRITE REGENT.
                     PERFORM 450 THRU 490.                              Ler retorno

                     GO TO   302.
      *
      * -----------  FECHAMENTO DO CUPOM FISCAL   ----------------------
      *
      * -----------  SUB-TOTALIZA COM DESCONTO NA VENDA (Se Houver)                                 
      *
       303.          IF   MOVDES NOT = ZEROS
                          MOVE MOVDES        TO W-VLR
                          MOVE "-"           TO T-VRD (01:01)
                          MOVE W-VR1         TO T-VRD (02:08)
                          MOVE "."           TO T-VRD (10:01)
                          MOVE W-VR2         TO T-VRD (11:02)
                        ELSE
                          MOVE ZEROS  TO T-VRD (01:08)
                          MOVE "."    TO T-VRD (09:01)
                          MOVE ZEROS  TO T-VRD (10:02).

                     PERFORM 400.                                       Criar ENT.TXT / Ativar Cupom
                     MOVE T-SUB-TOTALIZA-CUPOM TO REGENT   WRITE REGENT.
                     PERFORM 450 THRU 490.                              Ler retorno
      *
      * -----------  EFETUA PAGAMENTO                                           
      *
                     MOVE T-OP2       TO T-FPG.

                     MOVE MOVREC        TO W-VLR.
                     MOVE W-VR1         TO T-VRT (01:08).
                     MOVE "."           TO T-VRT (09:01).
                     MOVE W-VR2         TO T-VRT (10:02).

                     PERFORM 400.                                       Criar ENT.TXT / Ativar Cupom
                     MOVE T-EFETUA-PAGAMENTO TO REGENT   WRITE REGENT.
                     PERFORM 450 THRU 490.                              Ler retorno
      *
      * -----------  FECHA CUPOM                                        
      *
                     PERFORM 400.                                       Criar ENT.TXT / Ativar Cupom
                     MOVE "ECF.FechaCupom" TO REGENT  WRITE REGENT.
                     PERFORM 450 THRU 490.                              Ler retorno
      *
      * -----------  ENCERRA VENDA DOS ITENS                           
      *
       309.          EXIT.
      *
      * ===========  IMPRESSAO DO CHEQUE  ==============================
      *
       310.          IF   T-OP1 NOT = 4            GO TO 319.

                     ACCEPT DTACPU FROM DATE.

                     ACCEPT HRSCPU FROM TIME.

                     MOVE CDI  TO Z-DD.
                     MOVE CME  TO Z-MM. 
                     MOVE CAN  TO Z-AA.

                     MOVE CHR  TO Z-HH.
                     MOVE CMI  TO Z-MI       MOVE Z-DTAHOR TO T-DTA.
      *
      * -----------  Dados do Cheque
      *
       311.          MOVE 1      TO W-TEL     PERFORM 860.

                     MOVE "Digite o Codigo do Banco/<Esc>-Encerrar/<F1>-
      -                   "Pesquisar"                          TO T-MEN.
                     PERFORM 999.

                     DISPLAY (22, 13) "Banco ....: ".
                     DISPLAY (22, 50) "Valor: ".
                     DISPLAY (23, 13) "Favorecido: ".
                     DISPLAY (24, 13) "Municipio : ".

                     ACCEPT (22, 25) T-BNU WITH PROMPT AUTO-SKIP.
                     ACCEPT W-TEC FROM ESCAPE KEY

                            IF W-TEC = "02"        PERFORM 800.

                            IF W-TEC = "01" OR
                               T-BNU = ZEROS       GO TO   319.

                     MOVE T-BNU  TO BCO1.
                     MOVE ZEROS  TO BCO2.
                     MOVE SYMBCO TO KEYBCO.
                     READ CADBCO INVALID KEY       GO TO   311.

                     DISPLAY (22, 25) T-BNU "-" BCOCOG.

       312.          DISPLAY (20, 13) "Digitar o Valor deste Cheque / <E
      -                               "sc>-Retornar
      -                               " "
                     ACCEPT (22, 57) T-VLR WITH PROMPT AUTO-SKIP UPDATE.
                     ACCEPT W-TEC FROM ESCAPE KEY

                            IF W-TEC = "01"        GO TO   311.

                            MOVE T-VLR TO T-VLRX
                                            DISPLAY (22, 57) T-VLRX.

                     MOVE EMPCEP TO CEP1.
                     MOVE SYMCEP TO KEYCEP.
                     READ CADCEP INVALID KEY      MOVE SPACES TO REGCEP.

                     MOVE EMPNOM TO T-FAV.
                     MOVE CEPMUN TO T-MUN.

                     MOVE SPACES TO T-OBS.

       313.          DISPLAY (20, 13) "Digite o Favorecido do Cheque/<Es
      -                               "c>-Retornar          "
                     ACCEPT (23, 25) T-FAV WITH PROMPT AUTO-SKIP UPDATE.
                     ACCEPT W-TEC FROM ESCAPE KEY

                            IF W-TEC = "01"        GO TO   312.

       314.          DISPLAY (20, 13) "Digite o Municipio  do Cheque/<Es
      -                               "c>-Retornar          "
                     ACCEPT (24, 25) T-MUN WITH PROMPT AUTO-SKIP UPDATE.
                     ACCEPT W-TEC FROM ESCAPE KEY

                            IF W-TEC = "01"        GO TO   313.

       315.          MOVE SPACES TO W-MSD (1) W-MSD (2)
                                    W-MSD (3) W-MSD (4).
                     MOVE 99     TO W-NMS.
                     MOVE ZEROS  TO W-SEM.
                     MOVE "Inserir a Folha de Cheque no E.C.F.  !!!   
      -                   "          "             TO W-MSD (1).
                     MOVE "Teclar S -> Imprimir este Cheque     !!!  
      -                   "          "             TO W-MSD (3).
                     MOVE "       N -> Nao Imprimir este Cheque !!!
      -                   "          "             TO W-MSD (4).

                     PERFORM 865.

                     IF W-OPX = "N"                GO TO 319.

                     IF W-OPX NOT = "S"            GO TO 315.

                     MOVE T-VLR         TO W-VLR.
                     MOVE W-VR1         TO T-VCH (01:08).
                     MOVE "."           TO T-VCH (09:01).
                     MOVE W-VR2         TO T-VCH (10:02).

       316.          MOVE T-IMPRIME-CHEQUE     TO REGENT   WRITE REGENT.

                     PERFORM 450 THRU 490.                              Ler retorno

                     IF   W-OPX = "S"
                          PERFORM 400                                   Criar ENT.TXT / Ativar Cupom
                          MOVE "ECF.Ativar"   TO REGENT WRITE REGENT
                          GO TO   316.

                     GO TO   310.

       319.          MOVE 2      TO W-TEL     PERFORM 860.

                     EXIT.
      *
      * ===========  GRAVA CONTADOR DE OPERA€OES - NUMERO DO CUPOM  ====
      *
       390.          MOVE ZEROS TO W-ECF.
       
      *              MOVE 6 TO W-STS   PERFORM 400 THRU 490.
      *
      *              MOVE W-ECF TO MOVECF          REWRITE REGMOV.
      *
      * ===========  Criar Arquivo - ENT.TXT / ATIVAR CUPOM  ===========
      *
      *
      * -----------  Criar/Limpar Arquivo - SAI.TXT                               
      *
       400.          MOVE "C:\TEMP\SAI.TXT" TO DRISEQ.
                     MOVE W-FDMOVER         TO W-FDSAI.

                     OPEN OUTPUT CADSAI.
                          IF ERRO NOT = "00"                         
                             MOVE SPACES TO W-MSD (1) W-MSD (2)
                                            W-MSD (3) W-MSD (4)
                             MOVE 99     TO W-NMS 
                             MOVE ZEROS  TO W-SEM
                             MOVE SPACES TO T-MEN
                             MOVE "Erro "              TO T-MEN (01:05)
                             MOVE ERRO                 TO T-MEN (06:04)
                             MOVE "ao Criar   o Arquivo sai.txt"
                                                       TO T-MEN (10:35)
                             MOVE T-MEN                TO W-MSD (1)
                             MOVE "Teclar <Enter> para Encerrar   !!!
      -                           "                  " TO W-MSD (3)
                             PERFORM 865
                             GO TO   010.
       
                     CLOSE CADSAI.

                     MOVE "C:\TEMP\ENT.TXT" TO DRISEQ.
                     MOVE W-FDMOVER         TO W-FDENT.

                     OPEN OUTPUT CADENT.
                          IF ERRO NOT = "00"                         
                             MOVE SPACES TO W-MSD (1) W-MSD (2)
                                            W-MSD (3) W-MSD (4)
                             MOVE 99     TO W-NMS 
                             MOVE ZEROS  TO W-SEM
                             MOVE SPACES TO T-MEN
                             MOVE "Erro "              TO T-MEN (01:05)
                             MOVE ERRO                 TO T-MEN (06:04)
                             MOVE "ao Criar   o Arquivo ent.txt"
                                                       TO T-MEN (10:35)
                             MOVE T-MEN                TO W-MSD (1)
                             MOVE "Teclar <Enter> para Encerrar   !!!
      -                           "                  " TO W-MSD (3)
                             PERFORM 865
                             GO TO   010.
      *
      * -----------  Abrir e Ler Arquivo Retorno - sai.txt / Retorno
      *
       450.          MOVE REGENT TO W-REGENT.

                     CLOSE CADENT.

                     MOVE "C:\TEMP\SAI.TXT"  TO DRISEQ.
                     MOVE W-FDMOVER          TO W-FDSAI.

                     MOVE 0    TO W-STS.
                     MOVE " "  TO W-OPX.

                     MOVE 1 TO W-TEL PERFORM 860.
                     MOVE "Aguarde, ECF Processando o Comando:"
                                                              TO T-MEN.
                     PERFORM 999.
                     DISPLAY (22, 13) W-REGENT.

       453.          OPEN INPUT CADSAI.

       455.          READ CADSAI NEXT RECORD AT END                      

                                 IF   W-STS = 0       CLOSE CADSAI
                                                      GO TO   453  
                                    ELSE
                                                      GO TO   490.

                     MOVE 1 TO W-STS.

                     IF   W-RETOR NOT = "ERRO"        GO TO   455.

                     MOVE 2      TO W-TEL             PERFORM 860.

       456.          PERFORM 500 THRU 509.                              Corrige acentuacao

                     MOVE SPACES TO W-MSD (1) W-MSD (2)
                                    W-MSD (3) W-MSD (4).
                     MOVE 99     TO W-NMS.
                     MOVE ZEROS  TO W-SEM.
                     MOVE SPACES TO T-MEN.
                     MOVE "Retorno ECF: " TO T-MEN (01:13).
                     MOVE W-RET (002:41)  TO T-MEN (14:41).
                     MOVE T-MEN           TO W-MSD (1).
                     MOVE SPACES          TO T-MEN.
                     MOVE W-RET (042:41)  TO T-MEN (14:41).
                     MOVE T-MEN           TO W-MSD (2).
                     MOVE W-RET (084:40)  TO T-MEN (14:41).
                     MOVE T-MEN           TO W-MSD (3).

                     IF   T-OP1 = 4                                     Cheques
                          MOVE "Inserir Folha de Cheque e Digitar (S), S
      -                   "enao <Ent>"             TO W-MSD (3).

                     PERFORM 865.

                     IF   W-OPX NOT = "S"          GO TO 010.

       490.          MOVE REGSAI (03:04) TO W-ECF.

                     CLOSE CADSAI.
      *
      * -----------  TROCA ACENTUACAO  --------------------------------
      *
       500.          MOVE ZEROS TO I.

       501.          ADD  1     TO I.
       
                     IF   I   > 124          GO TO 509.
       
                     IF   W-RE (I) = " "     GO TO 501.      

                     IF   W-RE (I) = "ç"     MOVE "c" TO W-RE (I).
                     IF   W-RE (I) = "é"     MOVE "e" TO W-RE (I).
                     IF   W-RE (I) = "ã"     MOVE "a" TO W-RE (I).
                     IF   W-RE (I) = "ô"     MOVE "o" TO W-RE (I).
                     IF   W-RE (I) = "ó"     MOVE "a" TO W-RE (I).
                     IF   W-RE (I) = "â"     MOVE "a" TO W-RE (I).
                     IF   W-RE (I) = "á"     MOVE "a" TO W-RE (I).
       
                     GO TO 501.

       509.          EXIT.
      *
      * -----------  PESQUISA BANCOS CADASTRADOS   -------------
      *
       800.          MOVE "S"           TO GRBOXF-FUNCTION
                     MOVE "ADLPBCO"     TO GRBOXF-PROGRAM
                     MOVE 05            TO GRBOXF-LINE
                     MOVE 10            TO GRBOXF-COLUMN
                     MOVE 18            TO GRBOXF-VERTICAL-LENGTH
                     MOVE 66            TO GRBOXF-HORIZONTAL-LENGTH
                     MOVE "Banco_Agenc_Contato_________Nome_do_Banco___T
      -                   "elefone_________"
                                        TO GRBOXF-TITLE
                     MOVE 2             TO GRBOXF-ORDER
                     MOVE 28            TO GRBOXF-STRING-1-LENGTH
                     MOVE 34            TO GRBOXF-STRING-2-LENGTH
      
                     PERFORM TEST AFTER UNTIL GRBOXF-OPTION NOT = SPACES
                             MOVE SPACES TO GRBOXF-OPTION
                             CALL "GRBOXF" USING PARAMETROS-GRBOXF
                             MOVE GRBOXF-OPTION (3:3) TO T-BNU 
      *                      MOVE GRBOXF-OPTION (7:5) TO T-AGE 

                     END-PERFORM.
      *
      * -----------  CARREGA / LIMPA TELA DE MENSAGEM   ----------------
      *
       860.          MOVE "\MODULOS\MODTEL" TO DRISEQ.
                     MOVE W-FDMOVER         TO W-VOLTA.

                     IF   W-TEL = 1      MOVE 5 TO W-TEL4
                         ELSE
                                         MOVE 6 TO W-TEL4.

                     CALL W-VOLTA USING  W-TEL1 W-TEL2
                                         W-TEL3 W-TEL4 ERRA.

                     CANCEL W-VOLTA.
      *
      * -----------  BUSCA MENSAGEM DE ERROS DA AGUIA   ------------------
      *
       865.          MOVE "\MODULOS\MODMSG" TO DRISEQ.
                     MOVE W-FDMOVER         TO W-VOLTA.
       
                     CALL W-VOLTA USING  W-MSG ERRA.
       
                     CANCEL W-VOLTA.
      *
      * -----------  LIMPA OS CAMPOS DE DISPLAY   ----------------------
      *
       999.          DISPLAY (21, 01) BCO.
                     DISPLAY (22, 01) BCO.
                     DISPLAY (23, 01) BCO.
                     DISPLAY (24, 01) BCO.
                     DISPLAY (20, 13) T-MEN.
      *-----------------------------------------------------------------
