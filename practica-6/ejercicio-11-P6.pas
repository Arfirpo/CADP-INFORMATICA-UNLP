program nombrePrograma;

type
  lEgresados = ^nEgresados;
  
  str30 = string[30];
  rango = 0..10.00;

  egresado = record
    leg: longint;
    ape: str30;
    prom: rango;
  end;

  nEgresados = record
    dato: egresado;
    sig: lEgresados;
  end;

{modulos}

procedure generarLista(var l: lEgresados);

  procedure leerEgresado(var e: egresado);
  begin
    with e do begin
      write('Ingrese N° de legajo del egresado: ');
      readln(leg);
      if leg <> 0 then begin
        write('Ingrese apellido del egresado: ');
        readln(ape);
        write('Ingrese el promedio del egresado: ');
        readln(prom);
      end;
    end;
  end;

  procedure insertarOrdenado(var l: lEgresados; e: egresado);
  var
    ant,act,nue: lEgresados;
  begin
    new(nue);
    nue^.dato := e;
    ant:= l;
    act:= l;
    while (act <> nil) and (e.prom < act^.dato.prom) do begin
      ant := act;
      act := act^.sig;
    end;
    if act = ant then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  e: egresado;
begin
  leerEgresado(e);
  while e.leg <> 0 do begin
    insertarOrdenado(l,e);
    leerEgresado(e);
  end;
end;

procedure informarLista(l: lEgresados);
var aux: lEgresados; num: integer;
begin
  aux := l; num := 0;
  writeln('------------------------------');
  writeln('Premio Joaquin V. Gonzalez: ');
  writeln();
  if aux = nil then writeln('No existen egresados que cumplan los requisitos del premio.');
  while (aux <> nil) and (num < 10) do begin
    num := num +1;
    writeln(num,'° puesto: ',aux^.dato.ape,' legajo N° ',aux^.dato.leg,' Promedio: ',aux^.dato.prom:2:2);
    aux := aux^.sig;
  end;
end;


{programa principal}

var
  pri: lEgresados;
begin
  pri := nil;
  generarLista(pri);
  informarLista(pri);
end.

//-------------------------------------------------------------------------------------

{version para pruebas automatizadas}

program nombrePrograma;

uses
  sysUtils;

type
  lEgresados = ^nEgresados;
  
  str30 = string[30];
  
  egresado = record
    leg: longint;
    ape: str30;
    prom: real;
  end;

  nEgresados = record
    dato: egresado;
    sig: lEgresados;
  end;

{modulos}

procedure randomString(StringLen: integer; var palabra: str30);
var
  str: string; result: str30;
begin
  str := 'abcdefghijklmnopqrstuvwxyz';
  result := '';
  repeat
    result := result + str[Random(length(str)) + 1];
  until (length(result) = StringLen);
  palabra := result;
end;

procedure generarLista(var l: lEgresados);

  procedure leerEgresado(var e: egresado);
  begin
    with e do begin
      leg := Random(19);
      if leg <> 0 then begin
        randomString(5,ape);
        prom := Random(10) + 1;
      end;
    end;
  end;

  procedure insertarOrdenado(var l: lEgresados; e: egresado);
  var
    ant,act,nue: lEgresados;
  begin
    new(nue);
    nue^.dato := e;
    ant:= l;
    act:= l;
    while (act <> nil) and (e.prom < act^.dato.prom) do begin
      ant := act;
      act := act^.sig;
    end;
    if act = ant then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  e: egresado;
begin
  leerEgresado(e);
  while e.leg <> 0 do begin
    insertarOrdenado(l,e);
    leerEgresado(e);
  end;
end;

procedure informarLista(l: lEgresados);
var aux: lEgresados; num: integer;
begin
  aux := l; num := 0;
  writeln('------------------------------');
  writeln('Premio Joaquin V. Gonzalez: ');
  writeln();
  if aux = nil then writeln('No existen egresados que cumplan los requisitos del premio.');
  while (aux <> nil) and (num < 10) do begin
    num := num +1;
    writeln(num,'° puesto: ',aux^.dato.ape,' legajo N° ',aux^.dato.leg,' Promedio: ',aux^.dato.prom:2:2);
    aux := aux^.sig;
  end;
end;


{programa principal}

var
  pri: lEgresados;
begin
  Randomize;
  pri := nil;
  generarLista(pri);
  informarLista(pri);
end.
