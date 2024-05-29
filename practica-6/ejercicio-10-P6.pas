{
10-Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes. 
Su funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un
número (que es el siguiente al último número entregado). 
El cliente quedará esperando a ser llamado por su número, en cuyo caso sale de la lista de espera. 
Se pide:
    a. Definir una estructura de datos apropiada para representar la lista de espera de clientes.

    b. Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de clientes en espera, asigna un número al cliente y retorna la lista de espera actualizada.

    c. Implementar el módulo AtenderCliente, que recibe como parámetro la lista de clientes en espera,
    y retorna el número y DNI del cliente a ser atendido y la lista actualizada. El cliente atendido debe
    eliminarse de la lista de espera.

    d. Implementar un programa que simule la atención de los clientes. En dicho programa, primero
    llegarán todos los clientes juntos, se les dará un número de espera a cada uno de ellos, y luego se
    los atenderá de a uno por vez. El ingreso de clientes se realiza hasta que se lee el DNI 0, que no
    debe procesarse.
}

program ListaDeEsperaClientes;

type
  Cliente = record
    DNI: longint;
    Numero: longint;
  end;

  Nodo = ^NodoLista;
  NodoLista = record
    Datos: Cliente;
    Siguiente: Nodo;
  end;

  Cola = record
    Frente, Final: Nodo;
    UltimoNumero: longint;
  end;

procedure InicializarCola(var Q: Cola);
begin
  Q.Frente := nil;
  Q.Final := nil;
  Q.UltimoNumero := 0;
end;

function ColaVacia(Q: Cola): Boolean;
begin
  ColaVacia := Q.Frente = nil;
end;

procedure RecibirCliente(DNI: longint; var Q: Cola);
var
  Nuevo: Nodo;
begin
  New(Nuevo);
  Q.UltimoNumero := Q.UltimoNumero + 1;
  Nuevo^.Datos.DNI := DNI;
  Nuevo^.Datos.Numero := Q.UltimoNumero;
  Nuevo^.Siguiente := nil;
  if Q.Final = nil then
  begin
    Q.Frente := Nuevo;
  end
  else
  begin
    Q.Final^.Siguiente := Nuevo;
  end;
  Q.Final := Nuevo;
end;

procedure AtenderCliente(var Q: Cola; var DNI, Numero: longint);
var
  Aux: Nodo;
begin
  if not ColaVacia(Q) then
  begin
    Aux := Q.Frente;
    DNI := Aux^.Datos.DNI;
    Numero := Aux^.Datos.Numero;
    Q.Frente := Q.Frente^.Siguiente;
    if Q.Frente = nil then
    begin
      Q.Final := nil;
    end;
    Dispose(Aux);
  end
  else
  begin
    DNI := -1;
    Numero := -1;
    writeln('No hay clientes para atender.');
  end;
end;

var
  ColaClientes: Cola;
  DNI, turno: longint;

begin
  InicializarCola(ColaClientes);
  
  write('Ingrese DNI del clientes: ');
  readln(DNI);
  while dni <> 0 do begin
    RecibirCliente(DNI, ColaClientes);
    write('Ingrese los DNI de los clientes (0 para finalizar): ');
    readln(DNI);
  end;

  writeln('Atendiendo clientes:');
  while not ColaVacia(ColaClientes) do
  begin
    AtenderCliente(ColaClientes, DNI, turno);
    writeln('Atendiendo cliente con DNI: ', DNI, ' y número: ', turno);
  end;
end.
