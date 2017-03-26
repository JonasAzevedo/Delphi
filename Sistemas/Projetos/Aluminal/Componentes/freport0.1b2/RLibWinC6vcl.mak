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
PROJECT = bin\c6vcl\RLibWinC6vcl.bpl
OBJFILES = bin\c6vcl\RLibWinC6vcl.obj bin\c6vcl\RLAbout.obj bin\c6vcl\RLBarcode.obj \
    bin\c6vcl\RLConsts.obj bin\c6vcl\RLDesign.obj bin\c6vcl\RLDraftFilter.obj \
    bin\c6vcl\RLFeedBack.obj bin\c6vcl\RLFilters.obj \
    bin\c6vcl\RLHTMLFilter.obj bin\c6vcl\RLMetaFile.obj bin\c6vcl\RLMetaVCL.obj \
    bin\c6vcl\RLParser.obj bin\c6vcl\RLPDFFilter.obj bin\c6vcl\RLPreview.obj \
    bin\c6vcl\RLPreviewForm.obj bin\c6vcl\RLPrintDialog.obj \
    bin\c6vcl\RLPrinters.obj bin\c6vcl\RLReg.obj bin\c6vcl\RLReport.obj \
    bin\c6vcl\RLRichFilter.obj bin\c6vcl\RLRichText.obj \
    bin\c6vcl\RLSpoolFilter.obj bin\c6vcl\RLTypes.obj bin\c6vcl\RLUtils.obj \
    bin\c6vcl\RLFindDialog.obj bin\c6vcl\RLSaveDialog.obj \
    bin\c6vcl\RLXLSFilter.obj
RESFILES = RLReport.dcr
MAINSOURCE = RLibWinC6vcl.cpp
RESDEPEN = $(RESFILES)
LIBFILES = 
IDLFILES = 
IDLGENFILES = 
LIBRARIES = bcb2kaxserver.lib indy.lib dbxcds.lib dclocx.lib soaprtl.lib bcbie.lib \
    nmfast.lib dbexpress.lib inetdbxpress.lib inetdbbde.lib dsnapcon.lib \
    dsnapcrba.lib teeqr.lib dss.lib tee.lib teedb.lib teeui.lib qrpt.lib \
    bdecds.lib cds.lib ibxpress.lib vcldbx.lib bdertl.lib adortl.lib
PACKAGES = rtl.bpi designide.bpi vcl.bpi visualclx.bpi dbrtl.bpi vcldb.bpi \
    visualdbclx.bpi bcbsmp.bpi
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
USERDEFINES = CPP;CPP6;VCL
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
    cpp -DCPP -DCPP6 -DVCL -boa
PFLAGS = -N2bin\c6vcl -N0bin\c6vcl -$Y- -$L- -$D- -$A8 -v -JPHNE -M
RFLAGS = 
AFLAGS = /mx /w2 /zn
LFLAGS = -lbin\c6vcl -Ibin\c6vcl -D"FortesReport VCL Library" -aa -Tpp -x -Gn -Gl -Gi
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




