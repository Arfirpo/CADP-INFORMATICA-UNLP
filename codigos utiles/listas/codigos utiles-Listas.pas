
//agregar nodo adelante.

procedure armarNodo(var l: lista; e: elemento);
var
  nue: lista;
begin
  new(nue);
  nue^.dato := e;
  nue^.sig := l;
  l := nue;
end;

//Insertar nodo Ordenado.

procedure insertarOrdenado(var l: lista; e: elemento);
var
  nue,ant,act: lista;
begin
  new(nue);
  nue^.dato := e;
  ant := l;
  act := l;
  while (act <> nil) and (e > act^.dato) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = ant) then
    l := nue
  else 
    ant^.sig := nue;
  nue^.sig := act;
end;

//agregar nodo atras (con dos punteros).

procedure agregarAtras(var pri,ult: lista; e: elemento);
var
  nue: lista;
begin
  new(nue);
  nue^.dato := e;
  nue^.sig := nil;
  if (pri = nil) then
    pri := nue
  else
    ult^.sig := nue;
  ult := nue;
end;

//eliminar nodo (una sola vez).

procedure eliminarElem(var l: lista; e: elemento);
var
  ant,act: lista;
  pude: boolean;
begin
  pude := false;
  ant := nil;
  act := l;
  while (act <> nil) and (not pude) do begin
    if (e <> act^.dato) then begin
      ant := act;
      act := act^.sig;
    end
    else
      pude := true;     
  end;
  if (act <> nil) and (pude) then
    if (act = l) then
      l := l^.sig
    else
      ant^.sig := act^.sig;
    dispose(act);
end;

//eliminar ocurrencias.

procedure eliminarOcurrencias(var l: lista; e: elemento);
var
  ant,act;
begin
  ant := nil;
  act := l;
  while (act <> nil) do begin
    if (e <> act^.dato) then begin
      ant := act;
      act := act^.sig;
    end
    else begin
      if (act = l) then
        l := l^.sig
      else
        ant^.sig := act^.sig;
      dispose(act);
      act := ant;  
    end;
  end;
end;