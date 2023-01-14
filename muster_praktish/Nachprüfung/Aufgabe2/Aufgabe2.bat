nasm -fobj Aufgabe2.asm
nasm -fobj read_list.asm
nasm -fobj print_list.asm
nasm -fobj max_list.asm
nasm -fobj average_list.asm
alink Aufgabe2.obj read_list.obj print_list.obj max_list.obj average_list.obj -oPE -subsys console -entry start
Aufgabe2.exe
pause