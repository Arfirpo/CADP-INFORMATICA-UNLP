program vectores;

const dimF = 100;
type 
	vector = array [1..dimF] of integer;
	vectorContador = array [1..10] of integer;
	lista = ^nodo;
	nodo = record
		dato: integer;
		sig: lista;
	end;

{modulos}

//operaciones con vectores
	procedure inicializarContador(var v: vectorContador);
	var i:integer;
	begin
		for i := 1 to 10 do
			v[i] := 0;
	end;

	procedure cargarVector(var v:vector; var dimL: integer);
	var num: integer;
	begin
		read(num)
		while (dimL + 1 <= dimF) and (num <> -1) do begin
			dimL := dimL + 1;
			v[dimL] := num;
			read(num);
		end;
	end;

	procedure agregarAlFinal(var v: vector; var dimL: integer; num: integer);
	begin
		if(dimL + 1 <= dimF) then begin
			dimL := dimL + 1;
			v[dimL] := num;
		end;
	end;

	procedure insertar(var v:vector; var dimL: integer; num: integer);

		//busquedas con pre-condicion: inserción en vector ordenado
		function buscarPos(v:vector; dimL,num: integer):integer;
		var pos:integer;
		begin
			pos := 1;
			while (pos <= dimL) and (v[pos] < num) do
				pos := pos + 1;
			buscarPos := pos;	
		end;

	var pos,num,i: integer;
	begin
		Read(num);
		pos := buscarPos(v,dimL,num);																						//busco la posición y la guardo en la variable pos.
		if(dimL + 1 <= dimF) and ((pos >= 1) and (pos <= dimL + 1)) then begin	//si hay espacio en el vector y la posición es valida (en el caso de inserción al final, verificamos que haya un espacio mas).
			for i := dimL downto pos do																						//hago un corrimiento (desde la dimensión logica hasta la posicion a insertar) hacia la derecha.
				v[i+1] := v[i];
			v[pos] := num;																												//inserto el elemento en la posición.
			dimL := dimL + 1;																											//incremento la dimensión logica.
		end;
	end;

	//busquedas con pre-condicion: vectores desordenados
	function buscarPosVecDes(v:vector; dimL,num:integer): integer;
	var pos: integer; esta: boolean;
	begin
		pos := 1;
		esta := false;
		while (pos <= dimL) and not(esta) do begin
			if(v[pos] = num) then
				esta := true
			else
				pos := pos + 1;
		end;
		if not((pos <= dimL) and (esta)) then
			pos := -1;
		buscarPosVecDes := pos;
	end;

	//busquedas con pre-condicion: vectores ordenados (busqueda mejorada)
	function buscarPosVecOrd(v:vector; dimL,num:integer): integer;
	var pos: integer;
	begin
		pos := 1;
		while (pos <= dimL) and (v[pos] < num) do
			pos := pos + 1;
		if not((pos <= dimL) and (v[pos] = num)) then pos := -1;
		buscarPosVecOrd := pos;
	end;

	//busquedas con pre-condicion: vectores ordenados (busqueda binaria)
	function busquedaDicotomica(v:vector; dimL,num: integer): integer;
	var inf,sup,med: integer;
	begin
		inf := 1; sup := dimL; med := (sup + inf) DIV 2;
		while (inf <= sup) and (v[med] <> num) do begin
			if(v[med] < num) then
				inf := med + 1
			else
				sup := med - 1;
			med := (sup + inf) DIV 2;
		end;
		if not((inf <= sup) and (v[med] = num)) then 
			med := -1;
		busquedaDicotomica := med;
	end;

	procedure eliminarElemento(var v:vector; var dimL: integer; num: integer);
	var pos,i:integer;
	begin
		pos := buscarPosVecOrd(v,dimL,num);
		if (pos >=1) and (pos <= dimL) then begin
			for i:= pos to dimL - 1 do
				v[i] := v[i+1];
			dimL := dimL - 1;
		end;
	end;

	procedure eliminarPos(var v:vector; var dimL: integer; pos: integer);
	var i:integer;
	begin
		if(pos >= 1) and (pos <= dimL) then begin
			for i := pos to dimL - 1 do
				v[i] := v[i+1];
			dimL := dimL - 1;
		end;
	end;

	procedure eliminarOcurrencias(var v:vector; var dimL: integer; num: integer);
	var pos,i: integer;
	begin
		pos := 1;
		while (pos <= dimL) do begin
			if(v[pos] = num) then begin
				for i:= pos to dimL - 1 do v[i] := v[i+1];
				dimL := dimL - 1;
			end
			else
				pos := pos + 1;
		end;
	end;
{=====================================================================}
//operaciones con listas

	procedure agregarAdelante(var l: lista; num: integer);
	var nue: lista;
	begin
		new(nue);
		nue^.dato := num;
		nue^.sig := l;
		l := nue;
	end;

	procedure agregarAtras(var l: lista; num: integer);
	var nue,aux: lista;
	begin
		new(nue);
		nue^.dato := num;
		nue^.sig := nil;
		if(l = nil) then
			l := nue
		else begin
			aux := l;
			while aux^.sig <> nil do 
				aux := aux^.sig;
			aux^.sig := nue;
		end;
	end;

	procedure agregarAtrasOptimizado(var pri,ult: lista; num: integer);
	var nue: lista;
	begin
		new(nue);
		nue^.dato := num;
		nue^.sig := nil;
		if(pri = nil) then begin
			pri := nue;
			ult := nue;
		end
		else
			ult^.sig := nue;
		ult := nue;
	end;


	procedure insertarOrdenado(var l: lista; num: integer);
	var nue,ant,act: lista;
	begin
		new(nue);
		nue^.dato := num;
		act := l;
		ant := nil;
		while (act <> nil) and (act^.dato < num) do begin
			ant := act;
			act := act^.sig;
		end;
		if (ant = nil) then begin
			nue^.sig := l;
			l := nue;
		end
		else begin
			ant^.sig := nue;
			nue^.sig := act;
		end;
	end;

	procedure eliminarNodo(var l: lista; num: integer);
	var ant,act: lista;
	begin
	  act := l;
	  ant := Nil;
	  while (act <> nil) and (act^.dato <> num) do begin
			ant := act;
			act := act^.sig;
	  end;
	  if(act <> nil) and (act^.dato = num) then begin
			if (ant = nil) then
	  		l := l^.Sig
			else
				ant^.sig := act^.sig;
			dispose(act);
		end;
	end;

	procedure eliminarOcurrencias(var l:lista; num: integer);
	var ant,act,aux: lista;
	begin
	  act := l;
	  ant := nil;
	  while (act <> nil) do begin
			if (act^.dato = num) then begin
				aux := act;
			  if(ant = nil) then begin
					l := l^.sig;
					act := l;				
			  end
				else begin
					ant^.sig := act^.sig
					act := act^.sig
				end;
				dispose(aux);
			end
			else begin
				ant := act
				act := act^.sig;
			end;
	  end;
	end;


{programa principal}
var
	v:vector; vC: vectorContador;
	dimL,pos,num:integer;
	pri,ult:lista;
begin
	pri := nil;
	ult := nil;
	dimL := 0;
	//----------------------------
	inicializarContador(vC);
	cargarVector(v,dimL);
	//----------------------------
	agregarAlFinal(v,dimL);
	insertar(v,dimL);
	//----------------------------
	read(num);
	pos := buscarPosVecDes(v,dimL,num);
	pos := buscarPosVecOrd(v,dimL,num);
	pos := busquedaDicotomica(v,dimL,num);
	//----------------------------
	eliminarElemento(v,dimL,num);
	eliminarPosicion(v,dimL,pos);
	eliminarOcurrencias(v,dimL,num);
	//----------------------------
	agregarAdelante(pri,num);
	agregarAtras(pri,num);
End.