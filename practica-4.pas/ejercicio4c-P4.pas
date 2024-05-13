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


procedure sumaVector(v: vNum; dimL: integer; var sumaV: integer);
var
  i: integer;
begin
  for i := 1 to dimL do
    begin
      sumaV := sumaV + v[i];
    end;
end;


procedure imprimirTot(v: vNum; dimL: integer; sumaV: integer);
Var
  i: integer;
Begin
  for i := 1 to dimL do
    write(v[i],' ');
    writeln(' ');
  writeln('La suma total de todos los valores cargados en el vector es: ',sumaV);
end;

{programa principal}
Var 
  // x,y,posX,posY,
  dimL,sumaV: integer;
  v: vNum;
Begin
  dimL := 0;
  // x := 0; 
  // y := 0;
  // posX := 0; 
  // posY := 0;
  sumaV := 0;
  cargarVector(v,dimL);
  sumaVector(v,dimL,sumaV);
  // posicionVector(v,dimL,x,y,posX,posY);
  // intercambioPos(v,x,y,posX,posY);
  imprimirTot(v,dimL,sumaV);   
End.