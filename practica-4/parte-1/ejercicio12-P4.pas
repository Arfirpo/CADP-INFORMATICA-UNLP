program ejercicio12P4;

{constantes}
const
  dimF = 10;  //Grupo Local de Galaxias.
  tG = 4;     //Tipos de galaxia por su forma.

type
  {subrangos}
  rango = 1..dimF;
  tipos = 1..tG;
  str30 = string[30];
  {registros}
  galaxia = record
    nom: str30;
    tipo: tipos;
    masa: real;
    disT: real;
  end;
  
  {vectores}
  vGalaxias = array[rango] of galaxia;  //vector de registro de galaxias.
  vTipoGal = array[tipos] of integer;  //vector contador.

{modulos}

procedure leerGalaxia(var g: galaxia); //recibe un registro g tipo galaxia vacio y lo devuelve con los campos completos.
begin
  write('Ingrese el nombre de galaxia: ');
  readln(g.nom);
  write('Ingrese el tipo de galaxia: ');
  readln(g.tipo);
  write('Ingrese la masa de la galaxia: ');
  readln(g.masa);
  write('Ingrese la distancia de la galaxia al Planeta Tierra: ');
  readln(g.disT);
  writeln();
end;

procedure cargarVector(var g: vGalaxias; var c: vTipoGal);  //recibe un vector de registros (gal) y un vector contador (tGal). El primero lo carga hasta dimF y el segundo lo inicializa en 0.
var
  i: rango;
begin
  for i := 1 to dimF do
    begin
      //le paso la galaxia indexada. ej: en la 1° vuelta del for le paso el registro de la posicion 1 del vector.
      leerGalaxia(g[i]);  
    end;
  for i := 1 to tG do
    c[i] := 0;
end;

procedure procesarGalaxia(g: Galaxia; var c: vTipoGal; var mTotG,mTotP,max1,max2,min1,min2: real; var cantGal: integer; var nGalMax1,nGalMax2,nGalMin1,nGalMin2: str30);
begin
  {conteo por tipo de galaxia}
  c[g.tipo] := c[g.tipo] + 1;

  {Importante: el vector contador se recorre usando como indice: el campo "tipo" del registro galaxia (g) = c[g.tipo] y es en esa posicion donde incrementa el valor contado en +1, que fue inicializado en 0 por "cargarVector"}

  {calculos de masa total general y masa total de tres galaxias especiales}
  mTotG := mTotG + g.masa;

  //si la galaxia es "via lactea", "andromeda" o "triangulo", suma a la masa acumulada de las tres.
  if ((g.nom = 'via lactea') or (g.nom = 'andromeda') or (g.nom = 'triangulo')) then  
    mTotP := mTotP + g.masa;

  {conteo de las galaxias no irregulares cercanas a la tierra}

  //si la galaxia no es irregular (tipo 4) y esta a menos de 1000 parsecs de distancia de la tierra, suma 1 a la cantidad de galaxias.
  if ((g.tipo <> 4) and (g.disT < 1000)) then  
    cantGal := cantGal + 1;

  {calculo de maximos y minimos}

  if g.masa > max1 then
  begin
    max2 := max1;
    nGalMax2 := nGalMax1;
    max1 := g.masa;
    nGalMax1 := g.nom;
  end
  else if g.masa > max2 then
  begin
      max2 := g.masa;
      nGalMax2 := g.nom;
  end;
  if g.masa < min1 then
    begin
      min2 := min1;
      nGalMin2 := nGalMin1;
      min1 := g.masa;
      nGalMin1 := g.nom;
    end
  else if g.masa < min2 then
  begin
      min2 := g.masa;
      nGalMin2 := g.nom;
  end;
end;

function porcMasa(mTotG,mTotP: real):real;
begin
  porcMasa := (mTotP / mTotG) * 100; 
end;

procedure recorrerVector(g: vGalaxias; var c: vTipoGal; var mTotG,mTotP,max1,max2,min1,min2: real; var cantGal: integer; var nGalMax1,nGalMax2,nGalMin1,nGalMin2: str30);
var
  i: rango;
begin

{proceso por galaxia}

  for i := 1 to dimF do
      procesarGalaxia(g[i],c,mTotG,mTotP,max1,max2,min1,min2,cantGal,nGalMax1,nGalMax2,nGalMin1,nGalMin2);
  
{informo resultados}

  writeln('Resultados: ');
  writeln();
  {informo punto a.}
  for i := 1 to tG do
    case i of
      1: writeln('Hay ',c[i], ' galaxia/s eliptica/s');
      2: writeln('Hay ',c[i], ' galaxia/s espiralada/s');
      3: writeln('Hay ',c[i], ' galaxia/s lenticular/es');
      4: writeln('Hay ',c[i], ' galaxia/s irregular/es');
    end;
  writeln();
  {informo punto b.}
  writeln('La masa total acumulada de las tres galaxias principales es de ', mTotP:2:2, 'Kg');
  writeln('que representa el ', porcMasa(mTotG, mTotP):2:2, '% de la masa de todas las galaxias procesadas');
  writeln();
  {informo punto c.}
  writeln(cantGal, ' galaxias no irregulares se encuentran a menos de 1000pc de distancia de la tierra');
  writeln();
  {informo punto d.}
  writeln('Las dos galaxias con mayor masa son: ');
  writeln('1. ', nGalMax1);
  writeln('2. ', nGalMax2);
  writeln();
  writeln('Las dos galaxias con menor masa son: ');
  writeln('1. ', nGalMin1);
  writeln('2. ', nGalMin2);
end;

{programa principal}
var
  g: vGalaxias;
  c: vTipoGal;
  cantGal: integer;
  mTotG,mTotP,max1,max2,min1,min2: real;
  nGalMax1,nGalMax2,nGalMin1,nGalMin2: str30;

begin
  mTotG := 0; mTotP := 0; cantGal := 0;
  max1 := -1; max2 := -1; min1 := 9999; min2 := 9999;
  nGalMax1 := ''; nGalMax2 := ''; nGalMin1 := ''; nGalMin2 := '';
  cargarVector(g,c);
  recorrerVector(g,c,mTotG,mTotP,max1,max2,min1,min2,cantGal,nGalMax1,nGalMax2,nGalMin1,nGalMin2);
end.