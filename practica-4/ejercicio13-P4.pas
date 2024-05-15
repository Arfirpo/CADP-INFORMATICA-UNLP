program ejercicio13P4;

const
  pDeMedicion = 100; //puntos de medicion en el planeta.
  aDeRelev = 50; //años de relevamiento

type
  str30 = string[30];
  rango = 1..pDeMedicion;
  rRelev = 1..aDeRelev;

  punto = record
    lugar: str30;
    tProm: real;
  end;

  vPuntos = array[rango] of punto;    //vector de registros de puntos 
  vRelev = array[rRelev] of vPuntos;  //vector que guarda: vectores que almacenan registros de puntos.

  {modulos}





  {programa principal}
  var
    p: vPuntos;
    r: vRelev;
  begin
    cargarV();
  end.