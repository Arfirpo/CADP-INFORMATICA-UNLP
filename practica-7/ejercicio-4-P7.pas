program ejercicio4P7;

uses
  sysUtils;

const
  dimF_sem = 42;

type
  str30 = string[30];
  rangoSemanas = 1..dimF_sem;
  lPacientes = ^nPacientes;

  vPesos = array[rangoSemanas] of real;

  rSemanas = record
    pSem: vPesos;
    dimL: integer;
  end;

  paciente = record
    nom: str30;
    ap: str30;
    peso: rSemanas;
  end;

  nPacientes = record
    dato: paciente;
    sig: lPacientes;
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

procedure cargarVectorPeso(var p: rSemanas);
var
  i: integer;
  aux: real;
begin
  p.dimL := 0;
  i := 1;
  aux := Random(30) - 1;
  while (i <= dimF_sem) and (aux <> -1) do begin
    p.pSem[i] := aux; 
    aux := aux + (Random(30) - 1);
    p.dimL := p.dimL + 1;
    i := i + 1;
  end;
end;

procedure leerPaciente(var p: paciente);
begin
  with p do begin
    randomString(3,nom);
    if (nom <> 'laj') then begin
      randomString(5,ap);
      cargarVectorPeso(peso);
    end;
  end;
end;

procedure armarNodo(var l: lPacientes; p: paciente);
var
  nue: lPacientes;
begin
  new(nue);
  nue^.dato := p;
  nue^.sig := l;
  l := nue;
end;

procedure generarLista(var l: lPacientes);
var
  p: paciente;
begin
  leerPaciente(p);
  while(p.nom <> 'laj') do begin
    armarNodo(l,p);
    leerPaciente(p);
  end;
end;

procedure procesarEmbarazo(p: rSemanas; var maxSem: integer; var totPeso: real);
var
  i: integer;
  max,dif: real;
begin
  max := -1;
  for i := 2 to p.dimL do begin
    dif := p.pSem[i] - p.pSem[i-1];
    totPeso := totPeso + dif;
    if (dif > max) then begin
      max := dif;
      maxSem := i;
    end;
  end;
end;

procedure procesarLista(l: lPacientes);
var
  maxSem: integer;
  totPeso: real;
begin
  while(l <> nil) do begin
    maxSem := 0;
    totPeso := 0;
    procesarEmbarazo(l^.dato.peso,maxSem,totPeso);
    writeln('Para la paciente ',l^.dato.nom,' la semana con mayor aumento de peso fue la Nro ',maxSem);
    writeln('Para la paciente ',l^.dato.nom,' el aumento de peso total durante su embarazo fue de ',totPeso:0:2,'Kg');
    l := l^.sig;
  end;
end;


{Programa principal}
var
  pri: lPacientes;
begin
  Randomize;
  generarLista(pri);
  procesarLista(pri);
end.
