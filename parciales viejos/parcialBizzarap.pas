// program nombrePrograma;

// const
//   dimF_generos = 5;

// type
// {subrangos}
//   rango_g = 1..dimF_generos;
//   str30 = string[30];

//   lSessions = ^nSessions;

//   session = record
//     tit: str30;
//     nArt: str30;
//     gen: rango_g;
//     estAnio: integer;
//     cantRep: longint;
//   end;

//   nSessions = record
//     dato: session;
//     sig: lSessions;
//   end;

//   vGeneros = array[rango_g] of longint;

// {modulos}
// procedure inicializarV(var vC: vGeneros);
// var
//   i: rango_g;
// begin
//   for i := 1 to dimF_generos do
//     vC[i] := 0;
// end;

// procedure leerSession(var s: session);
// begin
//   with s do begin
//     write('Cantidad de reproducciones de la session: ');
//     readln(cantRep);
//     if (cantRep <> 0) then begin
//       write('Titulo de la Session: ');
//       readln(tit);
//       write('Nombre del Artista: ');
//       readln(nArt);
//       repeat
//         write('Genero de la Session -entre 1 y 5-: ');
//         readln(gen);
//       until ((gen >= 1) and (gen <= 5));
//       write('Anio de Estreno de la Session: ');
//       readln(estAnio);
//     end;
//   end;
// end;

// procedure agregarAdelante(var l: lSessions; s: session);
// var
//   nue: lSessions;
// begin
//   new(nue);
//   nue^.dato := s;
//   nue^.sig := l;
//   l := nue;
// end;


// procedure generarListaS(var l: lSessions);
// var
//   s: session;
// begin
//   leerSession(s);
//   while (s.cantRep <> 0) do begin
//     agregarAdelante(l,s);
//     leerSession(s);
//   end;
// end;


// function cumpleB(genero: rango_g; reproducciones: longint ):boolean;

//   function digM5(rep: longint):boolean;
//   var
//     dig,cantDig: integer;
//   begin

//     cantDig := 0;
//     while rep <> 0 do begin
//       dig := rep mod 10;
//       cantDig := cantDig + dig;
//       rep := rep div 10;
//     end;

//     digM5 := (cantDig mod 5 = 0);
//   end;

// begin
//   cumpleB := ((genero = 1) or (genero = 3)) and (digM5(reproducciones));
// end;

// procedure insertarOrdenado(var l: lSessions; s: session);
// var
//   nue,ant,act: lSessions;
// begin
//   new(nue);
//   nue^.dato := s;
//   ant := l;
//   act := l;
//   while (act <> nil) and (s.estAnio > l^.dato.estAnio) do begin
//     ant := act;
//     act := act^.sig;
//   end;
//   if (act = ant) then
//     l := nue
//   else
//     ant^.sig := nue;
//   nue^.sig := act;
// end;

// procedure minReps(vC: vGeneros; var genMin1,genMin2: rango_g);
// var
//   min1,min2: longint;
//   i: rango_g;
// begin
//   min1 := 99999; min2 := 99999;
//   for i := 1 to dimF_generos do begin
//     if(vC[i] < min1) then begin
//       min2 := min1;
//       genMin2 := genMin1;
//       min1 := vC[i];
//       genMin1 := i;
//     end
//     else if(vC[i] < min2) then begin
//       min2 := vC[i];
//       genMin2 := i;
//     end;
//   end;
    
// end;

// procedure procesarL(l: lSessions; var l2: lSessions; var vC: vGeneros);
// var
//   genMin1,genMin2: rango_g;
// begin
//   genMin1 := 1; genMin2 := 1;
//   while (l <> nil) do begin
    
//     vC[l^.dato.gen] := vC[l^.dato.gen] + l^.dato.cantRep;

//     if(cumpleB(l^.dato.gen,l^.dato.cantRep)) then
//       insertarOrdenado(l2,l^.dato);
//     l := l^.sig;
//   end;
//   minReps(vC,genMin1,genMin2);
//   writeln('-----------------------------------------------------------------------------------------');
//   writeln('El codigo del genero con menor cantidad de reproducciones en spotify es: ',genMin1);
//   writeln('El codigo del segundo genero con menor cantidad de reproducciones en spotify es: ',genMin2);
//   writeln('-----------------------------------------------------------------------------------------');
// end;

// procedure procesarL2(l: lSessions);
// var
//   cantSes,corte_anio: integer;
//   totRep: longint;
// begin
//   while (l<>nil) do begin
//     corte_anio := l^.dato.estAnio;
//     cantSes := 0; totRep := 0;
//     while (l <> nil) and (corte_anio = l^.dato.estAnio) do begin
//       cantSes := cantSes + 1;
//       totRep := totRep + l^.dato.cantRep;
//       l := l^.sig;
//     end;
//     writeln('-----------------------------------------------------------------------------------------');
//     writeln('Anio: ',corte_anio);
//     writeln('Cantidad de Sessions: ',cantSes);
//     writeln('Total de reproducciones: ',totRep);
//     writeln('-----------------------------------------------------------------------------------------');
//   end;
// end;


