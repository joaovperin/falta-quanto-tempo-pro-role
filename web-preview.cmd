@echo off
setlocal
rem
:init
   set PREVIEW-NAME=
rem
   call :accept-name || goto :error
   call :create-preview || goto :error
   echo "Success!"
goto :eof
rem
:accept-name
   echo "Input your preview name:"
   set /p PREVIEW-NAME=
   if "%PREVIEW-NAME%"=="" echo "Canceled by user!" && exit /B %ERRORLEVEL%
goto :eof
rem
:create-preview
   echo "Creating a new release build for web channel..."
   call :echo-and-call flutter build web --release
   echo "Creating preview with name '%PREVIEW-NAME%'..."
   call :echo-and-call firebase hosting:channel:deploy %PREVIEW-NAME%
goto:eof
rem
:echo-and-call
   set CMD=%*
   if not "%CMD%"=="" (
      echo Running 'call %CMD%'...
      call %CMD%
   )
goto:eof
endlocal
rem
:error
echo Failed with error #%errorlevel%.
exit /B %errorlevel%
