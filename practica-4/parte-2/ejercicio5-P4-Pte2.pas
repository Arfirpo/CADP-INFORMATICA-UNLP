program ejercicio5P4Pte2;

uses
  sysUtils;

const
  dimF_Clientes = 500;
  dimF_dias = 31;
  dimF_meses = 12;
  dimF_ciudades = 2400;
  dimF_max = 10;

type
  rango_clientes = 1..dimF_Clientes;
  dias = 1..dimF_dias;
  meses = 1..dimF_meses;
  str30 = string[30];
  categoria = 'A'..'F';
  ciudades = 1..dimF_ciudades;

  fecha = record
    dia: dias;
    mes: meses;
    anio: integer;
  end;

  cliente = record
    FechaFC: fecha;
    catMono: categoria;
    codC: ciudades;
    montoC: real;
  end;

  ciudad = record
    cod: integer;
    valor: integer;
  end;

  vClientes = array[rango_clientes] of cliente; //se dispone
  vCont = array[categoria] of integer;
  vCiudades = array[ciudades] of ciudad;
  vMeses = array[meses] of integer;


{modulos}

procedure inicializarVCatecogrias(var vC: vCont);
var
  i: categoria; 
begin
  for i := 'A' to 'F' do 
    vC[i] := 0;
end;

procedure inicializarVciudades(var vCiu: vCiudades);
var
  i: integer;
begin
  for i := 1 to dimF_ciudades do
    vCiu[i].valor := 0;
end;

procedure inicializarVmeses(var vM: vMeses);
var
  i: integer;
begin
  for i := 1 to dimF_meses do
    vM[i] := 0;
end;


// procedure leerFecha(var f: fecha);
// begin
//   with f do begin
//     write('Dia: ');
//     readln(dia);
//     write('Mes: ');
//     readln(mes);
//     write('Anio: ');
//     readln(anio);
//   end;
// end;

// procedure leerCliente(var c: cliente);
// begin
//   with c do begin
//     leerFecha(c.fechaFC);
//     write('Categoria Monotributo: ');
//     readln(catMono);
//     write('Codigo de ciudad: ');
//     readln(codC);
//     write('Monto del contrato: ');
//     readln(montoC);
//   end;
// end;

procedure leerFecha(var f: fecha);
begin
  with f do begin
    dia := Random(dimF_dias) + 1;
    mes := Random(dimF_meses) + 1;
    anio := Random(75) + 1950;
  end;
end;

procedure leerCliente(var c: cliente);
begin
  with c do begin
    leerFecha(c.fechaFC);
    catMono := Chr(Ord('A') + Random(6));
    codC := Random(dimF_ciudades) + 1;
    montoC := Random(500) + 1;
  end;
end;


//se dispone-------------------------------------------------------------------------
procedure insertarOrdenado(var vCli: vClientes; c: cliente; var dimL: integer);
  
  function determinarPosicion(f: fecha; dimL: integer; vCli: vClientes):integer;
  var
    ps: integer;
  begin
    ps:= 1;
    while (ps <= dimL) and ((f.anio < vCli[ps].fechaFC.anio) or ((f.anio = vCli[ps].fechaFC.anio) and (f.mes < vCli[ps].fechaFC.mes)) or ((f.anio = vCli[ps].fechaFC.anio) and ((f.mes = vCli[ps].fechaFC.mes) and ((f.dia < vCli[ps].fechaFC.dia))))) do
      ps:= ps+ 1;
    determinarPosicion := ps;
  end;

  procedure insertar(var vCli: vClientes; var dimL: integer; ps: integer; c: cliente);
  var
    j: integer;
  begin
    for j := dimL downto ps do
      vCli[j+1] := vCli[j];
    vCli[ps] := c;
    dimL := dimL + 1;
  end;

var
  ps: integer;
begin
  if (dimL < dimF_Clientes) then begin
    ps:= determinarPosicion(c.fechaFC,dimL,vCli);
    insertar(vCli,dimL,ps,c);
  end;
end;

procedure cargarVector(var vCli: vClientes); //se dispone
var
  i: rango_clientes;
  c: cliente;
  dimL: integer;
begin
  dimL := 0;
  for i := 1 to dimF_Clientes do begin
    leerCliente(c);
    insertarOrdenado(vCli,c,dimL);
  end;    
end;
//-----------------------------------------------------------------------------------

procedure cantPorCaT(vC: vCont);
var
  i: categoria;
begin
  for i := 'A' to 'F' do
    case i of
      'A': if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria A de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      'B': if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria B de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      'C': if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria C de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      'D': if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria D de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      'E': if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria E de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      'F': if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria F de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
    end;
end;

function cantClientes(vCli: vClientes; prom: real):integer;
var
  i,aux: integer;
begin
  aux := 0;
  for i := 1 to dimF_Clientes do begin
    if (vCli[i].montoC > prom) then
      aux := aux + 1;
  end;
  cantClientes := aux;
end;


procedure maximo(anio,cantAnio: integer; var max_anio,max_Contratos: integer);
begin
  if (cantAnio > max_Contratos) then begin
    max_contratos := cantAnio;
    max_anio := anio;
  end;
end;

function promedio(prom: real; vCli: vClientes):real;
var
  i: integer;
begin
  for i := 1 to dimF_Clientes do
    prom := prom + vCli[i].montoC;
  promedio := prom / dimF_Clientes    
end;

procedure ordenarVector(var vCiu: vCiudades);
var
  i, j, p: integer;
  item: ciudad;
begin
  for i := 1 to dimF_ciudades - 1 do
  begin
    p := i;
    for j := i + 1 to dimF_ciudades do
    begin
      if vCiu[j].valor > vCiu[p].valor then
        p := j;
    end;
    item := vCiu[p];
    vCiu[p] := vCiu[i];
    vCiu[i] := item;
  end;
