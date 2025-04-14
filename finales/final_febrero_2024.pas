{1) Una empresa dispone de una estructura de datos con las ventas de su comercio. De cada venta se conoce: numero de venta, cantidad de productos y tipo de pago (efectivo o tarjeta). Se pide implementar un programa que genere una seguda estructura con las ventas cuya cantidad de productos tenga mas digitos pares que impares. En la estructura generada deben quedar almacenadas las ventas de tipo de pago efectivo antes que las de tipo de pago con tarjeta}

{=======================================================================================================}

{2) Dados los siguientes programas indique para cada uno si son válidos o no. Además, analice si considera que el funcionamiento en ambos programas es el mismo o no. JUSTIFIQUE.}

Program uno;
Type datos = array [1..100] of integer;
Var d: datos;
Begin
  //Operaciones e invocaciones a módulos para cargar y recorrer el vector d
End;


Program dos;
Var d: array [1..100] of integer;
Begin
// Operaciones e invocaciones a módulos para cargar y recorrer el vector d
End.


{=======================================================================================================}

{3) calcule e indique la cantidad de memoria estatica y dinamica que utiliza el siguiente programa. Mostrar los valores intermedios para llegar al resultado y JUSTIFICAR

------------------------------
char     |  1 byte
integer  |  6 bytes
real     |  10 bytes
boolean  |  1 byte
string   |  longitud + 1 byte
puntero  |  4 bytes
------------------------------
}

program ejercicio3;
type 
  info = record                     
    nombre: string;                 
    nota: integer;                  
    datos: ^integer;                
  end;

  vector = array [1..100] of info;          

var 
  v: vector;                                               
  i,j: integer;                              
  e: info;                                   
begin
  read(e.nombre);
  i := 0;
  while(i <= 100) and (e.nombre <> 'ZZZ') do begin
    read(e.nota);
    e.datos:= nil;
    i := i + 1;
    v[i] := e;
    read(e.nombre);
  end;
  for j := 1 to i do begin
    new(v[j].datos);
    v[j].datos^ := v[j].nota MOD 10;
  end;
End.

{ 
Ejercicio 3)

Cálculo de Memoria Estática y Dinámica

-----------------------------------------------------
TABLA DE TAMAÑOS
char     : 1 byte
boolean  : 1 byte
integer  : 6 bytes
real     : 10 bytes
string   : longitud + 1 byte
puntero  : 4 bytes
-----------------------------------------------------

Tipos definidos:
--------------
}
type 
  info = record                     
    nombre: string;       // sin longitud específica → se asume string[255] → 256 bytes
    nota: integer;        // 6 bytes
    datos: ^integer;      // puntero: 4 bytes
  end;

  vector = array [1..100] of info;

{Variables del programa:
------------------------
- v: vector de 100 elementos → cada elemento ocupa:
    nombre: 256 bytes
    nota: 6 bytes
    datos: 4 bytes
    TOTAL por elemento: 266 bytes

  → 266 × 100 = **26.600 bytes**

- i, j: integer → 6 + 6 = 12 bytes
- e: info → 266 bytes

Memoria Estática Total:
------------------------
vector v            : 26.600 bytes  
enteros i y j       :     12 bytes  
registro e          :    266 bytes  
**TOTAL ESTÁTICA    : 26.878 bytes**

Memoria Dinámica (peor caso):
------------------------------
En el ciclo `for j := 1 to i`, se ejecuta hasta `i = 100`.
Se hace: `new(v[j].datos)` → se reserva 6 bytes por cada uno.

→ 100 × 6 bytes = **600 bytes**

Memoria dinámica total (peor caso): **600 bytes**

Resumen:
--------
Memoria Estática : 26.878 bytes  
Memoria Dinámica (máx): 600 bytes } 

{=======================================================================================================}

{4) Calcule el tiempo de ejecución del programa del punto 3. Mostrar los valores intermedios para llegar al resultado y justificar.}

program ejercicio3;
type 
  info = record                     
    nombre: string;                 
    nota: integer;                  
    datos: ^integer;                
  end;

  vector = array [1..100] of info;          

var 
  v: vector;                                               
  i,j: integer;                              
  e: info;                                   
