// program parcialFutbolistas;

// const
//   dimF_equipo = 28;
//   dimF_fechas = 27;
//   dimF_cal = 10;
//   anioAct = 2022;

//   type

//     r_equipo = 1..dimF_equipo;
//     r_fechas = 1..dimF_fechas;
//     r_cal = 1..dimF_cal;
//     str30 = string[30];

//     lJugadores = ^nJugadores;

//     vCal = array[r_fechas] of real;

//     jugador = record
//       cod: integer;
//       apYnom: str30;
//       cEquipo: r_equipo;
//       aNac: integer;
//       cal: vCal;
//     end;

//     nJugadores = record
//       dato: jugador;
//       sig: lJugadores;
//     end;

//     vCont = array[r_equipo] of integer;

// {modulos}

// procedure inicializarContador(var c: vCont);
// var
//   i: r_equipo;
// begin
//   for i := 1 to dimF_equipo do
//     c[i] := 0;
// end;

// procedure leerJugador(var j: jugador);

//   procedure cargarCalificaciones(var cal: vCal);
//   var
//     i: r_fechas;
//     nota: r_cal;
//   begin
//     for i := 1 to dimF_fechas do begin
//       repeat
//         write('Calificacion Partido Fecha ',i,': ');
//         readln(nota);
//         cal[i] := nota;
//       until ((nota >= 0) and (nota <= 10));
//     end;
//   end;

// begin
//   with j do begin  
//     write('Codigo de Jugador: ');
//     readln(cod);
//     if (cod <> 0) then begin
//       write('Apellido y Nombre del Jugador: ');
//       readln(apYnom);
//       write('Codigo de Equipo: ');
//       readln(cEquipo);
//       write('Anio de Nacimiento del Jugador: ');
//       readln(aNac);
//       cargarCalificaciones(j.cal);
//     end;
//   end;
// end;

// procedure agregarAdelante(var l: lJugadores; j: jugador);
// var
//   nue: lJugadores;
// begin
//   new(nue);
//   nue^.dato := j;
//   nue^.sig := l;
//   l := nue;
// end;

// procedure generarLista(var l: lJugadores);
// var
//   j: jugador;
// begin
//   leerJugador(j);
//   while (j.cod <> 0) do begin
//     agregarAdelante(l,j);
//     leerJugador(j);
//   end;
// end;

// procedure informarA(vC: vCont);
// var
//   i: r_equipo;
// begin
//   for i := 1 to dimF_equipo do begin
//     if (vC[i] <> 0) then
//       writeln('El equipo N° ',i,' posee ',vC[i],' jugadores con mas de 35 anios.')
//     else
//       writeln('El equipo N° ',i,' no posee jugadores con mas de 35 anios.');
//   end;
// end;

// function cumpleA(aNac: integer):boolean;
// begin
//   cumpleA := ((anioAct - aNac) > 35);
// end;

// procedure promedio(cal: vCal; var cantJug: integer; var promCal: real);
// var
//   i: r_fechas;
//   totCal: real;
// begin
//   totCal := 0;
//   for i := 1 to dimF_fechas do
//     if cal[i] > 0 then begin
//       cantJug := cantJug + 1;
//       totCal := totCal + cal[i];
//     end;
//     promCal := totCal / cantJug;
// end;

// procedure maxProm(codJug: integer; promCal: real; var max1,max2: real; var codMax1,codMax2: integer);
// begin
//   if (promCal > max1) then begin
//     max2 := max1;
//     codMax2 := codMax1;
//     max1 := promCal;
//     codMax1 := codJug;
//   end
//   else if(promCal > max2) then begin
//     max2 := promCal;
//     codMax2 := codJug;
//   end;
// end;

// function cumpleDig(codJug: integer): boolean;
// var
//   dig,cantDig: integer;
// begin
//   cantDig := 0;

