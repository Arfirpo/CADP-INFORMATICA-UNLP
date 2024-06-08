program ejercicio6P7;

uses
  sysUtils;

const
  dimF_clas = 7;

type
  rango_clas = 1..dimF_clas;
  str30 = string[30];

  lObjetos = ^nObjetos;

  objeto = record
    cod: integer;
    cat: rango_clas;
    nom: str30;
    distT: real;
    desc: str30;
    aDesc: integer;
  end;

  nObjetos = record
    dato: objeto;
    sig: lObjetos;
  end;

  vCategorias = array[rango_clas] of integer;

{modulos}

procedure inicializarV(var vC: vCategorias);
var
  i: rango_clas;
begin
  for i := 1 to dimF_clas do
    vC[i] := 0;
end;

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

// procedure leerObjeto(var o: objeto);
// begin
//   with o do begin
//     write('Codigo de Objeto: ');
//     readln(cod);
//     if (cod <> -1) then begin
//       write('Categoria de Objeto: ');
//       readln(cat);
//       write('Nombre del Objeto: ');
//       readln(nom);
//       write('Distancia del Planeta Tierra: ');
//       readln(distT);
//       write('Descubridor: ');
//       readln(desc);
//       write('Anio de Descubrimiento: ');
//       readln(aDesc);
//     end;
//   end;
// end;

procedure leerObjeto(var o: objeto);
begin
  with o do begin
    cod := Random(9999) - 1;
    if cod <> -1 then begin
      cat := Random(7) + 1;
      randomString(5,nom);
      distT := Random(9999) + 1;
      randomString(6,desc);
      aDesc := Random(1024) + 1000;
    end;
  end;
end;

procedure agregarAtras(var pri,ult: lObjetos; o: objeto);
var
  nue: lObjetos;
begin
  new(nue);
  nue^.dato := o;
  nue^.sig := nil;
  if(pri = nil) then
    pri := nue
  else
    ult^.sig := nue;
  ult := nue;
end;

procedure generarLista(var pri,ult: lObjetos);
var
  o: objeto;
begin
  leerObjeto(o);
  while (o.cod <> -1) do begin
    agregarAtras(pri,ult,o);
    leerObjeto(o);
  end;
end;

procedure maxDist(dist: real; cod: integer; var max1,max2: real; var codMax1,codMax2: integer);
begin
  if (dist > max1) then begin
    max2 := max1;
    codMax2 := codMax1;
    max1 := dist;
    codMax1 := cod;
  end
  else if(dist > max2) then begin
    max2 := dist;
    codMax2 := cod;
  end;
end;

function cumple4(cod: integer):boolean;
var
  dig,cantP,cantI: integer;
begin
  cantP := 0; cantI := 0;
  while(cod <> 0) do begin
    dig := cod mod 10;
    if (dig mod 2 = 0) then
      cantP := cantP + 1
    else
      cantI := cantI +1;
    cod := cod div 10; 
  end;
  cumple4 := (cantP > cantI);
end;

procedure informarC(vC: vCategorias);
var
  i: rango_clas;
begin
  for i := 1 to dimF_clas do begin
    case i of
      1: if (vC[i] > 0) then
        writeln('Se observaron ',vC[i],' estrellas.')
      else
        writeln('No se observaron estrellas.');
      2: if (vC[i] > 0) then
        writeln('Se observaron ',vC[i],' planetas.')
      else
        writeln('No se observaron planetas.');
      3: if (vC[i] > 0) then 
        writeln('Se observaron ',vC[i],' satelites.')
      else
        writeln('No se observaron satelites.');
      4: if (vC[i] > 0) then
        writeln('Se observaron ',vC[i],' galaxias.')
      else
        writeln('No se observaron galaxias.');
      5: if (vC[i] > 0) then
        writeln('Se observaron ',vC[i],' asteroides.')
      else
        writeln('No se observaron asteroides.');
      6: if (vC[i] > 0) then
        writeln('Se observaron ',vC[i],' cometas.')
      else
        writeln('No se observaron cometas.');
      7: if (vC[i] > 0) then
        writeln('Se observaron ',vC[i],' nebulosas.')
      else
        writeln('No se observaron nebulosas.');
    end;
    writeln('---------------------------');
  end;    
end;

procedure procesarLista(l: lObjetos; var vC: vCategorias);
var
  max1,max2: real;
  codMax1,codMax2,CantGalileo: integer;
begin
  max1 := -1; max2 := -1;
  codMax1 := 0; codMax2 := 0;
  CantGalileo := 0;

  writeln('------------------------------------------------------');
  while(l <> nil) do begin

    //punto 1.
    maxDist(l^.dato.distT,l^.dato.cod,max1,max2,codMax1,codMax2);

    //punto 2.
    vC[l^.dato.cat] := vC[l^.dato.cat] + 1;
    
    //punto 3.
    if ((l^.dato.cat = 2) and (l^.dato.desc = 'galileo galilei') and (l^.dato.aDesc < 1600)) then
      CantGalileo := CantGalileo + 1;
    
    //punto 4.
    if (l^.dato.cat = 1) and (cumple4(l^.dato.cod)) then begin
      writeln('El codigo de la estrella ',l^.dato.nom,' posee mas digitos pares que impares.');
      writeln('------------------------------------------------------');
    end;

    l := l^.sig;
  end;
    
  writeln('Los codigos de los dos objetos mas lejanos a la Tierra son: ');
  writeln('1.- ',codMax1);
  writeln('2.- ',codMax2);
  writeln('------------------------------------------------------');
  if(CantGalileo > 0) then begin
    writeln(CantGalileo,', planetas fueron descubiertos por Galileo Galilei antes del anio 1600.');    
  end
  else
    writeln('No se registran planetas descubiertos por Galileo Galilei antes del anio 1600');
  writeln('------------------------------------------------------');
  informarC(vC);
end;


var
  pri,ult: lObjetos;
  vC: vCategorias;

begin
  Randomize;
  pri := nil; ult := nil;
  inicializarV(vC);
  generarLista(pri,ult); //Punto A.
  procesarLista(pri,vC);
end.
