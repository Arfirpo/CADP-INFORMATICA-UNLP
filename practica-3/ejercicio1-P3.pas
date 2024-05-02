
Program ejercicio1P3;

Type 
  str20 = string[20];
  alumno = Record
    codigo: integer;
    nombre: str20;
    promedio: real;
  End;

Procedure leer(Var alu: alumno);
Begin
  write('Ingrese el codigo del alumno: ');
  readln(alu.codigo);
  If (alu.codigo <> 0) Then
    Begin
      write('Ingrese el nombre del alumno: ');
      readln(alu.nombre);
      write('Ingrese el promedio del alumno: ');
      readln(alu.promedio);
    End;
End;

Var 
  alu: alumno;
  cantAlu: integer;
Begin
  cantAlu := 0;
  leer(alu);
  While (alu.codigo <> 0) Do
    Begin
      cantAlu := cantAlu +1;
      leer(alu);
    End;
  write('La cantidad de alumnos leidos fue: ', cantAlu);
End.
