program ejercicio3P4Pte2;

const
  dimF = 31;
  dimF2 = 200;
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

  {modulos}
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
    write('Ingrese distancia recorrida en Km: ');
    readln(rViaje.distR);
    if (rViaje.distR <> corte) then
    begin
      write('Ingrese el dia del viaje: ');
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
    i: rangoV;
  begin
    i := 1;
    leerViaje(v[i]);
    while(dimL < dimF2) and (v[i].distR <> corte) do
    begin
      dimL := dimL +1;
      d[v[i].dia].totDia := d[v[i].dia].totDia + v[i].montoT;
      d[v[i].dia].cantViajes := d[v[i].dia].cantViajes +1;
      minViajeD(d[v[i].dia].vMinMonto,v[i]);
      i := i +1;
      leerViaje(v[i]);
    end;
  end;

  procedure minViajeM(monto: real; var min: real; var posMinV: rangoD; i: rangoD);
  begin
    if(monto < min) then
    begin
      min := monto;
      posMinV := i;
    end;
  end;

  procedure procesarV(d: vMes; dimL: integer);
  var
    i,posMinV: rangoD;
    mTprom,min: real;
  begin
    mTprom := 0;
    posMinV := 1;
    min := 9999;
    for i := 1 to dimF do
      begin
        mTprom := mTprom + d[i].totDia;
        minViajeM(d[i].vMinMonto.monto,min,posMinV,i);
        writeln('El ',i,' de Marzo se realizaron ',d[i].cantViajes,' viajes.');
      end;
      mTprom := mTprom / dimL;
      writeln('El monto promedio de los viajes realizados fue ',mTprom:2:2);
      writeln('El ',posMinV,' de Marzo se realizo el viaje que transporto menos dinero.');
      writeln('Dicho viaje recorrio una distancia de ',d[posMinV].vMinMonto.dist,' Kms.');
  end;

  procedure eliminarDeV(var v:vViajes; var dimL: integer; var elim: boolean; pos: rangoV);
  var
    i: integer;
  begin
    if((pos >= 1) and (pos <= dimL)) then
      begin
        for i := pos to (dimL -1) do
          v[i] := v[i+1];
        elim := true;
        dimL := dimL -1; 
      end;
  end;

  procedure modificarV(var v: vViajes; var dimL: integer);
  var
    elim: boolean;
    i: rangoV;
    distancia: real;
  begin
    distancia := 1000;
    elim := false;
    for i := 1 to dimL do
      if(v[i].distR = distancia) then
        eliminarDeV(v,dimL,elim,i);
  end;


  {programa principal}
  var
    d: vMes;
    v: vViajes;
    dimL: integer;
  begin
    dimL := 0;
    inicializarV(d);
    cargarV(d,v,dimL);
    procesarV(d,dimL);
    modificarV(v,dimL);
  end.


