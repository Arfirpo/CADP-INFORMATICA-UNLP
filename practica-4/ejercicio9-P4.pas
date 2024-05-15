program ejercicio9P4;

const
  dimF = 400;
  condCorte = -1;

{tipos de datos creados por el programador}
type
  str50 = string[50]; // subrango para acotar cadena de strings a 50 caracteres.
  rango = 1..dimF;
  alumnos = record // Registro que almacena nro de inscripción, dni, nombre, apellido y año de nacimiento del alumno.
    insc: integer;
    DNI: integer;
    nom: str50;
    ape: str50;
    aNac: integer;
  end;
  vAlu = array[rango] of alumnos; // Vector de tipo almumno, almacena el registro de cada alumno que se ingresa al sistema.

{modulos del programa}

procedure leerAlu(var a: alumnos);
begin
  write('Ingrese su nro. de DNI: ');
  readln(a.DNI);
  if (a.DNI <> condCorte) then
    begin
      write('Ingrese su nro. de inscripción: ');
      readln(a.insc);
      write('Ingrese su nombre: ');
      readln(a.nom);
      write('Ingrese su apellido: ');
      readln(a.ape);
      write('Ingrese el año de su nacimiento: ');
      readln(a.aNac);
    end;
end;

procedure cargarVector(var v: vAlu; var dimL: integer);
var
  a: alumnos;
begin
  leerAlu(a);
  while (a.DNI <> condCorte) and (dimL < dimF) do
  begin
    dimL := dimL +1;
    v[dimL] := a;
    leerAlu(a);
  end;
  writeln('Se termino de cargar el vector con exito.');
end;

procedure maxEdad(nom, ape: str50; aNac: integer; var min1, min2: integer; var minN1, minN2, minAp1, minAp2: str50);
begin
  if aNac < min1 then
  begin
    min2 := min1;
    minN2 := minN1;
    minAp2 := minAp1;
    min1 := aNac;
    minN1 := nom;
    minAp1 := ape;
  end
  else if aNac < min2 then
  begin
    min2 := aNac;
    minN2 := nom;
    minAp2 := ape;
  end;
end;

function cumpleDni(dni: integer): boolean;
var
  dig: integer;
  soloPares: boolean;
begin
  soloPares := true;
  while (dni <> 0) and (soloPares) do
  begin
    dig := dni mod 10;
    if (dig mod 2 <> 0) then
      soloPares := false;
    dni := dni div 10;
  end;
  cumpleDni := soloPares;
end;



procedure informar(porcAlu: real; minN1, minN2, minAp1, minAp2: str50);
begin
  writeln('El porcentaje de alumnos con DNI compuesto solo por dígitos pares es de: ', porcAlu:2:2, '%.');
  writeln('Alumnos de mayor edad inscriptos:');
  writeln('1. ', minN1, ' ', minAp1);
  writeln('2. ', minN2, ' ', minAp2);
end;



procedure procesarVector(v: vAlu; dimL: integer);
var
  cantDniPar, i, min1, min2: integer;
  minN1, minN2, minAp1, minAp2: str50;
  porcAlu: real;
begin
  porcAlu := 0;
  cantDniPar := 0;
  min1 := 9999;
  min2 := 9999;
  minN1 := '';
  minN2 := '';
  minAp1 := '';
  minAp2 := '';

  for i := 1 to dimL do
    begin
      if cumpleDni(v[i].DNI) then
        cantDniPar := cantDniPar + 1;
      maxEdad(v[i].nom, v[i].ape, v[i].aNac, min1, min2, minN1, minN2, minAp1, minAp2);
    end;
  porcAlu := (cantDniPar * 100) / dimF;
  informar(porcAlu, minN1, minN2, minAp1, minAp2);
end;

{Programa principal}
var
  v: vAlu;
  dimL: integer;
begin
  dimL := 0;
  cargarVector(v,dimL);
  procesarVector(v,dimL);
end.

