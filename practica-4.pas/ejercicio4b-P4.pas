Program ejercicio4bP4;

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
  while (num <> 0) and (dimL < dimF) do   
    begin
      dimL := diml +1;
      v[dimL] := num; 
      write('Ingrese un numero: ');   
      read(num);
    end;
end;

{procedimiento para cargar variables X e Y}
procedure cargarXY(var x,y: integer);
begin
  write('Ingrese el valor de X: ');
  readln(x);
  write('Ingrese el valor de Y: ');
  readln(y);
end;


{a. procedimiento que retorna la POSICION en la que se encuentran X e Y dentro del vector}
procedure posicionVector(v: vNum; dimL: integer; var x,y,posX,posY: integer);
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

procedure intercambioPos(var v: vNum;  x,y: integer; var posX,posY: integer);
var
  aux: integer;
begin
  aux := v[posX]; 
  v[posX] := v[posY];
  v[posY] := aux;
end;


procedure imprimirTot(v: vNum; dimL: integer);
Var
  i: integer;
Begin
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
  x := 0; 
  y := 0;
  posX := 0; 
  posY := 0;
  cargarVector(v,dimL);
  posicionVector(v,dimL,x,y,posX,posY);
  write('El vector original quedo cargado de la siguiente manera: ');
  imprimirTot(v,dimL);
  intercambioPos(v,x,y,posX,posY);
  write('El vector modificado quedo cargado de la siguiente manera: ');
  imprimirTot(v,dimL);   
End.