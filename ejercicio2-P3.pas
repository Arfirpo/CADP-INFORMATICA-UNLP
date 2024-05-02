
Program ejercicio2P3;

Type 
  dias = 1..31;
  meses = 1..12;
  fechaCas = Record
    dia: dias;
    mes: meses;
    anio: integer;
  End;

Procedure leerFecha(Var casorio: fechaCas);
Begin
  write('Ingrese el anio del casamiento: ');
  readln(casorio.anio);
  If casorio.anio = 2019 Then
    Begin
      write('Ingrese el dia del casamiento: ');
      readln(casorio.dia);
      write('Ingrese el mes del casamiento: ');
      readln(casorio.mes);
    End;
End;

Var 
  casorio: fechaCas;
  cantVer,cant10d: integer;
Begin
  cantVer := 0;
  cant10d := 0;
  leerFecha(casorio);
  While casorio.anio <> 2020 Do
    Begin
      If casorio.mes <= 3 Then
        cantVer := cantVer +1;
      If casorio.dia <= 10 Then
        cant10d := cant10d + 1;
      leerFecha(casorio);
    End;
  writeln('La cantidad de casamientos celebrados durante el verano de 2019 fue: ', cantVer);
  writeln('La cantidad de casamientos celebrados durante los primeros 10 dias de cada mes en 2019 fue: ', cant10d);
End.
