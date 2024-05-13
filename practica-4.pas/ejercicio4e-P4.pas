Program ejercicio4eP4;

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
  dimL: integer;
  v: vNum;
Begin
  dimL := 0;
  cargarVector(v,dimL);
  write('El vector esta cargado con los siguientes valores: ');
  imprimirTot(v,dimL);
  writeln('El valor mas grande cargado en el vector esta en la posicion: ',maxVector(v,dimL));  
End.