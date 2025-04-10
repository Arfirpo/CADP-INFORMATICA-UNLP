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

  procedure leerEstudiante(var e: estudiante); //se dispone
  begin
  end;

  procedure agregarOrdenado(var l: lEstudiantes; e: estudiante); //se dispone
  var nue,ant,act: lEstudiantes;
  begin
  end;

begin
  // Código del procedimiento
end;

procedure ordenarVector(var v: noRegulares; dimL: integer);
var i,j,p: integer; item: estudiante;
begin
  for i := 1 to dimL -1 do begin
    p := i;
    for j := i + 1 to dimL do if (v[j] < v[p]) then p := j;
    item := v[p];
    v[p] := v[i];
    v[i] := item;
  end;
end;

procedure eliminarNoregulares(var l: lEstudiantes; v: noRegulares; dimL: integer); // recorrido tipo merge
var ant,act,aux: lEstudiantes; i:integer;
begin
  act := l;
  ant := nil;
  i := 1;

  while (act <> nil) and (i <= dimL) do
  begin
    if(act^.dato.dni < v[i]) then begin
      ant := act;
      act := act^.sig;
    end
    else if(act^.dato.dni = v[i]) then begin
      if(ant = nil) then l := act^.sig
      else ant^.sig := act^.sig;
      aux := act;
      act := act^.sig;
      dispose(aux);
      i := i + 1;
    end
    else
      i := i + 1;
  end;
end;

{ Programa Principal}
var
  v: noRegulares; dimL: integer; pri: lEstudiantes;
begin
  pri := nil;
  dimL := 0;
  cargarVector(v,dimL);
  ordenarVector(v,dimL);
  generarLista(pri);
  eliminarNoregulares(pri,v,dimL);
end.

{ Observaciones:

Alternativa eficiente propuesta (recorrido tipo merge tras ordenar)
🔹 Paso 1: Ordenar el vector (por selección o inserción)
Dado que el vector tiene a lo sumo 1000 elementos, se puede ordenar con algoritmo de selección o inserción, ambos de complejidad O(m²) en el peor caso.

Aunque no es óptimo para vectores grandes, con m ≤ 1000 es aceptable y dentro de lo enseñado.

🔹 Paso 2: Recorrer la lista y el vector ordenado simultáneamente
Como la lista está ordenada por DNI y el vector también, se puede aplicar una lógica tipo merge:

Comparamos el DNI del nodo actual de la lista con el actual del vector.

Si hay coincidencia → se elimina el nodo de la lista.

Si el vector tiene un DNI menor → se avanza el vector.

Si la lista tiene un DNI menor → se avanza la lista.

Esto recorre una sola vez ambos: O(n + m) donde n = total estudiantes, m = irregulares.

Comparativa
-----------

---> Estrategia: Ordenar vector (por inserción o selección) + recorrido conjunto.
---> Complejidad: O(m² + n + m) = O(m² + n).
---> Eficiencia práctica: ✅ Eficiente dentro del contexto (m ≤ 1000).

---> Estrategia: Buscar cada DNI del vector en la lista.
---> Complejidad: O(m × n).
---> Eficiencia: ❌ Ineficiente si n es grande.
}

{===================================================================}

{
2) teniendo en cuenta la siguiente declaración de tipos (type) y los siguientes procedimientos (A, B y C) indique para cada uno de los procesos si los sueldos de los empleados se duplican de manera correcta, el valor del campo dato en cada nodo de la lista "l" recibida como parametro. Justifique su respuesta (en caso de considerar algun procesp incorrecto, indicar todos sus errores).
}

type
  lista = ^nodo;
  nodo = record
    dato: integer;
    sig: lista;
  end;

  procedure uno(l: lista);
  begin
    while(l^.sig <> nil) then begin
      l^.dato := l^.dato * 2;
      l := l^.sig;
    end;
  end;

  procedure dos(l: lista);
  begin
    while(l <> nil) then begin
      l^.dato := l^.dato * 2;
      l := l^.sig;
    end;)
  end;

  procedure tres(var l: lista);
  begin
    while(l <> nil) then begin
      l := l^.sig;
      l^.dato := l^.dato * 2;
    end;)
  end;

  {===================================================================}

{
3) Dado el siguiente programa indique que imprime en cada sentencia write. Justifique su respuesta.
}

program NombrePrograma;

var a,c: integer

{modulos}

procedure numero(a: integer; var b: integer; var c: integer);
var a: integer;
begin
  b := 10 DIV 4 + a;
  a := b + 3 * c;
  if((a + b) > 5) then b := b + a * 2
                  else b := b + a * 3;
  c := a + b + c;
  writeln('Valor a: ',a,', ',' Valor b: ',b,', ','Valor c: ',c,','.');
end;

{ Programa Principal}

var
  a,d: integer;
begin
  a := 4
  b := 3
  c := 8
  numero(b,c,a);
  writeln('Valor a: ',a,', ',' Valor b: ',b,', ','Valor c: ',c,','.');
end.