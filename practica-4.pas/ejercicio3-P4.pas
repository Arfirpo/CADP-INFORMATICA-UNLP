Program ejercicio2P4;

const
  dimF = 5;

Type 
  vNum = array [1..dimF] of integer;

procedure cargarVector(var v: vNum; var dimL: integer);
Var
  num: real;
Begin
  dimL := 0;
  write('Ingrese un numero: ');
  read(num);
  for dimL := 1 to dimF do
    begin
      v[dimL] := num;
      dimL := diml +1;
      write('Ingrese un numero: ');
      read(num);
    end;
end;

procedure imprimirTot(num: vNum; dimL: integer);
Var
  i: integer;
Begin
  for i := 1 to dimL do
    write(num[i]:0:2,' ');
    writeln(' ');
end;




{programa principal}
Var 
  dimL: integer;
  num: vNum;
Begin
  dimL := 0;
  cargarVector(num,dimL);
  imprimirTot()
End.