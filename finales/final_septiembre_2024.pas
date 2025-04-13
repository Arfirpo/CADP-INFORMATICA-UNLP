{
1) Una empresa dispone de la información de las asistencias de sus empleados durante un periodo de tiempo. De cada empleado se conoce: dni, apellido y nombre, codigo de departamento en el que trabaja (entre 1 y 100), fecha y si estuvo presente o no ese dia (no todos los dias se pasa asistecia y los empleados pueden haber estado trabajando o haber faltado). ESTA ESTRUCTURA SE ENCUENTRA ORDENADA POR CÓDIGo DE DEPARTAMENTO. Se pide realizar un programa que informe el departamento con mas empleados presentes durante el período evaluado por la empresa
}

program ejercicio1;

const max_deptos = 100;

type
  rango_deptos = 1..max_deptos;

  Fecha = record
    dia: 1..31;
    mes: 1..12;
    anio: 2024..2025;
  end;

  empleado = record
    dni: integer;
    apeYnom: String[20];
    cod_Depto: rango_deptos;
  end;

  asistencia = record
    emp: empleado;
    fecha: Fecha;
    presente: boolean;
  end;

  lAsistencia = ^nAsistencia;

  nAsistencia = record
    dato: asistencia;
    sig: lAsistencia;
  end;

  lDnis = ^nDnis;

  nDnis = record
    dato: integer;
    sig: lDnis;
  end;

{modulos}

  procedure leerFecha(var f: Fecha);
  begin
    with f do begin
      write('Dia: '); readln(dia);      
      write('Mes: '); readln(mes);      
      write('Anio: '); readln(anio);      
    end;
  end;

  procedure generarLista(var l: lAsistencia);
  var a: asistencia;
  begin
    // se dispone
  end;

  function fechaValida(f, fIni, fFin: Fecha): boolean;
  begin
    fechaValida := ((f.anio > fIni.anio) or (f.anio = fIni.anio) and (f.mes > fIni.mes) or (f.mes = fIni.mes) and (f.dia >= fIni.dia)) and
                  ((f.anio < fFin.anio) or (f.anio = fFin.anio) and (f.mes < fFin.mes) or (f.mes = fFin.mes) and (f.dia <= fFin.dia));
  end;

  procedure procesarLista(l: lAsistencia);

    procedure actualizarMaximo(cant_presente: integer; var max_presente: integer; cod_act: rango_deptos; var max_cod);
    begin
      if(cant_presente > max_presente) then begin
        max_presente := cant_presente;
        max_cod := cod_act;
      end;
    end;

    procedure agregarListaDnis(var l: lDnis; dni: integer);
    var aux: lDnis;
    begin
      aux := l;
      while (aux <> nil) and (aux^.dato <> dni ) do begin
        aux := aux^.sig;
      end;
      if aux = nil then begin
        new(aux);
        aux^.dato := dni;
        aux^.sig := l;
        l := aux;
      end;
    end;

  var 
    fIni,fFin: Fecha;
    pri: lDnis;
    cant_presente,max_presente: Integer;
    cod_act: rango_deptos;
    max_cod: integer;
  begin
    Writeln('Ingrese fecha de inicio (Periodo de asistencias): '); leerFecha(fIni);
    Writeln('Ingrese fecha de final (Periodo de asistencias): ');  leerFecha(fFin);
    max_presente := -1;

    while(l <> Nil) do begin
      pri := nil;
      cod_act := l^.dato.emp.cod_Depto;
      cant_presente := 0;

      while(l <> nil) and (l^.dato.emp.cod_Depto = cod_act) do begin
        if(fechaValida(l^.dato.fecha, fIni, fFin) and l^.dato.presente) then begin
          agregarListaDnis(pri,l^.dato.emp.dni);
          l := l^.sig;
        end;
      end;

      while (pri <> nil) do begin
        cant_presente := cant_presente + 1;
        pri := pri^.sig;
      end;

      actualizarMaximo(cant_presente,max_presente,cod_act,max_cod);
    end;
    Writeln('El departamento con codigo ',max_cod,' fue el que mas empleados presentes tuvo durante el periodo ',fIni,' - ',fFin,'.');
  end;

