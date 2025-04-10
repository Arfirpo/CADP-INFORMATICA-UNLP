{
La biblioteca de la facultad DISPONE de sus prestamos ordenados por código de tema (1..15).
De cada préstamo se conoce: código de tema, fecha y el código del libro prestado.
Se pide realizar un programa que informe el código de tema con más cantidad de prestamos y la cantidad total de prestamos para cada tema. Declare todas las estructuras utilizadas para resolver el programa.
Considerar que la solución propuesta debe optimizar el tiempo de ejecución y la memoria estática.
}

program final_cadp_febrero_25;

const
	max_temas = 15;

type
	{Tipos}
	rango_temas = 1..max_temas;

	Prestamo = record
		cod_tema: rango_temas;
		fecha: string[10];
		cod_libro: integer;
	end;

	lPrestamos = ^nPrestamos; //se dispone.

	nPrestamos = record
		dato: Prestamo;
		sig: lPrestamos;
	end;

{modulos}

procedure generarListaOrdenada(var l: lPrestamos);

	procedure leerPrestamo(var p: Prestamo);
	const 
		v: array[1..3] of String[10] = ('27/04/1993', '21/08/1999', '10/03/1961');
	var 
		n: integer; 
	begin
		n := Random(13) + 1;
		with p do begin
			cod_tema := 1 + Random(15);
			if (n = 2) then 
				fecha := 'zzz'
			else 
				fecha := v[1 + Random(3)];
			end;
	end;

	procedure agregarOrdenado(var l: lPrestamos; p: Prestamo);
	var nue,ant,act: lPrestamos;
	begin
		new(nue);
		nue^.dato := p;
		ant:= nil;
		act:= l;
		while(act <> nil) and (p.cod_tema > act^.dato.cod_tema) do begin
			ant := act;
			act := act^.sig;
		end;
		if(ant = nil) then l := nue	
		else ant^.sig := nue;
		nue^.sig := act;
	end;

var p: Prestamo;
begin
	leerPrestamo(p);
	while(p.fecha <> 'zzz') do begin
		agregarOrdenado(l,p);
		leerPrestamo(p);
	end;
end;

procedure procesarLista(l: lPrestamos);

	procedure actualizarMaxTema(t: rango_temas; cP: integer; var maxT:rango_temas; var max: integer);
	begin
		if (cP > max) then begin
			max := cP;
			maxT := t;
		end;
	end;

var 
	temaAct,maxTema: rango_temas; 
	cantPrestamos, max: integer;
begin
	max := -9999;
	while (l <> nil) do begin
		temaAct := l^.dato.cod_tema;
		cantPrestamos := 0;
		while (l <> nil) and (l^.dato.cod_tema = temaAct) do begin
			cantPrestamos += 1;
			l := l^.sig;
		end;
		actualizarMaxTema(temaAct,cantPrestamos,maxTema,max);
		Writeln('Codigo de tema: ',temaAct,' | ','Cantidad de Prestamos: ',cantPrestamos,'.');
	end;
	Writeln();
	Writeln('El codigo de tema ',maxTema,' registro la mayor cantidad de prestamos, con un total de: ',max,'.');
end;

{Programa Principal}
var
	pri: lPrestamos;
begin
	Randomize;
	generarListaOrdenada(pri);
	procesarLista(pri);	
end.

{=================================================================================}

{
	2)Indique VERDADERO o FALSO. Justifique en todos los casos:

	A.La comunicación entre el programa principal y un modulo a traves de un parametro por valor evita que el programa principal pueda ver las modificacones realizadas por el modulo al manipular dicho parametro.

	B.Un modulo procedimiento no puede contener la siguiente declaración:
	===============
	type
		lista = ^nodo;
		nodo = record
			dato: string;
			sig: lista;
		end;
	===============
	C.El proceso de agregar al final un elemento en un vector requiere de 5 UT y el proceso de agrega un elemento al final en una lista usando la técnica de llevar un puntero al último nodo requiere 4 UT.

	D.La memoria  requerida por el programa "ejercicio2" es exactamente 79 bytes.
	
	E.La memoria  requerida por el programa "ejercicio2"no supera los 1500 bytes.	
}

