program ejercicio6P6;

const
  dimF = 7;

type

lSondas = ^nSondas;

str30 = string[30];
rangoE = 1..dimF;

sonda = record
  nom: str30;
  dMis: integer;
  cConst: real;
  cMant: real;
  EspElect: rangoE;
end;

nSondas = record
  dato: sonda;
  sig: lSondas;
end;

vCont = array[rangoE] of integer;

{modulos}

procedure inicializarV (var c: vCont);
var
  i: rangoE;
begin
  for i := 1 to dimF do
    c[i] := 0;
end;

procedure generarLista(var l: lSondas);

  procedure leerSonda(var s: sonda);
  begin
    with s do begin
      write('Ingrese el nombre de la sonda: ');
      readln(nom);
      write('Ingrese duracion estimada de la mision: ');
      readln(dMis);
      write('Ingrese costo de construccion de la sonda: ');
      readln(cConst);
      write('Ingrese costo de mantenimiento de la sonda: ');
      readln(cMant);
      write('Ingrese el tipo de espectro electromagnetico a estudiar: ');
      readln(EspElect);
    end;
  end;

  procedure agregarAdelante(var l: lSondas; s: sonda);
  var
    aux: lSondas;
  begin
    new(aux);
    aux^.dato := s;
    aux^.sig := l;
    l := aux;
  end;

var
  s: sonda;
begin
  repeat
    leerSonda(s);
    agregarAdelante(l,s);
  until(s.nom = 'gaia');
end;

procedure recorrerLista(l: lSondas; var c: vCont);

  procedure masCostosa(constr,mant: real; nom: str30; var max: real; var nomMax: str30);
  var
    costoTot: real;
  begin
    costoTot := constr + mant;
    if costoTot > max then begin
      max := costoTot;
      nomMax := nom;
    end;
  end;

  procedure cargarV(pos: rangoE; var c: vCont);
  begin
    c[pos] := c[pos] + 1;
  end;

var
  nMaxCost, nCConst: str30; i: rangoE; 
  cantSondas,cantMaxD,cantMaxCost: integer; 
  max,promCConst,promDurM: real; 
  ori: lSondas;
begin
  nMaxCost := ''; nCConst := ''; cantSondas := 0; max:= -1; 
  promCConst := 0; promDurM := 0; cantMaxD := 0; cantMaxCost := 0;
  ori := l;

  while (l <> nil) do begin
    cantSondas := cantSondas + 1;
    promCConst := promCConst + l^.dato.cConst;
    promDurM := promDurM + l^.dato.dMis;
    masCostosa(l^.dato.cConst,l^.dato.cMant,l^.dato.nom,max,nMaxCost);
    cargarV(l^.dato.EspElect,c);
    l := l^.sig;
  end;
  
  promCConst := (promCConst / cantSondas);
  promDurM := (promDurM / cantSondas);
  
  l := ori;

  while l <> nil do begin
    if l^.dato.dMis > promDurM then
      cantMaxD := cantMaxD +1;
    if l^.dato.cConst > promCConst then
      cantMaxCost := cantMaxCost +1;
    l := l^.sig;    
  end;

  writeln();
  writeln('-------------------------------------------------------------');
  writeln('La cantidad de sondas que realizaran estudios se dividen en: ');
  writeln();
  for i := 1 to dimF do begin
    case i of
      1: writeln(c[i],' estudiara/n el espectro electromagnetico "radio"');
      2: writeln(c[i],' estudiara/n el espectro electromagnetico "microondas"');
      3: writeln(c[i],' estudiara/n el espectro electromagnetico "infrarojo"');
      4: writeln(c[i],' estudiara/n el espectro electromagnetico "luz visible"');
      5: writeln(c[i],' estudiara/n el espectro electromagnetico "ultravioleta"');
      6: writeln(c[i],' estudiara/n el espectro electromagnetico "rayos x"');
      7: writeln(c[i],' estudiara/n el espectro electromagnetico "rayos gamma"');
    end;
  end;
  writeln('-------------------------------------------------------------');
  writeln('La sonda mas costosa es: ',nMaxCost);
  writeln('-------------------------------------------------------------');
  writeln('La cantidad de sondas cuya duracion es mayor al promedio de todas las sondas es: ',cantMaxD);
  writeln('La cantidad de sondas cuyo costo de construccion es mayor al promedio de todas las sondas es: ',cantMaxCost);
  writeln('-------------------------------------------------------------');
end;

{programa principal}

var
  s: lSondas; c : vCont;
begin
  s := nil;
  inicializarV(c);
  generarLista(s);
  recorrerLista(s,c);
