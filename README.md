Nota: Si imprime las expresiones, el unico problema es que imprimira la ultima operacion hecha. 
ejem: (1+1)*2=
salida: 2 * 2 = 4

Comandos:
flex calc.l
bison -dy calc.y
gcc lex.yy.c y.tab.c -o calculadora -lm
./calculadora < texto.txt
