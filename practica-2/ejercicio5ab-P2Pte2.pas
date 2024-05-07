program ejercicio5aP2Pte2;

{procedimiento}
procedure esDobledeA(numA, numB: integer);
begin
  if(numB = (numA*2)) then
    write('El número ', numB, ' es el doble del numero ', numA)
  else
    write('El número ', numB, ' no es el doble del nummero ', numA);
end;

{programa principal}
var
  numA, numB: integer;
begin
  writeln('Ingrese un número entero: ');
  read(numA);
  writeln('Ingrese otro número entero: ');
  read(numB);
  esDobledeA (numA,numB)
end.

{si se quiere probar, hay que comentar el codigo que esta arriba}

program ejercicio5bP2Pte2;

{procedimiento}
procedure esDobledeA(numA, numB: integer);
var
  cantDoble, cantPar: integer;
begin
  cantPar := 0;
  cantDoble := 0;
  writeln('Ingrese un número entero: ');
  read(numA);
  writeln('Ingrese otro número entero: ');
  read(numB);
  while(numA <> 0) and (numB <> 0) do begin
    cantPar := cantPar +1;
    if(numB = (numA*2)) then
      cantDoble := cantDoble + 1;
    writeln('Ingrese un número entero: ');
    read(numA);
    writeln('Ingrese otro número entero: ');
    read(numB);
  end;
  write('La cantidad de pares leidos es de: ', cantPar, ' y la cantidad de pares donde el segundo numero es el doble del primero fue: ', cantDoble);
end;

{programa principal}
var
  numA, numB: integer;
begin
  esDobledeA (numA,numB);
end.