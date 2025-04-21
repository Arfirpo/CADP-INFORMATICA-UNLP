{1.- Un comercio dispone de una estructura de datos con las facturas (como maximo 2000 facturas) realizadas durante marzo de 2023. De cada factura se conoce el numero de la factura, código del cliente, código de la sucursal, y monto total. Las facturas se encuentran ordenadas por codigo de sucursal. Se pide implementar un programa con un módulo que reciba la estructura que se dispone y devuelva el código de sucursal con mayor cantidad de facturas. El programa debe informar el valor retornado por el modulo.}

	program final;

	const
		dimF = 2000;

	type
		factura = record
			nro: integer;
			codCli: integer;
			codSuc: integer;
			mTot: real;
		end;

		vFacturas = array [1..dimF] of factura; //se dispone

	{modulos}

	procedure actualizarMaxSuc(sucAct,cantFact: integer; var maxSuc,maxFact: integer);
	begin
		if(cantFact > maxFact) then begin
			maxFact := cantFact;
			maxSuc := sucAct;
		end;	
	end;

	procedure procesarVector(v:vFacturas; dimL: integer; var maxSuc: integer);
	var
		i,sucAct,cantFact,maxFact: integer;
	begin
		maxFact := -1;
		i := 1;
		while i <= dimL do begin
			sucAct := v[i].codSuc;
			cantFact := 0;
			while (i <= dimL) and (v[i].codSuc = sucAct) do begin
				cantFact := cantFact + 1;
				i := i +1;
			end;
			actualizarMaxSuc(sucAct,cantFact,maxSuc,maxFact);
		end;
	end;

	{programa principal}
	var
		v: vFacturas;
		maxSuc,dimL: integer;
	begin
		dimL := 0;
		cargarVector(v,dimL); //se dispone
		procesarVector(v,dimL,maxSuc);
		WriteLn('La mayor cantidad de facturas fue emiida por la sucursal: ',maxSuc,'.');
	End.

{=======================================================================}
{2.- Dada la siguiente declaración y los siguientes procesos, indique para cada uno de los procesos, si son correctos o no. El objetivo es duplicar el contenido del último nodo de la lista.Justifique su respuesta}

	type
		miLista = ^nodo;
		nodo = record
			dato: integer;
			sig: miLista;
		end;
		lista = record
			pri: miLista;
			ult: miLista;
		end;

		//A
		procedure duplicar1(L: lista);
		begin
			L.ult^.dato := L.ult^.dato * 2;
		end;

		//B
		procedure duplicar2(L: lista);
		var aux: miLista;
		begin
			aux := L.pri;
			while (aux^.sig <> nil) do
				aux := aux^.sig;
			aux^.dato := aux^.dato * 2;
		end;
{=======================================================================}
{3.-Calcule e indique la cantidad de meoria estatica y dinamica que utiliza el siguiente programa.Mostrar los valores intermedios para llegar al resultado y justificar.}

	{
		tabla de valores:
		-----------------
		char: 				1 byte
		integer: 			4 bytes
		real: 				8 bytes
		boolean: 			1 byte
		string: 			longitud + 1 byte
		puntero: 			4 bytes
		------------------
	}

		program ejercicio3;
		const dimF = 200;
		type
			cadena31 = String[31];
			alumno = record
				ap_nom: cadena31;
				promedio: real;
			end;
			vector = array [1..dimF] of ^alumno;
			lista = ^nodo;
			nodo = record
				dato: alumno;
				sig: lista;
			end;
		
		var
			v: vector;
			a: alumno;
			nota,i,suma,cant: integer;
			aux: lista;
		begin
			for i := 1 to dimF do begin	
				Read(a.ap_nom); Read(nota); cant := 0; suma := 0;
				while (nota <> -1) do begin
					suma := suma + nota; cant := cant +1;
					Read(nota);
				end;
				if (cant <> 0) then a.promedio := suma/cant
											else a.promedio := 0;
				new(v[i]);
				v[i]^ := a;
			end;
		end;

		{
	-----------------------------------------------------
	ANÁLISIS DE MEMORIA ESTÁTICA Y DINÁMICA
	-----------------------------------------------------

	TIPOS Y TAMAÑOS SEGÚN LA TABLA:
	- char:      1 byte
	- integer:   4 bytes
	- real:      8 bytes
	- boolean:   1 byte
	- string:    longitud + 1 byte
	- puntero:   4 bytes

	-----------------------------------------------------
	MEMORIA ESTÁTICA:

	- Constante dimF           : 4 bytes
	- Vector v (200 punteros) : 200 * 4 = 800 bytes
	- Variable a (alumno)     : 32 (string[31]) + 8 (real) = 40 bytes
	- 4 variables integer      : 4 * 4 = 16 bytes
	- Puntero aux              : 4 bytes

	TOTAL MEMORIA ESTÁTICA     = 4 + 800 + 40 + 16 + 4 = 864 bytes

	-----------------------------------------------------
	MEMORIA DINÁMICA:

	Se reserva una vez por iteración en el for, o sea 200 veces:
	- Cada new(v[i]) reserva un alumno = 32 (string[31]) + 8 (real) = 40 bytes
	- 200 alumnos * 40 bytes = 8000 bytes

	TOTAL MEMORIA DINÁMICA     = 8000 bytes

	-----------------------------------------------------
	RESUMEN:
	Memoria Estática = 864 bytes
	Memoria Dinámica = 8000 bytes
	-----------------------------------------------------
	}
{=======================================================================}
{4.- Calcule el tiempo de ejecución del programa del punto 3. Mostrar los valores intermedios para llegar al resultado y justificar.}
	{
	Tiempo de ejecución del programa (en unidades de tiempo - ut):

	Asignación inicial:
		aux := nil                          → 1 ut

	Bucle FOR i := 1 to dimF do:         → N = 200
		Fórmula de control del for:        → (3N + 2) = 3×200 + 2 = 602 ut

		Cuerpo del FOR (por iteración):
		cant := 0                        → 1 ut
		suma := 0                        → 1 ut
		while (nota <> -1) do            → M + 1 evaluaciones
			suma := suma + nota;          → 2 ut
			cant := cant + 1;             → 2 ut
		→ Total while: (5M + 1) ut
		if (cant <> 0) then              → 1 ut (comparación)
			a.promedio := suma / cant     → 2 ut (división + asignación)
		else
			a.promedio := 0               → 1 ut (asignación)
		new(v[i])                        → 0 ut (no se cuenta)
		v[i]^ := a                       → 1 ut
		→ Total cuerpo por iteración: (7 + 5M) ut
		→ Total cuerpo for: N × (7 + 5M) = 200 × (7 + 5M) = 1400 + 1000M ut

	TOTAL GENERAL:
		1 (inicio) + 602 (control for) + 1400 + 1000M = 2003 + 1000M ut
	}

