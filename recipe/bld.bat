move bin\* "%LIBRARY_BIN%"
move include\* "%LIBRARY_INC%"
move jre "%LIBRARY_PREFIX%"\jre
move lib\* "%LIBRARY_LIB%"
move src.zip "%LIBRARY_PREFIX%"\jre\src.zip

:: ensure that JAVA_HOME is set correctly
mkdir "%PREFIX%"\etc\conda\activate.d
echo set "JAVA_HOME_CONDA_BACKUP=%%JAVA_HOME%%" > "%PREFIX%\etc\conda\activate.d\java_home.bat"
echo set "JAVA_HOME=%%CONDA_PREFIX%%\Library" >> "%PREFIX%\etc\conda\activate.d\java_home.bat"
mkdir "%PREFIX%"\etc\conda\deactivate.d
echo set "JAVA_HOME=%%JAVA_HOME_CONDA_BACKUP%%" > "%PREFIX%\etc\conda\deactivate.d\java_home.bat"
