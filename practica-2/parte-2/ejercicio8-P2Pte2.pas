program ejercicio8;
const 
  condicion = 123456;
procedure analizarParImpar(num: integer; var sumDigPar,cantDigImpar: integer);
var
  digito, digPar: integer;
begin
  while(num <> 0) do
  begin
    digito := num mod 10;
    if(digito mod 2 = 0) then
    begin
      digPar := digito;
      sumDigPar := sumDigPar + digPar;
    end
    else
      cantDigImpar := cantDigImpar +1;
    num := num div 10;
  end
end;
procedure procesarDig(num: integer);
var
  sumDigPar, cantDigImpar: integer;
begin
  sumDigPar := 0;
  cantDigImpar := 0;
  analizarParImpar(num,sumDigPar,cantDigImpar);
  writeln('La suma de los digitos pares del numero procesado fue: ', sumDigPar);
  writeln('La cantidad de digitos impares del numero procesado fue: ', cantDigImpar);  
end;
var
  num: integer;
begin
  writeln('Ingrese un numero entero (para finalizar escriba: 123456): ');
  readln(num);
  while(num <> condicion) do
  begin
    procesarDig(num);
    writeln('Ingrese un numero entero (para finalizar escriba: 123456): ');
    readln(num);
  end
end.