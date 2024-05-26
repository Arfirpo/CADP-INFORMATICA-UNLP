// program ejercicio7P6;

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

// {modulos}

// procedure agregarAdelante(var l: lSondas; s: sonda);
// var
//   aux: lSondas;
// begin
//   new(aux);
//   aux^.dato := s;
//   aux^.sig := l;
//   l := aux;
// end;

// procedure generarLista(var l: lSondas);

//   procedure leerSonda(var s: sonda);
//   begin
//     with s do begin
//       write('Ingrese el nombre de la sonda: ');
//       readln(nom);
//       write('Ingrese duracion estimada de la mision: ');
//       readln(dMis);
//       write('Ingrese costo de construccion de la sonda: ');
//       readln(cConst);
//       write('Ingrese costo de mantenimiento de la sonda: ');
//       readln(cMant);
//       write('Ingrese el tipo de espectro electromagnetico a estudiar: ');
//       readln(EspElect);
//     end;
//   end;

// var
//   s: sonda;
// begin
//   repeat
//     leerSonda(s);
//     agregarAdelante(l,s);
//   until(s.nom = 'gaia');
// end;

// procedure procesarLista(l: lSondas);

//   procedure filtroH2020(l: lSondas; var cumple,noCumple: lSondas);

//     function okH2020(constr,mant: real; tEspectro: rangoE):boolean;
//     var
//       cumple: boolean;
//     begin
//       cumple := false;
//       if (mant < constr) and (tEspectro <> 1) then
//         cumple := true;
//       okH2020 := cumple;
//     end;

//   begin
//     if (okH2020(l^.dato.cConst, l^.dato.cMant, l^.dato.EspElect)) then
//       agregarAdelante(cumple,l^.dato)
//     else
//       agregarAdelante(noCumple,l^.dato);
//   end;

//   procedure procesarRechazados(l:lSondas; var cantTot: integer; var costTot: real);
//   begin
//     while l <> nil do begin
//       cantTot := cantTot +1;
//       costTot := costTot + (l^.dato.cConst + l^.dato.cMant);
//         l := l^.sig;
//       end;
//     writeln('--------------------------------------------------');
//     writeln(cantTot,' proyecto/s sera/n no seran financiados por H2020.');
//     writeln('--------------------------------------------------');
//     writeln('$',costTot:2:2,' es el costo total de/l los proyecto/s sera/n no seran financiados por H2020.');
//     writeln('--------------------------------------------------');
//   end;

// var
//   cumple,noCumple: lSondas;
//   cantTot: integer; costTot: real;
// begin
//   cumple := nil; noCumple := nil;
//   cantTot := 0; costTot := 0;
//   while l <> nil do begin
//     filtroH2020(l,cumple,noCumple);
//     l := l^.sig;
//   end;
//   procesarRechazados(noCumple,cantTot,costTot);
// end;

// {programa principal}

// var
//   s: lSondas;
// begin
//   s := nil;
//   generarLista(s);
//   procesarLista(s);
// end.

{--------------------------------------------------------------------------------------------}

//version para pruebas automatizadas

program ejercicio6P6;

uses
  sysUtils;

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

vCont = array[rangoE] of integer;

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
      dMis := Random(100) + 1;
      cConst := Random(9999) + 1;
      cMant := Random(9999) + 1;
      EspElect := Random(dimF) + 1;
    end;
  end;

var
  s: sonda;
begin
  repeat
    leerSonda(s);
    agregarAdelante(l,s);
  until (s.nom = 'gaia');
end;

procedure procesarLista(l: lSondas);

  procedure filtroH2020(l: lSondas; var cumple,noCumple: lSondas);

    function okH2020(constr,mant: real; tEspectro: rangoE):boolean;
    begin
      okH2020 := (mant < constr) and (tEspectro <> 1);
    end;

  begin
    if (okH2020(l^.dato.cConst, l^.dato.cMant, l^.dato.EspElect)) then
      agregarAdelante(cumple,l^.dato)
    else
      agregarAdelante(noCumple,l^.dato);
  end;

  procedure procesarRechazados(l:lSondas; var cantTot: integer; var costTot: real);
  begin
    while l <> nil do begin
      cantTot := cantTot +1;
      costTot := costTot + (l^.dato.cConst + l^.dato.cMant);
      writeln('--------------------------------------------------');
      writeln('La sonda "',l^.dato.nom,'", que estudia el espectro ',l^.dato.EspElect,', tiene un costo de construccion de $',l^.dato.cConst:2:2,', un costo de mantenimiento de $',l^.dato.cMant:2:2,',y un costo total de ',(l^.dato.cConst + l^.dato.cMant):2:2);
        l := l^.sig;
      end;
    writeln('--------------------------------------------------');
    writeln(cantTot,' proyecto/s no sera/n financiados por H2020.');
    writeln('--------------------------------------------------');
    writeln('$',costTot:2:2,' es el costo total del/los proyecto/s que no sera/n financiado/s por H2020.');
    writeln('--------------------------------------------------');
  end;

var
  cumple,noCumple: lSondas;
  cantTot: integer; costTot: real;
begin
  cumple := nil; noCumple := nil;
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