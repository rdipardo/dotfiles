@echo off
SETLOCAL
SET "SCITE_CONF=%UserProfile%\SciTEUser.properties"
SET "VIM_CONF=%UserProfile%\.vimrc"
SET "NVIM_DIR=%LocalAppData%\nvim"
SET "NVIM_DATA_DIR=%LocalAppData%\nvim-data"
SET "NVIM_CONF=%NVIM_DIR%\init.vim"
SET "TS=%date:~5,6%-%date:~0,4%"
IF EXIST %SCITE_CONF% (
move %SCITE_CONF% %SCITE_CONF%.bak.%TS%
@echo F | xcopy /DVY .SciTEUser.properties %SCITE_CONF% 2>NUL:
)
IF EXIST %VIM_CONF% (
move %VIM_CONF% %VIM_CONF%.bak.%TS%
@echo F | xcopy /DVY _vim\vimrc %VIM_CONF% 2>NUL:
)
IF EXIST "%UserProfile%\.vim" (
@echo F | xcopy /DVY _vim\user.vim "%UserProfile%\.vim" 2>NUL:
)
IF EXIST "%UserProfile%\vimfiles" (
@echo F | xcopy /DVY _vim\user.vim "%UserProfile%\vimfiles" 2>NUL:
)
IF EXIST %NVIM_DIR% (
move %NVIM_DIR% %NVIM_DIR%.bak.%TS%
@rem IF EXIST %NVIM_DATA_DIR% ( move %NVIM_DATA_DIR% %NVIM_DATA_DIR%.bak.%TS% )
@echo D | xcopy /ISY _config\nvim\* %NVIM_DIR% 2>NUL:
@echo F | xcopy /DVY _vim\user.vim %NVIM_DIR% 2>NUL:
)
PAUSE
ENDLOCAL
