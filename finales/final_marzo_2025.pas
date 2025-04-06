{Un comercio DISPONE de una estructura de datos con información de las facturas realizadas durante el ultimo mes (como máximo 1000).
De cada factura se conoce el número de factura, código de sucursal (1..5) a la que pertenece y monto total.
Se pide implementar un programa que lea de teclado un código de sucursal y elimine de la estructura todas las facturas pertenecientes al código de sucursal leído.
Al finalizar debe informar el monto total acumulado en todas las facturas eliminadas.
La solución debe ser optima en tiempo de ejecución.
}

Program final_marzo_2025;

Type
  sucursales: 1..5;
  Factura = record
    nro: integer;
    cod_Sucursal: sucursales;
    mtot: real;
  end;

    vFacturas =  array[1..1000] of Factura; //se dispone.

{ Módulos }

  // procedures o functions

{ Programa Principal}

Var 
  Facturas: vFacturas;
  cod: sucursales;
Begin
  inicializarVector(Facturas);

  eliminarFacturas(Facturas,cod);
End.
