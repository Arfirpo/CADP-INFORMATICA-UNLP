program ejercicio8P6;

type
  lista = ^nodo;

  nodo = record
    dato: integer;
    sig: lista;
  end;

{modulos}

//procedimiento creador de nodos - agregar adelante.
procedure armarNodo(var L: lista; v: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := v;
  aux^.sig := L;
  L := aux;
end;

// procedimiento creador de nodos en forma ascendente - insertar ordenado.
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

// Procedimiento que elimina el nodo (si el elemento puede o no existir en la lista).
procedure eliminarNodoA(var l: lista; v: integer; var eliminado: boolean);
var 
  ant, act: lista;
begin 
  eliminado := false;
  act := l;
  ant := nil; // Inicializar ant para evitar posibles referencias no válidas.
  {Recorro mientras no se termine la lista y no encuentre el elemento}
  while  (act <> nil)  and (act^.dato <> v) do begin
      ant := act;
      act := act^.sig
  end;   
  if (act <> nil) then begin
    eliminado := true; 
    if (act = l) then  
      l := act^.sig
    else  
      ant^.sig:= act^.sig;
    dispose (act);
  end;
end;

// Procedimiento que elimina el nodo (si el elemento seguro existe).
procedure eliminarNodoB(var l: lista; v: integer; var eliminado: boolean);
var 
  ant, act: lista;
begin 
  eliminado := false;
  act := l;
  ant := nil; // Inicializar ant para evitar posibles referencias no válidas.
  {Recorro mientras no encuentre el elemento}
  while (act <> nil) and (act^.dato <> v) do begin   // Verificación adicional
      ant := act;
      act := act^.sig
  end;   
  // Si sale del while es porque ya lo encontró seguro
  if act <> nil then begin
    eliminado := true; 
    if (act = l) then  
        l := act^.sig
    else  
        ant^.sig := act^.sig;
    dispose (act);
  end;
end;

// Módulo que recorre e imprime los valores de la lista.
//En este caso le agregue la funcionalidad que avise si la lista esta ordenada.
procedure imprimirNodo(L: lista);
var
  aux: lista;
begin
  aux := L;  // Asignar la lista a aux para no perder el puntero original.
  if (estaOrdenada(aux)) then begin
    write('La lista está ordenada y contiene los siguientes valores: ');
  end
  else begin
    write('La lista no está ordenada y contiene los siguientes valores: ');
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

//ejercicio 9.c.- partiendo de la premisa que la lista "l" no esta ordenada.
function sublista(l: lista; a, b: integer): lista;
var
  aux, lista2: lista;
begin
  aux := l;
  lista2 := nil;
  
  while (aux <> nil) and (aux^.dato > a) do begin
    if (aux^.dato < b) then
      armarNodo(lista2, aux^.dato);
    aux := aux^.sig;
  end;
  sublista := lista2;
end;

//ejercicio 9.d.- partiendo de la premisa que la lista "l" esta ordenada en forma ascendente.
function sublistaAsc(l: lista; a, b: integer): lista;
var
  aux, lista2: lista;
begin
  aux := l;
  lista2 := nil;
  while (aux <> nil) do begin
    if (aux^.dato > a) and (aux^.dato < b) then
      armarNodo(lista2, aux^.dato);
    aux := aux^.sig;
  end;
  sublistaAsc := lista2;
end;

//ejercicio 9.e - partiendo de la premisa que la lista "l" esta ordenada en forma descendente.
function sublistaDesc(l: lista; a, b: integer): lista;
var
  aux, lista2: lista;
begin
  aux := l;
  lista2 := nil;
  
  while (aux <> nil) and (aux^.dato > a) do begin
    if (aux^.dato < b) then
      armarNodo(lista2, aux^.dato);
    aux := aux^.sig;
  end;
  
  sublistaDesc := lista2;
end;

{ Programa principal }
var
  pri, subL: lista;
  valor, a, b, tLista: integer;
  eliminado: boolean;
begin
  pri := nil; subL := nil;
  {Punto 9.a: módulo "estaOrdenada".}
  write('Elija un criterio de lista: 1.-desordenada / 2.- ordenada. : ');
  read(valor);
  while valor <> -1 do begin
    if (valor = 1) then begin
      write('Ingrese un valor: ');
      readln(valor);
      while (valor <> 0) do
      begin
        armarNodo(pri, valor);
        write('Ingrese un valor: ');
        readln(valor);
      end;
      imprimirNodo(pri);
      liberarLista(pri);
    end
    else if (valor = 2) then begin
      write('Ingrese un valor: ');
      readln(valor);
      while (valor <> 0) do
      begin
        insertarOrdenado(pri, valor);
        write('Ingrese un valor: ');
        readln(valor);
      end;
      imprimirNodo(pri);
      liberarLista(pri);
    end;
    writeln();
    write('Elija un criterio de lista: 1.-desordenada / 2.- ordenada. : ');
    read(valor);
  end;

  {Punto 9.b: módulo "eliminar".}

  // a.- Cargo la lista
  write('Ingrese un valor: ');
  readln(valor);
  while (valor <> 0) do
  begin
    insertarOrdenado(pri, valor);
    write('Ingrese un valor: ');
    readln(valor);
  end;
  // b.- Imprimo los valores de la lista original.
  imprimirNodo(pri);
  // c.- Elijo un valor random a eliminar.
  write('Ingrese un valor: ');
  readln(valor);
  // d.- Como el ejercicio me dice que el elemento puede no existir, llamo a eliminarNodoA.
  eliminarNodoA(pri, valor, eliminado);
  // e.- Vuelvo a imprimir el nodo para controlar si se eliminó el elemento.
  if (eliminado) then
    imprimirNodo(pri)
  else
    writeln('No se pudo eliminar el elemento seleccionado.');
  
  {Punto 9.c,d y e: módulos "sublista".}

  //establezco el rango de la sublista. desde a, hasta b.
  write('Ingrese un valor "a": ');
  readln(a);
  write('Ingrese un valor "b": ');
  readln(b);
  if b > a then begin
    //arme un case, para seleccionar el tipo de sublista según caso 1, 2 o 3.
    writeln('Tipo de sublista (1-2-3): ');
    read(tLista);
    case tLista of
      1:  subL := sublista(pri, a, b);
      2:  subL := sublistaAsc(pri, a, b);
      3:  subL := sublistaDesc(pri, a, b);
    end;
    writeln('Sublista generada entre ', a, ' y ', b, ':');
    imprimirNodo(subL);
  end;  
  liberarLista(subL);
  liberarLista(pri);
end.

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

// Procedimiento que elimina el nodo (si el elemento puede o no existir en la lista).
procedure eliminarNodoA(var l: lista; v: integer; var eliminado: boolean);
var 
  ant, act: lista;
begin 
  eliminado := false;
  act := l;
  ant := nil; // Inicializar ant para evitar posibles referencias no válidas.
  {Recorro mientras no se termine la lista y no encuentre el elemento}
  while  (act <> nil)  and (act^.dato <> v) do begin
      ant := act;
      act := act^.sig
  end;   
  if (act <> nil) then begin
    eliminado := true; 
    if (act = l) then  
      l := act^.sig
    else  
      ant^.sig:= act^.sig;
    dispose (act);
  end;
end;

// Procedimiento que elimina el nodo (si el elemento seguro existe).
procedure eliminarNodoB(var l: lista; v: integer; var eliminado: boolean);
var 
  ant, act: lista;
begin 
  eliminado := false;
  act := l;
  ant := nil; // Inicializar ant para evitar posibles referencias no válidas.
  {Recorro mientras no encuentre el elemento}
  while (act <> nil) and (act^.dato <> v) do begin   // Verificación adicional
      ant := act;
      act := act^.sig
  end;   
  // Si sale del while es porque ya lo encontró seguro
  if act <> nil then begin
    eliminado := true; 
    if (act = l) then  
        l := act^.sig
    else  
        ant^.sig := act^.sig;
    dispose (act);
  end;
end;

// Módulo que recorre e imprime los valores de la lista.
procedure imprimirNodo(L: lista);
var
  aux: lista;
begin
  aux := L;  // Asignar la lista a aux para no perder el puntero original.
  if (estaOrdenada(aux)) then begin
    write('La lista está ordenada y contiene los siguientes valores: ');
  end
  else begin
    write('La lista no está ordenada y contiene los siguientes valores: ');
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

//ejercicio 9.c.
function sublistaAsc(l: lista; a, b: integer): lista;
var
  aux, lista2: lista;
begin
  aux := l;
  lista2 := nil;
  while (aux <> nil) do begin
    if (aux^.dato > a) and (aux^.dato < b) then
      armarNodo(lista2, aux^.dato);
    aux := aux^.sig;
  end;
  sublistaAsc := lista2;
end;

//ejercicio 9.e - partiendo de la premisa que la lista "l" esta ordenada en forma descendente.
function sublistaDesc(l: lista; a, b: integer): lista;
var
  aux, lista2: lista;
begin
  aux := l;
  lista2 := nil;
  
  while (aux <> nil) and (aux^.dato > a) do begin
    if (aux^.dato < b) then
      armarNodo(lista2, aux^.dato);
    aux := aux^.sig;
  end;
  
  sublistaDesc := lista2;
end;

function sublista(l: lista; a, b: integer): lista;
var
  aux, lista2: lista;
begin
  aux := l;
  lista2 := nil;
  
  while (aux <> nil) and (aux^.dato > a) do begin
    if (aux^.dato < b) then
      armarNodo(lista2, aux^.dato);
    aux := aux^.sig;
  end;
  
  sublista := lista2;
end;


{ Programa principal }

var
  pri, subL: lista;
  valor, a, b, tLista: integer;
  eliminado: boolean;
begin
  Randomize;
  pri := nil; subL := nil;

  {Punto 9.a: módulo "estaOrdenada".}

  write('Elija un criterio de lista: 1.-desordenada / 2.- ordenada. : ');
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
    read(valor);
  end;

  {Punto 9.b: módulo "eliminar".}

  // a.- Cargo la lista
  valor := Random(21);
  while (valor <> 0) do
  begin
    insertarOrdenado(pri, valor);
    valor := Random(21);
  end;
  // b.- Imprimo los valores de la lista original.
  imprimirNodo(pri);
  // c.- Elijo un valor random a eliminar.
  valor := Random(21);
  // d.- Como el ejercicio me dice que el elemento puede no existir, llamo a eliminarNodoA.
  eliminarNodoA(pri, valor, eliminado);
  // e.- Vuelvo a imprimir el nodo para controlar si se eliminó el elemento.
  if (eliminado) then
    imprimirNodo(pri)
  else
    writeln('No se pudo eliminar el elemento seleccionado.');
  
  {Punto 9.c,d y e: módulos "sublista".}

  //establezco el rango de la sublista. desde a, hasta b.
  a := 5;
  b := 15;
  //arme un case, para seleccionar el tipo de sublista según caso 1, 2 o 3.
  writeln('Tipo de sublista (1-2-3): ');
  read(tLista);
  case tLista of
    1:  subL := sublista(pri, a, b);
    2:  subL := sublistaAsc(pri, a, b);
    3:  subL := sublistaDesc(pri, a, b);
  end;
  writeln('Sublista generada entre ', a, ' y ', b, ':');
  imprimirNodo(subL);
  liberarLista(subL);
  liberarLista(pri);
end.

