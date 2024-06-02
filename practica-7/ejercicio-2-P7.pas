{2. Implementar un programa que lea y almacene información de clientes de una empresa aseguradora automotriz. 
De cada cliente se lee: código de cliente, DNI, apellido, nombre, código de póliza contratada (1..6) y monto básico que abona mensualmente. 
La lectura finaliza cuando llega el cliente con código 1122, el cual debe procesarse. 
La empresa dispone de una tabla donde guarda un valor que representa un monto adicional que el cliente debe abonar en la liquidación mensual de su seguro, de acuerdo al código de póliza que tiene contratada. 
Una vez finalizada la lectura de todos los clientes, se pide: 
  a. Informar para cada cliente DNI, apellido, nombre y el monto completo que paga mensualmente por su seguro automotriz (monto básico + monto adicional). 
  b. Informar apellido y nombre de aquellos clientes cuyo DNI contiene al menos dos dígitos 9. 
  c. Realizar un módulo que reciba un código de cliente, lo busque (seguro existe) y lo elimine de la estructura.}

program ejercicio2P7;

const
  dimF_Cod = 9999;
  dimF_pol = 6;
  condCorte = 1122;

type
  rango_cod = 1..dimF_Cod;
  rango_pol = 1..dimF_pol;
  str30 = string[30];

  lClientes = ^nClientes;

  cliente = record
    cod: rango_cod;
    dni: longint;
    ap: str30;
    nom: str30;
    cPol: rango_pol;
    mBase: real;
  end;

  nClientes = record
    dato: cliente;
    sig: lClientes;
  end;

  poliza = record
    codigo: rango_pol;
    tipo: string;
    mExtra: real;
  end;

  vPol = array[rango_pol] of poliza; //se dispone.

{modulos}
procedure cargarVector(var vP: vPol);

  procedure leerPoliza(var p: poliza; i: rango_pol);
  begin
    with p do begin
      codigo := i;
      case i of
        1: begin
            tipo := 'basica';
            mExtra := 10.5;
          end;
        2: begin
            tipo := 'basica plus';
            mExtra := 15.5;
          end; 
        3: begin
            tipo := 'intermedia';
            mExtra := 20.5;
          end; 
        4: begin
            tipo := 'intermedia plus';
            mExtra := 25.5;
          end; 
        5: begin
            tipo := 'completa';
            mExtra := 30.5;
          end;
        6: begin
            tipo := 'completa plus';
            mExtra := 35.5;
          end;
      end;
    end;
  end;

var
  i: rango_pol;
  p: poliza;
begin
  for i := 1 to dimF_pol do begin
    leerPoliza(p,i);
    vP[i] := p;
  end;
end;

procedure generarLista(var l: lClientes);

  procedure leerCliente(var c: cliente);
  begin
    with c do begin
      write('Ingrese el codigo de cliente: ');
      readln(cod);
      write('Ingrese el dni del cliente: ');
      readln(dni);
      write('Ingrese el apellido del cliente: ');
      readln(ap);
      write('Ingrese el nombre del cliente: ');
      readln(nom);
      write('Ingrese codigo de la poliza contratada: ');
      readln(cPol);
      write('Ingrese el monto (sin adicionales) de la poliza del cliente: ');
      readln(mBase);
    end;
  end;

  procedure insertarOrdenado(var l: lClientes; c: cliente);
  var
    nue,ant,act: lClientes;
  begin
    new(nue);
    nue^.dato := c;
    ant := l;
    act := l;
    while (act <> nil) and (c.cod > act^.dato.cod) do begin //ordeno por codigo de cliente, ascendente
      ant := act;
      act := act^.sig;
    end;
    if (act = ant) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  c: cliente;
begin
  repeat
    leerCliente(c);
    insertarOrdenado(l,c);
  until (c.cod = condCorte);
end;

procedure procesarLista(l: lClientes; vP: vPol);

  function cumpleB(dni: longint):boolean;
  var
    dig,cant: integer;
  begin
    cant := 0;
    while dni <> 0 do begin
      dig := dni mod 10;
      if dig = 9 then 
        cant := cant + 1;
      dni := dni div 10;        
    end;
    cumpleB := (cant >= 2);
  end;

  function totalPoliza(base,adicional: real):real;
  begin
    totalPoliza := base + adicional;
  end;

var
  aux: lClientes;
  totP: real;
begin
  aux := l;
  writeln();
  writeln('Datos del Cliente:');
  while aux <> nil do begin
    totP := 0; //inicializo en 0 el contador de total dentro del while para que se reinicie por cada cliente.
    totP :=  totalPoliza(aux^.dato.mBase,vP[aux^.dato.cPol].mExtra); //sumo el monto base de la poliza del cliente con el plus por tipo de poliza.
    //informo por cliente.
    writeln('---------------------------------------------------------');
    writeln('DNI: ',aux^.dato.dni);
    writeln('Apellido: ',aux^.dato.ap);
    writeln('Nombre: ',aux^.dato.nom);
    writeln('Monto total a abonar: $',totP:0:2);
    //chequeo si el dni del cliente cumple la condicion B.
    if (cumpleB(aux^.dato.dni)) then begin
      writeln('---------------------------------------------------------');
      writeln('El dni del cliente ',aux^.dato.ap,' ',aux^.dato.nom,' posee al menos dos digitos 9.'); 
    end;
    aux := aux^.sig;  
  end;
end;

function eliminarCliente(l: lClientes; codigo: rango_cod): lClientes;
var
  ant, act: lClientes;
begin
  act := l;
  ant := nil; // Inicializo ant a nil
  while act^.dato.cod <> codigo do begin // Buscar el nodo a eliminar
    ant := act;
    act := act^.sig;
  end;
  if act = l then // Si el nodo a eliminar es el primer nodo
    l := act^.sig
  else
    ant^.sig := act^.sig;
  dispose(act); //elimino de memoria el registro del cliente con el codigo buscado.
  eliminarCliente := l; //la funcion devuelve el puntero con la lista modificada.
end;


var
  pri: lClientes;
  vP: vPol;
  codigo: rango_cod;
begin
  pri := nil;
  cargarVector(vP); //se dispone.
  generarLista(pri);
  procesarLista(pri,vP);
  writeln('---------------------------------------------------------');
  write('Ingrese el codigo del cliente a eliminar de la lista: ');
  readln(codigo);
  pri := eliminarCliente(pri,codigo);
  writeln('---------------------------------------------------------');
  writeln('El cliente fue eliminado con exito.');
  writeln('---------------------------------------------------------');
end.
