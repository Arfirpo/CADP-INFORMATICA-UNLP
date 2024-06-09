{un fabricante de dispositivos electronicos desea procesar información de repuestos que compró.
El fabricante dispone de una estructura de datos con información de los 200 paises de los cuales provienen los repuestos, en la que para cada codigo del pais (1..200) se tiene su nombre.
Realizar un programa que:

  A.Lea la información de los repuestos comprados y la almacene en una estructura de    datos adecuada. De cada repuesto se lee codigo, precio y codigo del pais del que proviene (entre 1 y 200). La lectura finaliza al ingresar el codigo -1 (que no debe procesarse)
  B.Una vez cargada la información, procese la estructura de datos del inciso A e informe:
    1. cantidad de paises para los que la cantidad de repuestos comprados es menor que el promedio de repuestos comprados a todos los paises.
    2.Para cada pais, el nombre del pais y el precio del repuesto mas caro.
    3.COMPLETO: La cantidad de repuestos que poseen al menos 3 cerosa en su codigo.

Implemente el programa principal que invoque a los modulos de los incisos a y b, e imprima los resultados.
}

program parcialRepuestos;

uses
  sysUtils;

const
  dimF_paises = 200;

type
  r_paises = 1..dimF_paises;
  str30 = string[30];
  
  lRepuestos = ^nRepuestos;
  
  repuesto = record
    cod: integer;
    prec: real;
    codP: r_paises;
  end;
  
  nRepuestos = record
    dato: repuesto;
    sig: lRepuestos;
  end;

  pais = record
    nombre: str30;
    repC: integer;
    maxPrec: real;
  end;

  vPaises = array[r_paises] of pais;

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

procedure cargarV(var vC: vPaises);
var
  i: r_paises;
  nom: str30;
begin
  for i := 1 to dimF_paises do begin
    randomString(5,nom);
    vC[i].nombre := nom;
    vC[i].repC := 0;
  end;
end;

procedure leerRepuesto(var r: repuesto);
begin
  with r do begin
    cod := Random(9999) -1;
    if(cod <> -1) then begin
      prec := Random(999) + 1;
      codP := Random(dimF_paises) + 1;
    end;
  end;
end;

// procedure cargarV(var vC: vPaises);
// var
//   i: r_paises;
//   nom: str30;
// begin
//   for i := 1 to dimF_paises do begin
//     write('Nombre del Pais: ');
//     readln(nom);
//     vC[i].nombre := nom;
//     vC[i].repC := 0;
//   end;
// end;

// procedure leerRepuesto(var r: repuesto);
// begin
//   with r do begin
//     write('Codigo de repuesto: ');
//     readln(cod);
//     if(cod <> -1) then begin
//       write('Precio del repuesto: ');
//       readln(prec);
//       write('Codigo del pais: ');
//       readln(codP);
//     end;
//   end;
// end;

procedure insertarOrdenado(var l: lRepuestos; r: repuesto);
var
  nue,ant,act: lRepuestos;
begin
  new(nue);
  nue^.dato := r;
  ant := l;
  act := l;
  while (act <> nil) and (r.codP > act^.dato.codP) do begin
    ant := act;
    act := act^.sig;
  end;
  if(act = ant) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure generarLista(var l: lRepuestos);
var
  r: repuesto;
begin
  leerRepuesto(r);
  while (r.cod <> -1) do begin
    insertarOrdenado(l,r);
    leerRepuesto(r);
  end;
end;

procedure cumple1(vC: vPaises; promR: real; var cantP: integer);
var
  i: r_paises;
begin
  for i := 1 to dimF_paises do begin
    if (vC[i].repC < promR) then
      cantP := cantP + 1;
  end;    
end;

function precMax(precio: real; var maximo: real):real;
begin
  if precio > maximo then
    maximo := precio;
  precMax := maximo;
end;

function cumple3(codigo: integer):boolean;
var
  dig,cant0: integer;
begin
  cant0 := 0;
  while (codigo <> 0) do begin
    dig := codigo mod 10;
    if(dig = 0) then
      cant0 := cant0 + 1;
    codigo := codigo div 10;
  end;
  cumple3 := (cant0 >= 3);
end;

procedure procesarLista(l: lRepuestos;var vC: vPaises; var cantP: integer);
var
  corte_pais: r_paises;
  totR,pCumple3: integer;
  promR: real;
begin
  totR := 0; promR := 0; pCumple3 := 0;
  //recorro la lista de repuestos (ordenada por codigo de paises).
  while (l <> nil) do begin
    //tomo el codigo del pais para corte de control.
    corte_pais := l^.dato.codP;
    //inicializo el campo de precio maximo del vector de paises en -1.
    vC[l^.dato.codP].maxPrec := -1;
    //recorro los elementos de la lista que corresponden al mismo pais y proceso sus datos.
    writeln('----------------------------------------------------------');
    while (l <> nil) and (l^.dato.codP = corte_pais) do begin
      //cuento el total de repuestos comprados.
      totR := totR + 1;
      //cuento por repuesto, si su codigo cumple la condicion 3.
      if(cumple3(l^.dato.cod)) then
        pCumple3 := pCumple3 + 1;
      //sumo 1 al vector por pais, en el campo de repuestos comprados.
      vC[l^.dato.codP].repC := vC[l^.dato.codP].repC + 1;
      //actualizo el precio del repuesto mas caro por pais.
      vC[l^.dato.codP].maxPrec := precMax(l^.dato.prec,vC[l^.dato.codP].maxPrec);
      //me muevo al siguiente nodo de la lista.
      l := l^.sig;
    end;
    //informo por pais, nombre y precio del repuesto mas caro.
    writeln('Nombre del Pais: ',vC[corte_pais].nombre);
    writeln('Precio del Repuesto mas caro: $',vC[corte_pais].maxPrec:0:2);
  end;
  //informo la cantidad de repuestos que cumplen la condicion 3.
  writeln('----------------------------------------------------------');
  if (pCumple3 > 0) then
    writeln(pCumple3,' pais/es poseen al menos tres ceros en su codigo.')
  else
    writeln('Ningun pais cumple la condicion solicitada.');
  //calculo el promedio de repuestos comprados por pais.
  promR := totR / dimF_paises;
  //con el promedio de repuestos y el vector de paises calculo el total de paises que cumplen la condicion 1.
  cumple1(vC,promR,cantP);
end;

{programa principal}
var
  pri: lRepuestos;
  vC: vPaises;
  cantP: integer;
begin
  Randomize;
  pri := nil;
  cantP := 0;
  cargarV(vC);
  generarLista(pri);
  procesarLista(pri,vC,cantP);
  writeln('----------------------------------------------------------------------');
  if cantP > 0 then
    writeln(cantP,' pais/es compraron menos repuestos que el promedio de repuestos comprados a todos los paises.')
  else
    writeln('No hay paises que cumplan la condicion 1.');
  writeln('----------------------------------------------------------------------');
end.

