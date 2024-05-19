program ejercicio13P4;
{
  para darse una idea de como encarar el ejercicio, sugiero ver: 
  https://github.com/OmgCopito95/CADP/blob/main/A%C3%B1os/2023/Consultas%20Pr%C3%A1cticas/Viernes%205-5/project1.lpr

}
const
  dimF = 100; //puntos de medicion en el planeta.
  dimF2 = 50; //años de relevamiento.

type
  rango = 1..dimF;
  rango2 = 1..dimF2;
  vTemp = array[rango] of real;    //vector de reales
  vAnios = array[rango2] of vTemp;  //vector que guarda: vectores que almacenan reales.

{modulos}

procedure cargarVecTemp(var t: vTemp);
var
  i: rango;
begin
  for i := 1 to dimF do
    begin
      write('Ingrese la temperatura promedio del punto ',i,': ');
      readln(t[i]);    
    end;
end;

procedure cargarVecAnios(var a: vAnios);
var
  i: rango2;
begin
  for i := 1 to dimF2 do
    cargarVecTemp(a[i]);
end;

procedure recorrerVecTemp(t: vTemp; i: rango2; var prom,max2: real; var maxT: rango2);
var
  aux: rango;
begin
  prom := 0;
  for aux := 1 to dimF do
    begin
      if t[aux] > max2 then
        begin
          max2 := t[aux];
          maxT := i;
        end;
      prom := prom + t[aux];
    end;
  prom := prom / dimF;
end;

procedure promMax(prom: real; i: rango2; var max: real;  var maxA: rango2);
begin
  if prom > max then
    begin
      max := prom;
      maxA := i;      
    end;
end;

procedure recorrerVectorAnios(a: vAnios);
var
  i: rango2;
  prom,max,max2: real;
  maxT,maxA: rango2;
begin
  max := -9999;
  max2:= -9999;
  maxA := 1;
  maxT := 1;
  for i := 1 to dimF2 do
    begin
      recorrerVecTemp(a[i],i,prom,max2,maxT);
      promMax(prom,i,max,maxA);
    end;
  writeln('El anio con mayor temperatura promedio es ',maxA);
  writeln('El anio con mayor temperatura detectada en los ultimos 50 años es ',maxT);
end;

  {programa principal}
  var
    a: vAnios;
  begin
    cargarVecAnios(a);
    recorrerVectorAnios(a);
  end.