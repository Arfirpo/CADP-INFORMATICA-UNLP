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

procedure eliminarDeV(a: vStr20; var dimL: integer; nom: str20; pos: integer; var elim:boolean);
var
  i: integer;
begin
  if ((pos >= 1) and (pos <= dimL)) then
    begin
      for i := pos to (dimL -1) do
        a[i] := a[i+1];
      elim := true;
      dimL := dimL -1;
    end;
end;


{programa principal}
var
  a: vStr20;
  dimL,pos: integer;
  nom: str20;
  esta,elim: boolean;
begin
  dimL := 0;
  pos := 1;
  esta := false;
  elim := false;
  cargarV(a,dimL);
  informarV(a,dimL);
  writeln();
  write('Nombre a buscar: ');
  readln(nom);
  buscarEnV(a,dimL,nom,pos,esta);
  if esta then
    begin
      writeln('El nombre estaba en el vector.');
      eliminarDeV(a,dimL,nom,pos,elim);
      informarV(a,dimL);
      if elim then
        writeln();
        writeln('El nombre fue elimiado del vector con exito.');
    end;
  else
    writeln('El nombre no se encontro en el vector.');
end.
