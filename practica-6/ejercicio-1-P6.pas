{
  1)a. El programa genera una lista de enteros, lee un valor por teclado y lo incorpora a la lista, repite esta secuencia hasta que se lea el valor 0 (que no se procesa) y luego imprime los valores almacenados en la lista.
    b. La lista queda conformada en sentido inverso al orden de ingreso: 48 - 13 - 21 - 10. Cada valor se agrega adelante, quedando primero en la lista el último que se ingresa.
}

program JugamosConListas;

type
  lista = ^nodo;

  nodo = record
    dato: integer;
    sig: lista;
  end;

{modulos}

procedure armarNodo(var L: lista; v: integer);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := v;
  aux^.sig := L;
  L := aux;
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

{d. Modulo que recorre e incrementa, con un valor dado, los valores almacenados en la lista}
procedure incrementarNodo(L: lista; v: integer);
begin
  while L <> nil do
  begin
    L^.dato := L^.dato + v;
    L := L^.sig;
  end;
end;

{programa principal}

var
  pri: lista;
  valor: integer;
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

  write('Ingrese un numero: ');
  read(valor);  
  recorrerNodo(pri,valor);
  imprimirNodo(pri);
end.
