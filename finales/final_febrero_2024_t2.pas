{1) Una empresa dispone de una estructura de datos con las ventas de su comercio. De cada venta se conoce: numero de venta, cantidad de productos y tipo de pago (efectivo o tarjeta). Se pide implementar un programa que genere una seguda estructura con las ventas cuya cantidad de productos tenga al menos dos digitos pares. En la estructura generada deben quedar almacenadas las ventas de tipo de pago tarjeta antes que las de tipo de pago efectivo}
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


  {Respuesta:  ambos programas son validos. A nivel funcional son equivalentes, ya que ambos declaran una variable que es un array de enteros pero el programa uno al tener un tipo de dato creado por el usuario, permitela reutilización del tipo, mientras que en el programa dos debera declararse el array de enteros cada vez que quiera usarse una variable de tal tipo}

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
      prom: real;
			datos: ^integer;                
    end;

    vector = array [1..80] of info;          

  var 
    v: vector;                                               
    i,cant integer;                              
    e: info;                                   
  begin
    for i := 1 to 80 do begin
			read(e.nota);
			read(e.nombre);
			read(e.prom);
			if(i MOD 2 = 0) then new(v[i].datos)
											else v[i].datos := nil;
    end;
    i := 0;
    while(i <= 80) and (e.nombre <> 'ZZZ') do begin
			cant := 0;
      if(v[i].nota > 5) then cant := cant + 1;
			i := i+1;
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
    info = record                		//Total: 276 bytes
      nombre: string;            		//255 + 1 = 256 bytes     
      nota: integer;             		// 6 bytes
      prom: real;								 		// 10 bytes
			datos: ^integer;           		// 4 bytes     
    end;

    vector = array [1..80] of info; // 80 * 276 = 22.080 bytes.

  {Variables del programa:
  ------------------------
  - v: vector de 80 elementos → cada elemento ocupa:
      nombre: 256 bytes
      nota: 6 bytes
			prom: 10 bytes
      datos: 4 bytes
      TOTAL por elemento: 276 bytes

    → 276 × 80 = **22.080 bytes**

  - i, cant: integer → 6 + 6 = 12 bytes
  - e: info → 276 bytes

  Memoria Estática Total:
  ------------------------
  vector v            : 22.080 bytes  
  enteros i y j       :     12 bytes  
  registro e          :    276 bytes  
  **TOTAL ESTÁTICA    : 22.368 bytes**

  Memoria Dinámica:
  ------------------------------
  En el ciclo `for j := 1 to 80`, se ejecuta hasta `i = 80`.
  Se hace: `new(v[i].datos)` solo cuando`if(i MOD 2 = 0)` lo cual ocurre la mitad de las veces, es decir 40 veces. → se reserva 6 bytes por cada uno.

  → 40 × 6 bytes = **240 bytes**

  Memoria dinámica total (peor caso): **600 bytes**

  Resumen:
  --------
  Memoria Estática : 22.368 bytes bytes  
  Memoria Dinámica: 240 bytes } 

{=======================================================================================================}

{4) Calcule el tiempo de ejecución del programa del punto 3. Mostrar los valores intermedios para llegar al resultado y justificar.}

  program ejercicio3;
  type 
    info = record                     
      nombre: string;                 
      nota: integer;                  
      prom: real;
			datos: ^integer;                
    end;

    vector = array [1..80] of info;          

  var 
    v: vector;                                               
    i,cant integer;                              
    e: info;                                   
  begin
    for i := 1 to 80 do begin // (3N + 2) + N(C). N = 80; C = 
			read(e.nota);           // no cuenta.
			read(e.nombre);					// no cuenta.
			read(e.prom);						// no cuenta.
			if(i MOD 2 = 0) then new(v[i].datos) 		// 2 + 1
											else v[i].datos := nil;
    end;
    i := 0;																		// 1
    while(i <= 80) and (e.nombre <> 'ZZZ') do begin // C(N + 1) + N(Cuerpo While)
			cant := 0;						//1
      if(v[i].nota > 5) then cant := cant + 1; //1 + 2
			i := i+1;				// 2
    end;
  End.

  {
	Tiempo del programa = tiempo del for (482 UT) + 1 + tiempo del while (732 UT) - Total: 1215 UT.
	Tiempo del for = ((3 * 80) + 2) + 80  * 3 = 242 + 240 = 482 UT.
	Tiempo del While = 3(81 + 1) + 81(6) = 732 UT.
	Tiempo de I := 0 -> 1 UT
}
{=======================================================================================================}

{ 5. Indique Verdadero o Falso. Justifique en todos los casos.

  a. Siempre es posible declarar un tipo subrango donde su tipo base sea cualquiera de los tipos simples vistos en la teoria.
  
  b. Incluir modulos dentro de un programa implica que el programa es mas eficiente que otro programa que realiza la misma tarea pero sin utilizar modulos.
	
	
	c.El siguiente programa es válido.  }

  program ejercicio;

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
    a:= 4;
    b:= 8;
    calculo(auxiliar(a),b);
  end.
    
  {  d. Si conozco la dimensión logica de un arreglo de elementos enteros puedo utilizar un repeat para recorrerlo e imprimir sus elementos
    
    e. La comunicación entre el programa y los modulos solo se puede hacer utilizando parametros.
  }

  { Respuestas al punto 5:
    a. Falso
    b. Falso
    c. Verdadero
    d. Verdadero
    e. Falso

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

{=======================================================================================================}