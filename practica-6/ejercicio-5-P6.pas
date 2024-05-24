program ejercicio5P6;

type
  str30 = string[30];

  lSuper = ^nodo;

  producto = record
    cod: integer;
    stAct: integer;
    stMin: integer;
    precio: real;
    des: str30;
  end;

  nodo = record
    dato: producto;
    sig: lSuper;
  end;

  

{modulos}

procedure agregarAdelante(var l: lSuper; p:producto);
var
  aux: lSuper;
begin
  new(aux);
  aux^.dato := p;
  aux^.sig := l;
  l := aux;
end;

procedure leerProd(var p: producto);
begin
  with p do begin
    write('Ingrese el codigo del producto: ');
    readln(cod);
    if cod <> -1 then begin
      write('Ingrese descripcion del producto: ');
      readln(des);
      write('Ingrese stock actual del producto: ');
      readln(stAct);
      write('Ingrese stock minimo del producto: ');
      readln(stMin);
      write('Ingrese precio del producto: ');
      readln(precio);
    end;
  end;
end;

procedure generarLista(var l: lSuper);
var
  p: producto;
begin
  leerProd(p);
  while (p.cod <> -1) do begin
    agregarAdelante(l,p);
    leerProd(p)
  end;
end;

function contCondicion(actual,minimo: integer):integer;
var
  aux: integer;
begin
  if actual <  minimo then aux := 1
  else aux := 0;
  contCondicion := aux;
end;

function mas3digPar(codigo: integer):boolean;

  function digPares(num: integer): integer;
  var
    dig, cantDigP: integer;
  begin
    cantDigP := 0;
    while num <> 0 do begin
      dig := num mod 10;
      if dig mod 2 = 0 then
        cantDigP := cantDigP + 1;
      num := num div 10;
    end;
    digPares := cantDigP;
  end;

var
  ok: boolean;
begin
  if (digPares(codigo) > 3) then ok := true
  else ok := false;
  mas3digPar := ok;    
end;

procedure minProds(precio: real; codigo: integer; var codMin1, codMin2: integer; var min1,min2: real);
begin
  if precio < min1 then begin
    min2 := min1;
    codMin2 := codMin1;
    min1 := precio;
    codMin1 := codigo;
  end
  else if precio < min2 then begin
    min2 := precio;
    codMin2 := codigo;
  end;
end;

procedure informarDesc(descripcion: str30);
begin
  writeln('El/La ',descripcion,' posee un codigo de Prod. con mas de tres digitos pares.')
end;

procedure recorrerLista(l: lSuper);
var
  cantTot,cantCumple,codMin1,codMin2: integer;
  min1,min2,porcentCond: real;
begin
  cantTot := 0; cantCumple := 0; codMin1 := 0; codMin2 := 0; min1 := 9999; min2 := 9999;

  while l <> nil do begin
    cantCumple := cantCumple + contCondicion(l^.dato.stAct,l^.dato.stMin);
    cantTot := cantTot + 1;
    if(mas3digPar(l^.dato.cod)) then informarDesc(l^.dato.des);
    minProds(l^.dato.precio,l^.dato.cod,codMin1,codMin2,min1,min2);
    l := l^.sig;
  end;

  porcentCond := (cantCumple / cantTot) * 100;
  writeln('Un ',porcentCond:2:2,'% de los productos leidos poseen un stock actual menor a su stock minimo.');
  writeln('Los codigos de los dos productos mas economicos son: ');
  writeln('1.- ',codMin1);
  writeln('2.- ',codMin2);
end;


{programa principal}

var
  ls: lSuper;
begin
  ls := nil;
  generarLista(ls);
  recorrerLista(ls);
end.

{--------------------------------------------------------------------------------------------}

//version para pruebas automatizadas

program ejercicio5P6;

uses
  SysUtils;

type
  str30 = string[30];

  lSuper = ^nodo;

  producto = record
    cod: integer;
    stAct: integer;
    stMin: integer;
    precio: real;
    des: str30;
  end;

  nodo = record
    dato: producto;
    sig: lSuper;
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


procedure agregarAdelante(var l: lSuper; p:producto);
var
  aux: lSuper;
begin
  new(aux);
  aux^.dato := p;
  aux^.sig := l;
  l := aux;
end;

procedure leerProd(var p: producto);
begin
  with p do begin
    cod := Random(10001) - 1;
    if cod <> -1 then begin
      randomString(8,des);
      stAct := Random(101);
      stMin := Random(101);
      precio := Random(1001);
    end;
  end;
end;

procedure generarLista(var l: lSuper);
var
  p: producto;
begin
  leerProd(p);
  while (p.cod <> -1) do begin
    agregarAdelante(l,p);
    leerProd(p)
  end;
end;

function contCondicion(actual,minimo: integer):integer;
var
  aux: integer;
begin
  if actual <  minimo then aux := 1
  else aux := 0;
  contCondicion := aux;
end;

function mas3digPar(codigo: integer):boolean;

  function digPares(num: integer): integer;
  var
    dig, cantDigP: integer;
  begin
    cantDigP := 0;
    while num <> 0 do begin
      dig := num mod 10; // Obtener el dígito de las unidades
      if dig mod 2 = 0 then
        cantDigP := cantDigP + 1;
      num := num div 10;
    end;
    digPares := cantDigP;
  end;

var
  ok: boolean;
begin
  if (digPares(codigo) > 3) then ok := true
  else ok := false;
  mas3digPar := ok;    
end;

procedure minProds(precio: real; codigo: integer; var codMin1, codMin2: integer; var min1,min2: real);
begin
  if precio < min1 then begin
    min2 := min1;
    codMin2 := codMin1;
    min1 := precio;
    codMin1 := codigo;
  end
  else if precio < min2 then begin
    min2 := precio;
    codMin2 := codigo;
  end;
end;

procedure informarDesc(descripcion: str30);
begin
  writeln('El/La ',descripcion,' posee un codigo de Prod. con mas de tres digitos pares.')
end;

procedure recorrerLista(l: lSuper);
var
  cantTot,cantCumple,codMin1,codMin2: integer;
  min1,min2,porcentCond: real;
begin
  cantTot := 0; cantCumple := 0; codMin1 := 0; codMin2 := 0; min1 := 9999; min2 := 9999;

  while l <> nil do begin
    cantCumple := cantCumple + contCondicion(l^.dato.stAct,l^.dato.stMin);
    cantTot := cantTot + 1;
    if(mas3digPar(l^.dato.cod)) then informarDesc(l^.dato.des);
    minProds(l^.dato.precio,l^.dato.cod,codMin1,codMin2,min1,min2);
    l := l^.sig;
  end;

  porcentCond := (cantCumple / cantTot) * 100;
  writeln('Un ',porcentCond:2:2,'% de los productos leidos poseen un stock actual menor a su stock minimo.');
  writeln('Los codigos de los dos productos mas economicos son: ');
  writeln('1.- ',codMin1);
  writeln('2.- ',codMin2);
end;


{programa principal}

var
  ls: lSuper;
begin
  Randomize;
  ls := nil;
  generarLista(ls);
  recorrerLista(ls);
end.