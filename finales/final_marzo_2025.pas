
{Un comercio DISPONE de una estructura de datos con información de las facturas realizadas durante el ultimo mes (como máximo 1000).
De cada factura se conoce el número de factura, código de sucursal (1..5) a la que pertenece y monto total.
Se pide implementar un programa que lea de teclado un código de sucursal y elimine de la estructura todas las facturas pertenecientes al código de sucursal leído.
Al finalizar debe informar el monto total acumulado en todas las facturas eliminadas.
La solución debe ser optima en tiempo de ejecución.
}

Program final_marzo_2025;

Const dimF = 1000;

Type
  rango_vFacturas = 1..dimF;
  rango_sucursales = 1..5;
  Factura = Record
    nro: integer;
    cod_Sucursal: rango_sucursales;
    mtot: real;
  End;

  vFacturas =  array[rango_vFacturas] Of Factura; //se dispone.

{ Módulos }

procedure leerFactura(var F: Factura);
begin
  with F do begin
    nro := Random(121) - 1;
    cod_Sucursal := 1 + Random(5);
    mtot := 0.50 + (Random() * 299.5);
  end;
end;

Procedure cargarVector(Var Facturas: vFacturas; Var dimL: integer);
Var F: Factura;
Begin
  leerFactura(F);
  While (dimL <= dimF) and (f.nro <> -1) Do Begin
    dimL += 1;
    Facturas[dimL] := F;
    leerFactura(F);
  End;
End;

procedure imprimirFacturas(Facturas: vFacturas; dimL: integer);
var
  i: integer;
begin
  Writeln();
  Writeln('Lista de Facturas');
  Writeln('=================');
  Writeln();
  for i := 1  to dimL do begin
    Writeln('Numero de factura: ',Facturas[i].nro);
    Writeln('Codigo de sucursal de la factura: ',Facturas[i].cod_Sucursal);
    Writeln('Monto total de la factura: $',Facturas[i].mtot:0:2);
    Writeln();
  end;
  Writeln('=================');
end;

procedure eliminarFacturas(var Facturas: vFacturas; var dimL: integer);
var cod: rango_sucursales; pos,i,j: rango_vFacturas; tot: real;
begin
  j := 1;
  tot := 0;
  Writeln();
  Write('Ingrese el codigo de la sucursal a buscar: '); readln(cod);
  for i := 1 to dimL do begin
    if(Facturas[i].cod_Sucursal = cod) then begin
      tot += Facturas[i].mtot;
    end
    else begin
      Facturas[j] := Facturas[i];
      j += 1;
    end;
  end;
  diml := j - 1;
  Writeln();
  Writeln('El monto acumulado de las facturas eliminadas de la sucursal ',cod,' es de Pesos $',tot:0:2);
  Writeln();
end;

{ Programa Principal}

Var 
  Facturas: vFacturas;
  dimL,opc: integer;
Begin
  Randomize;
  dimL := 0;
  cargarVector(Facturas,dimL);
  repeat
    Writeln('---- Menu Principal ----');
    Writeln('----> Opciones:');
    Writeln();
    Writeln('1 ----> Listado de Facturas');
    Writeln('2 ----> Eliminar Facturas');
    Writeln();
    Write('Seleccione una opcion -0 para salir- : '); Readln(opc);
    if(opc = 1) then imprimirFacturas(Facturas,dimL)
    else if(opc = 2) then eliminarFacturas(Facturas,dimL);
  until (opc = 0);
End.

{============================================================================================}

{2) se quiere implementar un modulo que reciba un empleado y lo agregue a una estructura de empleados.
Indique si las soluciones A y B lo resuelven de forma correecta. Justificar en ambos casos}

program ejercicio_2;

const CAPACIDAD = 100;

type
  empleado = Record
    cod: integer;
    nombre: string[30];
  end;

  personal = record
    empleados: array[1..CAPACIDAD] of ^empleado;
    cantEmpleados: integer;
  end;

{ Modulos }

procedure agregarEmpleado(p: personal; em: empleado);
begin
  if p.cantEmpleados < CAPACIDAD then
  begin
    p.cantEmpleados := p.cantEmpleados + 1;
    new(p.empleadosp[.cantempleados]);
    p.empleados[p.cantEmpleados]^:= em;
  end;
end;

procedure agregarEmpleado(var p: personal; em: empleado);
begin
  if(p.cantEmpleados < CAPACIDAD) then begin
    p.cantEmpleados := p.cantEmpleados + 1;
    p.empleados[p.cantEmpleados]^:= em;
  end;