program ejercicio2;

{
	Tabla de valores:

		Char			= 1 byte	
		Integer		= 6 bytes
		real			= 8 bytes
		Boolean		= 1 bytes
		String		= Longitud + 1 byte
		Puntero		=  4 bytes
}


const
	max1 = 15; 
	max2 = 20;

type
	rango1 = 1..max1;
	rango2 = 1..max2;
	vector = array[1..20] of ^real;
	estudiante = record
		nombre: string[15];
		apellido: string[15];
		legajo: string[10];
		notas: ^vector;
	end;

	var
		e: estudiante;
		i: rango1;
		j: rango2;
		nota: real;
	begin
		for i := 6 to max1 do begin
			read(e.nombre);
			read(e.apellido);
			read(e.legajo);
			new(E.notas);
			for J := 1 to max2 do begin
				read(nota);
				new(e.notas^[i]);
				e.notas^[i]^ := nota;
			end;
		end;
	end;

{=================================================================================}

{
  3) Se requiere implementar un modulo que duplique todos los valores existentes en el vector almacenado en el campo dato del registro. Indique para ambas posibles soluciones (A y B) si realiza de forma correcta dicha duplicación. Justificar
}

program ejercicio_3


type
  numeros = array [1...1000] of ^integer;
  vector = record
    dato: numeros;
    diml: 0..1000;
  end;

{procedimiento A}
procedure duplicar(v: vector);
var
  i: integer;
begin
  for i: 1 to 1000 do
    v.dato[i]^ := (v.dato[i]^ * 2);
end;

{procedimiento B}
procedure duplicar(v: vector);
var
  i: integer;
begin
  i := 1;
  while(i <= 1000) do begin
    v.dato[i]^ := (v.dato[i]^ * 2);
    i := i + 1;
  end;
end;

{Respuesta: ✅ 1. No se usa diml
🔴 Esto es crítico, porque diml indica cuántos elementos del vector están realmente ocupados y contienen punteros válidos.

Ambos procedimientos recorren todas las 1000 posiciones, incluso si muchas de ellas no tienen nada asignado (nil), lo que puede provocar errores al intentar hacer v.dato[i]^.

✅ 2. No se pasa el vector por referencia
El parámetro v se pasa por valor, lo cual significa que se trabaja con una copia del registro.

Aunque los punteros internos (^integer) apuntan a la misma dirección de memoria, el campo diml está en la copia, y cualquier cambio en él no se refleja en el original.

En este caso particular, como solo se modifica el contenido al que apuntan los punteros (v.dato[i]^), no es un error grave pasar por valor, pero es una mala práctica si eventualmente se quisiera modificar otra parte del registro (como diml, o asignar nuevos punteros).

}

{=================================================================================}

{
  4) Dado el siguiente programa indique que imprime en cada sentencia del write. Justifique su respuesta.
}

Program cuatro;

var c,d: integer;

procedure calcular(var a: integer; b: integer; var c: integer); 
  var
  d: integer;
  begin
  d := (b mod 2) + c;
  b := (d mod 10) + d;
  if (a + b) > 25 then b := b + (a * 2)
                  else c := (b + a) * 3;
  c := (a - b) + c;
  writeln('valor a: ',a,', valor b: ',b,', valor c: ',c,', valor d: ',d);
  end;

var a,b: integer;
begin
  a := 5;
  b := 3;
  c := 2;
  d := 9;
  calcular(b,c,a);
  writeln('valor a: ',a,', valor b: ',b,', valor c: ',c,', valor d: ',d);
End.

{Respuesta:
  En el proceso:  a := 3;  b := 10; c := 32; d := 9;
  En el programa: a := 32; b := 3;  c := 2;  d := 9;
}