begin
  read(e.nombre);                                       //no se cuenta
  i := 0;                                               // 1 unidad de tiempo  
  while(i < 100) and (e.nombre <> 'ZZZ') do begin      //C(N+1) + N(cuerpo while)
    read(e.nota);                                       //C = 3, N = 100, cuerpo while = 4
    e.datos:= nil;                                      //(3*101) + (100*4) = 703 unidades de tiempo
    i := i + 1;
    v[i] := e;
    read(e.nombre);
  end;
  for j := 1 to i do begin                              //(3N + 2) +N(cuerpo for) = (3*100 + 2) + 100(2) = 
    new(v[j].datos);                                    //302 + 200 = 502 unidades de tiempo
    v[j].datos^ := v[j].nota MOD 10;
  end;
End.

{
Tiempo de ejecución = 1 + tiempo de while + tiempo del for = 1 + 703 + 502 = 1206 UT
}

{=======================================================================================================}

{ 5. Indique Verdadero o Falso. Justifique en todos los casos.

  a. Incluir módulos dentro de un programa implica que el programa es más eficiente que otro programa que realiza la misma tarea pero sin utilizar módulos. F
  
  b. El siguiente programa es válido.  v}

program ejercicio5;

  function auxiliar(val:integer): integer;
  begin
    val:= val * val;
    auxiliar:= val;
  end;
  
  procedure calculo(c: integer; var b:integer);
  begin
    b:= b + c DIV 4;
  end;

var
  a,b:integer;
begin
  a:= 16;
  b:= 6;
  calculo(auxiliar(a),b);
end.
  
{  c. No siempre es posible declarar un tipo subrango donde su tipo base sea cualquiera de los tipos simples en la teoría. V
  
  d. Un programa que utiliza un repeat until puede reescribirse utilizando un while. F
  
  e. La comunicación entre el programa y los módulos no sólo se puede hacer utilizando parámetros. V
}

{ Respuestas al punto 5:
  a. Falso
  b. Verdadero
  c. Verdadero
  d. Verdadero
  e. Verdadero

  Justificaciones detalladas:

  a. Falso    
    Justificación: La modularización (uso de procedimientos y funciones) no necesariamente hace que un 
    programa sea más eficiente en términos de tiempo de ejecución. De hecho, las llamadas a procedimientos 
    y funciones añaden una ligera sobrecarga debido al tiempo necesario para pasar parámetros, guardar y 
    restaurar el estado, y crear variables locales. La principal ventaja de usar módulos es mejorar la 
    legibilidad, reutilización del código y facilitar el mantenimiento. En algunos casos, un programa 
    monolítico podría ser ligeramente más rápido, aunque menos mantenible.

  b. Verdadero  
    Justificación: El programa funciona correctamente. La función auxiliar(a) calcula el cuadrado de a (16²=256)
    y devuelve este valor. Luego, se llama a calculo(256,b) donde el primer parámetro se pasa por valor (puede 
    ser una expresión) y el segundo por referencia. Dentro de calculo, se modifica b = 6 + 256 DIV 4 = 6 + 64 = 70.
    Al finalizar el programa, a=16 y b=70.

  c. Verdadero    
    Justificación: En Pascal, los subrangos solo pueden definirse a partir de tipos ordenados (que tienen una 
    secuencia natural). Esto incluye tipos como integer, char, boolean o enumerados, pero excluye tipos como 
    real. Por ejemplo, no se puede crear un subrango de números reales como "type SubReal = 1.5..3.7;", ya que 
    los reales no se pueden usar como base para subrangos en Pascal estándar.

  d. Verdadero    
    Justificación: Cualquier bucle repeat-until puede reescribirse como un bucle while. La diferencia principal 
    es que repeat-until siempre ejecuta el cuerpo al menos una vez (comprueba la condición al final), mientras 
    que while comprueba la condición al principio. Para reescribir un repeat-until como while, hay que negar la 
    condición y asegurarse de que el cuerpo se ejecute al menos una vez si es necesario. Un ejemplo sería:
    
    repeat
      // código
    until condición;
    
    Se puede reescribir como:
    
    // código (primera ejecución forzada)
    while not condición do
    begin
      // código
    end;

  e. Verdadero
    Justificación: Además de los parámetros, existen otros mecanismos para comunicar información entre el 
    programa principal y los módulos: variables globales declaradas en la sección principal del programa y 
    accesibles desde los módulos, unidades (units) que permiten compartir tipos, constantes y variables entre 
    módulos, el valor de retorno en el caso de las funciones, y archivos compartidos que pueden ser usados por 
    diferentes partes del programa. Por tanto, los parámetros no son el único mecanismo de comunicación entre 
    el programa y sus módulos.
}