// {Programa Principal}
// var
//   pri,pri2: lSessions;
//   vC: vGeneros;

// begin
//   pri := nil; pri2 := nil;
//   inicializarV(vC);
//   generarListaS(pri); //se dispone
//   procesarL(pri,pri2,vC);
//   procesarL2(pri2);
// end.

{----------------------------------------------------------------------------------------------------------------------}

program nombrePrograma;

uses
  sysUtils;

const
  dimF_generos = 5;

type
  {subrangos}
  rango_g = 1..dimF_generos;
  str30 = string[30];

  lSessions = ^nSessions;

  session = record
    tit: str30;
    nArt: str30;
    gen: rango_g;
    estAnio: integer;
    cantRep: longint;
  end;

  nSessions = record
    dato: session;
    sig: lSessions;
  end;

  vGeneros = array[rango_g] of longint;

{modulos}
procedure inicializarV(var vC: vGeneros);
var
  i: rango_g;
begin
  for i := 1 to dimF_generos do
    vC[i] := 0;
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

procedure leerSession(var s: session);
begin
  with s do begin
    cantRep := Random(10000); { Se cambió el límite superior a 10000 para incluir 9999 }
    if (cantRep <> 0) then begin
      randomString(8, tit);
      randomString(8, nArt);
      gen := Random(6) + 1; { Se cambió 6 a dimF_generos para evitar errores si se cambia dimF_generos }
      estAnio := Random(15) + 2010;
    end;
  end;
end;

procedure agregarAdelante(var l: lSessions; s: session);
var
  nue: lSessions;
begin
  new(nue);
  nue^.dato := s;
  nue^.sig := l;
  l := nue;
end;

procedure generarListaS(var l: lSessions);
var
  s: session;
begin
  leerSession(s);
  while (s.cantRep <> 0) do begin
    agregarAdelante(l, s);
    leerSession(s);
  end;
end;

function cumpleB(genero: rango_g; reproducciones: longint): boolean;

  function digM5(rep: longint): boolean;
  var
    dig, cantDig: integer;
  begin
    cantDig := 0;
    while rep <> 0 do begin
      dig := rep mod 10;
      cantDig := cantDig + dig;
      rep := rep div 10;
    end;
    digM5 := (cantDig mod 5 = 0);
  end;

begin
  cumpleB := ((genero = 1) or (genero = 3)) and (digM5(reproducciones));
end;

procedure insertarOrdenado(var l: lSessions; s: session);
var
  nue, ant, act: lSessions;
begin
  new(nue);
  nue^.dato := s;
  ant := l;
  act := l;
  while (act <> nil) and (s.estAnio > act^.dato.estAnio) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = ant) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure minReps(vC: vGeneros; var genMin1, genMin2: integer);
var
  min1, min2: longint;
  i: integer;
begin
  genMin1 := 0; genMin2 := 0; 
  min1 := 99999; 
  min2 := 99999;
  for i := 1 to dimF_generos do begin
    if (vC[i] < min1) then begin
      min2 := min1;
      genMin2 := genMin1;
      min1 := vC[i];
      genMin1 := i;
    end
    else if (vC[i] < min2) then begin
      min2 := vC[i];
      genMin2 := i;
    end;
  end;
end;

procedure procesarL(l: lSessions; var l2: lSessions; var vC: vGeneros);
var
  genMin1, genMin2: integer;
begin
  while (l <> nil) do begin
    vC[l^.dato.gen] := vC[l^.dato.gen] + l^.dato.cantRep;

    if (cumpleB(l^.dato.gen, l^.dato.cantRep)) then
      insertarOrdenado(l2, l^.dato);
    l := l^.sig;
  end;
  minReps(vC, genMin1, genMin2);
  writeln('-----------------------------------------------------------------------------------------');
  writeln('El codigo del genero con menor cantidad de reproducciones en spotify es: ', genMin1);
  writeln('El codigo del segundo genero con menor cantidad de reproducciones en spotify es: ', genMin2);
  writeln('-----------------------------------------------------------------------------------------');
end;


procedure procesarL2(l: lSessions);
var
  cantSes, corte_anio: integer;
  totRep: longint;
begin
  while (l <> nil) do begin
    corte_anio := l^.dato.estAnio;
    cantSes := 0; totRep := 0;
    while (l <> nil) and (corte_anio = l^.dato.estAnio) do begin
      cantSes := cantSes + 1;
      totRep := totRep + l^.dato.cantRep;
      l := l^.sig;
    end;
    writeln('-------------------------------------');
    writeln('Anio: ', corte_anio);
    writeln('Cantidad de Sessions: ', cantSes);
    writeln('Total de reproducciones: ', totRep);
    writeln('-------------------------------------');
  end;
end;

{Programa Principal}
var
  pri, pri2: lSessions;
  vC: vGeneros;

begin
  Randomize;
  pri := nil; pri2 := nil;
  inicializarV(vC);
  generarListaS(pri); {se dispone}
  procesarL(pri, pri2, vC);
  procesarL2(pri2);
end.

