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

program ejercicio10P6;

type
  lClientes = ^clientes;

  cliente = record
    turno: integer;
    dni: integer;
  end;

  clientes = record
    dato: cliente;
    sig: lClientes;
  end;

{modulos}

{b. Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de clientes en espera}
procedure recibirCliente(var l: lClientes; dni: integer);

  //a. Definir una estructura de datos apropiada para representar la lista de espera de clientes.
  procedure agregarAlFinal(var l: lClientes; c: cliente);
  var
    aux,nuevo: lClientes;
  begin
    new(nuevo);
    nuevo^.dato := c;
    nuevo^.sig := nil;

    if (l = nil) then
      l := nuevo
    else
    begin
      aux := l;
      while (aux^.sig <> nil) do
        aux := aux^.sig;
      aux^.sig := nuevo;
    end;
  end;

var
  c: cliente; t: integer;
begin
  t := 0;
  while dni <> 0 do begin
    c.dni := dni;
    t := t + 1;
    c.turno := t;
    agregarAlFinal(l,c);
    write('Ingrese su numero de documento: ');
    readln(dni);
  end;
end;


{programa principal}

var
  lEspera: lClientes;
  dni: integer;

begin
  lEspera := nil;
  write('Ingrese su numero de documento: ');
  readln(dni);
  recibirCliente(lEspera,dni);



end.



{procedure eliminarAtendido(var l: lClientes; pos: integer);
var
  ant,act: lClientes;
begin
  
  act := l;
  while act^.dato.turno <> pos do begin
    ant := act;
    act := act^.sig;
  end;
  
  if act = l then
    l := act^.sig;
  dispose(act);
end;

procedure atenderCliente(l: lClientes; var dniAt,turnoAt: integer);
begin
  dniAt := l^.dato.dni;
  turnoAt := l^.dato.turno;
  writeln('Siguiente: Turno N° ',dniAt,' Dni ',turnoAt);  
end;}