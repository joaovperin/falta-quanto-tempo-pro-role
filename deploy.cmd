@echo off
setlocal
rem
:init
rem
   call :deploy-app || goto :error
   echo "Success!"
goto :eof
rem
:deploy-app
   echo "Creating a new release build for web channel..."
   call :echo-and-call flutter build web --release
   echo "Deploying app to the production web channel..."
   call :echo-and-call firebase deploy --only hosting
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