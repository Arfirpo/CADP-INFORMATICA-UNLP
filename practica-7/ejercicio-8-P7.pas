program ejercicio8P7;

uses
  sysUtils;

const
  dimF_mes = 11;
  dimF_dias = 31;
  dimF_horas = 23;
  dimF_minutos = 59;
  dimF_cod = 7;

type
  rCod = 1..dimF_cod;
  rDias = 1..dimF_dias;
  rMes = 0..dimF_mes; // corregido para incluir hasta 11
  rHoras = 0..dimF_horas;
  rMinutos = 0..dimF_minutos;

  lTrans = ^nTrans;

  fechas = record
    dia: rDias;
    mes: rMes;
    anio: integer;
  end;

  horario = record
    h: rHoras;
    m: rMinutos;
    s: rMinutos;
  end;

  trans = record
    nCuenta_ori: integer;
    dniTit_Co: integer;
    nCuenta_dest: integer;
    dniTit_Cd: integer;
    fecha: fechas;
    hora: horario;
    monto: real;
    codTrans: rCod;
  end;

  nTrans = record
    dato: trans;
    sig: lTrans;
  end;

  vCodTrans = array[rCod] of integer;

{ Módulos }

procedure leerFecha(var f: fechas);
begin
  with f do begin
    dia := Random(dimF_dias) + 1;
    mes := Random(dimF_mes + 1); // para incluir el mes 11
    anio := 2018;
  end;
end;

procedure leerHora(var hr: horario);
begin
  with hr do begin
    h := Random(dimF_horas + 1);
    m := Random(dimF_minutos + 1);
    s := Random(dimF_minutos + 1);
  end;
end;

procedure leerTransferencia(var t: trans);
begin
  with t do begin
    nCuenta_ori := Random(1001) - 1;
    dniTit_Co := Random(1000) + 1;
    nCuenta_dest := Random(1001) - 1;
    dniTit_Cd := Random(1000) + 1;
    leerFecha(fecha);
    leerHora(hora);
    monto := Random(1550) + 1;
    codTrans := Random(dimF_cod) + 1;
  end;
end;

procedure armarNodo(var l: lTrans; t: trans);
var
  nue: lTrans;
begin
  new(nue);
  nue^.dato := t;
  nue^.sig := l;
  l := nue;
end;

procedure generarLista(var l: lTrans);
var
  t: trans;
begin
  leerTransferencia(t);
  while t.nCuenta_ori <> -1 do
  begin
    armarNodo(l, t);
    leerTransferencia(t);
  end;
end;

procedure inicializarVector(var vCod: vCodTrans);
var
  i: rCod;
begin
  for i := 1 to dimF_cod do
    vCod[i] := 0;
end;

procedure insertarOrdenado(var l2: lTrans; t: trans);
var
  nue, ant, act: lTrans;
begin
  new(nue);
  nue^.dato := t;
  ant := l2;
  act := l2;
  while (act <> nil) and (t.nCuenta_ori > act^.dato.nCuenta_ori) do
  begin
    ant := act;
    act := act^.sig;
  end;
  if (act = ant) then
    l2 := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure procesarLista(l: lTrans; var l2: lTrans);
begin
  while l <> nil do
  begin
    if l^.dato.dniTit_Co <> l^.dato.dniTit_Cd then
      insertarOrdenado(l2, l^.dato);
    l := l^.sig;
  end;
end;

function procesarDig(cDest: integer): boolean;
var
  dig, digP, digI: integer;
begin
  digP := 0;
  digI := 0;
  while cDest <> 0 do
  begin
    dig := cDest mod 10;
    if dig mod 2 = 0 then
      digP := digP + 1
    else
      digI := digI + 1;
    cDest := cDest div 10;
  end;
  procesarDig := digP < digI;
end;

function cumpleCond(cDest: integer; mes: rMes): boolean;
begin
  cumpleCond := procesarDig(cDest) and (mes = 6);
end;

function maxCod(vCod: vCodTrans): integer;
var
  max, i, cod: integer;
begin
  max := -1;
  cod := 0;
  for i := 1 to dimF_cod do
  begin
    if vCod[i] > max then
    begin
      max := vCod[i];
      cod := i;
    end;
  end;
  maxCod := cod;
end;

procedure procesarLista2(l2: lTrans; var vCod: vCodTrans);
var
  totTrans: real;
  cumpleD, cOri_actual: integer;
begin
  cumpleD := 0;
  while l2 <> nil do
  begin
  writeln('--------------------------------------------------------------------------');
    cOri_actual := l2^.dato.nCuenta_ori;
    totTrans := 0;
    while (l2 <> nil) and (l2^.dato.nCuenta_ori = cOri_actual) do
    begin
      totTrans := totTrans + l2^.dato.monto;
      vCod[l2^.dato.codTrans] := vCod[l2^.dato.codTrans] + 1;
      if cumpleCond(l2^.dato.nCuenta_dest, l2^.dato.fecha.mes) then
        cumpleD := cumpleD + 1;
      l2 := l2^.sig;
    end;
    writeln('La cuenta de origen ', cOri_actual, ' transfirió a terceros un total de $', totTrans:0:2);
  end;
  writeln('El código de motivo de transferencia más usado fue el ', maxCod(vCod));
  writeln('--------------------------------------------------------------------------');
  writeln(cumpleD, ' transferencias fueron realizadas en el mes de junio con un número de cuenta destino cuyos dígitos pares eran menos que sus dígitos impares.');
  writeln('--------------------------------------------------------------------------');
end;

{ Programa Principal }
var
  pri, pri2: lTrans;
  vCod: vCodTrans;
begin
  Randomize;
  pri := nil;
  pri2 := nil;
  inicializarVector(vCod);
  generarLista(pri); // se dispone
  procesarLista(pri, pri2);
  procesarLista2(pri2, vCod);
end.
