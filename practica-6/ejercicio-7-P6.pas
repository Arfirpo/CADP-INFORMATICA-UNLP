program ejercicio7P6;

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

{modulos}

procedure agregarAdelante(var l: lSondas; s: sonda);
var
  aux: lSondas;
begin
  new(aux);
  aux^.dato := s;
  aux^.sig := l;
  l := aux;
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

var
  s: sonda;
begin
  repeat
    leerSonda(s);
    agregarAdelante(l,s);
  until(s.nom = 'gaia');
end;

procedure procesarListaLista(l: lSondas);

  procedure filtroH2020(l: lSondas; var cumple,noCumple: lSondas);

    function okH2020(constr,mant: real; tEspectro: rangoE):boolean;
    var
      cumple: boolean;
    begin
      cumple := false;
      if (mant < constr) and (tEspectro <> 1) then
        cumple := true;
      okH2020 := ok;
    end;

  begin
    if (okH2020(l^.dato.cConst, l^.dato.cMant, l^.dato.EspElect)) then
      agregarAdelante(cumple,l^.dato);
    else
      agregarAdelante(noCumple,l^.dato);
  end;

  procedure procesarRechazados(l:lSondas; var cantTot: integer; var constTot: real);
  begin
    while l <> nil do begin
      cantTot := cantTot +1;
      costTot := costTot + (l^.dato.cConst + l^.dato.cMant);
        l := l^.sig;
      end;
  end;
  writeln('--------------------------------------------------');
  writeln(cantTot,' proyecto/s sera/n no seran financiados por H2020.');
  writeln('--------------------------------------------------');
  writeln('$'costTot:2:2,' es el costo total de/l los proyecto/s sera/n no seran financiados por H2020.');
  writeln('--------------------------------------------------');

var
  aux,cumple,noCumple: lSondas;
  cantTot: integer; costTot: real;
begin
  aux := l; cumple := nil; noCumple := nil;
  cantTot := 0; costTot := 0;
  while l <> nil do begin
    filtroH2020(l,cumple,noCumple);
    l := l^.sig;
  end;
  procesarRechazados(noCumple,cantTot,costTot);
end;

{programa principal}

var
  s: lSondas;
begin
  s := nil;
  generarLista(s);
  procesarLista(s);
end.

{--------------------------------------------------------------------------------------------}

//version para pruebas automatizadas

// program ejercicio6P6;

// uses
//   sysUtils;

// const
//   dimF = 7;

// type

// lSondas = ^nSondas;

// str30 = string[30];
// rangoE = 1..dimF;

// sonda = record
//   nom: str30;
//   dMis: integer;
//   cConst: real;
//   cMant: real;
//   EspElect: rangoE;
// end;

// nSondas = record
//   dato: sonda;
//   sig: lSondas;
// end;

// vCont = array[rangoE] of integer;

// {modulos}

// procedure generarLista(var l: lSondas);

//   procedure leerSonda(var s: sonda);
//   begin
//     with s do begin
//       write('Ingrese el nombre de la sonda: ');
//       readln(nom);
//       dMis := Random(100) + 1;
//       cConst := Random(9999) + 1;
//       cMant := Random(9999) + 1;
//       EspElect := Random(dimF) + 1;
//     end;
//   end;

//   procedure agregarAdelante(var l: lSondas; s: sonda);
//   var
//     aux: lSondas;
//   begin
//     new(aux);
//     aux^.dato := s;
//     aux^.sig := l;
//     l := aux;
//   end;

// var
//   s: sonda;
// begin
//   repeat
//     leerSonda(s);
//     agregarAdelante(l,s);
//   until (s.nom = 'gaia');
// end;

// procedure inicializarV (var c: vCont);
// var
//   i: rangoE;
// begin
//   for i := 1 to dimF do
//     c[i] := 0;
// end;

// procedure recorrerLista(l: lSondas; var c: vCont);

//   procedure masCostosa(constr,mant: real; nom: str30; var max: real; var nomMax: str30);
//   var
//     costoTot: real;
//   begin
//     costoTot := constr + mant;
//     if costoTot > max then begin
//       max := costoTot;
//       nomMax := nom;
//     end;
//   end;

//   procedure cargarV(pos: rangoE; var c: vCont);
//   begin
//     c[pos] := c[pos] + 1;
//   end;

// var
//   nMaxCost, nCConst: str30; i: rangoE; 
//   cantSondas,cantMaxD,cantMaxCost: integer; 
//   max,promCConst,promDurM: real; 
//   aux: lSondas;
// begin
//   nMaxCost := ''; nCConst := ''; cantSondas := 0; max:= -1; 
//   promCConst := 0; promDurM := 0; cantMaxD := 0; cantMaxCost := 0;
//   aux := l;

//   while (aux <> nil) do begin
//     cantSondas := cantSondas + 1;
//     promCConst := promCConst + aux^.dato.cConst;
//     promDurM := promDurM + aux^.dato.dMis;
//     masCostosa(aux^.dato.cConst,aux^.dato.cMant,aux^.dato.nom,max,nMaxCost);
//     cargarV(aux^.dato.EspElect,c);
//     aux := aux^.sig;
//   end;
  
//   promCConst := (promCConst / cantSondas);
//   promDurM := (promDurM / cantSondas);
  
//   aux := l;

//   while aux <> nil do begin
//     if aux^.dato.dMis > promDurM then
//       cantMaxD := cantMaxD +1;
//     if aux^.dato.cConst > promCConst then
//       cantMaxCost := cantMaxCost +1;
//     aux := aux^.sig;    
//   end;

//   writeln();
//   writeln('-------------------------------------------------------------');
//   writeln('La cantidad de sondas que realizaran estudios se dividen en: ');
//   writeln();
//   for i := 1 to dimF do begin
//     case i of
//       1: writeln(c[i],' estudiara/n el espectro electromagnetico "radio"');
//       2: writeln(c[i],' estudiara/n el espectro electromagnetico "microondas"');
//       3: writeln(c[i],' estudiara/n el espectro electromagnetico "infrarojo"');
//       4: writeln(c[i],' estudiara/n el espectro electromagnetico "luz visible"');
//       5: writeln(c[i],' estudiara/n el espectro electromagnetico "ultravioleta"');
//       6: writeln(c[i],' estudiara/n el espectro electromagnetico "rayos x"');
//       7: writeln(c[i],' estudiara/n el espectro electromagnetico "rayos gamma"');
//     end;
//   end;
//   writeln('-------------------------------------------------------------');
//   writeln('La sonda mas costosa es: ',nMaxCost);
//   writeln('-------------------------------------------------------------');
//   writeln('La cantidad de sondas cuya duracion es mayor al promedio de todas las sondas es: ',cantMaxD);
//   writeln('La cantidad de sondas cuyo costo de construccion es mayor al promedio de todas las sondas es: ',cantMaxCost);
//   writeln('-------------------------------------------------------------');
// end;

// {programa principal}

// var
//   s: lSondas; c : vCont;
// begin
//   Randomize;
//   s := nil;
//   inicializarV(c);
//   generarLista(s);
//   recorrerLista(s,c);
// end.