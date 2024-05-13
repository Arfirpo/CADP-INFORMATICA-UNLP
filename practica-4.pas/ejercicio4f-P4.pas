Program ejercicio4fP4;

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
  write('El vector esta cargado con los valores: ');
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
  imprimirTot(v,dimL);
  writeln('El numero mas chico del vector se encuentra en la posicion: ',minVector(v,dimL));         
End.