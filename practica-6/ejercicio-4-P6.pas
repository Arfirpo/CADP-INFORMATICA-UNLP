program ejercicio4P6;

type
  lista = ^nodo;

  nodo = record
    dato: integer;
    sig: lista;
  end;

{modulos}

//proceso original del ejercicio 1.
procedure armarNodo(var L: lista; v: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := v;
  aux^.sig := L;
  L := aux;
end;


//c. Modulo que recorre e imprime los valores de la lista.
procedure imprimirNodo(L: lista);
begin
    write('La lista contiene los siguientes valores: ');
  while L <> nil do
  begin
    write(L^.dato,' ');
    L := L^.sig;
  end;
  writeln();
end;

{4.a}
function maximo(l: lista):integer;
var
  max: integer;
begin
  max := l^.dato;
  while l <> nil do begin
    if l^.dato > max then
      max := l^.dato;
    l := l^.sig;
  end;
  maximo := max;
end;

{4.b}
function minimo(l: lista):integer;
var
  min: integer;
begin
  min := l^.dato;
  while l <> nil do begin
    if l^.dato < min then
      min := l^.dato;
    l := l^.sig;
  end;
  minimo := min;
end;

{4.c}
function cantMultiplos(l: lista; a: integer):integer;

  function esMultiplo(num,a: integer):boolean;
  var
    ok: boolean;
  begin
    if (num mod a = 0) then
      ok := true
    else 
      ok := false;
    esMultiplo := ok;      
  end;

var
  cant: integer;
begin
  cant := 0;
  while (l <> nil) do begin
    if (esMultiplo(l^.dato,a)) then
      cant := cant + 1;
      l := l^.sig;
  end;
  cantMultiplos := cant;
end;

{programa principal}

var
  pri,ult: lista;
  valor,max,min,multiplos: integer;
begin
  pri := nil;
  write('Ingrese un numero: ');
  read(valor);
  while(valor <> 0) do
  begin 
    armarNodo(pri,valor);
    write('Ingrese un numero: ');
    read(valor);
  end;
  imprimirNodo(pri);
  {ejercicio 4.a}
  max := maximo(pri);
  {ejercicio 4.b}
  min := minimo(pri);
  {ejercicio 4.c}
  write('Ingrese un numero: ');
  read(valor);
  multiplos := cantMultiplos(pri,valor);
  writeln('El numero mas grande de la lista es: ',max);
  writeln('El numero mas chico de la lista es: ',min);
  writeln('La cantidad de numeros de la lista que son multiplos de ',valor,' son: ',multiplos);
end.

{--------------------------------------------------------------------------------------------}

//version para pruebas automatizadas

program ejercicio4P6;

uses
  sysUtils;

type
  lista = ^nodo;

  nodo = record
    dato: integer;
    sig: lista;
  end;

{modulos}

//proceso original del ejercicio 1.
procedure armarNodo(var L: lista; v: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := v;
  aux^.sig := L;
  L := aux;
end;


//c. Modulo que recorre e imprime los valores de la lista.
procedure imprimirNodo(L: lista);
begin
    write('La lista contiene los siguientes valores: ');
  while L <> nil do
  begin
    write(L^.dato,' ');
    L := L^.sig;
  end;
  writeln();
end;

{4.a}
function maximo(l: lista):integer;
var
  max: integer;
begin
  max := l^.dato;
  while l <> nil do begin
    if l^.dato > max then
      max := l^.dato;
    l := l^.sig;
  end;
  maximo := max;
end;

{4.b}
function minimo(l: lista):integer;
var
  min: integer;
begin
  min := l^.dato;
  while l <> nil do begin
    if l^.dato < min then
      min := l^.dato;
    l := l^.sig;
  end;
  minimo := min;
end;

{4.c}
function cantMultiplos(l: lista; a: integer):integer;

  function esMultiplo(num,a: integer):boolean;
  var
    ok: boolean;
  begin
    if (num mod a = 0) then
      ok := true
    else 
      ok := false;
    esMultiplo := ok;      
  end;

var
  cant: integer;
begin
  cant := 0;
  while (l <> nil) do begin
    if (esMultiplo(l^.dato,a)) then
      cant := cant + 1;
      l := l^.sig;
  end;
  cantMultiplos := cant;
end;

{programa principal}

var
  pri,ult: lista;
  valor,max,min,multiplos: integer;
begin
  Randomize;
  pri := nil;
  valor := Random(101);
  while(valor <> 0) do
  begin 
    armarNodo(pri,valor);
    valor := Random(101);
  end;
  imprimirNodo(pri);
  {ejercicio 4.a}
  max := maximo(pri);
  {ejercicio 4.b}
  min := minimo(pri);
  {ejercicio 4.c}
  write('Ingrese un numero: ');
  valor := Random(101);
  multiplos := cantMultiplos(pri,valor);
  writeln('El numero mas grande de la lista es: ',max);
  writeln('El numero mas chico de la lista es: ',min);
  writeln('La cantidad de numeros de la lista que son multiplos de ',valor,' son: ',multiplos);
end.