end;

{ Programa Principal}
var
  variable: tipo;

begin
  // Código principal
end.

{
  Solución: A	❌. 	
  ¿Funciona?: No.	
  Justificación: Porque p se pasa por valor, entonces los cambios no se reflejan afuera del procedimiento.

  Solucion: B	❌. 
  ¿Funciona? No. 
  Justificación:	Aunque p se pasa por referencia, no se reserva memoria para el puntero antes de usarlo.
}

{============================================================================================}

{3) Analizando el siguiente programa indique que imprime en cada sentencia write. Justifique su respuesta}

program tres;

var c,d: integer;

procedure calcular (var a: integer; var b: integer; c: integer);
var d: integer;
begin
  d := c MOD 2 + 15;
  a := c + a;
  if (a + d > 21) then 
    b := a + d * 3
  else b := a + d;
  end;
  writeln('Valor a: ',a,' Valor b: ',b,' Valor c: ',c,' Valor d: ',d);
end;

var
  a,b: integer;
begin
  a := 4; b := 6; d := 12;
  calcular(b,c,a);
  writeln('Valor a: ',a,' Valor b: ',b,' Valor c: ',c,' Valor d: ',d);
end.

{============================================================================================}

{4) Indique verdadero o falso y justifique su respuesta en todos los casos: 

a. Si se conoce la cantidad maxima de elementos a almacenar, el vector es siempre la      estructura de datos mas adecuada para que la solución tenga el menor tiempo de ejecución.

b. Corrección y Eficiencia representan el mismo concepto.

c. een un modulo que agrega un elemento al final de una lista, es correcto recibir el puntero inicial de la pista como un parametro por valor.

d. Las acciones dentro de una estructura de control for siempre se ejecutan al menos una vez.

e.El tiempo de ejecución requerido por el programa "ejercicio4" no supera las 600 unidades de tiempo.

f. La memoria estatica requerida por el programa "ejercicio4" no supera los 80 bytes.

g. La memoria dinamica requerida por el programa "ejercicio4" no supera los 1200 bytes.
}

program ejercicio4;

{
tabla de valores: 
  Char    = 1 byte
  integer = 6 bytes
  real    = 8 bytes
  boolean = 1 byte
  string  = longitud + 1 byte
  puntero = 4 bytes  
    }

const 
  MAX = 30;
  CANT_NOTAS = 4;

{ Sección de tipos }
type
  {subrangos}
  rangoEstudiantes = 1..MAX;
  rangoNotas = 1..CANT_NOTAS;
  {vector}
  vector = array[rangoNotas] of ^real;
  {registro}
  estudiante = record
    ApyNom: string[30];
    legajo: string[10];
    notas: ^vector;
  end;

{ Programa Principal}
var
  e: estudiante;
  j: rangoNotas;
  nota: real;
  i: rangoEstudiantes;
begin
  for i := 1 to MAX do
  begin
    read(e.ApyNom);
    read(e.legajo);
    new(e.notas);
    for j := 1 to CANT_NOTAS do
    begin
      read(nota);
      new(e.notas^[j]);
      e.notas^[j]^ := nota;
    end;
  end;
end.

{
a)	❌ FALSO	Aunque se conozca la cantidad máxima de elementos, el vector no siempre es la mejor opción. Si se requieren muchas inserciones/eliminaciones, otras estructuras como listas o árboles pueden ser más eficientes.
b)	❌ FALSO	Corrección implica que el programa resuelve correctamente el problema. Eficiencia se refiere al uso óptimo de recursos (tiempo/memoria). Son conceptos distintos.
c)	❌ FALSO	Si el puntero a la lista se pasa por valor, los cambios no se reflejan fuera del módulo. Para modificar la lista correctamente, debe pasarse por referencia (var).
d)	❌ FALSO	En Pascal, un for no se ejecuta si el límite inferior es mayor que el superior. Por lo tanto, las acciones no se ejecutan siempre al menos una vez.
e)	✅ VERDADERO	El programa realiza unas 450 operaciones (15 por cada uno de los 30 estudiantes), por lo tanto no supera las 600 unidades de tiempo.
f)	✅ VERDADERO	Se usan aproximadamente 66 bytes de memoria estática (e, j, nota, i), que es menor a 80 bytes.
g)	❌ FALSO	Se utilizan 1440 bytes de memoria dinámica (30 estudiantes × 48 bytes), por lo tanto sí supera los 1200 bytes.
}