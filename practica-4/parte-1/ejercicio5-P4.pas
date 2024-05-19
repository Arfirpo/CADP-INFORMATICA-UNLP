Program ejercicio5P4;

const
  dimF = 100;

Type
  rango = 1..dimF;
  vNum = array [rango] of integer;


procedure cargarVector(var v: vNum; var dimL: integer);
Var
  num: integer;
Begin
  write('Ingrese un numero: ');   
  read(num);         
  while (num <> 0) and (dimL <= dimF) do   
    begin
      dimL := diml +1;
      v[dimL] := num;
      write('Ingrese un numero: ');   
      read(num);                      
    end;
end;


procedure posicionVectorXY(v: vNum; dimL,x,y: integer; var posX,posY: integer);
Var
  i: integer;
  encX,encY: boolean;
Begin
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

procedure intercambioPos(var v: vNum;  x,y,posX,posY: integer);
var
  aux: integer;
begin
  aux := v[posX]; 
  v[posX] := v[posY];
  v[posY] := aux;
end;

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


procedure imprimirTot(v: vNum; dimL: integer);
Var
  i: integer;
Begin
  write('El vector tiene cargado los siguientes valores: ');
  for i := 1 to dimL do
    write(v[i],' ');
    writeln(' ');
end;

{programa principal}
Var 
  dimL,x,y,posX,posY: integer;
  v: vNum;
Begin
  dimL := 0;
  cargarVector(v,dimL);
  imprimirTot(v,dimL);            // imprime los valores cargados en el vector originalmente
  posX := maxVector(v,dimL);      //la variable posX almacena la posicion del valor mas grande del vector, calculado por la función maxVector. 
  posY := minVector(v,dimL);      //la variable posY almacena la posicion del valor mas chico del vector, calculado por la función minVector. 
  x := v[posX];                   //la variable x almacena el valor mas grande del vector, obtenido a traves del indice de la posicion calculada anteriormente. 
  y := v[posY];                   //la variable y almacena el valor mas chico del vector, obtenido a traves del indice de la posicion calculada anteriormente.
  posicionVectorXY(v,dimL,x,y,posX,posY);
  intercambioPos(v,x,y,posX,posY);
  writeln('El elemento maximo: ',x,' que se encontraba en la posicion ',posX,' fue intercambiado con el elemento minimo: ',y,' que se encontraba en la posicion ',posY);
  imprimirTot(v,dimL);            // a modo de comparación, imprime los valores cargados en el vector luego de intercambiar las posiciones del valor mas grande y mas chico del vector.
End.
