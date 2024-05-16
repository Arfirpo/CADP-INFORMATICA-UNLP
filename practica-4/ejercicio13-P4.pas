program ejercicio13P4;

{
  para darse una idea de como encarar el ejercicio, sugiero ver: 
  
  https://github.com/OmgCopito95/CADP/blob/main/A%C3%B1os/2023/Consultas%20Pr%C3%A1cticas/Viernes%205-5/project1.lpr

}


const
  dimF = 100; //puntos de medicion en el planeta.
  dimF2 = 50; //años de relevamiento
  anioActual = 2024;

type
  rango = 1..dimF;
  rango2 = 1..dimF2;
  
  vTemp = array[rango] of real;    //vector de reales
  vRelev = array[rango2] of vTemp;  //vector que guarda: vectores que almacenan reales.
  

{modulos}

procedure cargarVectorTemp(var t: vTemp);
var
  i: rango;
begin
  for i := 1 to dimF do
    write('Ingrese la temperatura promedio del punto ',i);
      readln(t[i]);
end;


procedure cargarVectorAnios(var r: vRelev);
var
  i: rRelev;
begin
  for i := 1 to dimF do
    cargarVectorPuntos(r[i]);
end;

procedure recorrerVectorAnios(r: vRelev);
var
  i: rango2;
  prom, max: real;
begin
  max := -9999;
  for i := 1 to dimF2 do
    begin
      recorrerVectorTemp(r[i],prom,i);
      PromMax(max,prom,i,maxA);
    end;
  writeln('El año con mayor temperatura promedio es ',maxA);
end;

  {programa principal}
  var
    t: vTemp;
    r: vRelev;
  begin
    cargarV(t,r);
    recorrerVectorAnios(r);
  end.