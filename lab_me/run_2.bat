nasm -fobj Rautoiu_Mircea_713_2_modul.asm
nasm -fobj Rautoiu_Mircea_713_2_function.asm
alink Rautoiu_Mircea_713_2_modul.obj Rautoiu_Mircea_713_2_function.obj -oPE -subsys console -entry start
Rautoiu_Mircea_713_2_modul.exe
pause