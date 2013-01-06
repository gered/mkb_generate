@echo off
for %%X in (bash.exe) do (set FOUND=%%~$PATH:X)
if not defined FOUND (
echo BASH not found in your path. Do you have Cygwin or MSYS installed?
exit /b
)

bash --login %CD%/mkb_generate
