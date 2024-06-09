program ejercicio7P7;

const
  dimF_mat = 24;

type
  str30 = string[30];
  r_mat = 1..dimF_mat;
  r_notas = 4..10;

  lAlumnos = ^nAlumnos;

  vNotas = array[r_mat] of integer;

  alumno = record
    cod: integer;
    nom: str30;
    ap: str30;
    mail: str30;
    ing: integer;
    egr: integer;
    notas: vNotas;
  end;

  nAlumnos = record
    dato: alumno;
    sig: lAlumnos;
  end;

procedure cargarV(var vN: vNotas);

  function determinarPosicion(nota,dimL: integer; vN: vNotas): integer;
  var
    ps: integer;
  begin
    ps := 1;
    while (ps <= dimL) and (nota < vN[ps]) do
      ps := ps + 1;
    determinarPosicion := ps;
  end;

  procedure insertar(var vN: vNotas; var dimL: integer; ps,nota: integer);
  var
    j: integer;
  begin
    for j := dimL downto ps do
      vN[j+1] := vN[j];
    vN[ps] := nota;
    dimL := dimL + 1;
  end;

var
  dimL,ps,i: integer;
  nota: r_notas;
begin
  dimL := 0;
  for i := 1 to dimF_mat do begin
    nota := Random(7) + 4;
    if (dimL < dimF_mat) then begin
      ps := determinarPosicion(nota,dimL,vN);
      insertar(vN,dimL,ps,nota);
    end;
  end;
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

procedure leerAlumno(var a: alumno);
begin
  with a do begin
    cod := Random(1002) - 1;
    if (cod <> -1) then begin
      randomString(5,ap);
      randomString(5,nom);
      randomString(8,mail);
      repeat
        ing := Random(45) + 1980;
        egr := Random(45) + 1983;
      until ((egr - ing) >= 3);
      cargarV(a.notas);
    end;
  end;
end;

procedure agregarAdelante(var l: lAlumnos; a: alumno);
var
  nue: lAlumnos;
begin
  new(nue);
  nue^.dato := a;
  nue^.sig := l;
  l := nue;
end;

procedure generarLista(var l: lAlumnos);
var
  a: alumno;
begin
  repeat
    leerAlumno(a);
    if (a.cod <> -1) then
      agregarAdelante(l,a);
  until (a.cod = -1);
end;

function prom(vN: vNotas): real;
var
  i: r_mat;
  totN: integer;
begin
  totN := 0;
  for i := 1 to dimF_mat do
    totN := totN + vN[i];
  prom := totN / dimF_mat;
end;

function cumpleB(ing,cod: integer): boolean;
var
  dig: integer;
  ok: boolean;
begin
  ok := true;
  if (ing = 2012) then begin
    while (cod <> 0) and ok do begin
      dig := cod mod 10;
      if (dig mod 2 = 0) then
        ok := false;
      cod := cod div 10;
    end;
  end else
    ok := false;
  cumpleB := ok;    
end;

procedure masRapido(ap,nom,mail: str30; tiempoC: integer; var min1,min2: integer; var minAp1,minAp2,minNom1,minNom2,minMail1,minMail2: str30);
begin
  if (tiempoC < min1) then begin
    min2 := min1;
    minAp2 := minAp1;
    minNom2 := minNom1;
    minMail2 := minMail1;
    min1 := tiempoC;
    minAp1 := ap;
    minNom1 := nom;
    minMail1 := mail;
  end
  else if (tiempoC < min2) then begin
    min2 := tiempoC;
    minAp2 := ap;
    minNom2 := nom;
    minMail2 := mail;
  end;
end;

procedure procesarLista(l: lAlumnos);
var
  cantB,tiempoC,min1,min2: integer;
  minAp1,minAp2,minNom1,minNom2,minMail1,minMail2: str30;
begin
  cantB := 0;
  min1 := 9999; min2 := 9999;
  minAp1 := ''; minAp2 := '';
  minNom1 := ''; minNom2 := '';
  minMail1 := ''; minMail2 := '';
  writeln('------------------------------------------------------------');
  while (l <> nil) do begin
    // Punto a.
    writeln('El promedio del Alumno ',l^.dato.ap,' ',l^.dato.nom,' fue: ',prom(l^.dato.notas):2:2);
    writeln('------------------------------------------------------------');
    // Punto b.
    if (cumpleB(l^.dato.ing,l^.dato.cod)) then
      cantB := cantB + 1;
    // Punto c.
    tiempoC := l^.dato.egr - l^.dato.ing;
    masRapido(l^.dato.ap,l^.dato.nom,l^.dato.mail,tiempoC,min1,min2,minAp1,minAp2,minNom1,minNom2,minMail1,minMail2);
    l := l^.sig;
  end;

  if (cantB > 0) then
    writeln('Los codigos de ',cantB,' alumnos poseen todos los digitos impares.')
  else
    writeln('Ningun codigo de alumno tiene todos sus digitos impares.');
  writeln('------------------------------------------------------------');
  writeln('Los dos alumnos que completaron la carrera en menor tiempo fueron: ');
  writeln('1.- Alumno: ',minAp1,' ',minNom1,' - correo: ',minMail1,'@outlook.com.ar');
  writeln('2.- Alumno: ',minAp2,' ',minNom2,' - correo: ',minMail2,'@outlook.com.ar');
  writeln('------------------------------------------------------------');
end;

procedure eliminar(var l: lAlumnos;cod: integer; var elim: boolean);
var
  ant,act: lAlumnos;
begin
  elim := false;
  ant := l;
  act := l;
  while (act <> nil) and (act^.dato.cod <> cod) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act <> nil) then begin
    elim := true;
    if (act = l) then
      l := l^.sig
    else
      ant^.sig := act^.sig;
    dispose(act);
  end;  
end;

var
  pri: lAlumnos;
  cod: integer;
  elim: boolean;
begin
  Randomize;
  pri := nil;
  generarLista(pri);
  procesarLista(pri);
  cod := Random(100) + 1;
  eliminar(pri,cod,elim);
  if(elim) then
    writeln('Se elimino al alumno ',cod,' de la lista')
  else
    writeln('No se pudo eliminar al alumno de la lista');
end.