//   while (codJug <> 0) do begin
//     dig := codJug mod 10;
//     if(dig mod 2 = 1) then
//       cantDig := cantDig + 1;
//     codJug := codJug div 10;
//   end;
//   cumpleDig := (cantDig = 3);
// end;

// procedure insertarOrdenado(var l: lJugadores; j: jugador);
// var
//   nue,ant,act: lJugadores;
// begin
//   new(nue);
//   nue^.dato := j;
//   ant := l;
//   act := l;
//   while(act <> nil) and (j.cod > act^.dato.cod) do begin
//     ant := act;
//     act := act^.sig;
//   end;
//   if (act = ant) then
//     l := nue
//   else
//     ant^.sig := nue;
//   nue^.sig := act;
// end;


// function cumpleC(codJug,aNac: integer): boolean;
// begin
//   cumpleC := (cumpleDig(codJug)) and ((aNac >= 1983) and (aNac <= 1990));
// end;

// procedure procesarLista(l: lJugadores; var l2: lJugadores; var vC: vCont);
// var
//   codMax1,codMax2,cantJug: integer;
//   max1,max2,promCal: real;
// begin
//   max1 := -1; max2 := -1;
//   codMax1 := 0; codMax2 := 0;
//   while (l <> nil) do begin
//     promCal := 0; cantJug := 0;

//     if cumpleA(l^.dato.aNac) then
//       vC[l^.dato.cEquipo] := vC[l^.dato.cEquipo] + 1;

//     promedio(l^.dato.cal,cantJug,promCal);

//     if(cantJug > 14) then
//       maxProm(l^.dato.cod,promCal,max1,max2,codMax1,codMax2);

//     if(cumpleC(l^.dato.cod,l^.dato.aNac)) then
//       insertarOrdenado(l2,l^.dato);
    
//     l := l^.sig;
//   end;
//   informarA(vC);

//   writeln('-------------------------------------------------------------');
//   writeln('El codigo del jugador con mejor promedio es: ',codMax1);
//   writeln('El codigo del jugador con segundo mejor promedio es: ',codMax2);
//   writeln('-------------------------------------------------------------');
// end;


// {Programa Principal}

// var
//   pri,pri2: lJugadores;
//   vC: vCont;
// begin
//   pri := nil; pri2 := nil;
//   inicializarContador(vC);
//   generarLista(pri);
//   procesarLista(pri,pri2,vC);
// end.


{-------------------------------------------------------------------------------}

program parcialFutbolistas;

uses
  sysUtils;

const
  dimF_equipo = 28;
  dimF_fechas = 27;
  dimF_cal = 10;
  anioAct = 2022;

  type

    r_equipo = 1..dimF_equipo;
    r_fechas = 1..dimF_fechas;
    r_cal = 1..dimF_cal;
    str30 = string[30];

    lJugadores = ^nJugadores;

    vCal = array[r_fechas] of real;

    jugador = record
      cod: integer;
      apYnom: str30;
      cEquipo: r_equipo;
      aNac: integer;
      cal: vCal;
    end;

    nJugadores = record
      dato: jugador;
      sig: lJugadores;
    end;

    vCont = array[r_equipo] of integer;

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


procedure inicializarContador(var c: vCont);
var
  i: r_equipo;
begin
  for i := 1 to dimF_equipo do
    c[i] := 0;
end;

procedure leerJugador(var j: jugador);

  procedure cargarCalificaciones(var cal: vCal);
  var
    i: r_fechas;
    nota: r_cal;
  begin
    for i := 1 to dimF_fechas do begin
      repeat
        nota := Random(11);
        cal[i] := nota;
      until ((nota >= 0) and (nota <= 10));
    end;
  end;

begin
  with j do begin  
    cod := Random(1001);
    if (cod <> 0) then begin
      randomString(8,apYnom);
      cEquipo := Random(28) + 1;
      aNac := Random(45) + 1980;
      cargarCalificaciones(j.cal);
    end;
  end;
end;

procedure agregarAdelante(var l: lJugadores; j: jugador);
var
  nue: lJugadores;
