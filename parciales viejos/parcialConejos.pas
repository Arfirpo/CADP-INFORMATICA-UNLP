{Un criadero de conejos está analizando ciclos de reproducción. El criadero cuenta con conejas reproductoras y dispone de una estructura que contiene, 
para cada coneja, su código, año de nacimiento, nombre, cantidad de partos (entre 1 y 10) y cantidad de crías que tuvo en cada parto.
  a) Realice un módulo que reciba la información de las conejas y retorne en una estructura adecuada el código, 
  el nombre y el año de nacimiento de las conejas que tuvieron en promedio más de 5 crías por parto.
  b) Realice un módulo que reciba la estructura generada en a) e imprima los nombres de las conejas con código par, nacidas antes del año 2016.
  c) Realice una función que reciba la información de las conejas y un código de coneja, y retorne la cantidad máxima de crías que tuvo la coneja 
  con dicho código en alguno de sus partos (retornar -1 si la coneja no se encuentra en la estructura).}

program parcialConejos;

uses
  sysUtils;

const
  maxPartos = 10;

type
  rango_partos = 1..maxPartos;
  str30 = string[30];

  vPartos = array[rango_partos] of integer;

  coneja = record
    cod: integer;
    aNac: integer;
    nom: str30;
    cantPartos: rango_partos;
    criasPorParto: vPartos;
  end;

  lConejas = ^nConejas;

  nConejas = record
    dato: coneja;
    sig: lConejas;
  end;

  promMas5 = record
    cod: integer;
    aNac: integer;
    nom: str30;      
  end;

  lPromMas5 = ^nPromMas5;

  nPromMas5 = record
    dato: promMas5;
    sig: lPromMas5;
  end;

{módulos}

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

procedure cargarVectorPartos(var v: vPartos; dimL: rango_partos);
var
  i: rango_partos;
begin
  for i := 1 to dimL do
    v[i] := Random(10) + 1;
end;

procedure leerConeja(var c: coneja);
begin
  with c do begin
    cod := Random(101) -1;
    if(cod <> -1) then begin
      aNac := Random(26) + 1999;
      randomString(5, nom);
      cantPartos := Random(maxPartos) + 1;
      cargarVectorPartos(criasPorParto, cantPartos);
    end;
  end;
end;

procedure armarNodo2(var l: lConejas; c: coneja);
var
  nuevo: lConejas;
begin
  new(nuevo);
  nuevo^.dato := c;
  nuevo^.sig := l;
  l := nuevo;
end;

procedure generarLista(var l: lConejas); // se dispone.
var
  c: coneja;
begin
  leerConeja(c);
  while (c.cod <> -1) do begin
    armarNodo2(l, c);
    leerConeja(c);
  end;
end;

function masDe5Crias(v: vPartos; dimL: rango_partos): boolean;
var
  i: rango_partos;
  totCrias: integer;
begin
  totCrias := 0;
  for i := 1 to dimL do
    totCrias := totCrias + v[i];
  masDe5Crias := ((totCrias / dimL) > 5);
end;

procedure armarNodo(var l: lPromMas5; p: promMas5);
var
  nue: lPromMas5;
begin
  new(nue);
  nue^.dato := p;
  nue^.sig := l;
  l := nue;
end;

procedure generarLista2(l: lConejas; var l2: lPromMas5);
var
  p: promMas5;
begin
  while (l <> nil) do begin
    if (masDe5Crias(l^.dato.criasPorParto, l^.dato.cantPartos)) then begin
      p.cod := l^.dato.cod;
      p.nom := l^.dato.nom;
      p.aNac := l^.dato.aNac;
      armarNodo(l2, p);
    end;
    l := l^.sig;
  end;
end;

procedure procesarLista2(l: lPromMas5);
begin
  while (l <> nil) do begin
    if ((l^.dato.cod mod 2 = 0) and (l^.dato.aNac < 2016)) then
      writeln(l^.dato.nom);
    l := l^.sig;
  end;
end;

function maximo(v: vPartos; dimL: rango_partos): integer;
var
  i: rango_partos;
  max: integer;
begin
  max := -1;
  for i := 1 to dimL do
    if (v[i] > max) then
      max := v[i];
  maximo := max;
end;

function maxCrias(l: lConejas; codigo: integer): integer;
var
  esta: boolean;
  res: integer;
begin
  esta := false;
  res := 0;
  while (l <> nil) and not esta do begin
    if (l^.dato.cod = codigo) then
      esta := true
    else
      l := l^.sig;
  end;

  if (esta) then 
    res := maximo(l^.dato.criasPorParto, l^.dato.cantPartos)
  else 
    res := -1;

  maxCrias := res;
end;

{Programa principal}

var
  pri: lConejas;
  pri2: lPromMas5;
  codigo: integer;

begin
  Randomize;
  pri := nil; pri2 := nil;
  generarLista(pri);
  generarLista2(pri, pri2);
  procesarLista2(pri2);
  codigo := Random(100);
  writeln(maxCrias(pri, codigo));
end.  