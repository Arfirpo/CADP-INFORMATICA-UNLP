program ejercicio6P6;

type

lSondas = ^nSondas;

str30 = string[30];
rangoE = 1..7;

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

contPorEspectro = array[rangoE] of integer;

{modulos}

procedure generarLista(var l: lSondas);
var
  s: sonda;
begin
  leerSonda(s);
  while s.nom <> 'gaia' do begin
    agregarAdelante(l,s);
    leerSonda(s);
  end;
end;



{programa principal}

var
  s: lSondas;
begin
  s := nil;
  generarLista(s);
  recorrerLista(s);
end.

{--------------------------------------------------------------------------------------------}

//version para pruebas automatizadas

program ejercicio6P6;

uses
  sysUtils;