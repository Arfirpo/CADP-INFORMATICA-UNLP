{}

program nombrePrograma;

uses
  sysUtils;

const
  dimF_marca = 130;
  dimF_pais = 10;

type
  r_marca = 1..dimF_marca;
  r_pais = 1..dimF_pais;
  str30 = string[30];

  lRepuestos = ^nRepuestos;

  repuesto = record
    cod: integer;
    prec: real;
    codM: r_marca;
    nomP: str30;
  end;

  marca = record
    cod: r_marca;
    nom: str30;
    minPrec: real;
  end;

  vMarcas = array[r_marca] of marca;
  vNom = array[r_pais] of str30;

  nRepuestos = record
    dato: repuesto;
    sig: lRepuestos;
  end;

{modulos}

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

procedure leerRepuesto(var r: repuesto;vN: vNom);
begin
  with r do begin
    cod := Random(9999) - 1;
    if (cod <> -1) then begin
      prec := Random(999) + 1;
      codM := Random(dimF_marca) + 1;
      nomP := vN[Random(5) + 1];
    end;
  end;
end;

procedure insertarOrdenado(var l: lRepuestos; r: repuesto);
var
  nue,ant,act: lRepuestos;
begin
  new(nue);
  nue^.dato := r;
  ant := l;
  act := l;
  while (act <> nil) and (r.nomP > act^.dato.nomP) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = ant) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure generarLista(var l:lRepuestos; vN: vNom); //se dispone
var
  r: repuesto;
begin
  leerRepuesto(r,vN);
  while (r.cod <> -1) do begin
    insertarOrdenado(l,r); //se ordena por nombre de pais.
    leerRepuesto(r,vN);
  end;
end;

procedure cargarVector(var vM: vMarcas;var vN: vNom);
var
  i: r_marca;
begin
  for i := 1 to dimF_marca do begin
    case i of
      1: vN[i] := 'Argentina';
      2: vN[i] := 'Chile';
      3: vN[i] := 'Alemania';
      4: vN[i] := 'Canada';
      5: vN[i] := 'Inglaterra';
    end;

    randomString(2,vM[i].nom);
    vM[i].cod := i;
    vM[i].minPrec := 9999;
  end;
end;

function cumple3(codigo: integer):boolean;
var
  dig: integer;
  ok: boolean;
begin
  ok := true;
  while (codigo <> 0) do begin
    dig := codigo mod 10;
    if (dig = 0) then begin
      ok := false;
      codigo := 0;
    end
    else
      codigo := codigo div 10;
  end;
  cumple3 := ok;
end;

function precMin(precio,min: real):real;
begin
  if (precio < min) then
    min := precio;

  precMin := min;
end;

procedure informarB2(vM: vMarcas);
var
  i: r_marca;
begin
  for i := 1 to dimF_marca do begin
    writeln('Nombre de la Marca: ',vM[i].nom);
    writeln('Precio del producto mas barato: ',vM[i].minPrec:0:2);
    writeln('----------------------------------------------');
  end;
end;

procedure procesarLista(l: lRepuestos; var vM: vMarcas);
var
  corte_nomP: str30;
  cantR,cantP,pCumple3: integer;
begin
  cantP := 0; pCumple3 := 0;
  while (l <> nil) do begin
    corte_nomP := l^.dato.nomP;
    cantR := 0;
    while (l <> nil) and (l^.dato.nomP = corte_nomP) do begin
      //cuento cantidad de repuestos comprados por pais.
      cantR := cantR + 1;
      //actualizo el precio minimo por marca.
      vM[l^.dato.codM].minPrec := precMin(l^.dato.prec,vM[l^.dato.codM].minPrec);
      //cuento paises que cumplen condicion 3.
      if(cumple3(l^.dato.cod)) then
        pCumple3 := pCumple3 + 1;
      //avanzo a otro repuesto.
      l := l^.sig;
    end;
    //al procesar un pais, evaluo y cuento si ese pais cumple condicion b.1.
    if(cantR > 100) then
      cantP := cantP + 1;
    writeln('----------------------------------------------------------');
    writeln('Al pais: ',corte_nomP,' se le compraron ',cantR,' repuestos.');
  end;
  //informo b.1.
  writeln('----------------------------------------------------------');
  if cantP > 0 then
    writeln('A ',cantP,' pais/es se les compro mas de 100 repuestos.')
  else
    writeln('A ningun pais se le compro mas de 100 repuestos.');
  writeln('----------------------------------------------------------');
  //informo b2
  informarB2(vM);
  //informo b.3.
  if (pCumple3 > 0) then
    writeln(pCumple3,' repuesto/s no poseen ningun cero en su codigo.')
  else
    writeln('Ningun repuesto no posee ningun cero en su codigo.');
  writeln('----------------------------------------------------------');
end;


{programa principal}
var
  pri: lRepuestos;
  vM: vMarcas;
  vN: vNom;

begin
  Randomize;
  pri := nil;
  cargarVector(vM,vN);
  generarLista(pri,vN); //se dispone.
  procesarLista(pri,vM);
end.
