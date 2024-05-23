program ejercicio3P6;

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

//3.a - proceso modificado para agregar nodo al final.
procedure agregarAlFinal(var L: lista; v: integer);
var
  nue,aux: lista;
begin
  new(nue);
  nue^.dato := v;
  nue^.sig := nil;
  if (L = nil) then
    L := nue
  else
  begin
    aux := L;
    while (aux^.sig <> nil) do
      aux := aux^.sig;
    aux^.sig := nue;
  end;
end;

//3.b - proceso modificado para agregar nodo atras manteniendo un puntero al ultimo ingresado.
procedure agregarAlFinal2(var pri,ult: lista; v: integer);
var
  nue: lista;
begin
  new(nue);
  nue^.dato := v;
  nue^.sig := nil;
  if (pri = nil) then
  begin
    pri := nue;
    ult := nue;
  end
  else
  begin
    ult^.sig := nue;
    ult := nue;
  end;
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

{programa principal}

var
  pri,ult: lista;
  valor: integer;
begin
  pri := nil;
  ult := nil;
  write('Ingrese un numero: ');
  read(valor);
  while(valor <> 0) do
  begin                             //descomentar el proceso que se quiera usar y comentar el otro.
    agregarAlFinal(pri,valor);
    // agregarAlFinal2(pri,ult,valor);
    write('Ingrese un numero: ');
    read(valor);
  end;
  imprimirNodo(pri);
end.

//-----------------------------------------------------------------------//

{version del programa para pruebas automatizadas}


program ejercicio3P6;

uses
  SysUtils;

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

//3.a - proceso modificado para agregar nodo al final.
procedure agregarAlFinal(var L: lista; v: integer);
var
  nue,aux: lista;
begin
  new(nue);
  nue^.dato := v;
  nue^.sig := nil;
  if (L = nil) then
    L := nue
  else
  begin
    aux := L;
    while (aux^.sig <> nil) do
      aux := aux^.sig;
    aux^.sig := nue;
  end;
end;

//3.b - proceso modificado para agregar nodo atras manteniendo un puntero al ultimo ingresado.
procedure agregarAlFinal2(var pri,ult: lista; v: integer);
var
  nue: lista;
begin
  new(nue);
  nue^.dato := v;
  nue^.sig := nil;
  if (pri = nil) then
  begin
    pri := nue;
    ult := nue;
  end
  else
  begin
    ult^.sig := nue;
    ult := nue;
  end;
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

{programa principal}

var
  pri,ult: lista;
  valor: integer;
begin
  Randomize;
  pri := nil;
  ult := nil;
  valor := Random(20) + 1;
  while(valor <> 0) do
  begin                    //descomentar el proceso que se quiera usar.
    agregarAlFinal(pri,valor);
    //agregarAlFinal2(pri,ult,valor);
    valor := Random(21);
  end;
  imprimirNodo(pri);
end.