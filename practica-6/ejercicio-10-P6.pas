program ejercicio10P6;

type
  lClientes = ^nClientes;

  cliente = record
    dni: longint;
    turno: integer;
  end;

  nClientes = record
    dato: cliente;
    sig: lClientes;
  end;

{modulos}
procedure simularAtencion(var pri, ult: lClientes);

  procedure inicializarLista(var pri, ult: lClientes);
  begin
    pri := nil;
    ult := nil;
  end;

  procedure cargarClientes(var pri, ult: lClientes);
  
    procedure recibirCliente(var pri, ult: lClientes; dni: longint);
    var
      nue: lClientes;
      c: cliente;
    begin
      if pri = nil then 
        c.turno := 1
      else 
        c.turno := ult^.dato.turno + 1;

      c.dni := dni;     
      
      new(nue);
      nue^.dato := c;
      nue^.sig := nil;
      if pri = nil then 
        pri := nue
      else
        ult^.sig := nue;
        
      ult := nue;
    end;
  
  var
    dni: longint;
  begin
    write('Ingrese el dni del cliente: ');
    read(dni);
    while dni <> 0 do 
    begin
      recibirCliente(pri, ult, dni);
      write('Ingrese el dni del cliente: ');
      read(dni);
    end;
  end;

  procedure procesarClientes(var pri: lClientes; var turnoAt: integer; var dniAt: longint);

    procedure atenderClientes(var pri: lClientes; var turnoAt: integer; var dniAt: longint);
    var 
      aux: lClientes;
    begin
      aux := pri;
      turnoAt := aux^.dato.turno;
      dniAt := aux^.dato.dni;
      pri := pri^.sig;
      dispose(aux);
    end;

  var
    aux: lClientes;
  begin
    aux := pri;
    writeln();
    writeln('------------------------------');
    writeln('Inicio de Atencion a clientes: ');
    writeln('------------------------------');
    while aux <> nil do begin
      writeln('Atencion: Turno N° ',aux^.dato.turno,', DNI N° ',aux^.dato.dni,' ingrese a la sala.');
      atenderClientes(pri, turnoAt, dniAt);
      writeln();
      writeln('El cliente con turno ', turnoAt, ', DNI N°: ', dniAt, ' fue atendido.');
      writeln('-------------------------------------------------------');
      aux := pri;
    end;
  end;

var
  turnoAt: integer; dniAt: longint;
begin
  turnoAt := 0; dniAt := 0;
  inicializarLista(pri, ult);
  cargarClientes(pri, ult);
  procesarClientes(pri, turnoAt, dniAt);
end;

{Programa principal}
var
  pri, ult: lClientes;
begin
  simularAtencion(pri, ult);
end.