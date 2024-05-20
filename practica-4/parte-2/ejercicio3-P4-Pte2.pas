program ejercicio3P4Pte2;

uses
  SysUtils;

const
  dimF = 31;  // Número de días en un mes
  dimF2 = 200; // Máximo número de viajes
  corte = 0;  

type
  rangoD = 1..dimF;
  rangoV = 1..dimF2;

  viaje = record
    dia: rangoD;
    montoT: real;
    distR: real;
  end;

  datosV = record
    dist: real;
    monto: real;
  end;

  datosDia = record
    totDia: real;
    cantViajes: integer;
    vMinMonto: datosV;
  end;

  vMes = array[rangoD] of datosDia;
  vViajes = array[rangoV] of viaje;

procedure inicializarV(var d: vMes);
var
  i: rangoD;
begin
  for i := 1 to dimF do
  begin
    d[i].totDia := 0;
    d[i].cantViajes := 0;
    d[i].vMinMonto.dist := 0;
    d[i].vMinMonto.monto := 9999;
  end;
end;

procedure leerViaje(var rViaje: viaje);
begin
  write('Ingrese la distancia recorrida: ');
  readln(rViaje.distR);
  if (rViaje.distR <> corte) then
  begin
    write('Ingrese el dia de viaje: ');
    readln(rViaje.dia);
    write('Ingrese el monto transportado: ');
    readln(rViaje.montoT);
  end;
end;

procedure minViajeD(var dV: datosV; rV: viaje);
begin
  if (rV.montoT < dV.monto) then
  begin
    dV.monto := rV.montoT;
    dV.dist := rV.distR;
  end;
end;

procedure cargarV(var d: vMes; var v: vViajes; var dimL: integer);
var
  i: integer;
begin
  i := 1;
  leerViaje(v[i]);
  while (dimL < dimF2) and (v[i].distR <> corte) do
  begin
    if (v[i].dia >= 1) and (v[i].dia <= dimF) then
    begin
      dimL := dimL + 1;
      d[v[i].dia].totDia := d[v[i].dia].totDia + v[i].montoT;
      d[v[i].dia].cantViajes := d[v[i].dia].cantViajes + 1;
      minViajeD(d[v[i].dia].vMinMonto, v[i]);
    end;
    i := i + 1;
    if i <= dimF2 then
      leerViaje(v[i]);
  end;
end;

procedure minViajeM(monto: real; var min: real; var posMinV: rangoD; i: rangoD);
begin
  if (monto < min) then
  begin
    min := monto;
    posMinV := i;
  end;
end;

procedure procesarV(d: vMes; dimL: integer);
var
  i, posMinV: rangoD;
  mTprom, min: real;
begin
  mTprom := 0;
  posMinV := 1;
  min := 9999;
  for i := 1 to dimF do
  begin
    if d[i].cantViajes > 0 then
    begin
      mTprom := mTprom + d[i].totDia;
      minViajeM(d[i].vMinMonto.monto, min, posMinV, i);
      writeln('El ', i, ' de Marzo se realizaron ', d[i].cantViajes, ' viajes.');
    end;
  end;
  if dimL > 0 then
    mTprom := mTprom / dimL;
  writeln('El monto promedio de los viajes realizados fue $', mTprom:2:2);
  writeln('El ', posMinV, ' de Marzo se realizo el viaje que transporto menos dinero.');
  writeln('Dicho viaje recorrio una distancia de ', d[posMinV].vMinMonto.dist:2:2, ' Kms.');
end;

procedure eliminarDeV(var v: vViajes; var dimL: integer; var elim: boolean; pos: integer);
var
  i: integer;
begin
  if (pos >= 1) and (pos <= dimL) then
  begin
    for i := pos to (dimL - 1) do
      v[i] := v[i + 1];
    elim := true;
    dimL := dimL - 1;
  end;
end;

procedure modificarV(var v: vViajes; var dimL: integer);
var
  i, cantElim: integer;
  distancia: real;
  elim: boolean;
begin
  cantElim := 0;
  distancia := 1000;
  elim := false;
  i := 1;
  while (i <= dimL) do
  begin
    if (v[i].distR = distancia) then
    begin
      eliminarDeV(v, dimL, elim, i);
      if elim then
      begin
        cantElim := cantElim +1;
        elim := false;        
      end
      else
        i := i + 1;
    end
    else
      i := i + 1;
  end;
  writeln('Se eliminaron con exito ',cantElim,' viajes.');
end;

{ Programa principal }
var
  d: vMes;
  v: vViajes;
  dimL: integer;
begin
  Randomize;
  dimL := 0;
  inicializarV(d);
  cargarV(d, v, dimL);
  procesarV(d, dimL);
  modificarV(v, dimL);
