program ejercicio7B;
procedure procDeDig (num:integer; var cantDig, sumaDig:integer);
var digito:integer;
begin while (num <> 0) do 
  begin 
    cantDig := cantDig + 1;
    digito:= num mod 10;
    sumaDig:= sumaDig + digito;
    num:= num div 10;
  end
end;
var
  num, cantDig,sumaDig: integer;
begin
  cantDig := 0;
  repeat
    sumaDig := 0;
    writeln('Ingrese un numero entero: ');
    readln(num);
    procDeDig(num,cantDig,sumaDig);
  until(sumaDig = 10);
  write('La cantidad de digitos leidos fue: ',cantDig);
end.