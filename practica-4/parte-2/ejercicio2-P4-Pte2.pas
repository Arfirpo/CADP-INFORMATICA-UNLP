program ejercicio2P4Pte2;

const
  dimF = 500;
  corte = 'zzz';

type
  str20 = string[20];
  rango = 1..dimF;
  vStr20 = array[rango] of str20;

{modulos}

procedure informarV(a: vStr20; dimL: integer);
var
  i: integer;
begin
  writeln('En el vector se almacenan los nombres: ');
  for i := 1 to dimL do      
    writeln(i,'.',a[i],'.');
end;

procedure cargarV(var a: vStr20; var dimL: integer);
var
  pos: integer;
begin
  pos := 1;
  write('Ingrese nombre del alumno: ');
  readln(a[pos]);
  while (dimL < dimF) and (a[pos] <> corte) do
    begin
      dimL := dimL +1;
      pos := pos +1;
      write('Ingrese nombre del alumno: ');
      readln(a[pos]);
    end;
end;

procedure buscarEnV(a: vStr20; dimL: integer; nom: str20; var pos: integer;  var esta: boolean);
begin
  while (pos <= dimL) and (not esta) do
    if a[pos] = nom then
      esta := true
    else
      pos := pos +1;
end;

procedure busqueda(a: vStr20; dimL: integer; var pos: integer; var esta: boolean; var nom: str20);
begin
  write('Nombre a buscar: ');
  readln(nom);
  buscarEnV(a,dimL,nom,pos,esta);
end;

procedure eliminarDeV(var a: vStr20; var dimL: integer; nom: str20; pos: integer; var elim:boolean);
var
  i: integer;
begin
  elim := false;
  if ((pos >= 1) and (pos <= dimL)) then
    begin
      for i := pos to (dimL -1) do
        a[i] := a[i+1];
      elim := true;
      dimL := dimL -1;
    end;
end;

procedure eliminacion(var a:vStr20; var dimL: integer; esta: boolean; pos: integer; nom: str20);
var
  elim: boolean;
begin
  if esta then
    begin
      writeln('El nombre estaba en el vector.');
      eliminarDeV(a,dimL,nom,pos,elim);
      informarV(a,dimL);
      if elim then
        writeln();
        writeln('El nombre fue elimiado del vector con exito.');
    end
  else
    writeln('El nombre no se encontro en el vector.');
end;

procedure insertarEnV(var a: vStr20; var dimL: integer; pos: integer; var insert: boolean; nom: str20);
var
  i: integer;
begin
  insert := false;
  if (((dimL + 1) <= dimF) and (pos >= 1) and (pos <= dimL)) then
    begin  
      for i := dimL downTo pos do
        a[i+1] := a[i];
      insert := true;
      a[pos] := nom;
      dimL := dimL +1;      
    end;
end;

procedure insercion(var a: vStr20; var dimL: integer);
var
  pos: integer;
  insert: boolean;
  nom: str20;
begin
  write('Ingrese el nombre del alumno a insertar: ');
  readln(nom);
  write('En que posicion desea insertar al alumno?: ');
  readln(pos);
  insertarEnV(a,dimL,pos,insert,nom);
  if insert then
    begin 
      writeln('El alumno se inserto con exito.');
      informarV(a,dimL);
    end
  else
    writeln('No se pudo insertar el alumno.');
end;

procedure agregarEnV(var a: vStr20; var dimL: integer; var agregado: boolean; nom: str20);
begin
  if ((dimL + 1) <= dimF) then
    begin
      agregado := true;
      dimL := dimL +1;
      a[dimL] := nom;
    end;
end;

procedure agregacion(var a: vStr20; var dimL: integer);
var
  agregado: boolean;
  nom: str20;
begin
  agregado := false;
  write('Ingrese el nombre del alumno a agregar: ');
  readln(nom);
  agregarEnV(a,dimL,agregado,nom);
  if agregado then
    begin
      writeln('El alumno fue agregado con exito.');
      informarV(a,dimL);
    end
  else
    writeln('El alumno no pudo ser agregado.');
end;

{programa principal}
var
  a: vStr20;
  dimL,pos: integer;
  esta: boolean;
  nom: str20;
begin
  dimL := 0; 
  pos := 0;
  nom := '';
  esta := false;
  cargarV(a,dimL);
  informarV(a,dimL); 
  writeln();
  //agregacion(a,dimL);
  //insercion(a,dimL);
  //busqueda(a,dimL,pos,esta,nom);
  //eliminacion(a,dimL,esta,pos,nom);
end.


