program ejercicio1P4Pte2;

uses
  SysUtils;

const
  dimF =  500;

  type
    rango = 1..dimF;
    vEnteros = array [rango] of integer;

{modulos}

//funcion para buscar un elemento en vector desordenado. 
function estaEnV(e: vEnteros; dimL,n: integer):boolean;
var
  pos: integer;
  ok: boolean;
begin
  pos := 1;
  ok := false;
  while (pos < dimL) and (not ok) do
    begin
      if n = e[pos] then
        ok := true
      else
        i := pos +1;
    end;
  estaEnV := ok;
end;


procedure imprimirVector(e: vEnteros; dimL: integer);
var
  i: integer;
begin
  write('El vector contiene ',dimL,' numeros: ');
  for i := 1 to dimL do
    if e[i] <> dimL then
      write(e[i],' ')
    else
      write(e[i],'.');
end;

procedure cargarV(var e: vEnteros; var dimL: integer);
var
  num: integer;
begin
  num := Random(100);
  while (dimL < dimF) and (num <> 0) do
    begin
      diml := dimL +1;
      e[dimL] := num;      
      num := Random(100);
    end;
  imprimirVector(e,dimL);
end;

{programa principal}

var
  e: vEnteros;
  dimL,n: integer;
  cumple: boolean;
begin
  Randomize;
  dimL := 0;
  cargarV(e,dimL);
  writeln();
  n := Random(100);
  writeln('¿El numero ',n,' se encuentra en el vector?');
  cumple := estaEnV(e,dimL,n);
  if cumple then
    write(n,' Se encuentra en el vector')
  else
    write(n,' No se encuentra en el vector');
end.

{--------------------------------------------------------------------}

program ejercicio1bP4Pte2;

uses
  SysUtils;

const
  dimF =  500;
  corte = 50;

  type
    rango = 1..dimF;
    vEnteros = array [rango] of integer;

{modulos}

//funcion para buscar un elemento en vector ordenado, busqueda dicotomica.
function estaEnV(e: vEnteros; dimL,n: integer):boolean;
var
  inf,sup,med: integer;
  ok: boolean;
begin
  ok := false;
  inf := 1; sup := dimL; med := (inf + sup) div 2;
  while (inf <= sup) and (n <> e[med]) do
    begin
      if n < e[med] then
        sup := med -1
      else
        inf := med +1;
      med := (inf + sup) div 2;
    end;
  if(inf <= sup) and(n = e[med]) then
    ok := true;
  estaEnV := ok;
end;


procedure imprimirVector(e: vEnteros; dimL: integer);
var
  i: integer;
begin
  write('El vector contiene ',dimL,' numeros: ');
  for i := 1 to dimL do
    if e[i] <> dimL then
      write(e[i],' ')
    else
      write(e[i],'.');
end;

procedure cargarV(var e: vEnteros; var dimL: integer);
var
  num: integer;
begin
  num := 1;
  while (dimL < dimF) and (num <> corte) do
    begin
      diml := dimL +1;
      e[dimL] := num;      
      num := num + 1;
    end;
  imprimirVector(e,dimL);
end;

{programa principal}

var
  e: vEnteros;
  dimL,n: integer;
  cumple: boolean;
begin
  Randomize;
  dimL := 0;
  cargarV(e,dimL);
  writeln();
  n := Random(100);
  writeln('¿El numero ',n,' se encuentra en el vector?');
  cumple := estaEnV(e,dimL,n);
  if cumple then
    write(n,' Se encuentra en el vector')
  else
    write(n,' No se encuentra en el vector');
end.