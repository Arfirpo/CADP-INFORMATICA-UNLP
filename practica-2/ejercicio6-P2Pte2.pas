program ejercicio6;
{modulo que devuelve los codigos de los dos productos mas baratos}
procedure prodMasBar(tipo: string; cod: integer; precio: real; var codMin1: integer; var codMin2: integer; var min1: real; var min2: real);
begin
  if precio < min1 then 
  begin
    min2 := min1;
    min1 := precio;
    codMin2 := codMin1;
    codMin1 := cod;
  end
  else if(precio < min2) then
  begin
      min2 := precio;
      codMin2 := cod;
  end;
end;
{funcion que devuelve el codigo del pantalon mas caro}
function pantMasCaro(cod: integer; precio: real; max1: real): integer;
begin
  if(precio > max1) then begin
    max1 := precio;
    pantMasCaro := cod;
  end;
end;
{funcion que devuelve el promedio de precio de los productos leidos}
function precioPromedio(i: integer; precioTot: real): real;
begin
  precioPromedio := precioTot / i;
end;

{modulo principal que lee y trabaja los productos}
procedure leerProd(i: integer; var min1, min2, max1, precProm, precioTot: real; var codMin1, codMin2, codPantMax: integer);
var
  tipo: string;
  cod: integer;
  precio: real;
begin
  writeln('Ingrese el tipo del producto ',i, ': ');
  readln(tipo);
  writeln('Ingrese el codigo del producto ',i, ': ');
  readln(cod);
  writeln('Ingrese el precio del producto ',i, ': ');
  readln(precio);
  prodMasBar(tipo,cod,precio,codMin1,codMin2,min1,min2);
  if(tipo = 'pantalon') then
    codPantMax := pantMasCaro(cod,precio,max1); {igualo variable con funcion que devuelve el codigo del pantalon mas caro}
  precioTot := precioTot + precio;
end;
{programa principal}
var
  i, codMin1, codMin2, codPantMax: integer;
  precProm, precioTot, min1, min2, max1: real;
begin
  min1 := 9999;
  min2 := 9999;
  max1 := -1.00;
  codMin1 := 0;
  codMin2 := 0;
  codPantMax := 0;
  precioTot := 0;
  for i:= 1 to 3 do
    leerProd(i,min1,min2,max1,precProm,precioTot,codMin1,codMin2,codPantMax);
  {respuestas}
  writeln('Los codigos de los dos productos mas baratos son: ', codMin1, ' y ', codMin2);
  writeln('El pantalon mas caro fue el de codigo: ', codPantMax);
  writeln('El valor promedio de los productos leidos fue de: ', precioPromedio(i, precioTot):0:2);
end.