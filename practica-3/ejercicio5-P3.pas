
Program ejercicio5P3;

Type 
  str20 = string[20];
  autos = Record
    marca: str20;
    modelo: str20;
    precio: real;
  End;

Function promedio(precioTot: real; cant: integer): real;
Begin
  promedio := precioTot / cant;
End;

Procedure masCaro(marca,modelo: str20; precio: real; Var max: real; Var maxMarca,maxModelo: str20);
Begin
  If precio > max Then
    Begin
      max := precio;
      maxMarca := marca;
      maxModelo := modelo;
    End;
End;

Procedure leerAuto(Var auto: autos);
Begin
  write('Ingrese la marca del auto: ');
  readln(auto.marca);
  write('Ingrese el modelo del auto: ');
  readln(auto.modelo);
  write('Ingrese el precio del auto: ');
  readln(auto.precio);
End;

Var 
  corte: str20;
  cant: integer;
  precioTot, max: real;
  maxMarca, maxModelo: str20;
  auto: autos;
Begin
  max := -1;
  maxMarca := '';
  maxModelo := '';
  leerAuto(auto);
  While auto.marca <> 'zzz' Do
    Begin
      cant := 0;
      precioTot := 0;
      corte := auto.marca;
      While (auto.marca = corte) And (auto.marca <> 'zzz') Do
        Begin
          cant := cant +1;
          precioTot := precioTot + auto.precio;
          masCaro(auto.marca,auto.modelo,auto.precio,max,maxMarca,maxModelo);
          leerAuto(auto);
        End;
      writeln('El precio promedio de los ',corte, ' es de $ ',promedio(precioTot,cant): 0: 2);
    End;
  writeln('El auto mas caro a la venta es el ',maxMarca,' ',maxModelo);
End.
