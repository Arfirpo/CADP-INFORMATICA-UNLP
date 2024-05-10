
Program ejercicio8P3;


{La Comision Provincial por la Memoria desea analizar la informacion de los proyectos presentados en el
programa Jovenes y Memoria durante la convocatoria 2020. 

Cada proyecto posee un codigo unico, un titulo, el docente coordinador (DNI, nombre y apellido, email), la cantidad de alumnos que participan del proyecto, el
nombre de la escuela y la localidad a la que pertenecen. 

Cada escuela puede presentar mas de un proyecto.

La informacion se ingresa ordenada consecutivamente por localidad y, para cada localidad, por escuela. 

Realizar un programa que lea la informacion de los proyectos hasta que se ingrese el proyecto con codigo -1 (que no debe procesarse).

informe:

a) Cantidad total de escuelas que participan en la convocatoria 2018 y cantidad de escuelas por cada localidad.
b) Nombres de las dos escuelas con mayor cantidad de alumnos participantes.
c) Titulo de los proyectos de la localidad de Daireaux cuyo codigo posee igual cantidad de digitos pares e impares.}

Type 
  str50 = string[50];
  cdg = -1..9999;
  {registro de coordinadores}
  coordinador = Record
    dni: str50;
    nomYape: str50;
    email: str50;
  End;
  {registro de proyectos}
  proyecto = Record
    cod: cdg;
    part: integer;
    doc: coordinador;
    tit: str50;
    esc: str50;
    loc: str50;
  End;


{compara, entre escuelas, las dos con mas alumnos participantes de proyectos}
Procedure escMaxAlu(escuela: str50; alumnos: integer; Var max1,max2: integer; Var escMax1,escMax2: str50);
Begin

  If alumnos > max1 Then
    Begin
      max2 := max1;
      escMax2 := escMax1;
      max1 := alumnos;
      escMax1 := escuela;
    End
  else
    if alumnos > max2 Then
      Begin
        max2 := alumnos;
        escMax2 := escuela;
      end;
End;

{analiza cada digito del codigo de un proyecto y cuenta cuantos digitos pares e impares tiene}
Procedure procDig(titulo: str50; codigo: cdg);
var
  digPar,digImp, digito: integer;
Begin
digPar := 0; digImp := 0;
while digito <> 0 do
  begin
    digito := codigo mod 10;
    if ((digito mod 2) = 0 ) then
      digPar := digPar +1;
    else
      digImp := digImp +1;
    digito := codigo div 10;
  end;
if digPar = digImp then
  writeln(titulo,' posee un codigo con misma cantidad de digitos pares e impares')
End;

{lee por teclado los datos del registro: coordinador}
Procedure leerCoordinador(Var c: coordinador);
Begin
  write('Ingrese el DNI del coordinador: ');
  readln(c.dni);
  write('Ingrese el nombre completo del coordinador: ');
  readln(c.nomYape);
  write('Ingrese el correo del coordinador: ');
  readln(c.email);
End;


{lee por teclado los datos del registro: proyecto}
Procedure leerProyecto(Var p: proyecto; Var c: coordinador);
Begin
  write('Ingrese el codigo del proyecto: ');
  readln(p.cod);
  If p.codigo <> -1 Then
    Begin
      write('Ingrese el titulo del proyecto: ');
      readln(p.tit);
      write('Ingrese la localidad de la escuela: ');
      readln(p.loc);
      write('Ingrese la escuela de los alumnos que participan: ');
      readln(p.esc);
      write('Ingrese la cantidad de alumnos participantes: ');
      readln(p.part);
      leerCoordinador(c);
    End;
End;


{programa principal}

Var 
  p: proyecto; c: coordinador;
  escTot,escLoc,cantAlu,max1,max2: integer;
  escuela,localidad,escMax1,escMax2: str50;
Begin
  // SECTOR 1- ACA VAN TODAS LAS VARIABLES QUE SE USAN PARA CONTABILIZAR LOS TOTALES ENTRE TODOS LOS DATOS LEIDOS
  escTot := 0; max1 := 0; max2 := 0;
  escMax1 := ''; escMax2 := '';
  leerProyecto(p,c);

  While p.cod <> 0 Do
    Begin
      // SECTOR 2- ACA VAN TODAS LAS VARIABLES QUE SE DEBEN INICIALIZAR CUANDO CAMBIA DE LOCALIDAD (OSEA CUANDO TE PIDEN ALGO POR LOCALIDAD)
      escLoc := 0;
      localidad := p.loc;
      //corte de control x localidad
      // SECTOR 3- ACA SE VAN A ESTAR PROCESANDO TODOS LOS DATOS POR LOCALIDAD (EN ESTE CASO TODAS LAS ESCUELAS)
      While (p.loc = localidad) And (p.cod <> 0) Do
        Begin
          // SECTOR 4- ACA SE VAN A ESTAR PROCESANDO TODOS LOS DATOS POR ESCUELA (EN ESTE CASO CADA ESCUELA)
          escTot := escTot +1;
          escLoc := escLoc +1;
          cantAlu := 0;
          escuela := p.esc; //corte de control x escuela
          if p.loc = 'daireaux' then
            procDig(p.tit,p.cod);
          While (p.esc = escuela) And (p.cod <> 0) Do
            Begin
              cantAlu := cantAlu + p.part;
              leerProyecto(p,c);
            End;
          // SECTOR 5- ACA VA TODO LO QUE ME PIDEN ACTUALIZAR O INFORMAR POR ESCUELA
          escMaxAlu(escuela,cantAlu,max1,max2,escMax1,escMax2);
        End;
      // SECTOR 6- ACA VA TODO LO QUE ME PIDEN ACTUALIZAR O INFORMAR POR LOCALIDAD
      writeln('La localidad ',localidad,' tiene ',escLoc,' escuelas');
    End;

  // SECTOR 7- ACA INFORMO TODO LO QUE ME PIDEN EN GENERAL Y SIN QUE DEPENDA DEL CORTE DE CONTROL DE LOCALIDAD
  writeln(escTot,' escuelas presentaron proyectos en el año 2020');
  writeln('Las dos escuelas con mayor numero de alumnos participantes fueron: 1.',escMax1,' 2.',escMax2);
End.