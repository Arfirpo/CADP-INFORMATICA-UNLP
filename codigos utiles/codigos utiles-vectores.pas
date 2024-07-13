
//agregar elemento al vector

procedure agregar(var v: vector; var dimL: integer; var pude: boolean; e: elemento);
begin
  pude := false;
  if((dimL + 1) <= dimF) then begin
    pude := true;
    dimL := dmL + 1;
    v[dimL] := e;
  end;
end;

//Insertar Ordenado en el Vector

procedure Insertar(var v: vector; var dimL: integer; var pude: boolean; p: integer; e: elemento);
var
  i: integer;
begin
  pude := false;
  if ((dimL + 1) <= dimF) and ((p >= 1 and) (p <= dimL)) then begin
    for i := dimL downto p do
      v[i +1] := v[i];
    pude := true;
    v[p] := e;
    dimL := dimL + 1;
  end;
end;