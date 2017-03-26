# ---------------------------------------------------------------------------
!if !$d(BCB)
BCB = $(MAKEDIR)\..
!endif

# ---------------------------------------------------------------------------
# IDE SECTION
# ---------------------------------------------------------------------------
# The following section of the project makefile is managed by the BCB IDE.
# It is recommended to use the IDE to change any of the values in this
# section.
# ---------------------------------------------------------------------------

VERSION = BCB.06.00
# ---------------------------------------------------------------------------
PROJECT = bin\c6clx\RLibWinC6clx.bpl
OBJFILES = bin\c6clx\RLibWinC6clx.obj bin\c6clx\RLConsts.obj \
    bin\c6clx\RLDraftFilter.obj bin\c6clx\RLFeedBack.obj \
    bin\c6clx\RLHTMLFilter.obj bin\c6clx\RLMetaFile.obj \
    bin\c6clx\RLPreview.obj bin\c6clx\RLPrintDialog.obj bin\c6clx\RLReport.obj \
    bin\c6clx\RLRichFilter.obj bin\c6clx\RLUtils.obj bin\c6clx\RLFilters.obj \
    bin\c6clx\RLParser.obj bin\c6clx\RLPreviewForm.obj \
    bin\c6clx\RLPrinters.obj bin\c6clx\RLTypes.obj bin\c6clx\RLAbout.obj \
    bin\c6clx\RLBarcode.obj bin\c6clx\RLDesign.obj bin\c6clx\RLMetaCLX.obj \
    bin\c6clx\RLMetaVCL.obj bin\c6clx\RLPDFFilter.obj bin\c6clx\RLReg.obj \
    bin\c6clx\RLRichText.obj bin\c6clx\RLSpoolFilter.obj \
    bin\c6clx\RLFindDialog.obj bin\c6clx\RLSaveDialog.obj \
    bin\c6clx\RLXLSFilter.obj
RESFILES = RLibWinC6clx.res RLReport.dcr
MAINSOURCE = RLibWinC6clx.cpp
RESDEPEN = $(RESFILES)
LIBFILES = 
IDLFILES = 
IDLGENFILES = 
LIBRARIES = bcb2kaxserver.lib indy.lib dbxcds.lib dclocx.lib soaprtl.lib nmfast.lib \
    dbexpress.lib inetdbxpress.lib inetdbbde.lib dsnapcon.lib dsnapcrba.lib \
    teeqr.lib dss.lib tee.lib teedb.lib teeui.lib qrpt.lib bdecds.lib cds.lib \
    ibxpress.lib vcldbx.lib bdertl.lib adortl.lib vcldb.lib
PACKAGES = rtl.bpi designide.bpi visualclx.bpi dbrtl.bpi visualdbclx.bpi bcbsmp.bpi \
    bcbie.bpi vcl.bpi
SPARELIBS = rtl.lib vcldb.lib adortl.lib bdertl.lib vcldbx.lib ibxpress.lib cds.lib \
    bdecds.lib qrpt.lib teeui.lib teedb.lib tee.lib dss.lib teeqr.lib \
    visualdbclx.lib dsnapcrba.lib dsnapcon.lib bcbsmp.lib inetdbbde.lib \
    inetdbxpress.lib dbexpress.lib nmfast.lib bcbie.lib soaprtl.lib dclocx.lib \
    dbxcds.lib indy.lib bcb2kaxserver.lib
DEFFILE = 
OTHERFILES = 
# ---------------------------------------------------------------------------
DEBUGLIBPATH = $(BCB)\lib\debug
RELEASELIBPATH = $(BCB)\lib\release
USERDEFINES = CPP;CPP6;CLX
SYSDEFINES = _RTLDLL;NO_STRICT;USEPACKAGES
INCLUDEPATH = $(BCB)\include;$(BCB)\include\vcl;$(BCB)\Source\Toolsapi
LIBPATH = $(BCB)\Projects;$(BCB)\lib\obj;$(BCB)\lib;$(BCB)\Source\Toolsapi
WARNINGS= -w-par
PATHCPP = .;
PATHASM = .;
PATHPAS = .;
PATHRC = .;
PATHOBJ = .;$(LIBPATH)
# ---------------------------------------------------------------------------
CFLAG1 = -O2 -w -Vx -Ve -X- -rd -a8 -b- -k- -vi -c -tWM
IDLCFLAGS = -I$(BCB)\include -I$(BCB)\include\vcl -I$(BCB)\Source\Toolsapi -src_suffix \
    cpp -DCPP -DCPP6 -DCLX -boa