end;

procedure imprimir10Max(vCiu: vCiudades);
var
  i: integer;
begin
  for i := 1 to dimF_max do
    writeln('La ',i,'° ciudad con mayor cantidad de clientes (',vCiu[i].valor,' contratos) tiene el codigo: ',vCiu[i].cod);
end;

procedure imprimirVectorMeses(vM: vMeses);
var
  i: meses;
begin
  for i := 1 to dimF_meses do begin
    case i of
      1: if vM[i] > 0 then
        writeln('En el mes de Enero se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Enero no se firmaron contratos.');
      2: if vM[i] > 0 then
        writeln('En el mes de Febrero se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Febrero no se firmaron contratos.');
      3: if vM[i] > 0 then
        writeln('En el mes de Marzo se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Marzo no se firmaron contratos.');
      4: if vM[i] > 0 then
        writeln('En el mes de Abril se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Abril no se firmaron contratos.');
      5: if vM[i] > 0 then
        writeln('En el mes de Mayo se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Mayo no se firmaron contratos.');
      6: if vM[i] > 0 then
        writeln('En el mes de Junio se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Junio no se firmaron contratos.');
      7: if vM[i] > 0 then
        writeln('En el mes de Julio se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Julio no se firmaron contratos.');
      8: if vM[i] > 0 then
        writeln('En el mes de Agosto se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Agosto no se firmaron contratos.');
      9: if vM[i] > 0 then
        writeln('En el mes de Septiembre se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Septiembre no se firmaron contratos.');
      10: if vM[i] > 0 then
        writeln('En el mes de Octubre se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Octubre no se firmaron contratos.');
      11: if vM[i] > 0 then
        writeln('En el mes de Noviembre se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Noviembre no se firmaron contratos.');
      12: if vM[i] > 0 then
        writeln('En el mes de Diciembre se firmaron: ',vM[i],' contratos.')
      else
        writeln('En el mes de Diciembre no se firmaron contratos.');
    end;
  end;
end;


procedure procesarVector(vCli: vClientes; var vCiu: vCiudades; var vC: vCont; var vM: vMeses);
var
  i: integer;
  cantAnio,cantMes,max_Contratos,max_anio,cantCli,corte_anio: integer;
  corte_mes: meses;
  montoProm: real;
begin
{inicializar variables totales}
  i := 0; 
  montoProm := 0;
  max_Contratos := -1;
  max_anio := 0;
  cantCli := 0;
  montoProm := promedio(montoProm,vCli);

  while (i < dimF_Clientes) do begin

      corte_anio := vCli[i].fechaFC.anio; {corte de control por año}
      cantAnio := 0;

      while (i < dimF_Clientes) and (vCli[i].fechaFC.anio = corte_anio) do begin

        corte_mes := vCli[i].fechaFC.mes; {corte de control por mes}
        cantMes := 0;

        while (i < dimF_Clientes) and (vCli[i].fechaFC.anio = corte_anio) and (vCli[i].fechaFC.mes = corte_mes) do begin

          vC[vCli[i].catMono] := vC[vCli[i].catMono] + 1; {cuenta cantidad de clientes por categoria de monotributo}
          cantMes := cantMes + 1; {cuento contratos dentro del mismo mes}
          vCiu[vCli[i].codC].valor := vCiu[vCli[i].codC].valor + 1; {sumo clientes en el vector de ciudades, segun codigo de ciudad}
          vCiu[vCli[i].codC].cod := vCli[i].codC; {guardo el codigo de ciudad en la parte correspondiente del vector de ciudades}
          if (vCli[i].montoC > montoProm) then {comparo el monto mensual del contrato de un cliente con el promedio calculado anteriormente}
            cantCli := cantCli + 1; {si el monto del contrato del cliente supera el promedio, sumo +1 en el contador de condicion}

          i := i + 1; {incremento el indice para recorrer la siguiente posicion del vector}
        end;
        
        cantAnio := cantAnio + cantMes;
        vM[corte_mes] := vM[corte_mes] + cantMes; {cuento cantidad de contratos en el mismo mes del año}
      end;
      writeln('En el anio ',corte_anio,' se firmaron ',cantAnio,' contratos.');
      maximo(corte_anio,cantAnio,max_anio,max_Contratos);
  end;

  writeln('----------------------------------------------------');
  ordenarVector(vCiu); {ordeno de mayor a menor el vector}
  imprimir10Max(vCiu); {imprimo los codigos de las 10 ciudades con mas clientes}
  writeln('----------------------------------------------------');
  writeln('La cantidad de clientes que superan mensualmente el monto promedio entre todos los clientes es: ',cantCli);
  writeln('----------------------------------------------------');
  writeln('La mayor cantidad de contratos se firmo en el anio ',max_anio);
  writeln('----------------------------------------------------');
  cantPorCaT(vC);
  writeln('----------------------------------------------------');
  imprimirVectorMeses(vM);
end;

{programa principal}
var
  vCli: vClientes; 
  vC: vCont; 
  vCiu: vCiudades; 
  vM: vMeses;
begin
  Randomize;
  inicializarVCatecogrias(vC);
  inicializarVmeses(vM);
  inicializarVciudades(vCiu);
  cargarVector(vCli); //se dispone
  procesarVector(vCli,vCiu,vC,vM);
end.


{https://github.com/OmgCopito95/CADP/blob/main/Ejercicios%20de%20Ayuda/Ejercicios%20Resueltos/Pr%C3%A1ctica%204%20-%20Vectores/ejercicio5.pas}