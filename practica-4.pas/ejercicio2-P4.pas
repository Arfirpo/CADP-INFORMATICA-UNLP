Program ejercicio2P4;

const
  cant_datos = 5;
  condicion = 0;

Type 
  vDatos = array [1..cant_datos] of real;

{a. El módulo cargarVector debe leer números reales y almacenarlos en el vector que se pasa como parámetro. Al finalizar, debe retornar el vector y su dimensión lógica. La lectura finaliza cuando se ingresa el valor 0 (que no debe procesarse) o cuando el vector está completo.}

procedure cargarVector(var v: vDatos; var dimL: integer);
Var
  num: real;
Begin
  dimL := 0;
  write('Ingrese un numero -real-: ');
  read(num);
  while ((dimL < cant_datos) and (num <> condicion)) do
    begin
      dimL := diml +1;
      v[dimL] := num;
      write('Ingrese un numero -real-: ');
      read(num);
    end;
end;

procedure imprimir(datos: vDatos; dimL: integer);
Var
  i: integer;
Begin
  for i := 1 to dimL do
    write(datos[i]:0:2,' ');
    writeln(' ');
end;

{b. El módulo modificarVectorySumar debe devolver el vector con todos sus elementos incrementados con el valor n y también debe devolver la suma de todos los elementos del vector.}

procedure modVectorYSumar(dimL: integer; n: real; var v: vDatos; var suma: real);
var
  i: integer;
begin
    for i := 1 to dimL do
      v[i] := v[i] + n;
    for i:= 1 to dimL do
      suma := suma + v[i];

end;

{programa principal}
Var 
  datos: vDatos;
  i,dim: integer;
  num,sumaTotal: real;
Begin
  dim := 0;
  sumaTotal := 0;
  cargarVector(datos,dim);
  imprimir(datos,dim);
  write('Ingrese un valor a sumar: ');
  readln(num);
  modVectorYSumar(dim,num,datos,sumaTotal);
  imprimir(datos,dim); writeln('');
  writeln('La suma de los vectores es: ', sumaTotal:0:2);
  writeln('Se procesaron: ',dim, ' numeros');
End.