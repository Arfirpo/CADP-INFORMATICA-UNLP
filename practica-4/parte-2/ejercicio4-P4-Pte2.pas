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
    asis := Random(51) - 1; // Genera un número aleatorio entre -1 y 50
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

{ejercicio 4.a.}
function buscarAlu(a: vAlu; dimL: integer; valor: integer):integer;
var
  pos: integer;
begin
  pos := 1;
  while ((pos < dimL) and (a[pos].cod < valor)) do
  begin
    pos := pos +1;
  end;
  if ((pos > dimL) or (a[pos].cod <> valor)) then
    pos := 0;
  buscarAlu := pos;
end;

{ejercicio 4.b.}
Procedure InsertarElemOrd(var a:vAlu; var dimL:integer; alu:alumno; var exito:boolean);

  Procedure Insertar(var a:vAlu; var dimL:integer; pos: integer; alu: alumno);
    var
      j: indice;
    begin
      for j:= dimL downto pos do
        a [j+1] := a [j] ;
        a [pos] := alu;
        dimL := dimL+1;
    End;
var
  pos: integer;

Begin
  exito := false;
  if (dimL < dimF) then begin
    pos := buscarAlu(a,dimL,alu.cod);
    Insertar (a, dimL, pos, alu);
    exito := true;
  end;
end;

{ejercicio 4.c.}
Procedure BorrarPos (var a: vAlu; var dimL: integer; pos: integer; var exito: boolean );
var
  i: integer; 
begin
  exito := false;
  if (pos >=1 and pos <= dimL)then begin   //verifica que sea una posicion valida
    exito := true;
    for i:= pos+1 to dimL do  //hace el corrimiento para la izquierda
      a[i-1] := a[i];
    dimL := dimL-1 ;   //resta uno a la cant de elementos que tiene el vector
  end;
end;

{ejercicio 4.d.}
Procedure BorrarElem (var a: vAlu;  var dimL: integer; cod: integer; var exito: boolean);

  Procedure BorrarPosModif (var a: vAlu; var dimL:integer; pos:integer);
  var
    i: integer; 
  begin
    for i:=pos+1 to dimL  do
      a[i-1] := a[i];
    dimL := dimL-1;

var
  pos: integer;
Begin
  exito:= False;
  pos:= BuscarPosElem (a,dimL,cod);
  if pos <> 0 then begin
    BorrarPosModif(v,dimL,pos);
    exito:= true;
  end;
end;

{ejercicio 4.e.}
procedure BorrarPorAsis(var vector: vAlu; var dimL: integer; var verificador: boolean);
var
  pos: integer;
  asis: integer;
begin
  asis := 0;
  elim := false;
  pos := 1;
  while (pos <= dimL) do
  begin
    if (vector[pos].asis = asis) then
    {el codigo dentro de aca, puede ser un procedure "eliminar" aparte}
    begin
      if (pos >= 1) and (pos <= dimL) then
      begin
        for i := pos to (dimL - 1) do
          v[i] := v[i + 1];
        elim := true;
        dimL := dimL - 1;
      end;
    {----------------------------------------------------} 
      if elim then
      begin
        elim := false;        
      end
      else
        i := i + 1;
    end
    else
      i := i + 1;
  end;
end;

{ Programa principal }
var
  a: vAlu;
  alu: alumno;
  codigos: codUsados;
  dimL,cod: integer;
  i, posAlu,pos: integer;
  pude,exito: boolean;
begin
  Randomize;
  dimL := 0;
  inicializarCodigos(codigos);
  cargarV(a, dimL, codigos);

  {ejercicio 4 inciso a.}
  write('Ingrese codigo del alumno a buscar: ');
  readln(cod);
  posAlu := buscarAlu(a,dimL,cod);
  if posAlu <> 0 then
    writeln('El alumno buscado se encuentra en la posicion ',posAlu,' y su nombre es ',a[posAlu].nomYape);
  {ejercicio 4 inciso b.}
  leerAlu(alu,codigos);
  InsertarElemOrd(a,alu,dimL,pude);
  {ejercicio 4 inciso c.}
  write('Ingrese posicion: ');
  readln(pos);
  BorrarPos(a,dimL,pos,exito);
  {ejercicio 4 inciso d.}
  write('Ingrese codigo de Alumno: ');
  readln(cod);
  BorrarPorCod(a,dimL,cod,exito);
  {ejercicio 4 inciso e.}
  BorrarPorAsis(a,dimL,exito);
end.