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
    detalle: str30;
    cant: integer;
  end;

  extra = record
    dni: longint;
    nomYape: str30;
    edad: rango_edad
    genAct: generos;
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
      write('Ingrese el nombre del genero de actuacion: ');
      readln(detalle);
      cant := 0;
    end;
  end;

var
  g: generos;
  i: rango_generos;
begin
  for i := 1 to dimF_generos do begin
    leerGenero(g);
    vG[i] := g;
  end;
    
end;

{programa principal}

var
  vG: vGen; //vector que almacenara los 5 tipos de generos de actuación ordenados por numero (1 a 5)
  pri: lExtras; //puntero donde se armara la lista de extras.

begin
  inicializarVector(vG);
end.
