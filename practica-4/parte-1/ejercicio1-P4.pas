Program ejercicio1P4;

const
  dimL = 10;

Type 
  vNums = array [1..10] of integer;
  
procedure imprimir(numeros: vNums);
Var
  i: integer;
Begin
  for i := 1 to dimL do
    write(numeros[i],' ');
end;

Var 
  numeros: vNums;
  i: integer;
Begin
  for i:= 1 to dimL do
    numeros[i] := i;
  imprimir(numeros);
  for i:=1 to 9 do 
    numeros[i+1] := numeros[i];
  writeln('');
  imprimir(numeros);
End.


{a. ¿Qué valores toma la variable numeros al finalizar el primer bloque for?
Respuesta: 1 2 3 4 5 6 7 8 9 10.

b. Al terminar el programa, ¿con qué valores finaliza la variable números?
Respuesta: 1 3 6 10 15 21 28 36 45 55.

c. Si se desea cambiar la línea 11 por la sentencia: "for i:=1 to 9 do"
¿Cómo debe modificarse el código para que la variable números contenga los mismos valores que en 1.b?
Respuesta: "numeros[i+1] := numeros[i+1] + numeros[i]";

d. Qué valores están contenidos en la variable numeros si la líneas 11 y 12 se reemplazan por: 
  for i:=1 to 9 do numeros[i+1] := numeros[i];
Respuesta: 1 1 1 1 1 1 1 1 1 1.
}