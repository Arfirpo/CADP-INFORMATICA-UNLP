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
