@echo off

SET PATH=%PATH%;%SystemDrive%\Program Files (x86)\Puppet Labs\Puppet\bin;%SystemDrive%\Program Files\Puppet Labs\Puppet\bin;

SET LOGFILE=C:\SmokeTest.log
SET PUPPETAGENT_LOGFILE=C:\PuppetAgent_SmokeTest.log

echo =============== >> %LOGFILE%
echo Versions        >> %LOGFILE%
echo =============== >> %LOGFILE%
puppet --version >>%LOGFILE%
facter --version >>%LOGFILE%
hiera --version >>%LOGFILE%

echo =============== >> %LOGFILE%
echo Help Commands   >> %LOGFILE%
echo =============== >> %LOGFILE%
puppet help >> %LOGFILE%
puppet help apply >> %LOGFILE%

echo =============== >> %LOGFILE%
echo Resources       >> %LOGFILE%
echo =============== >> %LOGFILE%
puppet resource user >>%LOGFILE%
puppet resource package --param provider >>%LOGFILE%

echo =============== >> %LOGFILE%
echo Puppet Apply    >> %LOGFILE%
echo =============== >> %LOGFILE%
puppet apply -e "user {'Administrator': ensure=> present}" >> %LOGFILE%
puppet apply c:\vagrantshared\puppet\manifests\pup1389.pp >> %LOGFILE%

echo =============== >> %PUPPETAGENT_LOGFILE%
echo Puppet Agent    >> %PUPPETAGENT_LOGFILE%
echo =============== >> %PUPPETAGENT_LOGFILE%
puppet agent -td >>%PUPPETAGENT_LOGFILE%
