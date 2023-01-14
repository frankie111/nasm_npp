nasm -fobj Toader_Cristian_3_modul.asm
nasm -fobj Toader_Cristian_3_function.asm
alink Toader_Cristian_3_modul.obj Toader_Cristian_3_function.obj -oPE -subsys console -entry start
Toader_Cristian_3_modul.exe
pause