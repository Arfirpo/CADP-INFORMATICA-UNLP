Program ejercicio8P3;

Type 
  str50 = string[50];
  cod = -1..9999;
  {registro de coordinadores}
  coordinador = Record
    dni: str50;
    nomYape: str50;
    email: str50;
  end;
  {registro de proyectos}
  proyecto = Record
    codigo: cod;
    participantes: integer;
    docente: coordinador;
    titulo: str50;
    escuela: str50;
    localidad: str50;
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
      readln(p.codigo);
  If p.codigo <> -1 Then
    Begin
      write('Ingrese el titulo del proyecto: ');
      readln(p.titulo);
      write('Ingrese la localidad de la escuela: ');
      readln(p.localidad);
      write('Ingrese la escuela de los alumnos que participan: ');
      readln(p.escuela);
      write('Ingrese la cantidad de alumnos participantes: ');
      readln(p.participantes);
      leerCoordinador(c);
    End;
End;

Var 
  p: proyecto; c: coordinador;
Begin
  // SECTOR 1- ACA VAN TODAS LAS VARIABLES QUE SE USAN PARA CONTABILIZAR LOS TOTALES ENTRE TODOS LOS DATOS LEIDOS
  leerProyecto(p,c);
End.