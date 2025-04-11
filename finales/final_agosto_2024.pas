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
2) teniendo en cuenta la siguiente declaración de tipos (type) y los siguientes procedimientos (A, B y C) indique para cada uno de los procesos si los sueldos de los empleados se duplican de manera correcta, el valor del campo dato en cada nodo de la lista "l" recibida como parametro. Justifique su respuesta (en caso de considerar algun proceso incorrecto, indicar todos sus errores).
}

type
  lista = ^nodo;
  nodo = record
    dato: integer;
    sig: lista;
  end;

  procedure uno(l: lista);
  begin
    while(l^.sig <> nil) then begin // debería ser (l <> nil)
      l^.dato := l^.dato * 2;
      l := l^.sig;
    end;
  end;

{
errores:
1.- Error de sintaxis: el bucle while se acompaña de la sentencia "do", then se usa para los "if".
2.- dentro del bucle while se evalua si el nodo siguiente esta vacio, en vez de preguntar si el nodo actual lo esta. Este error logra que si la lista tiene un unico elemento, directamente no se entre al bucle while y si tiene varios nodos, se saltee el ultimo. 
}

  procedure dos(l: lista);
  begin
    while(l <> nil) then begin
      l^.dato := l^.dato * 2;
      l := l^.sig;
    end;
  end;

{
errores:
1.- Error de sintaxis: el bucle while se acompaña de la sentencia "do", then se usa para los "if".
}

  procedure tres(var l: lista);
  begin
    while(l <> nil) then begin
      l := l^.sig;
      l^.dato := l^.dato * 2;
    end;)
  end;

{
errores:
1.- Error de sintaxis: el bucle while se acompaña de la sentencia "do", then se usa para los "if".
2.- La lista se pasa por referencia. En este caso no corresponde ya que el procedimiento no busca agregar o eliminar ningun nodo. Seria mas seguro pasar la lista por valor y trabajar sobre la copia de la misma ya que igualmente de esta manera se puede modificar los elementos apuntados por los punteros. Por otro lado, al pasar por referencia y avanzar el puntero de la lista, al finalizar el mismo quedara apuntando a nil y se perdera la referencia al primer nodo.
3.- Dentro del bucle while, se avanza el puntero de la lista antes de trabajar con el primer nodo, por lo que no se duplicara el primer elemento y ademas se intentara modificar un nodo inexistente en la ultima vuelta.
}

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
  b := 18 DIV 4 + a;
  a := b + 3 * c;
  if((a + b) > 5) then b := b + a * 2
                  else b := b + a * 3;
  c := a + b + c;
  writeln('Valor a: ',a,', ',' Valor b: ',b,', ','Valor c: ',c,','.');
end;

{ Programa Principal}

var
  a,b: integer;
begin
  a := 4
  b := 3
  c := 8
  numero(b,c,a);
  writeln('Valor a: ',a,', ',' Valor b: ',b,', ','Valor c: ',c,','.');
end.

{
  Análisis del programa y del procedimiento `numero`.

  Variables globales (programa principal):
    a := 4
    b := 3
    c := 8

  Llamada al procedimiento:
    numero(b, c, a);
    Esto implica:
      - `a` (parámetro valor) ← b = 3
      - `b` (parámetro por referencia) ← c (original) = 8
      - `c` (parámetro por referencia) ← a (original) = 4

  Dentro del procedimiento:
    b := 18 DIV 4 + a = 4 + 3 = 7
    a := b + 3 * c = 7 + 3 * 4 = 7 + 12 = 19
    (a + b) = 19 + 7 = 26 > 5 → se cumple el "then"
    b := b + a * 2 = 7 + 38 = 45
    c := a + b + c = 19 + 45 + 4 = 68

    Por lo tanto:
      - a (local) = 19
      - b (referencia a c original) = 45
      - c (referencia a a original) = 68

    Salida desde dentro del procedimiento:
      Valor a: 19, Valor b: 45, Valor c: 68.

  Luego de volver al programa principal:
    a (referencia modificada desde el procedimiento) = 68
    b (no fue pasado por referencia) = 3
    c (referencia modificada desde el procedimiento) = 45

  Salida final desde el programa principal:
    Valor a: 68, Valor b: 3, Valor c: 45.
}
