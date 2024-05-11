Program ejercicio4P4;

const
  dimF = 100;

Type 
  vNum = array [1..dimF] of integer;


{procedimiento para cargar el vector numerico}
procedure cargarVector(var v: vNum; var dimL: integer);
Var
  num, i: integer;
Begin
  i := 1;
  write('Ingrese un numero: ');   
  read(num);         
{como no pretendo cargar el vector completo, utilizo la esctructura de control WHILE.
agrego una condicion de corte (num <> 0) y, si no se cumple la condicion, con (dimL < diF) 
me aseguro que si la dimension logica iguala a la dimension fisica, el while culmine.}
  while (num <> 0) and (dimL < dimF) do   
    begin
      i := i +1;
      dimL := diml +1;                // aumento la dimension logica en +1.
      write('Ingrese un numero: ');   
      read(num);                      // ingreso un numero entero.
      v[i] := num;                    // almaceno, en la posicion que valga i del vector, el valor de num .
    end;
end;

{procedimiento para cargar variables X e Y}
procedure cargarX(var x: integer);
begin
  write('Ingrese el valor de X: ');
  readln(x);
end;

{a. procedimiento que retorna la POSICION en la que se encuentra X dentro del vector}
procedure posicionVector(v: vNum; dimL: integer; var x,pos: integer);
Var
  i: integer;
Begin
  cargarX(x);
  i := 1;
  {Uso un while y una variable i (que se incrementa con cada vuelta del while)
  para recorrer el vector 
  }
  while (v[i] <> x) and (i < dimL) do
    begin
      i := i +1;
    end;
  if (v[i] = x) then   // si alguna posición dentro del vector contiene el valor de X...
    pos := i           // la variable pos almacena el valor del indice donde se encontró x.
  else
    pos := -1;
end;

procedure informarPos(pos: integer);
begin
  if (pos = -1) then
    writeln('X no se encontro en ninguna posicion del vector.')
  else
    writeln('X se econtro en la posicion ',pos,' del vector.');
end;


{programa principal}
Var 
  dimL,x,pos: integer;
  v: vNum;
Begin
  dimL := 0;
  x := 0;
  pos := 0;
  cargarVector(v,dimL);
  posicionVector(v,dimL,x,pos);
  informarPos(pos);             
End.