{=======================================================================}
{5.- Indique Verdader o Falso. Justifique en todos los casos:
	a. Antes de utilizar una variable puntero siempre debe reservarse memoria.
	b. La comunicación mediante parametros asegura que un programa es correcto.
	c. La invocación al modulo "otro" es valida.
	}
	program ejercicio;
	var a,b: real;

		procedure calcular(var x: real; c: real);
			
			function otro(num: integer): integer;
			begin
			//...
			end;
		
		begin
		//...
		end;
	begin
		//...
		write(otro(40))
		//...
	end;
	{d. Siempre es posible eliminar el primer elemento en una lista.
	e. Las instrucciones dentro de una estructura de control Repeat-until se pueden ejecutar 0,1 o mas veces.
	f. el siguiente programa muestra por pantalla:
		valor de a: 200; valor de b: 30; valor de c: 20;
	}
	program imprimir;
	var a,c:integer;
		
		procedure calcular(b: integer; var x: integer);
		begin
			x := 10; 
			c := c + b;
			a := (b + x) * 5;
			b := (a + b) MOD 10;
		end;

	var b: integer:
	begin
		b := 20;
		c := b - 5;
		calcular(b,c);
		WriteLn('Valor de a: ',a,', Valor de b: ',b,', Valor de c: ',c,'.')
	End.
	{
		Mis respuestas:
		--------------
		a: FALSO.
		b: FALSO.
		c: FALSO.
		d: FALSO.
		e: FALSO.
		f: FALSO
		--------------
	a. Falso.
		Justificación: Aunque en la mayoría de los casos se necesita reservar memoria con `new` antes de 
		usar un puntero, **no es obligatorio en todos los casos**. Por ejemplo, un puntero puede 
		apuntar a una dirección ya válida o asignada previamente (como punteros que apuntan a 
		elementos de un vector o lista). Por lo tanto, hay excepciones.

	b. Falso.
		Justificación: Comunicar mediante parámetros no asegura la corrección de un programa. 
		Un programa puede pasar parámetros correctamente y aún tener errores lógicos o fallas 
		en la implementación. La corrección depende de muchos factores adicionales.

	c. Falso.
		Justificación: La función `otro` está declarada **dentro del procedimiento** `calcular`, 
		por lo que **su ámbito es local a ese procedimiento**. No se puede invocar desde el programa principal.

	d. Falso.
		Justificación: Si la lista está vacía, no hay primer elemento para eliminar. 
		Por lo tanto, **no siempre** es posible eliminar el primer elemento. Hay una excepción.

	e. Falso.
		Justificación: Las instrucciones dentro de un `repeat-until` se ejecutan **al menos una vez** 
		porque la condición se evalúa al final. Entonces **nunca se ejecutan 0 veces**. La afirmación 
		es incorrecta.

	f. Falso.
		Justificación: El programa imprime: 
			- b := 20;
			- c := b - 5 = 15;
			- calcular(b, c):
					x := 10;
					c := 10 + 20 = 30;
					a := (20 + 10) * 5 = 150;
					b (local) := (150 + 20) MOD 10 = 170 MOD 10 = 0;
			- En el main: b sigue siendo 20 (no es var), c = 30, a = 150;
		Por lo tanto, imprime: Valor de a: 150; Valor de b: 20; Valor de c: 30.
		Como **no coincide con lo que afirma el enunciado**, es falso.
	}
{=======================================================================}