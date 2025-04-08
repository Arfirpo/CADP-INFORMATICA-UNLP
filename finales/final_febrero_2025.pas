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
