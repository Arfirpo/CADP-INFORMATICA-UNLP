program ejercicio10P4;

{constantes globales}
const
  dimF = 300;          //se deben leer a lo sumo 300 salarios.
  aumento = 0.15;
  condCorte = 0;

{tipos de datos definidos por el programador}
type
  rango = 1..dimF;
  vSalarios = array[rango] of real;

{modulos}

procedure cargarVector(var sal: vSalarios; var dimL: integer);
var
  s: real;
begin
  write('Ingrese el salario del empleado: ');
  readln(s);
  while (s <> condCorte) and (dimL < dimF) do
    begin
      dimL := diml +1;
      sal[dimL] := s;
      write('Ingrese el salario del empleado: ');
      readln(s);
    end;
end;


procedure aumentoSal(var sal: vSalarios; dimL: integer; x: real);
var
  i: integer;
begin
  for i := 1 to dimL do
    sal[i] := sal[i] * x;
end;

function promSueldo(sal: vSalarios; dimL: integer):real;
var
  i: integer;
begin
  promSueldo := 0;
  for i := 1 to dimL do
    promSueldo := promSueldo + sal[i];
  promSueldo := promSueldo / dimL;
end;

procedure informarProm(prom: real);
begin
  writeln('El promedio salarial de los empleados de la empresa es de $ ',prom:2:2);
end;


{programa principal}
var
  sal: vSalarios;
  dimL: integer;
  x,prom: real;
begin
  x := 1.15;
  cargarVector(sal,dimL);
  prom := promSueldo(sal,dimL);
  informarProm(prom);
  aumentoSal(sal,dimL,x);
  prom := promSueldo(sal,dimL);
  write('Con el aumento del 15%, ');
  informarProm(prom);
end.
