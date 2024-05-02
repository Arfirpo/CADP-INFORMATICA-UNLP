
Program ejercicio4P3;

Const 
  cantClientes = 9300;
  valorMin = 3.40;
  valorMB = 1.35;

Type 
  {registro de clientes}
  clientes = Record
    id: integer;
    lineas: integer;
  End;
  {registro de linea}
  linea = Record
    num: int64;
    minutos: real;
    MB: real;
  End;

Function facturacion(totMin,totMB: real): real;
Begin
  facturacion := (totMin * valorMin) + (totMB * valorMB);
End;

Procedure leerLinea(Var celular: linea);
Begin
  write('Ingrese el numero de telefono: ');
  readln(celular.num);
  write('Ingrese la cantidad de minutos consumidos en el mes: ');
  readln(celular.minutos);
  write('Ingrese la cantidad de megabytes consumidos en el mes: ');
  readln(celular.MB);
End;

Procedure leerCliente(Var cliente: clientes; Var celular: linea; Var totMin,totMB: real);

Var 
  i: integer;
Begin
  write('Ingrese el codigo de cliente: ');
  readln(cliente.id);
  write('Ingrese la cantidad de lineas a su nombre: ');
  readln(cliente.lineas);
  For i := 1 To cliente.lineas Do
    Begin
      leerLinea(celular);
      totMin := totMin + celular.minutos;
      totMB := totMB + celular.MB;
    End;
End;


Var 
  totMB,totMin: real;
  i: integer;
  cliente: clientes;
  celular: linea;
Begin
  totMB := 0;
  totMin := 0;
  For i:= 1 To cantClientes Do {trabaja sobre la cantidad de clientes de la empresa}
    Begin
      leerCliente(cliente,celular,totMin,totMB);
      writeln('El cliente con codigo: ',cliente.id,' consumio un total de ', totMin:0:2,' minutos y ',totMB:0:2,' MB');
      writeln('El total de su factura es de $ ',facturacion(totMin,totMB): 0: 2);
    End;
End.
