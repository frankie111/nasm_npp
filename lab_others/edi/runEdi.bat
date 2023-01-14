nasm -fobj modul.asm
nasm -fobj function.asm
alink modul.obj function.obj -oPE -subsys console -entry start
modul.exe
pause