end.

{--------------------------------------------------------------------------------------------}

//version para pruebas automatizadas

program ejercicio6P6;

uses
  sysUtils;

const
  dimF = 7;

type

lSondas = ^nSondas;

str30 = string[30];
rangoE = 1..dimF;

sonda = record
  nom: str30;
  dMis: integer;
  cConst: real;
  cMant: real;
  EspElect: rangoE;
end;

nSondas = record
  dato: sonda;
  sig: lSondas;
end;

vCont = array[rangoE] of integer;

{modulos}

procedure recorrerLista(l: lSondas; var c: vCont);

  procedure masCostosa(constr,mant: real; nom: str30; var max: real; var nomMax: str30);
  var
    costoTot: real;
  begin
    costoTot := constr + mant;
    if costoTot > max then begin
      max := costoTot;
      nomMax := nom;
    end;
  end;

  procedure cargarV(pos: rangoE; var c: vCont);
  begin
    c[pos] := c[pos] + 1;
  end;


var
  nMaxCost, nCConst: str30; i: rangoE; 
  cantSondas,cantMaxD,cantMaxCost: integer; 
  max,promCConst,promDurM: real; 
  ori: lSondas;
begin
  nMaxCost := ''; nCConst := ''; cantSondas := 0; max:= -1; 
  promCConst := 0; promDurM := 0; cantMaxD := 0; cantMaxCost := 0;
  ori := l;

  while (l <> nil) do begin
    cantSondas := cantSondas + 1;
    promCConst := promCConst + l^.dato.cConst;
    promDurM := promDurM + l^.dato.dMis;
    masCostosa(l^.dato.cConst,l^.dato.cMant,l^.dato.nom,max,nMaxCost);
    cargarV(l^.dato.EspElect,c);
    l := l^.sig;
  end;
  
  promCConst := (promCConst / cantSondas);
  promDurM := (promDurM / cantSondas);
  
  l := ori;

  while l <> nil do begin
    if l^.dato.dMis > promDurM then
      cantMaxD := cantMaxD +1;
    if l^.dato.cConst > promCConst then
      cantMaxCost := cantMaxCost +1;
    l := l^.sig;    
  end;

  writeln();
  writeln('-------------------------------------------------------------');
  writeln('La cantidad de sondas que realizaran estudios se dividen en: ');
  writeln();
  for i := 1 to dimF do begin
    case i of
      1: writeln(c[i],' estudiara/n el espectro electromagnetico "radio"');
      2: writeln(c[i],' estudiara/n el espectro electromagnetico "microondas"');
      3: writeln(c[i],' estudiara/n el espectro electromagnetico "infrarojo"');
      4: writeln(c[i],' estudiara/n el espectro electromagnetico "luz visible"');
      5: writeln(c[i],' estudiara/n el espectro electromagnetico "ultravioleta"');
      6: writeln(c[i],' estudiara/n el espectro electromagnetico "rayos x"');
      7: writeln(c[i],' estudiara/n el espectro electromagnetico "rayos gamma"');
    end;
  end;
  writeln('-------------------------------------------------------------');
  writeln('La sonda mas costosa es: ',nMaxCost);
  writeln('-------------------------------------------------------------');
  writeln('La cantidad de sondas cuya duracion es mayor al promedio de todas las sondas es: ',cantMaxD);
  writeln('La cantidad de sondas cuyo costo de construccion es mayor al promedio de todas las sondas es: ',cantMaxCost);
  writeln('-------------------------------------------------------------');
end;

procedure generarLista(var l: lSondas);

  procedure leerSonda(var s: sonda);
  begin
    with s do begin
      write('Ingrese el nombre de la sonda: ');
      readln(nom);
      dMis := Random(100) + 1;
      cConst := Random(9999) + 1;
      cMant := Random(9999) + 1;
      EspElect := Random(dimF) + 1;
    end;
  end;

  procedure agregarAdelante(var l: lSondas; s: sonda);
  var
    aux: lSondas;
  begin
    new(aux);
    aux^.dato := s;
    aux^.sig := l;
    l := aux;
  end;

var
  s: sonda;
begin
  repeat
    leerSonda(s);
    agregarAdelante(l,s);
  until (s.nom = 'gaia');
end;

procedure inicializarV (var c: vCont);
var
  i: rangoE;
begin
  for i := 1 to dimF do
    c[i] := 0;
end;


{programa principal}

var
  s: lSondas; c : vCont;
begin
  Randomize;
  s := nil;
  inicializarV(c);
  generarLista(s);
  recorrerLista(s,c);
end.