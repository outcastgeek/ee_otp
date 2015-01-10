@echo off
setlocal
set relxscript=%~f0
escript.exe "%relxscript:.cmd=%" %*


