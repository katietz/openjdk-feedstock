Robocopy.exe /MOVE /S /E bin\ "%LIBRARY_BIN%"
Robocopy.exe /MOVE /S /E include\ "%LIBRARY_INC%"
Robocopy.exe /MOVE /S /E jre "%LIBRARY_PREFIX%"\jre
Robocopy.exe /MOVE /S /E lib\ "%LIBRARY_LIB%"

Robocopy.exe /MOVE /S /E jbrex\jre "%LIBRARY_PREFIX%"\jre

:: ensure that JAVA_HOME is set correctly
mkdir "%PREFIX%"\etc\conda\activate.d
echo set "JAVA_HOME_CONDA_BACKUP=%%JAVA_HOME%%" > "%PREFIX%\etc\conda\activate.d\java_home.bat"
echo set "JAVA_HOME=%%CONDA_PREFIX%%\Library" >> "%PREFIX%\etc\conda\activate.d\java_home.bat"
mkdir "%PREFIX%"\etc\conda\deactivate.d
echo set "JAVA_HOME=%%JAVA_HOME_CONDA_BACKUP%%" > "%PREFIX%\etc\conda\deactivate.d\java_home.bat"
