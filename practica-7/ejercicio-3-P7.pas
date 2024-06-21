{3. Una remisería dispone de información acerca de los viajes realizados durante el mes de mayo de 2020. 
De cada viaje se conoce: número de viaje, código de auto, dirección de origen, dirección de destino y
kilómetros recorridos durante el viaje. 
Esta información se encuentra ordenada por código de auto y para un mismo código de auto pueden existir 1 o más viajes. 
Se pide:
  a. Informar los dos códigos de auto que más kilómetros recorrieron.
  b. Generar una lista nueva con los viajes de más de 5 kilómetros recorridos, ordenada por número de
  viaje.}

program ejercicio3P7;

uses
  sysUtils;

type
{subrangos}
str30 = string[30];

lViajes = ^nViajes; {lista de viajes que se dispone}

viaje = record
  nro: integer;
  codA: integer;
  dir_origen: str30;
  dir_destino: str30;
  km_recorridos: real;
end;

nViajes = record
  dato: viaje;
  sig: lViajes;
end;

{modulos}

procedure randomString(StringLen: integer; var palabra: str30);
var
  str: string;
  Result: str30;
begin
  str := 'abcdefghijklmnopqrstuvwxyz';
  Result := '';
  repeat
    Result := Result + str[Random(Length(str)) + 1];
  until Length(Result) = StringLen;
  palabra := Result;
end;

procedure leerViaje(var v: viaje);
begin
  with v do begin
    nro := Random(51) - 1;
    if nro <> -1 then begin
      codA := Random(300) + 1;
      randomString(5,dir_origen);
      randomString(5,dir_destino);
      km_recorridos := Random(1001) + 1;
    end;
  end;
end;

procedure insertarOrdenado(var l: lViajes; v: viaje);
var
  nue,ant,act: lViajes;
begin
  new(nue);
  nue^.dato := v;
  ant := l;
  act := l;

  while(act <> nil) and (v.codA > act^.dato.codA) do begin
    ant:= act;
    act := act^.sig;
  end;

  if(act = ant) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;


procedure generarLista(var l: lViajes); //se dispone
var
  v: viaje;
begin
  leerViaje(v);
  while (v.nro <> -1) do begin
    insertarOrdenado(l,v);
    leerViaje(v);
  end;
end;

procedure maxAuto(cod: integer; kms: real; var codMax1,codMax2: integer; var maxKm1,maxKm2: real);
begin
  if(kms > maxKm1) then begin
    maxKm2 := maxKm1;
    codMax2 := codMax1;
    maxKm1 := kms;
    codMax1 := cod;
  end
  else if (kms > maxKm2) then begin
    maxKm2 := kms;
    codMax2 := cod;
  end;
end;

procedure insertarOrdenado2(var l2: lViajes; v: viaje);
var
  nue,ant,act: lViajes;
begin
  new(nue);
  nue^.dato := v;
  ant := l2;
  act := l2;
  while(act <> nil) and (v.nro > act^.dato.nro) do begin
    ant := act;
    act := act^.sig;
  end;
  if(act = ant) then
    l2 := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure recorrerLista(l: lViajes; var l2:lViajes);
var
  cantKm,maxKm1,maxKm2: real;
  codMax1,codMax2,autoAct: integer;
begin

  codMax1 := 0;
  codMax2 := 0;
  maxKm1 := -1;
  maxKm2 := -1;

  while(l <> nil) do begin
    autoAct := l^.dato.codA; {corte de control por cod de auto}
    cantKm := 0; {cuento la cantidad de km recorridos por auto}

    while(l <> nil) and (l^.dato.codA = autoAct) do begin
      cantKm := cantKm + l^.dato.km_recorridos; {voy sumando los km recorridos por el auto}

      if(l^.dato.km_recorridos > 5) then {si el viaje cumple el requisito, se lo incorpora a la lista 2}
        insertarOrdenado2(l2,l^.dato);

      l := l^.sig;
    end;
    maxAuto(autoAct,cantKm,codMax1,codMax2,maxKm1,maxKm2);{actualizo los dos autos con mas km recorridos}
  
  
  end;

  writeln('Los dos codigos de auto con mayor kilometraje realizado son: ');{informo los dos codigos de auto con max kms}
  writeln('1.- ',codMax1,' - Kms: ',maxKm1:0:2);
  writeln('2.- ',codMax2,' - Kms: ',maxKm2:0:2);
  writeln('------------------------------------------------------------------');
end;

procedure imprimirLista(l: lViajes);
begin
  writeln('----------------------------');
  while (l <> nil) do begin
    writeln('Viaje Nro: ',l^.dato.nro);
    writeln('Codigo de Auto: ',l^.dato.codA);
    writeln('Direccion de origen: ',l^.dato.dir_origen);
    writeln('Direccion de destino: ',l^.dato.dir_origen);
    writeln('Kilometros recorridos: ',l^.dato.km_recorridos:0:2);
    writeln('----------------------------');
    l:=l^.sig;
  end;

end;


{programa principal}
var
  pri: lViajes;
  pri2: lViajes;

begin
  Randomize;
  pri := nil;
  pri2 := nil;
  generarLista(pri); //se dispone
  recorrerLista(pri,pri2);
  writeln('Lista original: ');
  imprimirLista(pri);
  writeln('Lista secundaria: ');
  imprimirLista(pri2);
end.