end.

{-------------------------------------------------------------------------}

//para probar el codigo de manera automatica, usar esta version que genera valores random
program versionAutomatizada;

uses
  SysUtils;

const
  dimF = 31;  // Número de días en un mes
  dimF2 = 200; // Máximo número de viajes
  corte = 0;   // Marca de fin de datos

type
  rangoD = 1..dimF;
  rangoV = 1..dimF2;

  viaje = record
    dia: rangoD;
    montoT: real;
    distR: real;
  end;

  datosV = record
    dist: real;
    monto: real;
  end;

  datosDia = record
    totDia: real;
    cantViajes: integer;
    vMinMonto: datosV;
  end;

  vMes = array[rangoD] of datosDia;
  vViajes = array[rangoV] of viaje;

procedure inicializarV(var d: vMes);
var
  i: rangoD;
begin
  for i := 1 to dimF do
  begin
    d[i].totDia := 0;
    d[i].cantViajes := 0;
    d[i].vMinMonto.dist := 0;
    d[i].vMinMonto.monto := 9999;
  end;
end;

procedure leerViaje(var rViaje: viaje);
begin
  rViaje.distR := Random(9999) + 1;
  if (rViaje.distR <> corte) then
  begin
    rViaje.dia := Random(dimF) + 1; // Asegura que el día esté entre 1 y 31
    rViaje.montoT := Random(9999);
  end;
end;

procedure minViajeD(var dV: datosV; rV: viaje);
begin
  if (rV.montoT < dV.monto) then
  begin
    dV.monto := rV.montoT;
    dV.dist := rV.distR;
  end;
end;

procedure cargarV(var d: vMes; var v: vViajes; var dimL: integer);
var
  i: integer;
begin
  i := 1;
  leerViaje(v[i]);
  while (dimL < dimF2) and (v[i].distR <> corte) do
  begin
    if (v[i].dia >= 1) and (v[i].dia <= dimF) then
    begin
      dimL := dimL + 1;
      d[v[i].dia].totDia := d[v[i].dia].totDia + v[i].montoT;
      d[v[i].dia].cantViajes := d[v[i].dia].cantViajes + 1;
      minViajeD(d[v[i].dia].vMinMonto, v[i]);
    end;
    i := i + 1;
    if i <= dimF2 then
      leerViaje(v[i]);
  end;
end;

procedure minViajeM(monto: real; var min: real; var posMinV: rangoD; i: rangoD);
begin
  if (monto < min) then
  begin
    min := monto;
    posMinV := i;
  end;
end;

procedure procesarV(d: vMes; dimL: integer);
var
  i, posMinV: rangoD;
  mTprom, min: real;
begin
  mTprom := 0;
  posMinV := 1;
  min := 9999;
  for i := 1 to dimF do
  begin
    if d[i].cantViajes > 0 then
    begin
      mTprom := mTprom + d[i].totDia;
      minViajeM(d[i].vMinMonto.monto, min, posMinV, i);
      writeln('El ', i, ' de Marzo se realizaron ', d[i].cantViajes, ' viajes.');
    end;
  end;
  if dimL > 0 then
    mTprom := mTprom / dimL;
  writeln('El monto promedio de los viajes realizados fue $', mTprom:2:2);
  writeln('El ', posMinV, ' de Marzo se realizo el viaje que transporto menos dinero.');
  writeln('Dicho viaje recorrio una distancia de ', d[posMinV].vMinMonto.dist:2:2, ' Kms.');
end;

procedure eliminarDeV(var v: vViajes; var dimL: integer; var elim: boolean; pos: integer);
var
  i: integer;
begin
  if (pos >= 1) and (pos <= dimL) then
  begin
    for i := pos to (dimL - 1) do
      v[i] := v[i + 1];
    elim := true;
    dimL := dimL - 1;
  end;
end;

procedure modificarV(var v: vViajes; var dimL: integer);
var
  i, cantElim: integer;
  distancia: real;
  elim: boolean;
begin
  cantElim := 0;
  distancia := 1000;
  elim := false;
  i := 1;
  while (i <= dimL) do
  begin
    if (v[i].distR = distancia) then
    begin
      eliminarDeV(v, dimL, elim, i);
      if elim then
      begin
        cantElim := cantElim +1;
        elim := false;        
      end
      else
        i := i + 1;
    end
    else
      i := i + 1;
  end;
  writeln('Se eliminaron con exito ',cantElim,' viajes.');
end;

{ Programa principal }
var
  d: vMes;
  v: vViajes;
  dimL: integer;
begin
  Randomize;
  dimL := 0;
  inicializarV(d);
  cargarV(d, v, dimL);
  procesarV(d, dimL);
  modificarV(v, dimL);
end.