{
1) Una facultad DISPONE de los dni de aquellos estudiantes que no cumplen con los requisitos de regularidad ( a lo sumo 1000), los cuales no pueden seguir siendo estudiantes de la facultad. Ademas, dispone de una estructura en la cual almacena todos los estudiantes; de cada estudiante se conoce DNI, apellido y legajo. Esta estructura se encuentra ordenada por DNI. Se pide realizar un programa que elimine (eficientemente en tiempo de ejecución) de la estructura que posee, todos aquellos estudiantes que han perdido la regularidad
}

program ejercicio_1;

const MAX_VEC = 1000;

{ Sección de tipos }
type
  rango = 1..MAX_VEC;

  estudiante = record
    dni: integer;
    ape: string;
    leg: string;
  end;

{Las siguientes estructuras se disponen}

noRegulares = array [rango] of integer; 

lEstudiantes = ^nodoEstudiantes;

nodoEstudiantes = record
  dato: estudiante;
  sig: lEstudiantes;
end;



{ Modulos }

procedure cargarVector(var v: noRegulares; var dimL: integer); //se dispone
var
  e: estudiante;
begin
    // Código del procedimiento
end;

procedure generarLista(var l: lEstudiantes); //se dispone
begin
    // Código del procedimiento
end;

procedure eliminarNoregulares(var l: lEstudiantes; v: noRegulares; dimL: integer);
var ant,act,aux: lEstudiantes; i:integer;
begin
  for i := 1 to dimL do begin
    ant := nil;
    act := l;
    while (act <> nil) and (act^.dato.dni < v[i]) do begin
      ant := act;
      act := act^.sig;
    end;
    if (act<>nil) and (v[i] = act^.dato) then begin
      if ant = nil then l := act^.sig;
      else ant^.sig := act^.sig;
      aux := act;
      act := act^.sig;
      dispose(aux);
    end
  end;
end;


{ Programa Principal}
var
  v: noRegulares; dimL: integer; pri: lEstudiantes;
begin
  pri := nil;
  dimL := 0;
  cargarVector(v,dimL);
  generarLista(pri);
  eliminarNoregulares(pri,v,dimL);
end.