program parcialPartidos;

uses
  sysUtils;

const
  dimF_partidos = 52;

type
  str30 = string[30];
  rangoP = 1..dimF_partidos;
  rangoPaises = 1..24;

  gol = record
    nPart: rangoP;
    pais: str30;
    nJugador: integer;
  end;

  partido = record
    nPart: rangoP;
    estadio: str30;
    pais1: str30;
    pais2: str30;
  end;

  lGoles = ^nGoles;

  nGoles = record
    dato: gol;
    sig: lGoles;
  end;

  vPartidos = array[rangoP] of partido;
  vGoles = array[rangoP] of integer;
  vPaises = array[rangoPaises] of str30;

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

procedure cargarVectorPaises(var v: vPaises);
begin
  v[1] := 'Italia';
  v[2] := 'Argentina';
  v[3] := 'Brasil';
  v[4] := 'Alemania Federal';
  v[5] := 'Bélgica';
  v[6] := 'Inglaterra';
  v[7] := 'Corea del Sur';
  v[8] := 'Emiratos Árabes Unidos';
  v[9] := 'Camerún';
  v[10] := 'Egipto';
  v[11] := 'Costa Rica';
  v[12] := 'Estados Unidos';
  v[13] := 'Checoslovaquia';
  v[14] := 'Irlanda';
  v[15] := 'Rumania';
  v[16] := 'Suecia';
  v[17] := 'Colombia';
  v[18] := 'Uruguay';
  v[19] := 'Austria';
  v[20] := 'Escocia';
  v[21] := 'España';
  v[22] := 'Países Bajos';
  v[23] := 'Unión Soviética';
  v[24] := 'Yugoslavia';
end;

procedure leerGol(var g: gol; v: vPaises);
begin
  with g do begin
    nJugador := Random(34);
    if (nJugador <> 0) then begin
      nPart := Random(dimF_partidos) + 1;
      pais := v[Random(24) + 1];
    end;
  end;
end;

procedure insertarOrdenado(var l: lGoles; g: gol);
var
  nue, ant, act: lGoles;
begin
  new(nue);
  nue^.dato := g;
  ant := l;
  act := l;
  while (act <> nil) and (g.pais > act^.dato.pais) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = ant) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure generarLista(var l: lGoles; v: vPaises);
var
  g: gol;
begin
  leerGol(g, v);
  while (g.nJugador <> 0) do begin
    insertarOrdenado(l, g);
    leerGol(g, v);
  end;
end;

procedure inicializarVector(var v: vGoles);
var
  i: rangoP;
begin
  for i := 1 to dimF_partidos do
    v[i] := 0;
end;

procedure leerPartido(var p: partido);
begin
  with p do begin
    nPart := Random(dimF_partidos) + 1;
    if (Random(2) = 0) then
      estadio := 'San Paolo'
    else
      randomString(5, estadio);
  end;
end;

function posicioValida(v: vPartidos; nPart: integer): boolean;
var
  ps: integer;
  ok: boolean;
begin
  ps := 1;
  ok := true;
  while (ps <= dimF_partidos) and (ok) do begin
    if (v[ps].nPart = nPart) then
      ok := false
    else
      ps := ps + 1;
  end;
  posicioValida := ok;
end;

procedure cargarVector(var v: vPartidos);
var
  i: rangoP;
  p: partido;
begin
  i := 1;
  while (i <= dimF_partidos) do begin
    leerPartido(p);
    if (posicioValida(v, p.nPart)) then begin
      v[i] := p;
      i := i + 1;
    end;
  end;
end;

procedure maxPais(pais: str30; goles: integer; var max: integer; var nMax: str30);
begin
  if (goles > max) then begin
    max := goles;
    nMax := pais;
  end;
end;

function cantA(v: vGoles): integer;
var
  i: rangoP;
  cant: integer;
begin
  cant := 0;
  for i := 1 to dimF_partidos do
    if (v[i] > 5) then
      cant := cant + 1;
  cantA := cant;
end;


procedure procesarInformacion(l: lGoles; vP: vPartidos; var vG: vGoles);
var
  cantB, max: integer;
  nMax, paisActual: str30;
begin
  max := -1;
  nMax := '';
  while (l <> nil) do begin
    paisActual := l^.dato.pais;
    cantB := 0;
    while (l <> nil) and (l^.dato.pais = paisActual) do begin
      vG[l^.dato.nPart] := vG[l^.dato.nPart] + 1;
      if ((vP[l^.dato.nPart].estadio = 'San Paolo') and (l^.dato.nJugador = 9)) then
        cantB := cantB + 1;
      l := l^.sig;
    end;
    maxPais(paisActual, cantB, max, nMax);
  end;
  writeln('El mundial Italia 90 tuvo ', cantA(vG), ' partidos con mas de 5 goles.');
  writeln(nMax, ' es el pais con mayor cantidad de goles convertidos en el estadio San Paolo, por el jugador con camiseta nro 9.');
end;

{Programa Principal}
var
  pri: lGoles;
  vP: vPartidos;
  vG: vGoles;
  vPs: vPaises;
begin
  Randomize;
  pri := nil;
  cargarVectorPaises(vPs);
  generarLista(pri, vPs); //se dispone
  inicializarVector(vG);
  cargarVector(vP);
  procesarInformacion(pri, vP, vG);
end.