PFLAGS = -N2bin\c6clx -N0bin\c6clx -$Y- -$L- -$D- -$A8 -v -JPHNE -M
RFLAGS = 
AFLAGS = /mx /w2 /zn
LFLAGS = -lbin\c6clx -Ibin\c6clx -D"FortesReport CLX Library" -aa -Tpp -x -Gn -Gl -Gi
# ---------------------------------------------------------------------------
ALLOBJ = c0pkg32.obj $(PACKAGES) Memmgr.Lib sysinit.obj $(OBJFILES)
ALLRES = $(RESFILES)
ALLLIB = $(LIBFILES) $(LIBRARIES) import32.lib cp32mti.lib
# ---------------------------------------------------------------------------
!ifdef IDEOPTIONS

[Version Info]
IncludeVerInfo=0
AutoIncBuild=0
MajorVer=1
MinorVer=0
Release=0
Build=0
Debug=0
PreRelease=0
Special=0
Private=0
DLL=0

[Version Info Keys]
CompanyName=
FileDescription=
FileVersion=1.0.0.0
InternalName=
LegalCopyright=
LegalTrademarks=
OriginalFilename=
ProductName=
ProductVersion=1.0.0.0
Comments=

[Debugging]
DebugSourceDirs=$(BCB)\source\vcl

!endif





# ---------------------------------------------------------------------------
# MAKE SECTION
# ---------------------------------------------------------------------------
# This section of the project file is not used by the BCB IDE.  It is for
# the benefit of building from the command-line using the MAKE utility.
# ---------------------------------------------------------------------------

.autodepend
# ---------------------------------------------------------------------------
!if "$(USERDEFINES)" != ""
AUSERDEFINES = -d$(USERDEFINES:;= -d)
!else
AUSERDEFINES =
!endif

!if !$d(BCC32)
BCC32 = bcc32
!endif

!if !$d(CPP32)
CPP32 = cpp32
!endif

!if !$d(DCC32)
DCC32 = dcc32
!endif

!if !$d(TASM32)
TASM32 = tasm32
!endif

!if !$d(LINKER)
LINKER = ilink32
!endif

!if !$d(BRCC32)
BRCC32 = brcc32
!endif


# ---------------------------------------------------------------------------
!if $d(PATHCPP)
.PATH.CPP = $(PATHCPP)
.PATH.C   = $(PATHCPP)
!endif

!if $d(PATHPAS)
.PATH.PAS = $(PATHPAS)
!endif

!if $d(PATHASM)
.PATH.ASM = $(PATHASM)
!endif

!if $d(PATHRC)
.PATH.RC  = $(PATHRC)
!endif

!if $d(PATHOBJ)
.PATH.OBJ  = $(PATHOBJ)
!endif
# ---------------------------------------------------------------------------
$(PROJECT): $(OTHERFILES) $(IDLGENFILES) $(OBJFILES) $(RESDEPEN) $(DEFFILE)
    $(BCB)\BIN\$(LINKER) @&&!
    $(LFLAGS) -L$(LIBPATH) +
    $(ALLOBJ), +
    $(PROJECT),, +
    $(ALLLIB), +
    $(DEFFILE), +
    $(ALLRES)
!
# ---------------------------------------------------------------------------
.pas.hpp:
    $(BCB)\BIN\$(DCC32) $(PFLAGS) -U$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -O$(INCLUDEPATH) --BCB {$< }

.pas.obj:
    $(BCB)\BIN\$(DCC32) $(PFLAGS) -U$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -O$(INCLUDEPATH) --BCB {$< }

.cpp.obj:
    $(BCB)\BIN\$(BCC32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n$(@D) {$< }

.c.obj:
    $(BCB)\BIN\$(BCC32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n$(@D) {$< }

.c.i:
    $(BCB)\BIN\$(CPP32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n. {$< }

.cpp.i:
    $(BCB)\BIN\$(CPP32) $(CFLAG1) $(WARNINGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -n. {$< }

.asm.obj:
    $(BCB)\BIN\$(TASM32) $(AFLAGS) -i$(INCLUDEPATH:;= -i) $(AUSERDEFINES) -d$(SYSDEFINES:;= -d) $<, $@

.rc.res:
    $(BCB)\BIN\$(BRCC32) $(RFLAGS) -I$(INCLUDEPATH) -D$(USERDEFINES);$(SYSDEFINES) -fo$@ $<



# ---------------------------------------------------------------------------




