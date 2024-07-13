
//agregar elemento al vector

procedure agregar(var v: vector; var dimL: integer; var pude: boolean; e: elemento);
begin
  pude := false;
  if((dimL + 1) <= dimF) then begin //chequeo que haya espacio en el vector.
    pude := true;
    dimL := dmL + 1; //incremento la dimensión logica.
    v[dimL] := e; //guardo en la dimensión logica incrementada el elemento.
  end;
end;

//Insertar Ordenado en el Vector

procedure Insertar(var v: vector; var dimL: integer; var pude: boolean; p: integer; e: elemento);
var
  i: integer;
begin
  pude := false;
  if ((dimL + 1) <= dimF) and ((p >= 1 and) (p <= dimL)) then begin //chequeo que haya espacio en el vector y que la posición sea valida.
    for i := dimL downto p do //recorro el vector desde la dimensión logica, para atras, hasta la posición del elemento que voy a insertar.
      v[i +1] := v[i];  //hago el corrimiento para adelante en las posiciones del vector
    pude := true;
    v[p] := e; //inserto el elemento en la posición dada.
    dimL := dimL + 1; //incremento la dimensión logica.
  end;
end;

//Eliminar elemento (Por Posición).

procedure eliminarPos(var v: vector; var dimL: integer; var pude: boolean; p: integer; e: elemento);
var 
  i: integer;
begin
  pude := false;
  if (p >= 1) and (p <= dimL) then begin //chequeo si la posición es valida.
    for i := p to dimL do
      v[i] := v[ i+1]; //hago el corrimiento para atras.
    pude := true; 
    dimL := dimL - 1; //decremento la dimensión logica.
  end;
end;

//Eliminar elemento (sin saber Posición).

procedure eliminarElem(var v: vector; var dimL: integer; var pude: boolean; e: elemento); 
//para eliminar un elemento que no sabemos la posicion primero hay que buscar si se encuentra en el vector, 
//determinar su posicion y luego eliminarlo.
  
  function buscarPos(v: vector; dimL: integer; e: elemento):integer;
  var
    p: integer;
    pude: boolean;
  begin
    p := 1;
    pude := false;
    while (p <= dimL) and (not pude) do begin
      if (v[p] = e) then
        pude := true
      else
        p := p + 1;
    end;
    if (pude = false) then
      p := -1;
    buscarPos := p;
  end;

  procedure eliminarPos(var v: vector; var dimL: integer; var pude: boolean; p: integer);
  var
    i: integer;
  begin
    pude := false;
    if (p >= 1) and (p <= dimL) then begin
      for i := p to dimL do
        v[i] := v[i+1];
      dimL := dimL - 1;
      pude := true;
    end;
  end;

var
  p := integer;
begin
  p := buscarPos(v,dimL,e);
  if (p <> -1) then
    eliminarPos(v,dimL,pude,p);
end;

//Eliminar Ocurrencias.

procedure eliminarOcurrencias(var v: vector; var dimL: integer; e: elemento);

  procedure eliminarPos(var v: vector; var dimL: integer; p: integer);
  var
    i: integer;
  begin
    for i := p to dimL do
      v[i] := v[i+1];
  end;

var
  i: integer;
begin
  i := 1;
  while (i <= dimL) do begin
    if (e = v[i]) then
      eliminarPos(v,dimL,i);
    else
      i := i + 1;
  end;
end;

//Buscar Posicion de elemento (en Vector Desordenado).

function buscarPosDes(v: vector; dimL: integer; e: elemento):integer;
var
  p: integer;
  pude: boolean;
begin
  p := 1;
  pude := false;
  while (p <= dimL) and (not pude) do begin
    if (v[p] = e) then
      pude := true
    else
      p := p + 1;
  end;
  if (pude = false) then
    p := -1;
  buscarPos := p;
end;

//Buscar Posicion de elemento (en Vector Ordenado).

function buscarPosOrd(v: vector; dimL: integer; e: elemento):integer;
var
  p: integer;
begin
  p := 1;
  while (p <= 1) and (e > v[p]) do
    p := p + 1;
  if (p > dimL) or (e < v[p]) then
    p := -1;
  buscarPosOrd := p;
end;

//Ordenar -en este caso, de mayor a menor- un vector (cuando ya esta cargado);

procedure ordenarVector(var v: vector; dimL: integer;);
var
  i,j,p,item: integer;
begin
  for i := 1 to (dimL -1) do begin
    p := i;
    for j := (i + 1) to dimL do 
      if (v[j] > v[i]) then
        p := j;
    item := v[p];
    v[p] := v[i];
    v[i] := item;
  end;
end;