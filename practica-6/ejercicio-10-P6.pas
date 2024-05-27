{
10-Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes. 
Su funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un
número (que es el siguiente al último número entregado). 
El cliente quedará esperando a ser llamado por su número, en cuyo caso sale de la lista de espera. 
Se pide:
    a. Definir una estructura de datos apropiada para representar la lista de espera de clientes.
    b. Implementar el módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de clientes en espera, 
    asigna un número al cliente y retorna la lista de espera actualizada.
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

procedure leerCliente(var c: cliente,t:integer);
begin
  with c do begin
    write('Ingrese el Dni del Cliente: ');
    readln(dni);
    turno := t;
  end;
end;

procedure listaDeEspera(var l: lClientes);
var
  t: integer; c: cliente;
begin
  t := 1;
  leerCliente(c,t);
  while c.dni <> 0 do begin
    agregarAlFinal(l,c);
    t := t + 1;
    leerCliente(c,t);
  end;
end;

var
  lEspera: lClientes;


begin
  lEspera := nil;
  listaDeEspera(lEspera);
end.


