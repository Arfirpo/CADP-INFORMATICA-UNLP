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

procedure cargarVectorE(var v: vEventos);
begin
  //se dispone.
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
  min1,min2: integer;
begin
  min1 := -1;
  min2 := -1;
  for i := 1 to dimF_eventos do begin
    if(vRec[i] > max1) then begin
      min2 := max1;
      nMin1 := nMin2;
      lMin2 := lMin1;
      min1 := vRec[i];
      nM
    end
    else if(vRec[i] > max2) then begin
      
    end;
  end;
    
end;

{Programa Principal}
var
  vE: vEventos;
  pri: lVentas;
  vRec: vRecaudacion;
begin
  Randomize;
  pri: nil;
  cargarVectorE(vE); //se dispone.
  inicializarVRec(vRec);
  generarListaV(pri);
  procesarListaV(pri,vE,vRec);
end.