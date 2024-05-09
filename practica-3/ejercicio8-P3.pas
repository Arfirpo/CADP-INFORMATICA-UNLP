Program ejercicio8P3;

{La Comision Provincial por la Memoria desea analizar la informacion de los proyectos presentados en el
programa Jovenes y Memoria durante la convocatoria 2020. 

Cada proyecto posee un codigo unico, un titulo, el docente coordinador (DNI, nombre y apellido, email), la cantidad de alumnos que participan del proyecto, el
nombre de la escuela y la localidad a la que pertenecen. 

Cada escuela puede presentar mas de un proyecto.

La informacion se ingresa ordenada consecutivamente por localidad y, para cada localidad, por escuela. 

Realizar un programa que lea la informacion de los proyectos hasta que se ingrese el proyecto con codigo -1 (que no
debe procesarse).

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
  end;
  {registro de proyectos}
  proyecto = Record
    cod: cod;
    part: integer;
    doc: coordinador;
    tit: str50;
    esc: str50;
    loc: str50;
  End;

{compara, entre centros, las dos con menos becarios
Procedure centMinBeca(nombre: str50; cantBec: integer; Var min1,min2: integer; Var minCentro1,minCentro2: str50);
Begin
  If cantBec < min1 Then
    Begin
      min2 := min1;
      minCentro2 := minCentro1;
      min1 := cantBec;
      minCentro1 := nombre;
    End
  else
    if cantBec < min2 Then
      Begin
        min2 := cantBec;
        minCentro2 := nombre;
      end;
End;

compara entre universidades y devuelve la universidad con más investigadores
Procedure uniMaxInvest(universidad: str50; cantInvest: integer; Var max1: integer; Var maxUni: str50);
Begin
  If cantInvest > max1 Then
    Begin
      max1 := cantInvest;
      maxUni := universidad;
    End
End;

lee por teclado los datos del registro: coordinador}

Procedure leerCoordinador(var c: coordinador);
Begin
  write('Ingrese el DNI del coordinador: ');
  readln(c.dni);
  write('Ingrese el nombre completo del coordinador: ');
  readln(c.nomYape);
  write('Ingrese el correo del coordinador: ');
  readln(c.email);
End;


{lee por teclado los datos del registro: proyecto}
Procedure leerProyecto(Var p: proyecto; var c: coordinador);
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

Var 
  p: proyecto; c: coordinador;
  escTot,escLoc: integer;
Begin
  // SECTOR 1- ACA VAN TODAS LAS VARIABLES QUE SE USAN PARA CONTABILIZAR LOS TOTALES ENTRE TODOS LOS DATOS LEIDOS
  escTot := 0;

  leerProyecto(p,c);

  While p.cod <> 0 Do
    Begin
      // SECTOR 2- ACA VAN TODAS LAS VARIABLES QUE SE DEBEN INICIALIZAR CUANDO CAMBIA DE LOCALIDAD (OSEA CUANDO TE PIDEN ALGO POR LOCALIDAD)
      escLoc := 0;
      localidad := p.loc; //corte de control x localidad


      // SECTOR 3- ACA SE VAN A ESTAR PROCESANDO TODOS LOS DATOS POR LOCALIDAD (EN ESTE CASO TODAS LAS ESCUELAS)
      While (p.loc = localidad) And (p.cod <> 0) Do
        Begin
          // SECTOR 4- ACA SE VAN A ESTAR PROCESANDO TODOS LOS DATOS POR ESCUELA (EN ESTE CASO CADA ESCUELA)
          escTot := escTot +1;
          escLoc := escLoc +1;
          escuela := p.esc; //corte de control x escuela
          While(p.esc = escuela) do
            begin

            end;
          // SECTOR 5- ACA VA TODO LO QUE ME PIDEN ACTUALIZAR O INFORMAR POR ESCUELA
          writeln();
        End;
      // SECTOR 6- ACA VA TODO LO QUE ME PIDEN ACTUALIZAR O INFORMAR POR LOCALIDAD
      writeln();
      uniMaxInvest(universidad,cantInvest,max1,maxUni);
    End;


  // SECTOR 7- ACA INFORMO TODO LO QUE ME PIDEN EN GENERAL Y SIN QUE DEPENDA DEL CORTE DE CONTROL DE LOCALIDAD
  writeln();
  writeln();
End.b