{programa principal}
var
  pri: lAsistencia;
begin
  pri := nil;
  generarLista(pri);
  procesarLista(pri);
End.

{=============================================================================================}

{
2) suponga que se quiere implementar un modulo que retorne verdadero o falso si un valor entero existe o no en un vector. Indique para cada una de estas opciones (A y B) si realiza de forma correcta y/o eficiente la busqueda de un valor entero en un vector. Justificar.
}

type
  vector =  array[1..1000] of integer;

  type
  vector = array[1..1000] of integer;

{-----------------------------------------
  Procedimiento A - Incorrecto
------------------------------------------}
  procedure busqueda(v: vector; dimL: integer; valor: integer; var ok: boolean);
  var i: integer;
  begin
    i := 1;
    for i := 1 to dimL do
      if (valor = v[i]) then ok := true
                        else ok := false;
  end;

  {✘ Error lógico:
    - El valor de 'ok' se pisa en cada iteración.
    - Si encuentra el valor en alguna posición pero luego no lo encuentra, 'ok' vuelve a ser false.
    - No corta la búsqueda al encontrar el valor.
  }

  {⏱ Tiempo de ejecución: 5n + 4}
  {  (for = 3n + 3, cuerpo = 2n, inicialización = 1)}

{-----------------------------------------
  Procedimiento B - Correcto pero menos eficiente
------------------------------------------}
  procedure busqueda(v: vector; dimL: integer; valor: integer; var ok: boolean);
  var i: integer;
  begin
    i := 1; ok := false;
    while i < dimL and not(ok) do begin
      if (valor = v[i]) then ok := true;
      i := i + 1;
    end;
  end;

  {✔ Correcto:
    - Busca correctamente el valor.
    - Corta la búsqueda cuando lo encuentra.
    - Pero tiene un leve error en la condición del while: debería ser 'i <= dimL' para no saltear el último elemento.
  }

  {⏱ Tiempo de ejecución: 7n + 5}
  {  (evaluación while: 3(n+1), cuerpo: 4n, inicialización: 2)}

{-----------------------------------------
  Función sugerida - Correcta y eficiente
------------------------------------------}
function busqueda(v: vector; dimL: integer; valor: integer): boolean;
var
  pos: integer;
begin
  pos := 1;
  while (pos <= dimL) and (v[pos] <> valor) do
    pos := pos + 1;
  busqueda := pos <= dimL;
end;

{✔ Ventajas:
  - Correcta y clara: devuelve true si encuentra el valor, false en caso contrario.
  - Corta la búsqueda al encontrar coincidencia.
  - No necesita variable externa ('ok').
  - Más eficiente que el procedimiento B.
}

{⏱ Tiempo de ejecución: 5n + 6}
{  (while: 3(n+1), cuerpo: 2n, inicialización y asignación final: 3)}

{============================================================================================}

{
3) Dado el siguiente programa indique que imprime en cada sentencia write. Justifique su respuesta.
}
program tres;
var
  c, d: integer;

  procedure numero(var a: integer; var b: integer; var c: integer);
  var
    a: integer;
  begin
    a := (b DIV 3) + c;     // (8 DIV 3) + 4 = 6
    b := (18 DIV a) + d;    // (18 DIV 6) + 5 = 8
    if ((a + b) > 5) then   // (6 + 8) > 5 ? = TRUE
      b := b + (a * 2)      // 8 + (6 * 2) = 20
    else
      b := (b + a) * 3;
    c := a + b + c;         // 6 + 20 + 4 = 30
    writeln('Valor a: ', a, ', Valor b: ', b, ', Valor c: ', c);
  end;

var
  a, b: integer;
begin
  a := 4;
  b := 3;
  c := 8;
  d := 5;
  numero(b, c, a);
  writeln('Valor a: ', a, ', Valor b: ', b, ', Valor c: ', c);
end.

{
procedimiento: 
1 - a := 3 | b := 8 | c:= 4
2 - a := 6
3 - b := 8
4 - b := 20
5 - c := 30

Respuestas:
  en el Procedimiento: a := 6 | b := 20 | c := 30 |
  en el Programa: a := 30 | b := 3 | c := 20 |
}

