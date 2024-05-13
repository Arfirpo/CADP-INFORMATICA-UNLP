Program ejercicio4cP4;

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


function promVector(v: vNum; dimL: integer):integer;
var
  i: integer;
begin
sumaVector := 0;
  for i := 1 to dimL do
    promVector := promVector + v[i];
  promVector := promVector div dimL;
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
  writeln('La suma de los valores del vector es: ',sumaVector(v,dimL));
End.