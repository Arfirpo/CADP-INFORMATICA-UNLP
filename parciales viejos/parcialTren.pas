{Una empresa de venta de tickets de tren esta analizando la informacion de los viajes realizados por sus trenes durante el año 2022.
Para ello se conoce el codigo de tren, el mes en que se realizo el viaje (entre 1 y 12), la cantidad de pasajeros que viajaron, y el codigo de la ciudad de destino (entre 1 y 20).
La información se encuentra ordenada por codigo de tren.
Ademas, la empresa dispone de una estructura de datos con la informacion de costo del ticket por ciudad de destino.
Realizar un programa que procese la informacion de los viajes y:
  A.Genere una lista que tenga por cada codigo del tren, la cantidad de viajes realizados.
  B.Informe el mes con mayor monto recaudado.
  C.Informe el promedio de pasajeros por cada tren entre todos sus viajes}

program parcial2024;

const
  dimF_mes = 12;
  dimF_cd = 20;
type
  rango_meses = 1..dimF_mes;
  rango_cd = 1..dimF_cd;
  str30 = string[30];

  lViajes = ^nViajes;

  lTrenes = ^nTrenes;

  viaje = record
    codT: integer;
    mesV: rango_meses;
    cantPas: integer;
    codCD: rango_cd;
  end;

  tren = record
      cod: integer;
      cantViajes: integer;
  end;

  nTrenes = record
    dato: tren;
    sig: lTrenes;
  end;

  nViajes = record
    dato: lViajes;
    sig: lViajes;
  end;

  meses = record
    mRec: real;
    mes: str30;
  end;

  vPrecios = array[rango_cd] of real; //se dispone
  vMeses = array[rango_meses] of meses;

{modulos}

procedure inicializarVectorPrecios(var vP: vPrecios); // se dispone.

procedure inicializarVectorMeses(var vM: vMeses);
var 
  i: rango_meses;
begin
  for i := 1 to dimF_mes do
    vM[i].mRec := 0;
    case i of
      1: vM[i].mes := 'Enero';
      2: vM[i].mes := 'Febrero';
      3: vM[i].mes := 'Marzo';
      4: vM[i].mes := 'Abril';
      5: vM[i].mes := 'Mayo';
      6: vM[i].mes := 'Junio';
      7: vM[i].mes := 'Julio';
      8: vM[i].mes := 'Agosto';
      9: vM[i].mes := 'Septiembre';
      10: vM[i].mes := 'Octubre';
      11: vM[i].mes := 'Noviembre';
      12: vM[i].mes := 'Diciembre';
    end;
end;

procedure generarListaViajes(var l: lViajes); // se dispone.

procedure procesarListaViajes(l: lViajes; vP: vPrecios; var vM: vMeses);

  procedure agregarAdelante(var l: lTrenes; cantViajes: integer);
  var
    nue: lTrenes;
  begin
    new(nue);
    nue^.dato := cantViajes;
    nue^.sig := l;
    l := nue;
  end;

  function maxrec(vM: vMeses):integer;
  var
    max: real;
    mes: integer;
    i: rango_meses;
  begin
    max := vM[1].mRec;
    mes := 1;
    for i := 2 to dimF_mes do begin
      if vM[i].mRec > max then
        max := vM[i].mRec;
        mes := i;
    end;
    maxrec := mes;
  end;

  function promPas(pasajeros,viajes: integer):real;
  begin
    promPas := pasajeros / viajes;
  end;

var
  aux: lViajes;
  pri: lTrenes;
  corte_tren: integer;
  cantViajes,totPas: integer;
begin
  aux := l;
  pri := nil;
  while (aux <> nil) do begin
    corte_tren := aux^.dato.codT;
    cantViajes := 0;
    totPas := 0;
    while (aux <> nil) and (aux^.dato.codT = corte_tren) do begin
      cantViajes := cantViajes + 1;
      totPas := totPas + aux^.dato.cantPas;
      vM[aux^.dato.mesV].mRec := vM[aux^.dato.mesV].mRec + (aux^.dato.cantPas * vP[aux^.dato.codCD]);
      aux := aux^.sig;
    end;
    agregarAdelante(pri,cantViajes);
    writeln('El promedio de pasajeros para el tren Nro. ',corte_tren,' fue de aproximadamente ',promPas(totPas,cantViajes):0:2,' pasajeros por viaje');
  end;
  writeln('El mes con mayor monto recaudado fue: ',vM[maxrec(vM)].mes);
end;


{programa principal}

var
  pri: lViajes;
  vP: vPrecios;
  vM: vMeses;
begin
  pri := nil;
  inicializarVectorPrecios(vP); //se dispone.
  inicializarVectorMeses(vM);
  generarListaViajes(pri); //se dispone.
  procesarListaViajes(pri,vP,vM);
end.
