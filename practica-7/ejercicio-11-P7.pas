program ejercicio11P7;

uses
  sysUtils;

const
  dimF_eventos = 100;
  dimF_tipos = 5;

type
  str30 = string[30];
  rango_e = 1..dimF_eventos;
  rango_t = 1..dimF_tipos;

  evento = record
    nomE: str30;
    tipoE: rango_t;
    lugarE: str30;
    maxCant: integer;
    valor_entrada: real;
  end;

  venta = record
    codV: integer;
    numE: rango_e;
    dni_comprador: longint;
    cantEntradas: integer;
  end;

  vEventos = array[rango_e] of evento;

  lVentas = ^nVentas;

  nVentas = record
    dato: venta;
    sig: lVentas;
  end;

  vRecaudacion = array[rango_e] of real;

{modulos}

procedure randomString(StringLen: integer; var palabra: str30);
var
  str: string;
  Result: str30;
begin
  str := 'abcdefghijklmnopqrstuvwxyz';
  Result := '';
  repeat
    Result := Result + str[Random(Length(str)) + 1];
  until Length(Result) = StringLen;
  palabra := Result;
end;

procedure inicializarVRec(var v: vRecaudacion);
var
  i: rango_e;
begin
  for i := 1 to dimF_eventos do
    v[i] := 0;
end;

procedure leerEvento(var e: evento);
begin
  with e do begin
    randomString(5,nomE);
    tipoE := Random(dimF_tipos) + 1;
    randomString(5,lugarE);
    maxCant := Random(100) + 1;
    valor_entrada := Random(50) + 1;
  end;
end;

procedure cargarVectorE(var v: vEventos);
var
  i: rango_e;
  e: evento;
begin
  for i := 1 to dimF_eventos do begin
    leerEvento(e);
    v[i] := e;
  end;
end;

procedure leerVenta(var v: venta);
begin
  with v do begin
    codV := Random(100) - 1;
    if (codV <> -1) then begin
      numE := Random(dimF_eventos) + 1;
      dni_comprador := Random(39999999) + 1;
      cantEntradas := Random(10) + 1;
    end;
  end;
end;

procedure armarNodo(var l: lVentas; v: venta);
var
  nue: lVentas;
begin
  new(nue);
  nue^.dato := v;
  nue^.sig := l;
  l := nue;
end;

procedure generarListaV(var l: lVentas);
var
  v: venta;
begin
  leerVenta(v);
  while (v.codV <> -1) do begin
    armarNodo(l,v);
    leerVenta(v);
  end;
end;

procedure minRec(vRec: vRecaudacion; var nMin1,nMin2,lMin1,lMin2: str30; vE: vEventos);
var
  i: rango_e;
  min1,min2: real;
begin
  min1 := 9999;
  min2 := 9999;
  for i := 1 to dimF_eventos do begin
    if(vRec[i] < min1) then begin
      min2 := min1;
      nMin1 := nMin2;
      lMin2 := lMin1;
      min1 := vRec[i];
      nMin1 := vE[i].nomE;
      lMin1 := vE[i].lugarE;
    end
    else if(vRec[i] < min2) then begin
      min2 := vRec[i];
      nMin2 := vE[i].nomE;
      lMin2 := vE[i].lugarE;
    end;
  end;
end;

function procesarDig(dni: longint):boolean;
var
  dig,digP,digI: integer;
begin
  digP := 0; digI := 0;
  while (dni <> 0) do begin
    dig := dni mod 10;
    if (dig mod 2 = 0) then
      digP := digP + 1
    else
      digI := digI + 1;
    dni := dni div 10;
  end;
  procesarDig := (digP > digI);
end;

function condicionB(dni: longint; tipoE: rango_t):boolean;
begin
  condicionB := ((procesarDig(dni)) and (tipoE = 3));
end;

function condicionC(maxCant,cant: integer):boolean;
begin
  condicionC := (cant >= maxCant);
end;

procedure procesarListaV(l: lVentas; vE: vEventos; var vRec: vRecaudacion);
var
  nomMin1,nomMin2,lugMin1,lugMin2: str30;
  cantE50,cumpleB: integer;
begin
  nomMin1 := '';
  nomMin2 := '';
  lugMin1 := '';
  lugMin2 := '';
  cantE50 := 0;
  cumpleB := 0;
  while(l <> nil) do begin

    vRec[l^.dato.numE] := vRec[l^.dato.numE] + (l^.dato.cantEntradas * vE[l^.dato.numE].valor_entrada);
    
    if(condicionB(l^.dato.dni_comprador,vE[l^.dato.numE].tipoE)) then
      cumpleB := cumpleB + l^.dato.cantEntradas;
    
    if(l^.dato.numE = 50) then
      cantE50 := cantE50 + l^.dato.cantEntradas;

    l := l^.sig;
  end;

  minRec(vRec,nomMin1,nomMin2,lugMin1,lugMin2,vE);
  writeln('Nombre y Lugar de los dos eventos que han tenido menor recaudación.');
  writeln('1.- Nombre del evento: ',nomMin1,' - Lugar del Evento: ',lugMin1,'.');
  writeln('2.- Nombre del evento: ',nomMin2,' - Lugar del Evento: ',lugMin2,'.');

  writeln('Cantidad de entradas vendidas cuyo comprador tiene un dni con mas digitos pares que digitos impares: ',cumpleB,'.');
  if(condicionC(vE[50].maxCant,cantE50)) then
    writeln('La cantidad de entradas vendidas para el evento ',vE[50].nomE,' alcanzo la cantidad maxima de personas permitidas.')
  else
    writeln('La cantidad de entradas vendidas para el evento ',vE[50].nomE,' no alcanzo la cantidad maxima de personas permitidas.');

end;

{Programa Principal}
var
  vE: vEventos;
  pri: lVentas;
  vRec: vRecaudacion;
begin
  Randomize;
  pri:= nil;
  cargarVectorE(vE); //se dispone.
  inicializarVRec(vRec);
  generarListaV(pri);
  procesarListaV(pri,vE,vRec);
end.