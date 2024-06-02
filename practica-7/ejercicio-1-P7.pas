{1. Una productora nacional realiza un casting de personas para la selección de actores extras de una nueva película, para ello se debe leer y almacenar la información de las personas que desean participar de dicho casting. 
De cada persona se lee: DNI, apellido y nombre, edad y el código de género de actuación que prefiere (1: drama, 2: romántico, 3: acción, 4: suspenso, 5: terror). 
La lectura finaliza cuando llega una persona con DNI 33555444, la cual debe procesarse. 
Una vez finalizada la lectura de todas las personas, se pide: 
  a. Informar la cantidad de personas cuyo DNI contiene más dígitos pares que impares. 
  b. Informar los dos códigos de género más elegidos. 
  c. Realizar un módulo que reciba un DNI, lo busque y lo elimine de la estructura. El DNI puede no existir. Invocar dicho módulo en el programa principal.}

program ejercicio1P7;

const
  cond_corte = 33555444;
  dimF_generos = 5;
type
  str30 = string[30];
  rango_edad = 1..100;
  rango_generos = 1..dimF_generos;

  lExtras = ^nExtras;

  generos = record
    cod: rango_generos;
    tipo: str30;
    cant: integer;
  end;

  extra = record
    dni: longint;
    nomYape: str30;
    edad: rango_edad;
    codGen: rango_generos;
  end;

  nExtras = record
    dato: extra;
    sig: lExtras;
  end;

  vGen = array[rango_generos] of generos;

{modulos}

procedure inicializarVector(var vG: vGen);

  procedure leerGenero(var g: generos; i: rango_generos);
  begin
    with g do begin
      cod := i;
      case i of
        1: tipo := 'drama';
        2: tipo := 'romantico';
        3: tipo := 'accion';
        4: tipo := 'suspenso';
        5: tipo := 'terror';
      end;
      cant := 0;
    end;
  end;

var
  g: generos;
  i: rango_generos;
begin
  for i := 1 to dimF_generos do begin
    leerGenero(g,i);
    vG[i] := g;
  end;
end;

procedure generarLista(var l: lExtras);

  procedure leerExtra(var e: extra);
  begin
    with e do begin
      write('Ingrese el dni del actor: ');
      readln(dni);
      write('Ingrese apellido y nombre del actor: ');
      readln(nomYape);
      write('Ingrese edad del actor: ');
      readln(edad);
      write('Ingrese codigo de genero de actuacion elegido: ');
      readln(codGen);
    end;
  end;

  procedure insertarOrdenado(var l: lExtras; e: extra);
  var
    nue,ant,act: lExtras;
  begin
    new(nue);
    nue^.dato := e;
    act := l;
    ant := l;
    while (act <> nil) and (e.codGen > act^.dato.codGen) do begin
      ant := act;
      act := act^.sig;
    end;
    if (ant = act) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  e: extra;
begin
  repeat
  leerExtra(e); //completo el registro de un extra.
  insertarOrdenado(l,e); //lo incorporo a la lista de extras (ordenada por codigo de actuacion, ascendente).
  until (e.dni = cond_corte); //el proceso de cargar la lista termina cuando se procese un dni especifico.
end;

procedure procesarLista(l: lExtras; var v: vGen);

  function extraCumpleA(dni: longint):boolean;
  var
    dig,digP,digI: integer;
    ok: boolean;
  begin
    ok := false;
    digP := 0; digI := 0;
    dig := dni;
    while dni <> 0 do begin
      dig := dni mod 10; //me quedo con el ultimo numero del dni.
      if (dig mod 2 = 0) then
        digP := digP + 1  //si el digito es par, sumo 1 al contador de pares.
      else
        digI := digI + 1;  //si el digito es impar, sumo 1 al contador de impares.
      dni := dni div 10;  // achico el numero de dni, sacandole el ultimo digito (ya procesado).
    end;

    if digP > digI then
      ok := true;

    extraCumpleA := ok;
  end;

  procedure maxGeneros(v: vGen; var maxCod1,maxCod2: rango_generos);
  var
    i: rango_generos;
    max1,max2: integer;
  begin
    max1 := -1; max2 := -1;
    for i := 1 to dimF_generos do begin
      if (v[i].cant > max1) then begin
        max2 := max1;
        maxCod2 := maxCod1;
        max1 := v[i].cant;
        maxCod1 := v[i].cod;
      end
      else if (v[i].cant > max2) then begin
        max2 := v[i].cant;
        maxCod2 := v[i].cod;
      end;
    end;
  end;

var
  aux: lExtras;
  cantA: integer;
  maxCod1,maxCod2: rango_generos;
begin
  aux := l;
  cantA := 0;
  maxCod1 := 1; maxCod2 := 1;
  while aux <> nil do begin //recorro la lista de extras hasta el final
    if (extraCumpleA(aux^.dato.dni)) then cantA := cantA + 1; //verifica condicion A sobre 1 extra.
    v[aux^.dato.codGen].cant := v[aux^.dato.codGen].cant + 1; //sumo 1 al contador de generos, segun el codigo del extra leido.
    aux := aux^.sig;
  end;
  maxGeneros(v,maxCod1,maxCod2); //le paso el vector de generos y me devuelve los codigos de los dos mas elegidos.

  //terminado el procesamiento de datos, informo.
  writeln('-------------------------------------------------------------');
  if cantA > 0 then
    writeln(cantA,' persona/s tiene/n mas digitos pares que impares en su dni.')
  else
    writeln('Ninguna persona tiene mas digitos pares que impares en su dni.');
  writeln('-------------------------------------------------------------');
  writeln('Los dos codigos de genero mas elegidos fueron: ');
  writeln('1.- ',maxCod1,' - "',v[maxCod1].tipo,'".');
  writeln('2.- ',maxCod2,' - "',v[maxCod2].tipo,'".');
  writeln('-------------------------------------------------------------');  
end;

procedure eliminarExtra(var l: lExtras; num: longint; var exito: boolean);
var
  ant,act: lExtras;
begin
  ant := l;
  act := l;
  exito := false;
  while (act <> nil) and (act^.dato.dni <> num) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = nil) then exito := false //si el extra no estaba en la lista.
  else begin
    exito := true; //si el extra estaba en la lista.
    if ant = act then begin  //si el extra a eliminar es el primero de la lista.
      l := l^.sig;
    end
    else //si el extra a eliminar no es el primero de la lista.
      ant^.sig := act^.sig;
    dispose(act);  //elimino de memoria al extra seleccionado
  end;
end;

{programa principal}

var
  vG: vGen; //vector que almacenara los 5 tipos de generos de actuación ordenados por numero (1 a 5)
  pri: lExtras; //puntero donde se armara la lista de extras.
  num: longint;
  exito: boolean;

begin
  pri := nil; //inicio el puntero en nil.
  inicializarVector(vG); //cargo los tipos de genero y su contador individuaL lo inicio en 0.
  generarLista(pri);
  procesarLista(pri,vG);
  write('Ingrese dni del extra a eliminar de la lista: ');
  readln(num);
  eliminarExtra(pri,num,exito);
  if (exito) then writeln('El extra fue eliminado con exito.')
  else writeln('No se encontro al extra con dni N° ',num);
  writeln('-------------------------------------------------------------');  
end.