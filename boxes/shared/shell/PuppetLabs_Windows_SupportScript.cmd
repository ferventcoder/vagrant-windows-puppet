@echo off
SET LOGFILE="%systemdrive%\PuppetLabsSupportScript.log"
for /f "delims=" %%i in ('hostname') do set HOSTNAME=%%i

@echo.
@echo ==================================================================
@echo Puppet Labs Windows Support Script for %HOSTNAME%
@echo ==================================================================
@echo.
@echo Welcome to the Puppet Labs Support Script for Windows Agents!
@echo.
@echo The script will automatically kick off 20 seconds after this
@echo message is displayed. To exit immediately, press Control+C now.
@echo.
@echo The script will gather information about your system. If you see
@echo errors while it runs, that is okay, let it continue. Once it has
@echo finished, please zip up the file at %LOGFILE%
@echo and send it to the Puppet Labs Support Team. Thanks!

call timeout /t 20

@echo.
@echo This script may take from 15 seconds to over 30 minutes depending
@echo on your system and will run without output.
@echo.
@echo This script will notify you when it is complete.
@echo.

echo ===================================================== >%LOGFILE%
echo Puppet Labs Windows Support Script for %HOSTNAME% >>%LOGFILE%
echo ===================================================== >>%LOGFILE%
echo Executed on %date%. >>%LOGFILE%
echo. >>%LOGFILE%

echo --------------------------------------------- >>%LOGFILE%
echo --------------- Instructions ---------------- >>%LOGFILE%
echo --------------------------------------------- >>%LOGFILE%
echo Please zip up this file and upload it to the >>%LOGFILE%
echo Puppet Labs Support team for further review. >>%LOGFILE%
echo Thanks! >>%LOGFILE%
echo --------------------------------------------- >>%LOGFILE%
echo. >>%LOGFILE%
echo. >>%LOGFILE%

echo --------------------------------------------- >>%LOGFILE%
echo - Environment Variables - >>%LOGFILE%
echo ------------------------- >>%LOGFILE%
SET >>%LOGFILE% 2>&1
echo --------------------------------------------- >>%LOGFILE%
echo. >>%LOGFILE%

echo --------------------------------------------- >>%LOGFILE%
echo - Users/Groups - >>%LOGFILE%
echo ---------------- >>%LOGFILE%
call net user >> %LOGFILE% 2>&1
call net localgroup >> %LOGFILE%
call whoami /all >>%LOGFILE% 2>&1
echo --------------------------------------------- >>%LOGFILE%
echo. >>%LOGFILE%

echo --------------------------------------------- >>%LOGFILE%
echo - Puppet Specific Details - >>%LOGFILE%
echo --------------------------- >>%LOGFILE%
SET PATH=%systemdrive%\Program Files (x86)\Puppet Labs\Puppet\bin;%systemdrive%\Program Files\Puppet Labs\Puppet\bin;%PATH%

echo where puppet  >>%LOGFILE%
call where puppet  >>%LOGFILE% 2>&1
echo puppet --version >>%LOGFILE%
call puppet --version >>%LOGFILE% 2>&1
echo. >>%LOGFILE%
echo facter --version >>%LOGFILE%
call facter --version >>%LOGFILE% 2>&1
echo. >>%LOGFILE%
echo hiera --version >>%LOGFILE%
call hiera --version >>%LOGFILE% 2>&1
echo. >>%LOGFILE%
echo where ruby >>%LOGFILE%
call where ruby >>%LOGFILE% 2>&1
echo ruby --version >>%LOGFILE%
call ruby --version >>%LOGFILE% 2>&1
echo. >>%LOGFILE%
echo puppet module list >>%LOGFILE%
call puppet module list >>%LOGFILE% 2>&1
echo sc qc puppet >>%LOGFILE%
call sc qc puppet >>%LOGFILE% 2>&1
call sc qc pe-puppet >>%LOGFILE%
echo sc qc mcollective >>%LOGFILE% 2>&1
call sc qc mcollective >>%LOGFILE%
call sc qc pe-mcollective >>%LOGFILE% 2>&1
echo --------------------------------------------- >>%LOGFILE%
echo. >>%LOGFILE%

echo --------------------------------------------- >>%LOGFILE%
echo - Facter Information - >>%LOGFILE%
echo ---------------------- >>%LOGFILE%
echo facter --debug --trace >>%LOGFILE%
call facter --debug --trace >>%LOGFILE% 2>&1
echo --------------------------------------------- >>%LOGFILE%
echo. >>%LOGFILE%

echo --------------------------------------------- >>%LOGFILE%
echo - Certificates Information - >>%LOGFILE%
echo ---------------------------- >>%LOGFILE%
call powershell -Command Get-ChildItem -Recurse Cert: >>%LOGFILE% 2>&1
echo --------------------------------------------- >>%LOGFILE%
echo. >>%LOGFILE%

echo --------------------------------------------- >>%LOGFILE%
echo - Puppet System Discovery - >>%LOGFILE%
echo --------------------------- >>%LOGFILE%
echo puppet resource user >>%LOGFILE%
call puppet resource user >>%LOGFILE% 2>&1
echo --------------------------- >>%LOGFILE%
echo puppet resource group >>%LOGFILE%
call puppet resource group >>%LOGFILE% 2>&1
echo --------------------------- >>%LOGFILE%
echo puppet resource host >>%LOGFILE%
call puppet resource host >>%LOGFILE% 2>&1
echo --------------------------- >>%LOGFILE%
echo puppet resource service >>%LOGFILE%
call puppet resource service >>%LOGFILE% 2>&1
echo --------------------------- >>%LOGFILE%
echo puppet resource package --param provider >>%LOGFILE%
call puppet resource package --param provider >>%LOGFILE% 2>&1
echo --------------------------------------------- >>%LOGFILE%
echo. >>%LOGFILE%

echo --------------------------------------------- >>%LOGFILE%
echo - Puppet Agent Test - >>%LOGFILE%
echo --------------------- >>%LOGFILE%
:: eventually we may want to runas the user the service runs as
echo puppet agent --test --debug --verbose --trace >>%LOGFILE%
call puppet agent --test --debug --verbose --trace >>%LOGFILE% 2>&1
echo --------------------------------------------- >>%LOGFILE%
echo ============================================= >>%LOGFILE%
echo. >>%LOGFILE%

@echo.
@echo All finished! Please zip up and send
@echo %LOGFILE% to the Puppet Labs
@echo Support Team. Thanks!
@echo ==================================================================
