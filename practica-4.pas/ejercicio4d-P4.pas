Program ejercicio4dP4;

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


procedure promVector(v: vNum; dimL: integer; var sumaV: integer; var promV: real);
var
  i: integer;
begin
  for i := 1 to dimL do
    begin
      sumaV := sumaV + v[i];
    end;
  promV := sumaV div dimL;
end;


procedure imprimirTot(v: vNum; dimL: integer; sumaV: integer; promV: real);
Var
  i: integer;
Begin
  for i := 1 to dimL do
    write(v[i],' ');
    writeln(' ');
  writeln('La suma total de todos los valores cargados en el vector es: ',sumaV);
  writeln('La suma total de todos los valores cargados en el vector es: ',promV:0:2);
end;

{programa principal}
Var 
  dimL,sumaV: integer;
  promV: real;
  v: vNum;
Begin
  dimL := 0;
  sumaV := 0;
  promV := 0;
  cargarVector(v,dimL);
  promVector(v,dimL,sumaV,promV);
  imprimirTot(v,dimL,sumaV,promV);   
End.