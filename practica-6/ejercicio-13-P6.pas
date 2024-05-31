{13.-El Portal de Revistas de la UNLP está estudiando el uso de sus sistemas de edición electrónica por parte de los usuarios. Para ello, se dispone de información sobre los 3600 usuarios que utilizan el portal. Decada usuario se conoce su email, su rol (1: Editor; 2. Autor; 3. Revisor; 4. Lector), revista en la que
participa y cantidad de días desde el último acceso.
a. Imprimir el nombre de usuario y la cantidad de días desde el último acceso de todos los usuarios
de la revista Económica. El listado debe ordenarse a partir de la cantidad de días desde el último
acceso (orden ascendente).
b. Informar la cantidad de usuarios por cada rol para todas las revistas del portal.
c. Informar los emails de los dos usuarios que hace más tiempo que no ingresan al portal.}



program ejercicio13P6;

const
  dimF = 10;
  dimF_rol = 4;

type
  {subrangos}
  rango = 1..dimF;
  roles = 1..dimF_rol;
  str30 = string[30];
  {registros}
  usuario = record
    nom: str30;
    mail: str30;
    rol: roles;
    rev: str30;
    inact: integer;
  end;
  {listas}
  lUsuarios = ^nUsuarios;

  nUsuarios = record
    dato: usuario;
    sig: lUsuarios;
  end;
  {vectores}
  vUsuarios = array[rango] of usuario;
  vCont = array[roles] of integer;

{modulos}

procedure inicializarContador(var c: vCont);
var i:integer; 
begin
  for i := 1 to dimF_rol do
    c[i] := 0;
end;

procedure cargarVector(var v: vUsuarios);

  procedure leerUsuario(var u: usuario);
  begin
    with u do begin
      write('Ingrese nombre de usuario: ');
      readln(nom);
      write('Ingrese su correo: ');
      readln(mail);
      write('Ingrese el rol que cumple en la revista -entre 1 y 4- : ');
      readln(rol);
      write('Ingrese el nombre de la revista en la que participa: ');
      readln(rev);
      write('Ingrese la cantidad de dias transcurridos desde su ultimo acceso al editor: ');
      readln(inact);
    end;
  end;

var i: integer; u: usuario;
begin
  for i := 1 to dimF do begin
    leerUsuario(u);
    v[i] := u;
  end;
end;

procedure procesarVector(v: vUsuarios; var cont: vCont);

  procedure insertarOrdenado(var l: lUsuarios; u: usuario);
  var ant,act,nue: lUsuarios;
  begin
    new(nue);
    nue^.dato := u;
    ant := l;
    act := l;
    while (act <> nil) and (u.inact > act^.dato.inact) do begin
      ant := act;
      act := act^.sig;
    end;
    if (ant = act) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

  procedure maxInact(mail: str30; inact: integer; var max1,max2: integer; var mail1,mail2: str30);
  begin
    if inact > max1 then begin
      max2 := max1;
      mail2 := mail1;
      max1 := inact;
      mail1 := mail;
    end;
    if inact > max2 then begin
      max2 := inact;
      mail2 := mail;
    end;
  end;

  procedure imprimirLista(l: lUsuarios);
  var
    aux: lUsuarios;
  begin
    aux := l;
    writeln('----------------------------------------');
    writeln('Lista de usuarios de la revista "Economica" por inactividad: ');
    while (aux <> nil) do begin
      writeln('El usuario ',aux^.dato.nom,' lleva ',aux^.dato.inact,' dias inactivo.');
      aux := aux^.sig;
    end;
  end;

var
  i,max1,max2: integer;
  pri: lUsuarios;
  mail1,mail2: str30;
begin
  pri := nil; max1 := -1; max2 := -1; mail1 := ''; mail2 := '';

  {procesamiento de datos}

  for i := 1 to dimF do begin

    if v[i].rev = 'economica' then
      insertarOrdenado(pri,v[i]);

    cont[v[i].rol] := cont[v[i].rol] + 1;

    maxInact(v[i].mail,v[i].inact,max1,max2,mail1,mail2);
  end;

  {informes}

  imprimirLista(pri);

  for i := 1 to dimF_rol do
    writeln('----------------------------------------');
    case i of
      1: writeln('Hay ',cont[i],' usuarios con el rol "Editor".');
      2: writeln('Hay ',cont[i],' usuarios con el rol "Autor".');
      3: writeln('Hay ',cont[i],' usuarios con el rol "Revisor".');
      4: writeln('Hay ',cont[i],' usuarios con el rol "Lector".');
    end;
    writeln('----------------------------------------');

    writeln('Los correos de los dos usuarios mas inactivos son: ');
    writeln('1.- ',mail1);
    writeln('2.- ',mail2);
