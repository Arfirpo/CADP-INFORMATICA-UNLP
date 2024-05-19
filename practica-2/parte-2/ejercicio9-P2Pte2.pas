program ejercicio9;
{procedimiento que devuelve los dos apellidos de alumnos con numero de inscripción menor}
procedure apellidosMin(apellido: string; numInsc: integer; var apMin1,apMin2: string; var min1,min2: integer);
begin
  if(numInsc < min1) then
  begin
    min2 := min1;
    min1 := numInsc;
    apMin2 := apMin1;
    apMin1 := apellido;
  end
  else if(numInsc < min2) then 
  begin
    min2 := numInsc;
    apMin2 := apellido;
  end
end;
{procedimiento que devuelve los dos nombres de alumnos con numero de inscripcion mas grandes}
procedure nombresMax(nombre: string; numInsc: integer; var NomMax1,NomMax2: string; var max1,max2: integer);
begin
  if(numInsc > max1) then
  begin
    max2 := max1;
    max1 := numInsc;
    NomMax2 := NomMax1;
    NomMax1 := nombre;
  end
  else if(numInsc > max2) then 
  begin
    max2 := numInsc;
    NomMax2 := nombre;
  end
end;
procedure numInscPar(numInsc: integer; var cantAluPar: integer);
begin
  if(numInsc mod 2 = 0) then
    cantAluPar := cantAluPar +1;
end;
function porcAluPar(cantAlu,cantAluPar: integer): real;
begin
  porcAluPar := (cantAluPar / cantAlu)* 100;
end;
{programa principal}
var
  numInsc, min1, min2, max1, max2, cantAlu, cantAluPar: integer;
  nombre, apellido, apMin1, apMin2, NomMax1, NomMax2: string;
begin
    min1 := 9999;
    min2 := 9999;
    max1 := -9999;
    max2 := -9999;
    cantAlu := 0;
    cantAluPar := 0;
    apMin1 := '';
    apMin2 := '';
    NomMax1 := '';
    NomMax2 := '';
  repeat
    writeln ('Nombre: ');
    readln(nombre);
    writeln ('Apellido: ');
    readln(apellido);
    writeln ('Ingresa tu numero de inscripcion: ');
    readln(numInsc);
    cantAlu:= cantAlu +1;
    apellidosMin(apellido,numInsc,apMin1,apMin2,min1,min2);
    nombresMax(nombre,numInsc,NomMax1,NomMax2,max1,max2);
    numInscPar(numInsc,cantAluPar);
  until(numInsc = 1200);
  writeln('Los apellidos de los dos alumnos con numero de inscripcion mas bajos son: ', apMin1, ' y ', apMin2);
  writeln('Los nombres de los dos alumnos con los numeros de inscripcion mas grandes son: ', NomMax1, ' y ', NomMax2); 
  writeln('El porcentaje de alumnos con el numero de inscripción par es: ', porcAluPar(cantAlu,cantAluPar):0:2, '%');
end.