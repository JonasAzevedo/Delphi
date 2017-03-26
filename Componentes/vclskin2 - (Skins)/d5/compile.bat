SET OLDPATH=%PATH%
CD %1
path=d:\Program Files\Borland\Delphi5\bin
dcc32.exe /B winSkinD5R.dpk -$H-,W-
dcc32.exe /B winSkinD5D.dpk -$H-,W-
del dcc32.cfg
SET Path=%OLDPATH%