end;

var
  vUsu: vUsuarios;
  cont: vCont;
begin
  inicializarContador(cont);
  cargarVector(vUsu);
  procesarVector(vUsu,cont);
end.


















//-------------------------------------------------------------------------------------

{version para pruebas automatizadas}

program ejercicio13P6;

const
  dimF = 10;
  dimF_rol = 4; // Corregido el rango de roles

type
  rango = 1..dimF;
  roles = 1..dimF_rol;
  str30 = string[30];

  usuario = record
    nom: str30;
    mail: str30;
    rol: roles;
    rev: str30;
    inact: integer;
  end;

  lUsuarios = ^nUsuarios;
  nUsuarios = record
    dato: usuario;
    sig: lUsuarios;
  end;

  vUsuarios = array[rango] of usuario;
  vCont = array[roles] of integer;

procedure inicializarContador(var c: vCont);
var
  i: integer;
begin
  for i := 1 to dimF_rol do
    c[i] := 0;
end;

procedure cargarVector(var v: vUsuarios);
var
  i: integer;
  u: usuario;
begin
  for i := 1 to dimF do begin
    write('Ingrese nombre de usuario: ');
    readln(u.nom);
    write('Ingrese su correo: ');
    readln(u.mail);
    repeat
      write('Ingrese el rol que cumple en la revista (entre 1 y 7): ');
      readln(u.rol);
    until (u.rol in [1..dimF_rol]); // Validación del rol dentro del rango
    write('Ingrese el nombre de la revista en la que participa: ');
    readln(u.rev);
    write('Ingrese la cantidad de dias transcurridos desde su ultimo acceso al editor: ');
    readln(u.inact);
    v[i] := u;
  end;
end;

procedure procesarVector(v: vUsuarios; var cont: vCont);

  procedure insertarOrdenado(var l: lUsuarios; u: usuario);
  var
    ant, act, nue: lUsuarios;
  begin
    new(nue);
    nue^.dato := u;
    ant := nil;
    act := l;
    while (act <> nil) and (u.inact > act^.dato.inact) do begin
      ant := act;
      act := act^.sig;
    end;
    if (ant = nil) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  i, max1, max2: integer;
  pri: lUsuarios;
  mail1, mail2: str30;

begin
  pri := nil;
  max1 := -1;
  max2 := -1;
  mail1 := '';
  mail2 := '';

  for i := 1 to dimF do begin
    if v[i].rev = 'economica' then
      insertarOrdenado(pri, v[i]); // Insertar usuario en lista ordenada por inactividad

    cont[v[i].rol] := cont[v[i].rol] + 1; // Contar usuarios por rol

    if v[i].inact > max1 then begin
      max2 := max1;
      mail2 := mail1;
      max1 := v[i].inact;
      mail1 := v[i].mail;
    end
    else if v[i].inact > max2 then begin
      max2 := v[i].inact;
      mail2 := v[i].mail;
    end;
  end;

  writeln('----------------------------------------');
  writeln('Lista de usuarios de la revista "Economica" por inactividad: ');
  while (pri <> nil) do begin
    writeln('El usuario ', pri^.dato.nom, ' lleva ', pri^.dato.inact, ' dias inactivo.');
    pri := pri^.sig;
  end;

  writeln('----------------------------------------');
  for i := 1 to dimF_rol do begin
    case i of
      1: writeln('Hay ', cont[i], ' usuarios con el rol "Editor".');
      2: writeln('Hay ', cont[i], ' usuarios con el rol "Autor".');
      3: writeln('Hay ', cont[i], ' usuarios con el rol "Revisor".');
      4: writeln('Hay ', cont[i], ' usuarios con el rol "Lector".');
      // Agregar otros roles según sea necesario
    end;
  end;
  writeln('----------------------------------------');

  writeln('Los correos de los dos usuarios mas inactivos son: ');
  writeln('1.- ', mail1);
  writeln('2.- ', mail2);
end;

var
  vUsu: vUsuarios;
  cont: vCont;

begin
  inicializarContador(cont);
  cargarVector(vUsu);
  procesarVector(vUsu, cont);
end.