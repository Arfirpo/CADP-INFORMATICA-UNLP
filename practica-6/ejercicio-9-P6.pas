// program ejercicio8P6;

// type
//   lista = ^nodo;

//   nodo = record
//     dato: integer;
//     sig: lista;
//   end;
// {modulos}

// //tomar este procedimiento de referencia.
// procedure armarNodo(var L: lista; v: integer);
// var
//   aux: lista;
// begin
//   new(aux);
//   aux^.dato := v;
//   aux^.sig := L;
//   L := aux;
// end;

// //procedimiento que verifica si la lista esta ordenada (en este caso, de forma ascendente).
// function estaOrdenada(l: Lista):boolean;
// var
//   ok: boolean;
//   ant,act: integer;
// begin
//   ok := true;
//   act := -9999;
//   while (l <> nil) and (ok) do begin
//     ant := act;
//     act := l^.dato;
//     if (ant > act) then
//       ok := false;
//     l := l^.sig;
//   end;
//   estaOrdenada := ok
// end;

// //bprocedimiento para buscar un elemento en una lista

// function buscar(l: lista):boolean;
// begin
  
// end;



// {c. Modulo que recorre e imprime los valores de la lista}
// procedure imprimirNodo(L: lista);
// begin
//   if (estaOrdenada(l)) then
//     write('La lista esta ordenada y contiene los siguientes valores: ');
//     while L <> nil do
//     begin
//       write(L^.dato,' ');
//       L := L^.sig;
//     end;
//     writeln();
//   else
//     write('La lista no esta ordenada y contiene los siguientes valores: ');
//     while L <> nil do
//     begin
//       write(L^.dato,' ');
//       L := L^.sig;
//     end;
//     writeln();
// end;


// {programa principal}

// var
//   pri: lista;
//   valor: integer;
// begin
//   pri := nil;
//   write('Ingrese un numero: ');
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

{version para pruebas automatizadas}

program ejercicio8P6;

uses
  sysUtils;

type
  lista = ^nodo;

  nodo = record
    dato: integer;
    sig: lista;
  end;

{ Módulos }

// Arma listas desordenadas (agregar adelante).
procedure armarNodo(var L: lista; v: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := v;
  aux^.sig := L;
  L := aux;
end;

// Arma listas ordenadas en forma ascendente.
procedure insertarOrdenado(var L: lista; v: integer);
var
  aux, ant, act: lista;
begin
  new(aux);
  aux^.dato := v;
  act := l;
  ant := l;
  while (act <> nil) and (v > act^.dato) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = l) then
    l := aux
  else
    ant^.sig := aux;
  aux^.sig := act;
end;

// Procedimiento que verifica si la lista está ordenada (en este caso, de forma ascendente).
function estaOrdenada(l: lista): boolean;
var
  ok: boolean;
  ant, act: integer;
begin
  ok := true;
  act := -9999;
  while (l <> nil) and (ok) do begin
    ant := act;
    act := l^.dato;
    if (ant > act) then
      ok := false;
    l := l^.sig;
  end;
  estaOrdenada := ok;
end;


function estaEnListaD(l: lista; v: integer): boolean;
var
  aux: lista;
  esta: boolean;
begin
  esta := false;
  aux := l;
  while ((aux <> nil) and (esta = false)) do begin
    if (aux^.dato = v) then
      esta := true;
    else
      aux := aux^.sig;
  end;
  buscar := esta;
end;

function estaEnListaO(l: lista; v: integer): boolean;
var
  aux: lista;
  esta: boolean;
begin
  esta := false;
  aux := l;
  while ((aux <> nil) and (aux^.dato < v)) do begin
    aux := aux^.sig;
  end;
  if (aux <> nil) and (aux^.dato = valor) then
    esta := true;
  buscar := esta;  
end;

//procedimiento que elimina el nodo (si el elemento puede o no existir en la lista).
procedure eliminarNodoA(var l: lista; v: integer; var eliminado: boolean);
var 
  ant, act: lista;
begin 
  eliminado := false;
  act := l;
  {Recorro mientras no se termine la lista y no encuentre el elemento}
  while  (act <> nil)  and (act^.dato <> v) do begin
      ant := act;
      act := act^.sig
  end;   
  if (act <> nil) then begin
    eliminado := true; 
    if (act = l) then  
      l := act^.sig;
    else  
      ant^.sig:= act^.sig;
    dispose (act);
  end;
end;

//procedimiento que elimina el nodo (si el elemento seguro existe).
Procedure eliminarNodoB (var l: lista; v: integer; var eliminado: boolean);
var 
  ant, act: lista;
begin 
  eliminado := false;
  act := l;
  {Recorro mientras no encuentre el elemento}
  while (act^.dato <> v) do begin   //NO HACE FALTA PREGUNTAR POR NIL 
      ant := act;
      act := act^.sig
  end;   
  //SI SALE DEL WHILE ES PORQUE YA LO ENCONTRÓ SEGURO
  eliminado := true; 
  if (act = l) then  
      l := act^.sig;
  else  
      ant^.sig:= act^.sig;
  dispose (act);
end;

// Módulo que recorre e imprime los valores de la lista.
procedure imprimirNodo(L: lista);
var
  aux: lista;
begin
  aux := L;  // Asignar la lista a aux para no perder el puntero original.
  if (estaOrdenada(aux)) then begin
    write('La lista esta ordenada y contiene los siguientes valores: ');
  end
  else begin
    write('La lista no esta ordenada y contiene los siguientes valores: ');
  end;
  while aux <> nil do
  begin
    write(aux^.dato, ' ');
    aux := aux^.sig;
  end;
  writeln();
end;

// Procedimiento para liberar memoria de la lista.
procedure liberarLista(var L: lista);
var
  aux: lista;
begin
  while L <> nil do
  begin
    aux := L;
    L := L^.sig;
    dispose(aux);
  end;
end;

{ Programa principal }

var
  pri: lista;
  valor: integer;
begin
  Randomize;
  pri := nil;
{  write('Elija un criterio de lista: 1.-desordenada / 2.- ordenada. : ');
  read(valor);
  while valor <> -1 do begin
    if (valor = 1) then begin
      valor := Random(21);
      while (valor <> 0) do
      begin
        armarNodo(pri, valor);
        valor := Random(21);
      end;
      imprimirNodo(pri);
      liberarLista(pri);
    end
    else if (valor = 2) then begin
      valor := Random(21);
      while (valor <> 0) do
      begin
        insertarOrdenado(pri, valor);
        valor := Random(21);
      end;
      imprimirNodo(pri);
      liberarLista(pri);
    end;
    writeln();
    write('Elija un criterio de lista: 1.-desordenada / 2.- ordenada. : ');
    read(valor);}
    valor := Random(21);
    while (valor <> 0) do
    begin
      insertarOrdenado(pri, valor);
      valor := Random(21);
    end;
    imprimirNodo(pri);

    
    valor := Random(21);
    eliminarNodo(pri,valor);
  end;
end.
