program ejercicio12P4;

const
  dimF = 53;

type
  {subrangos}
  rango = 1..galaTot;
  tipos = 1..4;
  str30 = string[30];
  {registros}
  galaxia = record
    tipo: tipos;
    masa: real;
    disT: real;
  end;
  {vectores}
  vGalaxias = array[rango] of galaxia;  //vector de registro de galaxias.
  vTipoGal = array[tipos] of integer;  //vector contador.

{modulos}

procedure leerGalaxia(var g: galaxia);
begin
  writeln('Ingrese el tipo de galaxia: ');
  readln(g.tipo);
  writeln('Ingrese la masa de la galaxia: ');
  readln(g.masa);
  writeln('Ingrese la distancia a la galaxia: ');
  readln(g.disT);
end;



procedure cargarVector(var gal: vGalaxias; var tGal: vTipoGal);
var
  i: integer;
  g: galaxia;
begin
  for i := 1 to dimF do
    begin
      leerGalaxia(g);
      gal[i] := g;
      tGal[i] := 0;
    end;
end;

procedure contGalaxias(var tGal: vTipoGal, i: integer);
begin
  if gal[i].tipo = 1 then
    tGal[i] := tGal[i] +1;
  else if gal[i].tipo = 2 then
    tGal[i] := tGal[i] +1;
  else if gal[i].tipo = 3 then
    tGal[i] := tGal[i] +1;
  else if tGal[i].tipo = 4
    tGal[i] := tGal[i] +1;
end;

procedure recorrerVector(gal: vGalaxias; var tGal: vTipoGal);
var
  i: rango;
begin
  for i := 1 to dimF do
    begin
      contGalaxias(tGal, i);
    end;
    
end;

{programa principal}
var
  gal: vGalaxias;
  tGal: vTipoGal;
begin
  cargarVector(gal,tGal);
  recorrerVector(gal,tGal);
end;