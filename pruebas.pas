program pruebas;

{modulos}

//agregar al final
procedure agregarAlFinal(var v:vector; var dimL: integer; e: elemento);
begin
  if (dimL + 1 <= dimF) then begin //verifico que haya espacio.
    dimL := dimL + 1;              //incremento la dimensión logica.
    v[dimL] := e;                  //agrego el elemento en la ultima posición. 
  end;
end;

//insertar (suponiendo un vector ordenado)
procedure insertar(var v:vector; var dimL: integer; pos: integer; e: elemento);
var i: integer;
begin
  if ((dimL + 1) <= dimF) and ((pos >= 1) and (pos <= dimL)) then begin           //verifico que hay espacio y la psoicion es valida
    for i := dimL downTo pos do                                                   //hago un corrimiento de elementos hacia la derecha, hasta la posición donde quiero insertar el elemento.
      v[i+1] := v[i];
    v[pos] := e;                                                                  //inserto el elemnto en la posicion.
    dimL := dimL + 1;                                                             //incremento la dimensión logica.
  end;
end;

//eliminar (por posicion)
procedure eliminarPos(var v:vector; var dimL:integer; pos: integer);
var i: integer;
begin
  if(pos >= 1) and (pos <= dimL) then  begin                                           //verifico que la posicion es valida
    for i := pos to dimL -1 do v[i] := v[i+1];                                        //hago un corrimiento de elementos hacia la izquierda, hasta la posición que quiero borrar.
    dimL := dimL - 1;                                                                //decremento la dimensión logica. 
  end;
end;

//eliminar (por elemento)
procedure eliminarElemento(var v:vector; var dimL: integer; e: elemento);
var pos: integer;
begin
  pos := buscarPos(v,dimL,e);                                                     //busco si el elemento esta en el vector, en caso afirmativo devuelve la posición y en caso negativo devuelve -1.
  if(pos >= 1 and pos <= dimL) then                                               //verifico que la posición sea valida
    eliminarPos(v,dimL,pos);                                                      //en caso afirmativo, invoco al procedimiento para eliminar el elemento por su posición.
end;


//eliminar ocurrencias
procedure eliminarOcurrencias(var v:vector; var dimL: integer; e: elemento);
var p: integer;
begin
  p := 1;
  while (p <= dimL) do begin
    if v[p] = e then
      eliminarPos(v,dimL,p)
    else
      p := p + 1;
  end;
end;

//busqueda (en vector desordenado)
function buscar(v:vector; dimL:integer; e:elemento): integer;
var pos: integer; esta: boolean;
begin
  pos := 1;
  esta:= false;
  while(pos <= dimL) and not(esta) do begin
    if(v[pos] = e) then esta := true
    else pos := pos + 1;
  end;
  if not((pos <= dimL) and (v[pos] = e)) then pos := -1
  buscar := pos;
end;

//busqueda mejorada (en vector ordenado)
function buscar(v:vector; dimL:integer; e: elemento):integer;
var pos: integer;
begin
  pos := 1;
  while (pos <= dimL) and (v[pos] < e) do
    pos := pos + 1;
  if not((pos <= dimL) and (v[pos] = e)) then pos := -1;
  buscar := pos;
end;

//busqueda dicotomica (en vector ordenado)
function busquedaDicotomica(v:vector;  dimL:integer; e: elemento):integer;
var inf,med,sup: integer;
begin
  inf := 1; sup := dimL; med := (sup + inf) div 2;
  while (inf <= sup) and (v[med] <> e) do begin
    if(v[med] < e) then inf := med + 1
    else sup := med - 1;
    med := (sup+inf) div 2;
  end;
  if not((inf <= sup) and (v[med] = e)) then med := -1;
  busquedaDicotomica := med;
end;

{programa principal}