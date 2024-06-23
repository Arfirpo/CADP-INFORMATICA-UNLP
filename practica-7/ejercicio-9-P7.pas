program ejercicio8P7;

uses
  sysUtils;

const
  dimF_gen = 8;

type
  rGen = 1..dimF_gen;
  str30 = string[30];

  lPeliculas = ^nPeliculas;

  pelicula = record
    codP: integer;
    tit: str30;
    codG: rGen;
    pProm: real;
  end;
  
  nPeliculas = record
    dato: pelicula;
    sig: lPeliculas;  
  end;

  lCriticas = ^nCriticas;

  critica = record
    dni_critico: integer;
    apYnom: str30;
    codP: integer;
    puntaje: real;
  end;

  nCriticas = record
    dato: critica;
    sig: lCriticas;
  end;

  vGeneros = array[rGen] of real;

{ Módulos }

procedure inicializarVector(var vGen: vGeneros);
var
  i: rGen;
begin
  for i := 1 to dimF_gen do
    vGen[i] := 0;
end;

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

procedure leerPelicula(var p: pelicula);
begin
  with p do begin
    codP := Random(311) - 1;
    if(codP <> -1) then begin
      randomString(5,tit);
      codG := Random(dimF_gen) + 1;
      pProm := 0;
    end;
  end;
end;

procedure armarNodo(var l: lPeliculas; p: pelicula);
var
  nue: lPeliculas;
begin
  new(nue);
  nue^.dato := p;
  nue^.sig := l;
  l := nue;
end;

procedure generarListaP(var l: lPeliculas); //se dispone
var
  p: pelicula;
begin
  leerPelicula(p);
  while(p.codP <> -1) do begin
    armarNodo(l,p);
    leerPelicula(p);
  end;
end;

procedure leerCritica(var c: critica);
begin
  with c do begin
    codP := Random(311) - 1;
    if(codP <> -1) then begin
      dni_critico := Random(1000) + 1;
      randomString(5,apYnom);
      puntaje := Random(100) + 1;
    end;
  end;
end;

procedure insertarOrdenado(var l: lCriticas; c: critica);
var
  nue,ant,act: lCriticas;
begin
  new(nue);
  nue^.dato := c;
  ant := l;
  act := l;
  while(act <> nil) and (c.codP > act^.dato.codP) do begin
    ant := act;
    act := act^.sig;
  end;
  if(act = ant) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure generarListaC(var l: lCriticas);
var
  c: critica;
begin
  leerCritica(c);
  while(c.codP <> -1) do begin
    insertarOrdenado(l,c);
    leerCritica(c);
  end;
end;

function cumpleC(dni: integer):boolean;
var
  dig,digP,digI: integer;
begin
  digP := 0;
  digI := 0;
  while(dni <> 0) do begin
    dig := dni mod 10;
    if(dig mod 2 = 0) then
      digP := digP + 1
    else
      digI := digI +1;
    dni := dni div 10;
  end;
  cumpleC := (digP = digI);
end;

procedure actualizarCritica(l: lPeliculas; codP: integer; promCriticas: real);
var
  aux: lPeliculas;
begin
  aux := l;
  while(aux <> nil) and (codP <> aux^.dato.codP) do
    aux := aux^.sig;
  if(aux <> nil) and (codP = aux^.dato.codP) then
    aux^.dato.pProm := promCriticas;
end;

procedure procesarListaC(l: lPeliculas; l2: lCriticas);
var
  peli_act,cantCriticas: integer;
  totCriticas,promCriticas: real;
begin
  while(l2 <> nil) do begin
    peli_act := l2^.dato.codP;
    totCriticas := 0;
    cantCriticas := 0;
    promCriticas := 0;
    while(l2 <> nil) and (l2^.dato.codP = peli_act) do begin
      totCriticas := totCriticas + l2^.dato.puntaje;
      cantCriticas := cantCriticas + 1;
      if(cumpleC(l2^.dato.dni_critico)) then
        writeln('El critico ',l2^.dato.apYnom,' posee un dni con identica cantidad de digitos pares e impares.');
      l2 := l2^.sig;
    end;
    promCriticas := totCriticas / cantCriticas;
    actualizarCritica(l,peli_act,promCriticas);
  end;
end;

function maxGen(vGen: vGeneros):integer;
var
  max: real;
  cod,i: integer;
begin
  max := -1;
  cod := 0;
  for i := 1 to dimF_gen do begin
    if(vGen[i] > max) then begin
      max := vGen[i];
      cod := i;
    end;
  end;
  maxGen := cod;
end;

procedure procesarListaP(l: lPeliculas; var vGen: vGeneros);
begin
  while(l <> nil) do begin
    vGen[l^.dato.codG] := vGen[l^.dato.codG] + l^.dato.pProm;
    l := l^.sig;
  end;
  writeln('El genero con mejor puntaje total es el ',maxGen(vGen));
end;


procedure eliminarDeListaP(var l: lPeliculas; codElim: integer;var exito: boolean);
var
  ant,act: lPeliculas;
begin
  ant := l;
  act := l;
  while(act <> nil) and (codElim <> act^.dato.codP) do begin
    ant := act;
    act := act^.sig;
  end;
  if(act <> nil) and (codElim = act^.dato.codP) then begin
    exito := true;
    if(act = l) then
      l := l^.sig
    else
      ant^.sig := act^.sig;
    dispose(act);
  end;
end;

{ Programa Principal }
var
  pri: lPeliculas;
  pri2: lCriticas;
  vGen: vGeneros;
  codElim: integer;
  exito: boolean;
begin
  Randomize;
  pri := nil;
  pri2 := nil;
  exito := false;
  inicializarVector(vGen);
  generarListaP(pri); //se dispone
  generarListaC(pri2);
  procesarListaC(pri,pri2);
  procesarListaP(pri,vGen);
  codElim := Random(40) + 1;
  eliminarDeListaP(pri,codElim,exito);
  if(exito) then
    writeln('La pelicula con codigo nro',codElim,' se elimino con exito.')
  else
    writeln('La pelicula con codigo nro ',codElim,' no pudo ser eliminada.');
end.
