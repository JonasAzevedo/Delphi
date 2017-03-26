=================
EXPORTPACK v. 1.2
=================

Sorry my english... I'm spanish.

VCL components to export reports created with QuickReport and FastReport to graphics
formats: JPG, BMP, WMF, EMF, PDF.

NOTE: This components uses internally freeware external libraries and components created 
      by other users:
   TPrintPDF. Author: K. Nishita. -> Component for PDF creation.
   ZLIB. -> Used by TPrintPDF -> Compression library.

The component TPrintPDF by K. Nishita has been modified to save color palette of images and
save JPG images. Also to Landscape orientation.

Thanks to the authors.

Last revisión: may 2003

More information: http://usuarios.lycos.es/isma

-------------------
TABLA DE CONTENIDOS
-------------------
Latest changes
Preview
History
Install
Examples
Source Code
Special Thanks

--------------
Latest changes
--------------
may 2003
--------
* version 1.2

april 2002
----------
* Versión 1.0 born.

----------
Preview
----------

ExportPack is a VCL library that allows you to export reports created with
QuickReport and FastReport to graphic formats: JPG, BMP, EMF, WMF and PDF.
Has been created with Borland Delphi 6 & 7 but is possible compile it
with previos versions of Delphi.

ExportPack is freeware. You are free to distribute the components but don't
separate any files from the package.

Authors don't give any warranty of this software. There are no warranty of
any kind. You use this software under your responsability. Comments and critics
are acepted.

1. Components:

TExportQR -> Allows export reports created with QuickReport.
TExportFR -> Allows export reports created with FastReport.

--------
History
--------


ExportPack 1.2. Delphi 7 support.
    NEW METHOD in TExportFR (ExportFRFromPreview) because a bug when FastReport has dialog.
    // See Ex2 in Demos directory to see the new funcionality.
    New property PixelFormat
    Some bugs in FastReports with dialogs windows.

ExportPack 1.0 (april 2002). Delphi 6. It start.


-------
Install
-------

1. Delphi 7.x:
Option: File\Open in Delphi IDE, open file ExPackD7.DPK
Click in Compile
Click in Install

NOTE, don't save changes to ExPackD7.DPK

If you haven't FastReport open file ExportPack.Pas and
delete line {$DEFINE FASTREPORT}

Por english language delete line {$DEFINE SPANISH} and
add {$DEFINE ENGLISH}

Be sure that Tools\Environment Options\Library Path has
included the path  to source code of ExportPack 1.2.


2. Delphi 6.x:

Option: File\Open in Delphi IDE, open file ExPackD6.DPK
Click in Compile
Click in Install

NOTE, don't save changes to ExPackD6.DPK

If you haven't FastReport open file ExportPack.Pas and
delete line {$DEFINE FASTREPORT}

Por english language delete line {$DEFINE SPANISH} and
add {$DEFINE ENGLISH}

Be sure that Tools\Environment Options\Library Path has
included the path  to source code of ExportPack 1.2.

--------
Examples
--------

Examples are in DEMOS folder. They use DBDEMO database. There
are a file in DEMOS folder that describes all the examples.

-----------
Source Code
-----------

All source code of ExportPack 1.2 is in Source folder.

--------------
Special Thanks
--------------

I'd like greet to:

* K. Nishita by PrintPDF (the PDF format won't be possible)
* Authors of ZLIB library.
* All my friends.
* All the people I forget...

Authors:
   - Ismael Fernández Bustos (ismafb@terra.es)
   - K. Nishita (indirectly) (info@nishita.com).
   - ZLIB (indirectly).

