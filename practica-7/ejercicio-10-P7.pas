program ejercicio10P7;

uses
  sysUtils;

const
  dimF_cultivos = 20;
  dimF_tipos = 4;

type
  str30 = string[30];
  rMeses = 1..12;
  rangoTipos = 1..dimF_tipos;
  rCultivos = 1..dimF_cultivos;

  lEmpresas = ^nEmpresas;

  cultivo = record
    tipo: str30;
    h_ded: real;
    m_ciclo_cultivo: integer;
  end;

  vCultivos = array[rCultivos] of cultivo;

  cultivos = record
    c: vCultivos;
    dimL: integer;
  end;

  empresa = record
    cod: integer;
    nom: str30;
    estatal: boolean;
    rad: str30;
    cult: cultivos;
  end;

  nEmpresas = record
    dato: empresa;
    sig: lEmpresas;
  end;

  vTipos = array[rangoTipos] of str30;

{modulos}

procedure cargarVTipos(var v: vTipos);
begin
  v[1] := 'trigo';
  v[2] := 'maiz';
  v[3] := 'soja';
  v[4] := 'girasol';
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

procedure leerCultivo(var c: cultivo; v: vTipos);
begin
  with c do begin
    h_ded := Random(501);
    if(h_ded <> 0) then begin
      tipo := v[Random(4) + 1];
      m_ciclo_cultivo := Random(12) + 1;
    end;
  end;
end;

procedure cargarCultivos(var cult: cultivos; v: vTipos);
var
  c: cultivo;
begin
  cult.dimL := 0;
  leerCultivo(c,v);
  while(cult.dimL < dimF_cultivos) and (c.h_ded <> 0) do begin
    cult.dimL := cult.dimL + 1;
    cult.c[cult.dimL] := c;
    leerCultivo(c,v);
  end;
end;

procedure leerempresa(var e: empresa; v: vTipos);
begin
  with e do begin
    cod := Random(3001) - 1;
    if (cod <> -1) then begin
      randomString(5,nom);
      estatal := Random(2) = 0;
      if(Random(6) = 0) then
        rad := 'san miguel del monte'
      else
        randomString(6,rad);
      cargarCultivos(cult,v);
    end;
  end;
end;

procedure armarNodo(var l: lEmpresas; e: empresa);
var
  nue: lEmpresas;
begin
  new(nue);
  nue^.dato := e;
  nue^.sig := l;
  l := nue;
end;

procedure generarListaE(var l: lEmpresas; v: vTipos);
var
  e: empresa;
begin
  leerempresa(e,v);
  while(e.cod <> -1) do begin
    armarNodo(l,e);
    leerempresa(e,v);
  end;
end;

procedure incrementarTiempo(var c: cultivo; tEmpresa: boolean);
begin
  if(c.tipo = 'girasol') and not(tempresa) then
    c.m_ciclo_cultivo := c.m_ciclo_cultivo + 1;
end;

procedure procesarCultivos(var cult: cultivos; tipoE: boolean; var hSoja,hTotal: real; var tMaiz: integer; var okT: boolean);
var
  i: rCultivos;
begin
  for i := 1 to cult.dimL do begin
    if (cult.c[i].tipo = 'trigo') then
      okT := true
    else if (cult.c[i].tipo = 'soja') then
      hSoja := hSoja + cult.c[i].h_ded
    else if (cult.c[i].tipo = 'maiz') then
      tMaiz := tMaiz + cult.c[i].m_ciclo_cultivo;
    hTotal := hTotal + cult.c[i].h_ded;
    incrementarTiempo(cult.c[i],tipoE);
  end;
end;

procedure actualizarMaxMaiz(empresa: str30; tiempo: integer; var max: integer; var maxempresa: str30);
begin
  if (tiempo > max) then begin
    max := tiempo;
    maxempresa := empresa;
  end;
end;

function procesarCod(cod: integer):boolean;
var
  dig,ceros: integer;
begin
  ceros := 0;
  while(cod <> 0) and (ceros < 2) do begin
    dig := cod mod 10;
    if (dig = 0) then
      ceros := ceros + 1;
    cod := cod div 10;
  end;
  procesarCod := (ceros = 2);
end;

function cumpleB(rad: str30; okT: boolean; cod: integer):boolean;
begin
  cumpleB := ((rad = 'san miguel del monte') and (okT) and (procesarCod(cod)));
end;

procedure procesarListaE(l: lEmpresas);
var
  tCult_maiz, max: integer;
  cant_h_soja, cant_h_tot,porcent: real;
  okT: boolean;
  maxempresa: str30;
begin
  cant_h_soja := 0;
  cant_h_tot := 0;
  porcent := 0;
  max := -1;
  maxempresa := '';
  writeln('----------------------------------------------------');
  while(l <> nil) do begin
    tCult_maiz := 0;
    okT := false;
    procesarCultivos(l^.dato.cult,l^.dato.estatal,cant_h_soja,cant_h_tot,tCult_maiz,okT);
    if (cumpleB(l^.dato.rad,okT,l^.dato.cod)) then
      writeln('La empresa ',l^.dato.nom,' esta radicada en San Miguel del Monte, cultiva trigo y su codigo de empresa posee al menos dos ceros.');
    actualizarMaxMaiz(l^.dato.nom,tCult_maiz,max,maxempresa);
    l := l^.sig;
  end;
  porcent := (cant_h_soja * 100) / cant_h_tot;
  writeln('----------------------------------------------------');
  writeln(cant_h_soja:0:0,' hct. estan dedicadas al cultivo de soja. representan un ',porcent:0:2,'% del total de hectareas cultivadas.');
  writeln('----------------------------------------------------');
  writeln('La empresa ',maxempresa,' es la que mas tiempo le dedica al cultivo de maiz.');
  writeln('----------------------------------------------------');
end;


{Programa Principal}
var
  pri: lEmpresas;
  vT: vTipos;

begin
  Randomize;
  pri := nil;
  cargarVTipos(vT); //cree este vector para automatizar la carga de los tipos de cultivo.
  generarListaE(pri,vT);
  procesarListaE(pri);
end.