{1.-}
{=======================================================================}
{2.- Dada la siguiente declaración y los siguientes modulos, indique para cada opción si incrementa en 1 cada uno de los elementos del vector. Justifique en cada caso.}
    program ejercicio2;
    const dimF = 50;
    type
      rango = 1..dimF;
      tVector = array [rango] of ^integer;
      vector = record
        vec: tVector;
        dimL: Integer;
      end;
    
    {modulos}

    //A
    procedure inicializar(v:vector);
    var i: rango;
    begin
      for i := 1 to v.dimL do begin
        new(v.vec[i]);
        v.vec[i]^ := v.vec[i]^ + 1;
      end;
    end;

    //B
    procedure inicializar2(var v: vector);
    var i: rango;
    begin
      for i:=1 to dimL do begin
        v.vec[i] := v.vec[i] + 1;
      end;
    end;


{=======================================================================}
{3.-}
{=======================================================================}
{4.-}
{=======================================================================}
{5.-}
{=======================================================================}