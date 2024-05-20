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
  {imprimirV(a,dimL);}
end;


function buscarAlu(a: vAlu; dimL: integer; valor: integer):integer;
var
  pos: integer;
begin
  pos := 1;

  while ((pos < dimL) and (a[pos].cod < valor)) do
  begin
    pos := pos +1;
  end;
  if ((pos < dimL) and (a[pos].cod = valor)) then
    buscarAlu := pos
  else
    buscarAlu := -1;
end;

procedure insertarEnV(var a: vAlu; alu: alumno var dimL: integer; var pude: boolean);
var
  i: integer;
begin
  pude := false;
  if((dimL +1) < dimF) and (alu.cod > 1) and (alu.cod < dimL) then
  begin
    for i := dimL to alu.cod do
      a[i+1] := a[i];
    pude := true;
    a[alu.cod] := alu;
    dimL dimL +1;
  end;
end;

{ Programa principal }
var
  a: vAlu;
  alu: alumno;
  codigos: codUsados;
  dimL,cod: integer;
  i, posAlu: integer;
  pude: boolean;
begin
  Randomize;
  dimL := 0;
  inicializarCodigos(codigos);
  cargarV(a, dimL, codigos);

  {ejercicio 4 inciso a.}
  write('Ingrese codigo del alumno a buscar: ');
  readln(cod);
  posAlu := buscarAlu(a,dimL,cod);
  if posAlu <> -1 then
    writeln('El alumno buscado se encuentra en la posicion ',posAlu,' y su nombre es ',a[posAlu].nomYape);
  {ejercicio 4 inciso b.}
  leerAlu(alu,codigos);
  insertarEnV(a,alu,dimL,pude);
end.





