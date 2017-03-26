SET OLDPATH=%PATH%
CD %1
path=D:\Program Files\Borland\Delphi6\bin
dcc32.exe /B winSkinD6R.dpk -$H-,W-
dcc32.exe /B winSkinD6D.dpk -$H-,W-
del dcc32.cfg
SET Path=%OLDPATH%
