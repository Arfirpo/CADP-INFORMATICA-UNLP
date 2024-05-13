Program ejercicio6P4;

const
  corte = -1;
  dimF = 9;

Type
  rango = 0..dimF;
  vNum = array [rango] of integer;


procedure inicializarC(var c: vNum);
var
  i: integer;
begin
  for i := 1 to dimF do
    c[i] := 0;
end;

procedure descomponer(var c: vNum; num: integer);
Var
  resto: rango;
Begin
  while (num <> 0) do
    begin
      resto := num mod 10;
      c[resto] := c[resto] +1;
      num := num div 10;
    end;
end;

procedure informar(c: vNum);
Var
  i: rango;
begin
  for i := 0 to dimF do
    if c[i] > 1 then
      writeln('Numero ',i,': ',c[i],' veces.');
  write('Los digitos que no tuvieron ocurrencias son: ');
  for i := 0 to dimF do
    if c[i] = 0 then
      begin
        if i = 9 then
          write('',i,'.')
        else
          write('',i,', ');
      end;
end;

procedure procesarC(var c: vNum);
Var
  num: integer;
Begin
  write('Ingrese un numero: ');   
  read(num);         
  while (num <> corte) do   
    begin
      descomponer(c,num);
      write('Ingrese un numero: ');
      read(num);                      
    end;
  informar(c);
end;

{programa principal}
Var 
  num: integer;
  c: vNum;
Begin
  inicializarC(c);
  procesarC(c);
End.

