// program ejercicio8P6;

// type
//   lista = ^nodo;

//   nodo = record
//     dato: integer;
//     sig: lista;
//   end;

// {modulos}

// //modificar este procedimiento para insertar ordenado.
// procedure armarNodo(var L: lista; v: integer);
// var
//   aux: lista;
// begin
//   new(aux);
//   aux^.dato := v;
//   aux^.sig := L;
//   L := aux;
// end;

// //procedimiento armar nodo modificado.
// procedure insertarOrdenado(var L: lista; v: integer);
// var
//   aux: lista;
//   ant,act: lista;
// begin
//   new(aux);
//   aux^.dato := v;
//   act := l;
//   ant := l;
//   while (act <> nil) and (v > act^.dato) do begin
//     ant := act;
//     act := act^.sig;
//   end;
//   if (act = ant) then
//     l := aux;
//   aux^.sig := act;
// end;

// {c. Modulo que recorre e imprime los valores de la lista}
// procedure imprimirNodo(L: lista);
// begin
//     write('La lista contiene los siguientes valores: ');
//   while L <> nil do
//   begin
//     write(L^.dato,' ');
//     L := L^.sig;
//   end;
//   writeln();
// end;


// {programa principal}

// var
//   pri: lista;
//   valor: integer;
// begin
//   pri := nil;
//     write('Ingrese un numero: ');
//   read(valor);
//   while(valor <> 0) do
//   begin
//     armarNodo(pri,valor);
//     write('Ingrese un numero: ');
//     read(valor);
//   end;
//   imprimirNodo(pri);


// end.

{--------------------------------------------------------------------------------------------}

//version para pruebas automatizadas

program ejercicio8P6;

uses
  sysUtils;

type
  lista = ^nodo;

  nodo = record
    dato: integer;
    sig: lista;
  end;

{modulos}

//modificar este procedimiento para insertar ordenado.
procedure armarNodo(var L: lista; v: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := v;
  aux^.sig := L;
  L := aux;
end;

//procedimiento armar nodo modificado.
procedure insertarOrdenado(var L: lista; v: integer);
var
  aux: lista;
  ant,act: lista;
begin
  new(aux);
  aux^.dato := v;
  act := l;
  ant := l;
  while (act <> nil) and (v > act^.dato) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = ant) then
    l := aux;
  aux^.sig := act;
end;

{c. Modulo que recorre e imprime los valores de la lista}
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


{programa principal}

var
  pri: lista;
  valor: integer;
begin
  Randomize;
  pri := nil;
  valor := Random(51) -1;
  while(valor <> 0) do
  begin
    insertarOrdenado(pri,valor);
    valor := Random(51) -1;
  end;
  imprimirNodo(pri);
end.