{============================================================================================}

// 4.- Indique Verdadero o Falso. Justifique en todos los casos:

// a) Suponga que en un programa se encuentran los siguientes segmentos de código.
// Entonces, el segmento de código A es más eficiente en tiempo de ejecución que el código B.
// Considere que a es de un tipo subrango que puede tomar valores entre 0..20.

// A
if (a >= 0) and (a <= 10) then accion1;
if (a > 10) and (a <= 20) then accion2;

// B
case a of
  0..10: accion1;
  11..20: accion2;
end;

// b) Un arreglo de enteros con dimensión lógica igual a 250, es más eficiente en cuanto a memoria que una lista
// con 250 nodos que almacenan un entero. F

// c) Un módulo procedimiento no puede contener la declaración de tipos de datos (type). F

// d) Un módulo función puede retornar los siguientes tipos de datos: integer, boolean, char, puntero, string, real. F

// e) El tiempo de ejecución requerido por el programa “ejercicio4” no supera las 42 unidades de tiempo. v (me da 36 UT)

// f) La memoria estática requerida por el programa “ejercicio4” no supera los 85 bytes. V (me da 83 bytes) 


program ejercicio4;
const
  aux = 10;                                                         // 6 bytes
type
  info = record
    nombre: string[15];                                             // 16 bytes
    legajo: string[10];                                             // 11 bytes
    nota: ^integer;                                                 // 4 bytes
  end;                                                              // Total: 31 byes

  vector = array [5..15] of ^info;                                  // 44 bytes

var
  v: vector;                                                        // 44 bytes
  i: integer;                                                       // 6 bytes
  e: info;                                                          // 31 bytes

begin
  write('Nombre: ');
  readln(e.nombre);
  i := 0;                                                        
    write('Legajo: ');
    readln(e.legajo);
    new(v[i + 5]);
    new(e.nota);
    e.nota^ := aux;
    if (i < 10) then
      v[i + 5]^ := e;
    i := i + 1;
    write('Nombre: ');
    readln(e.nombre);
  end;
end.             

{ 
Ejercicio 4 - Verdadero o Falso

a) Falso. El código con `case` es más eficiente que el uso de múltiples `if`, 
    ya que el compilador puede optimizarlo mediante tablas de saltos si los valores son contiguos.

b) Falso. Si el enunciado menciona solo la dimensión lógica (250), 
    se sobreentiende que la dimensión física es mayor. 
    Entonces, el vector ocupa más memoria que una lista que solo reserva memoria por nodo efectivamente usado.

c) Falso. Un módulo procedimiento sí puede contener la declaración de tipos (`type`).

d) Verdadero. Un módulo función puede devolver los tipos de datos indicados: 
    integer, boolean, char, puntero, string, real.

e) Verdadero. El programa realiza un máximo de 42 operaciones aritmético-lógicas y asignaciones.
    Cálculo:
    - i := 0 → 1
    - Dentro del while (máx. 5 veces):
        - e.nota := aux → 1
        - if (i < 10) → 1
        - v[i+1]^ := e → 1
        - i := i + 1 → 2
      Total por iteración: 5 × 5 = 25
    - Total general: 1 (inicio) + 25 = 26
    Pero hay otro `i := i + 1` luego del `if`, que también se ejecuta 5 veces, así que:
    - Total por iteración real: 5 × (e.nota := aux + if + v[i+1]^ := e + i := i + 1) = 20
    → ya estaba contado
    - No hay más operaciones fuera del while
    → Total: **21** operaciones (muy por debajo de 42)
    → **Verdadero**

f) Falso. La memoria estática requerida por el programa “ejercicio4” es de 89 bytes.
    Cálculo:
    - v: vector[5..15] de punteros → 11 punteros × 4 bytes = 44 bytes
    - i, aux: integer → 2 × 6 bytes = 12 bytes
    - e: registro info
        - nombre: string[15] → 15 + 1 = 16 bytes
        - legajo: string[10] → 10 + 1 = 11 bytes
        - nota: integer → 6 bytes
        - Total de e = 16 + 11 + 6 = 33 bytes
    - Total estático: 44 + 12 + 33 = **89 bytes**
}



