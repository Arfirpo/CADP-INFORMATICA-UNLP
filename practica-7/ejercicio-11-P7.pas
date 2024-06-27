program ejercicio12P7;

uses
  sysUtils;

const
  dimF_tSusc = 4;

type
  str30 = string[30];
  rango_tSusc = 1..dimF_tSusc;
  vSuscripciones = array[rango_tSusc] of integer;
  vTipos = array[rango_tSusc] of real;

  cliente = record
    nom: str30;
    dni: longint;
    edad: integer;
    tSuscripcion: rango_tSusc;
  end;

  lClientes = ^nClientes;

  nClientes = record
    dato: cliente;
    sig: lClientes;
  end;

  mas40 = record
    nom: str30;
    dni: longint;
  end;

  lMas40 = ^nMas40;

  nMas40 = record
    dato: mas40;
    sig: lMas40;
  end;

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

procedure cargarVector(var vT: vTipos);
begin
  vT[1] := 15;
  vT[2] := 20.5;
  vT[3] := 33.15;
  vT[4] := 40;
end;

procedure inicializarVector(var vS: vSuscripciones);
var
  i: rango_tSusc;
begin
  for i := 1 to dimF_tSusc do
    vS[i] := 0;
end;

procedure leerCliente(var c: cliente);
begin
  with c do begin
    dni := Random(1099);
    if(dni <> 0) then begin
      randomString(5,nom);
      edad := Random(77) + 14;
      tSuscripcion := Random(dimF_tSusc) + 1;
    end;
  end;
end;

function posicionValida(l: lClientes; dni: longint):boolean;
var
  ok: boolean;
begin
  ok := true;
  while (l <> nil) and (l^.dato.dni <> dni) do
    l := l^.sig;
  if (l <> nil) and (l^.dato.dni = dni) then
    ok := false;
  posicionValida := ok;
end;

procedure armarNodo(var l: lClientes; c: cliente);
var
  nue: lClientes;
begin
  new(nue);
  nue^.dato := c;
  nue^.sig := l;
  l := nue;
end;

procedure generarLista(var l: lClientes);
var
  c: cliente;
begin
  leerCliente(c);
  while(c.dni <> 0) do begin
    if(posicionValida(l,c.dni)) then
      armarNodo(l,c);
    leerCliente(c);
  end;
end;

function cumpleCondicion(edad: longint; tipoS: rango_tSusc):boolean;
begin
  cumpleCondicion := ((edad > 40) and ((tipoS = 3) or (tipoS = 4)));
end;

procedure insertarOrdenado(var l: lMas40; n: str30; d: longint);
var
  nue,ant,act: lMas40;
begin
  new(nue);
  nue^.dato.nom := n;
  nue^.dato.dni := d;
  ant := l;
  act := l;
  while (act <> nil) and (d > act^.dato.dni) do begin
    ant := act;
    act := act^.sig;
  end;
  if(act = ant) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure maxSusc(vS: vSuscripciones; var maxS1,maxS2: integer);
var
  max1,max2: integer;
  i: rango_tSusc;
begin
  max1 := -1; 
  max2 := -1;
  for i := 1 to dimF_tSusc do begin
    if(vS[i] > max1) then begin
      max2 := max1;
      maxS2 := maxS1;
      max1 := vS[i];
      maxS1 := i;
    end
    else if(vS[i] > max2) then begin
      max2 := vS[i];
      maxS2 := i;
    end;
  end; 
end;

procedure procesarLista(l: lClientes; var l2: lMas40; vT: vTipos; var vS: vSuscripciones);
var
  ganTot: real;
  maxS1,maxS2: integer;
begin
  ganTot := 0;
  maxS1 := 0; maxS2 := 0;
  while (l <> nil) do begin
    ganTot := ganTot + vT[l^.dato.tSuscripcion];
    vS[l^.dato.tSuscripcion] := vS[l^.dato.tSuscripcion] + 1;
    if(cumpleCondicion(l^.dato.edad,l^.dato.tSuscripcion)) then
      insertarOrdenado(l2,l^.dato.nom,l^.dato.dni);    
    l := l^.sig;
  end;
  writeln('La ganancia total de Fortacos es: $',ganTot:0:2);
  maxSusc(vS,maxS1,maxS2);
  writeln('La suscripcion con mas clientes es la: ',maxS1,'.');
  writeln('La segunda suscripcion con mas clientes es la: ',maxS2,'.');
end;

procedure imprimirLista(l: lMas40);
begin
writeln('Lista de clientes mayores de 40:');
writeln('----------------------------------');
  while (l <> nil) do begin
    writeln(l^.dato.nom);
    writeln(l^.dato.dni);
    writeln('----------------------------------');
    l := l^.sig;
  end;
end;

{Programa Principal}
var
  pri: lClientes;
  pri2: lMas40;
  vT: vTipos;
  vS: vSuscripciones;

begin
  Randomize;
  pri := nil;
  pri2 := nil;
  inicializarVector(vS);
  cargarVector(vT); //se dispone
  generarLista(pri);
  procesarLista(pri,pri2,vT,vS);
  //solo para corroborar
  imprimirLista(pri2);
end.
