program ejercicio11P2Pte2;
procedure cumpleA(var cumpleA: boolean; var long: integer);
var
  c: char;
begin
  writeln('Ingrese la secuencia A:');
  readln(c);
  while((c <> '%') and (cumpleA)) do 
  begin
    long := long +1;
    if (c = '$') then
      cumpleA := false
    else begin
      writeln('Ingrese la secuencia A:');
      readln(c);  
    end;
  end;
end;

function cumpleB(longA,longB,cantArrobas: integer): boolean;
begin
  cumpleB := (longA = longB) and (cantArrobas >= 3);
end;
procedure contarB(var longB: integer; var cantArrobas: integer);
var
  c: char;
begin
  writeln('Ingrese la secuencia B:');
  readln(c);
  while (c <> '*') do 
  begin
    longB := longB + 1;
    if(c = '@') then
      cantArrobas := cantArrobas +1;
    writeln('Ingrese la secuencia B:');
    readln(c);
  end;
end;

var
  cumple: boolean;
  longA,longB,cantArrobas: integer;
begin
  cumple := true;
  longA := 0;
  longB := 0;
  cantArrobas := 0;
  cumpleA(cumple,longA);
  if cumple then 
  begin
    contarB(longB,cantArrobas);
    if (cumpleB(longA,longB,cantArrobas)) then
      writeln('Se cumple con la secuencia')
    else
      writeln('No se cumple con la secuencia B');
  end
  else
    writeln('No se cumple la secuencia A');
end.
------------------------------------------------------------------------------------

{version alternativa del ejercicio}
program ejercicio11P2Pte2;

function contarSecuencia(var long: integer; caracterFin: char; var cantArrobas: integer; contarArrobas: boolean): boolean;
var
  c: char;
begin
  writeln('Ingrese la secuencia:');
  readln(c);
  while (c <> caracterFin) do 
  begin
    if contarArrobas and (c = '@') then
      cantArrobas := cantArrobas + 1;
    long := long + 1;
    readln(c);
  end;
  contarSecuencia := c = caracterFin;
end;

function cumpleB(longA, longB, cantArrobas: integer): boolean;
begin
  cumpleB := (longA = longB) and (cantArrobas >= 3);
end;

var
  cumple: boolean;
  longA, longB, cantArrobas: integer;
begin
  cumple := true;
  longA := 0;
  longB := 0;
  cantArrobas := 0;

  cumple := contarSecuencia(longA, '%', cantArrobas, false);
  if cumple then 
  begin
    cumple := contarSecuencia(longB, '*', cantArrobas, true);
    if cumpleB(longA, longB, cantArrobas) then
      writeln('Se cumple con la secuencia')
    else
      writeln('No se cumple con la secuencia B');
  end
  else
    writeln('No se cumple la secuencia A');
end.
end;

var
  cumple: boolean;
  longA,longB,cantArrobas: integer;
begin
  cumple := true;
  longA := 0;
  longB := 0;
  cantArrobas := 0;
  cumpleA(cumple,longA);
  if cumple then 
  begin
    contarB(longB,cantArrobas);
    if (cumpleB(longA,longB,cantArrobas)) then
      writeln('Se cumple con la secuencia')
    else
      writeln('No se cumple con la secuencia B');
  end
  else
    writeln('No se cumple la secuencia A');
end.