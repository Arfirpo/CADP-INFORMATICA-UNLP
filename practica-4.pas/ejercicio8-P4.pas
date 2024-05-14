Program ejercicio8P4;

const
  dimF = 5;         


{tipos de datos creados por el programador}
Type
  str50 = string[50];                    //subrango pra acotar cadena de strings a 50 caracteres.
  alumnos = record                      //Registro que almacena nro de inscripción, dni, nombre, apellido y año de nacimiento del alumno.
    insc: integer;
    DNI: integer;
    nom: str50;
    ape: str50;
    aNac: integer;
  end;
  vAlu = array[1..dimF] of alumnos;       //Vector de tipo almumno, almacena el registro de cada alumno que se ingresa al sistema.

{modulos del programa}
//procesarDni(dni: integer;1);
//maxEdad()


function cumpleDni(dni: integer):boolean;         //esta funcion evalua que cada digito del dni sea par, devuelve true si todos son pares y false si alguno es impar.
var
  digito: integer;
begin
  cumpleDni := true;
  digito := dni mod 10;
  while (cumpleDni) and (digito <> 0) do
    begin
      if (digito mod 2 <> 0) then
        cumpleDni := false
      else
        cumpleDni := true;
        digito := dni div 10;
    end;  
end;

{Procedimiento que calcula, en base al año de nacimiento del alumno, los dos alumnos de mayor edad.
Teniendo en cuenta que, a menor sea el numero de año de nacimiento, mayor es la edad de la persona, calculamos los minimos y obtenemos
los alumnos de mayor edad}
procedure maxEdad(nom,ape: str50; aNac: integer; var min1,min2: integer; var minN1,minN2,minAp1,MinAp2: str50);
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

procedure leerAlu(var a: alumnos);    //proceso que carga, leyendo por teclado, los campos del registro alumnos.
begin
  write('Ingrese su nro. de inscripción: ');
  readln(a.insc);
  write('Ingrese su nro. de DNI: ');
  readln(a.DNI);
  write('Ingrese su nombre: ');
  readln(a.nom);
  write('Ingrese su apellido: ');
  readln(a.ape);
  write('Ingrese el año de su nacimiento: ');
  readln(a.aNac);
end;

procedure informar(porcAlu: real; minN1,minN2,minAp1,minAp2: str50);
begin
  writeln('El porcentaje de alumnos con dni compuesto solo por digitos pares es de: ',porcAlu,'%.');
  writeln('Alumnos de mayor edad inscriptos:');
  writeln('1. ',minN1,'',minAp1);
  writeln('2. ',minN2,'',minAp2);
end;


procedure cargarVector(var v: vAlu);    //el proceso cargarVector recibe un array vacio, una dimensión logica y un registro vacio.
var
  i: integer;
  a: alumnos;
begin
  for i := 1 to dimF do         //como voy a procesar el total de alumnos, conozco la cantidad exacta de datos del vector, y lo cargo con una estructura for.
    leerAlu(a);
    v[i] := a;
  writeln('Se termino de cargar el vector con exito.')
end;

procedure procesarVector(v: vAlu; var porcAlu: real);
var
  cantDniPar,i,min1,min2: integer;
  minN1,minN2,minAp1,MinAp2: str50;
begin
  cantDniPar := 0; min1 := 9999; min2 := 9999;
  minN1:= ''; minN2 := ''; minAp1 := ''; MinAp2 := '';
  for i := 1 to dimF do
    begin
        if (cumpleDni(v[i].DNI)) then     //si la función devuelve true, se suma 1 al contador de alumnos con dni totalmente con dig, pares.
          cantDniPar := cantDniPar +1;
        maxEdad(v[i].nom,v[i].ape,v[i].aNac,min1,min2,minN1,minN2,minAp1,MinAp2);
    end;
    porcAlu := (cantDniPar / dimF) * 100; //se almacena en la variable porcAlu el resultado de dividir la cantidad de alumnos con dni par, por la cantidad total de alumnos.
    informar(porcAlu,minN1,minN2,minAp1,minAp2);
end;

{Programa principal}
  var
    v: vAlu;
    porcAlu: real;
  begin
  porcAlu := 0;
    cargarVector(v);
    procesarVector(v,porcAlu);
  end.
