
program ejercicio5P7;

const
  dimF_cam = 100;
  cond_fin = -1;

type
  rango_cam = 1..dimF_cam;
  str30 = string[30];

  camion = record
    pat: str30;
    aFab: integer;
    cap: real;
  end;

  flota = array[rango_cam] of camion;

  lViajes = ^nViajes;

  viaje = record
    codV: integer;
    codC: rango_cam;
    kmRec: real;
    dest: str30;
    anioV: integer;
    dniCh: longint;
  end;

  nViajes = record
    dato: viaje;
    sig: lViajes;
  end;

{modulos}
procedure cargarVector(var f: flota);

  procedure leerCamion(var c: camion);
  begin
    with c do begin
      write('Patente del camion: ');
      readln(pat);
      write('Año de fabricacion: ');
      readln(aFab);
      write('Capacidad de carga -en Kg-: ');
      readln(cap);
    end;
  end;

var
  i: rango_cam;
  c: camion;
begin
  for i := 1 to dimF_cam do begin
    leerCamion(c);
    f[i] := c;
  end;
end;

procedure insertarOrdenado(var l: lViajes; v: viaje);
var
  nue,ant,act: lViajes;
begin
  new(nue);
  nue^.dato := v;
  ant := l;
  act := l;
  while(act <> nil) and ((v.codC > act^.dato.codC) or ((v.codC = act^.dato.codC) and (v.anioV > act^.dato.anioV))) do begin
    ant := act;
    act := act^.sig;
  end;
  if act = ant then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure generarListaV(var l: lViajes);

  procedure leerViaje(var v: viaje);
  begin
    with v do begin
      write('Codigo de viaje: ');
      readln(codV);
      if(codV <> cond_fin) then begin
        write('Codigo de camion: ');
        readln(codC);
        write('Kilometros recorridos: ');
        readln(kmRec);
        write('Lugar de destino: ');
        readln(dest);
        write('Anio del viaje: ');
        readln(anioV);
        write('DNI del Chofer: ');
        readln(dniCh);        
      end;
    end;
  end;

var
  v: viaje;
begin
  leerViaje(v);
  while (v.codV <> cond_fin) do begin
    insertarOrdenado(l,v);
    leerViaje(v);
  end;
end;

procedure procesarLista(l: lViajes; f: flota);

  function cumple2(c: camion; anioViaje: integer):integer;
  var
    num: integer;
  begin
    if ((c.cap / 1000) > 30.5) and (anioViaje - c.aFab > 5) then
      num := 1
    else
      num := 0;
    cumple2 := num;
  end;

  function soloDigImp(dni: longint):boolean;
  var
    dig: integer;
    copia: longint;
    esImp: boolean;
  begin
    copia := dni;
    esImp := true;
    while (copia <> 0) and (esImp) do begin
      dig := copia mod 10;
      if dig mod 2 = 0 then
        esImp := false;
      copia := copia div 10;
    end;
    soloDigImp := esImp;
  end;

  procedure MaxMinRec(patente: str30; kilometraje: real; var max,min: real; var maxPat,minPat: str30);
  begin
    if kilometraje > max then begin
      max := kilometraje;
      maxPat := patente;
    end;
    if kilometraje < min then begin
      min := kilometraje;
      minPat := patente;
    end;
  end;

var
  max,min,totKmRec: real;
  maxPat,minPat: str30;
  cantViajes: integer;
  corte_cam: rango_cam;
begin

  max := -1; min := 9999;
  maxPat := ''; minPat := '';

  while (l <> nil) do begin
    corte_cam := l^.dato.codC;
    totKmRec := 0;
    cantViajes := 0;
    while (l <> nil) and (l^.dato.codC = corte_cam) do begin
      totKmRec := totKmRec + l^.dato.kmRec;
      cantViajes := cantViajes + cumple2(f[l^.dato.codC],l^.dato.anioV);
      if(soloDigImp(l^.dato.dniCh)) then begin
        writeln('-----------------------------------');
        writeln('El dni del chofer del viaje N° ',l^.dato.codV,' solo posee digitos impares.');
        writeln('-----------------------------------');
      end;
      l := l^.sig;
    end;
    MaxMinRec(f[l^.dato.codC].pat,totKmRec,max,min,maxPat,minPat);
  end;

  writeln('---------------------------------------------');
  writeln('Patente del camion que mas kilometros recorrio: ',maxPat);
  writeln('Patente del camion que menos kilometros recorrio: ',minPat);
  writeln('---------------------------------------------');
  writeln(cantViajes,' viajes se realizaron en camiones con capacidad mayor a 30.5tn, y que posean una antiguedad mayor de 5 años al momento del viaje.');
end;

{programa principal}
var
  f: flota;
  pri: lViajes;
begin
  pri := nil;
  cargarVector(f);
  generarListaV(pri);
  procesarLista(pri,f);
end.