begin
  new(nue);
  nue^.dato := j;
  nue^.sig := l;
  l := nue;
end;

procedure generarLista(var l: lJugadores);
var
  j: jugador;
begin
  leerJugador(j);
  while (j.cod <> 0) do begin
    agregarAdelante(l,j);
    leerJugador(j);
  end;
end;

procedure informarA(vC: vCont);
var
  i: r_equipo;
begin
  for i := 1 to dimF_equipo do begin
    if (vC[i] <> 0) then
      writeln('El equipo N° ',i,' posee ',vC[i],' jugadores con mas de 35 anios.')
    else
      writeln('El equipo N° ',i,' no posee jugadores con mas de 35 anios.');
  end;
end;

function cumpleA(aNac: integer):boolean;
begin
  cumpleA := ((anioAct - aNac) > 35);
end;

procedure promedio(cal: vCal; var cantJug: integer; var promCal: real);
var
  i: r_fechas;
  totCal: real;
begin
  totCal := 0;
  for i := 1 to dimF_fechas do
    if cal[i] > 0 then begin
      cantJug := cantJug + 1;
      totCal := totCal + cal[i];
    end;
    promCal := totCal / cantJug;
end;

procedure maxProm(codJug: integer; promCal: real; var max1,max2: real; var codMax1,codMax2: integer);
begin
  if (promCal > max1) then begin
    max2 := max1;
    codMax2 := codMax1;
    max1 := promCal;
    codMax1 := codJug;
  end
  else if(promCal > max2) then begin
    max2 := promCal;
    codMax2 := codJug;
  end;
end;

function cumpleDig(codJug: integer): boolean;
var
  dig,cantDig: integer;
begin
  cantDig := 0;

  while (codJug <> 0) do begin
    dig := codJug mod 10;
    if(dig mod 2 = 1) then
      cantDig := cantDig + 1;
    codJug := codJug div 10;
  end;
  cumpleDig := (cantDig = 3);
end;

procedure insertarOrdenado(var l: lJugadores; j: jugador);
var
  nue,ant,act: lJugadores;
begin
  new(nue);
  nue^.dato := j;
  ant := l;
  act := l;
  while(act <> nil) and (j.cod > act^.dato.cod) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = ant) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;


function cumpleC(codJug,aNac: integer): boolean;
begin
  cumpleC := (cumpleDig(codJug)) and ((aNac >= 1983) and (aNac <= 1990));
end;

procedure procesarLista(l: lJugadores; var l2: lJugadores; var vC: vCont);
var
  codMax1,codMax2,cantJug: integer;
  max1,max2,promCal: real;
begin
  max1 := -1; max2 := -1;
  codMax1 := 0; codMax2 := 0;
  while (l <> nil) do begin
    promCal := 0; cantJug := 0;

    if cumpleA(l^.dato.aNac) then
      vC[l^.dato.cEquipo] := vC[l^.dato.cEquipo] + 1;

    promedio(l^.dato.cal,cantJug,promCal);

    if(cantJug > 14) then
      maxProm(l^.dato.cod,promCal,max1,max2,codMax1,codMax2);

    if(cumpleC(l^.dato.cod,l^.dato.aNac)) then
      insertarOrdenado(l2,l^.dato);
    
    l := l^.sig;
  end;
  informarA(vC);

  writeln('-------------------------------------------------------------');
  writeln('El codigo del jugador con mejor promedio es: ',codMax1,' con una calificacion promedio de ',max1:0:2);
  writeln('El codigo del jugador con segundo mejor promedio es: ',codMax2,' con una calificacion promedio de ',max2:0:2);
  writeln('-------------------------------------------------------------');
end;


{Programa Principal}

var
  pri,pri2: lJugadores;
  vC: vCont;
begin
  Randomize;
  pri := nil; pri2 := nil;
  inicializarContador(vC);
  generarLista(pri);
  procesarLista(pri,pri2,vC);
end.