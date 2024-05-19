Program ejercicio4P4;

const
  dimF = 100;

Type 
  vNum = array [1..dimF] of integer;


{procedimiento para cargar el vector numerico}
procedure cargarVector(var v: vNum; var dimL: integer);
Var
  num: integer;
Begin
  write('Ingrese un numero: ');   
  read(num);         
{como no pretendo cargar el vector completo, utilizo la esctructura de control WHILE.
agrego una condicion de corte (num <> 0) y, si no se cumple la condicion, con (dimL < diF) 
me aseguro que si la dimension logica iguala a la dimension fisica, el while culmine.}
  while (num <> 0) and (dimL <= dimF) do   
    begin
      dimL := diml +1;                // aumento la dimension logica en +1.
      v[dimL] := num;                 // almaceno, en la posicion que valga i del vector, el valor de num.
      write('Ingrese un numero: ');   
      read(num);                      // ingreso un numero entero.
    end;
end;


{procedimiento para cargar variable X}
procedure cargarX(var x: integer);
begin
  write('Ingrese el valor de X: ');
  readln(x);
end;

{procedimiento para cargar variables X e Y}
procedure cargarXY(var x,y: integer);
begin
  write('Ingrese el valor de X: ');
  readln(x);
  write('Ingrese el valor de Y: ');
  readln(y);
end;

{a. procedimiento que retorna la POSICION en la que se encuentra X dentro del vector}
procedure posicionVector(v: vNum; dimL: integer; var x,posX: integer);
Var
  i: integer;
  enc: boolean;
Begin
  i := 1;
  cargarX(x);
  {Uso un while y una variable i (que se incrementa con cada vuelta del while)
  para recorrer el vector}
  while (i < dimL) and (v[i] <> x) do
    i := i +1;
  if (v[i] = x) then   // si alguna posición dentro del vector contiene el valor de X...
    begin
      posX := i;           // la variable pos almacena el valor del indice donde se encontró x.     
    end
  else
    posX := -1;
end;

{procedimiento que informa la posicion de x en el vector}
procedure informarPos(posX: integer);
begin
  if (posX = -1) then
    writeln('X no se encontro en ninguna posicion del vector.')
  else
    writeln('X se econtro en la posicion ',posX,' del vector.');
end;

{b. procedimiento que retorna la POSICION en la que se encuentran X e Y dentro del vector}
procedure posicionVectorXY(v: vNum; dimL: integer; var x,y,posX,posY: integer);
Var
  i: integer;
  encX,encY: boolean;
Begin
  cargarXY(x,y);
  i := 0; 
  encX := false; 
  encY := false;
  while (i <= dimL) and (not encX or not encY) do
    begin
      if (v[i] = x) then
        begin
          posX := i;           
          encX := true;          
        end;  
      if (v[i] = y) then
      begin
        posY := i;           
        encY := true;        
      end;
      i := i +1;
    end;
end;

{b. procedimiento que recibe las posiciones de X e Y en el vector y las intercambia entre si}
procedure intercambioPos(var v: vNum;  x,y: integer; var posX,posY: integer);
var
  aux: integer;
begin
  aux := v[posX]; 
  v[posX] := v[posY];
  v[posY] := aux;
end;

{procedimiento que informa los valores cargados en el vector}
procedure imprimirTot(v: vNum; dimL: integer);
Var
  i: integer;
Begin
  writeln('El vector tiene cargado los siguientes valores: ');
  for i := 1 to dimL do
    write(v[i],' ');
    writeln(' ');
end;

{c. función que devuelve la suma de todos los valores cargados en el vector}
function sumaVector(v: vNum; dimL: integer):integer;
var
  i: integer;
begin
  sumaVector := 0;
  for i := 1 to dimL do
    sumaVector := sumaVector + v[i];
end;

{d. función que devuelve el promedio de todos los valores cargados en el vector}
function promVector(v: vNum; dimL: integer):real;
var
  i: integer;
begin
promVector := 0;
  for i := 1 to dimL do
    promVector := promVector + v[i];
  promVector := promVector / dimL;
end;

{e. función que devuelve el valor mas grande de todos los cargados en el vector}
function maxVector(v: vNum; dimL: integer):integer;
var
  maxPos, i: integer;
begin
  maxVector := -1;
  for i := 1 to dimL do
    if v[i] > maxVector then
      begin
        maxVector := v[i];
        maxPos := i;
      end;
  maxVector := maxPos;
end;

{e. función que devuelve el valor mas chico de todos los cargados en el vector}
function minVector(v: vNum; dimL: integer):integer;
var
  i,minPos: integer;
begin
  minVector := 9999;
  for i := 1 to dimL do
    if v[i] < minVector then
      begin
        minVector := v[i];
        minPos := i;
      end;
    minVector := minPos;
end;

{programa principal}
Var 
  dimL,x,y,posX,posY: integer;
  v: vNum;
Begin
  dimL := 0;
  x := 0; 
  y := 0;
  posX := 0; 
  posY := 0;
  cargarVector(v,dimL);
  posicionVector(v,dimL,x,posX);
  informarPos(posX);
  posicionVectorXY(v,dimL,x,y,posX,posY);
  imprimirTot(v,dimL);
  intercambioPos(v,x,y,posX,posY);
  imprimirTot(v,dimL);  
  writeln('La suma de todos los valores del vector es: ', sumaVector(v,dimL));
  writeln('el promedio de los valores almacenados en el vector es: ',promVector(v,dimL):0:2);
  writeln('El valor mas grande cargado en el vector esta en la posicion: ',maxVector(v,dimL));
  writeln('El numero mas chico del vector se encuentra en la posicion: ',minVector(v,dimL));
End.
