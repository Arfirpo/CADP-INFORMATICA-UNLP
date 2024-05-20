program ejercicio4P4Pte2;

uses
  SysUtils;

const
  dimF = 10;

type
  rAlu = 1..dimF;
  str30 = string[30];

  alumno = record
    cod: integer;
    nomYape: str30;
    asis: integer;
  end;

  vAlu = array[rAlu] of alumno;
  codUsados = array[1..dimF] of boolean;

{ Modulos }

procedure randomString(StringLen: integer; var palabra: str30);
var
  str: string;
  Result: str30;
begin
  str := 'abcdefghijklmnopqrstuvwxyz';
  Result := '';
  repeat
    Result := Result + str[Random(Length(str)) + 1];
  until Length(Result) = StringLen;
  palabra := Result;
end;

procedure inicializarCodigos(var codigos: codUsados);
var
  i: integer;
begin
  for i := 1 to dimF do
    codigos[i] := False;
end;

procedure leerAlu(var alu: alumno; var codigos: codUsados);
begin
  with alu do
  begin
    repeat
      cod := Random(dimF) +1; // Asegura que el código esté entre 1 y 1000
    until not codigos[cod];
    codigos[cod] := True;
    randomString(10, nomYape);
    asis := Random(50) + 1; // Genera un número aleatorio entre 1 y 50
  end;
end;

procedure insertarOrdenado(var a: vAlu; var dimL: integer; alu: alumno);
var
  i, j: integer;
begin
  if dimL < dimF then
  begin
    i := dimL;
    while (i > 0) and (a[i].cod > alu.cod) do
    begin
      a[i + 1] := a[i];
      i := i - 1;
    end;
    a[i + 1] := alu;
    dimL := dimL + 1;
  end;
end;

procedure cargarV(var a: vAlu; var dimL: integer; var codigos: codUsados);
var
  alu: alumno;
begin
  while (dimL < dimF) do
  begin
    leerAlu(alu, codigos);
    if (alu.cod >= 1) and (alu.cod <= dimF) then
    begin
      insertarOrdenado(a, dimL, alu);
    end;
  end;
end;

procedure imprimirV(a: vAlu; dimL: integer);
var
  i: integer;
begin
    for i := 1 to dimL do
    begin
      writeln('Codigo: ', a[i].cod);
      writeln('Nombre y Apellido: ', a[i].nomYape);
      writeln('Alumno ', i);
      writeln('Asistencias: ', a[i].asis);
      writeln('--------------------------');
    end;
end;

function buscarAlu(a: vAlu; dimL: integer):integer;
var
  i,cod,inf,med,sup: integer;
begin
  write('Ingrese codigo del alumno: ');
  readln(cod);
  inf := 1; sup := dimL; med := (inf + sup div 2);
  if cod >= 1 and cod <= dimF then
    for i := 1 to dimL do
    begin
      
    end;

end;

{ Programa principal }
var
  a: vAlu;
  codigos: codUsados;
  dimL: integer;
  i, posAlu: integer;
begin
  Randomize;
  dimL := 0;
  inicializarCodigos(codigos);
  cargarV(a, dimL, codigos);
  {imprimirV(a,dimL);}
  posAlu := buscarAlu(a,dimL);
end.





