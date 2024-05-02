
Program ejercicio3P3;

Const 
  escuelasProv = 2400;
  estandar = 23.435;

Type 
  codigo = 0000..2400;
  str30 = string[30];
  {registro de escuelas}
  establecimiento = Record
    cue: codigo;
    nombre: str30;
    docentes: integer;
    alumnos: integer;
    localidad: str30;
  End;

Function relacionDocAlu(doc,alu: integer): real;
Begin
  relacionDocAlu := alu / doc;
End;

Procedure leerEscuela(Var escuela: establecimiento);
Begin
  write('Ingrese el codigo unico de establecimiento (CUE): ');
  readln(escuela.cue);
  If escuela.cue <> 0 Then
    Begin
      write('Ingrese el nombre del establecimiento: ');
      readln(escuela.nombre);
      write('Ingrese la cantidad de docentes del establecimiento: ');
      readln(escuela.docentes);
      write('Ingrese la cantidad de alumnos del establecimiento: ');
      readln(escuela.alumnos);
      write('Ingrese la localidad del establecimiento: ');
      readln(escuela.localidad);
    End;
End;

Procedure mejorEstandar(cue: codigo; promEscuela: real; nombre: str30; Var min,min2: real; Var cue1,cue2: codigo; Var mejorRel1,mejorRel2: str30);
Begin
  If promEscuela < min Then
    Begin
      min2 := min;
      cue2 := cue1;
      mejorRel2 := mejorRel1;
      min := promEscuela;
      cue1 := cue;
      mejorRel1 := nombre;
    End
  Else
    If promEscuela < min2 Then
      Begin
        min2 := promEscuela;
        cue2 := cue;
        mejorRel2 := nombre;
      End;
End;

Var 
  escuela: establecimiento;
  mayorUnescoLp, i: integer;
  min,min2, promEscuela: real;
  cue1,cue2: codigo;
  mejorRel1,mejorRel2: str30;
Begin
  mayorUnescoLp := 0;
  min := 9999;
  min2 := 9999;
  cue1 := 0;
  cue2 := 0;
  mejorRel1 := '';
  mejorRel2 := '';
  For i:= 1 To escuelasProv Do
    Begin
      leerEscuela(escuela); {ingresas los datos de la escuela}
      promEscuela := relacionDocAlu(escuela.docentes,escuela.alumnos); {obtiene el promedio de alumnos por docente}
      mejorEstandar(escuela.cue,promEscuela,escuela.nombre, min,min2,cue1,cue2,mejorRel1,mejorRel2);
      {devuelve los datos de cue y nombre de las dos escuelas con mejor relacion alumnos-docentes}
      If ((escuela.localidad = 'la plata') And (promEscuela > estandar)) Then
        {si la esucela es de localidad 'la plata' y su relacion alumnos-docentes supera el estandar UNESCO, suma 1 al contador}
        mayorUnescoLp := mayorUnescoLp +1;
    End;
  writeln(mayorUnescoLp,' escuelas primarias de La Plata superan la relacion alumnos-docente recomendada por la UNESCO');
  writeln('El colegio ', mejorRel1, ' codigo: ', cue1,' fue el que mejor relacion alumnos-docente obtuvo');
  writeln('El colegio ', mejorRel2, ' codigo: ', cue2,' fue el que obtuvo la segunda mejor relacion alumnos-docente');
End.
