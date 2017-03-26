SET OLDPATH=%PATH%
CD %1
path=d:\Program Files\CodeGear\RAD Studio\6.0\bin
dcc32.exe /B winSkinD2009.dpk -$H-,W-
del dcc32.cfg
SET Path=%OLDPATH%
