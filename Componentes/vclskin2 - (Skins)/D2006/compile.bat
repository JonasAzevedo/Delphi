SET OLDPATH=%PATH%
CD %1
path=D:\Program Files\Borland\BDS\4.0\bin
dcc32.exe /B winSkinD2006.dpk -$H-,W-
del dcc32.cfg
SET Path=%OLDPATH%
