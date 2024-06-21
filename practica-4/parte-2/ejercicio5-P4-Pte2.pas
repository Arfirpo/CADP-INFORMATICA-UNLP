program ejercicio5P4Pte2;

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
    valor: imteger;
  end;

  vClientes = array[rango_clientes] of cliente; //se dispone
  vCont = array[categoria] of integer;
  vCiudades = array[ciudades] of ciudad;
  vMeses = array[meses] of integer;


{modulos}

procedure inicializarVCatecogrias(var vC: vCont);
var
  i: integer; 
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

procedure leerFecha(var f: fecha);
begin
  with f do begin
    write('Dia: ');
    readln(dia);
    write('Mes: ');
    readln(mes);
    write('Anio: ');
    readln(anio);
  end;
end;

procedure leerCliente(var c: cliente);
begin
  with c do begin
    leerFecha(c.fechaFC);
    write('Categoria Monotributo: ');
    readln(catMono);
    write('Codigo de ciudad: ');
    readln(codC);
    write('Monto del contrato: ');
    readln(montoC);
  end;
end;

procedure insertarOrdenado(var vCli: vClientes; c: cliente; var dimL: integer);
  
  function determinarPosicion(f: fecha; dimL: integer; vCli: vClientes):integer;
  var
    pos: integer;
  begin
    pos := 1;
    while (pos <= dimL) and ((f.anio < vCli[pos].fechaFC.anio) or ((f.anio = vCli[pos].fechaFC.anio) and (f.mes < vCli[pos].fechaFC.mes)) or ((f.anio = vCli[pos].fechaFC.anio) and ((f.mes = vCli[pos].fechaFC.mes) and ((f.dia < vCli[pos].fechaFC.dia))))) do
      pos: pos + 1;
    determinarPosicion := pos;
  end;

  procedure insertar(var vCli: vClientes; var dimL: integer; pos: integer; c: cliente);
  var
    j: integer;
  begin
    for j := dimL downto pos do
      vCli[j+1] := vCli[j];
    vCli[pos] := c;
    dimL := dimL + 1;
  end;

var
  pos: integer;
begin
  if (dimL < dimF_Clientes) then begin
    pos := determinarPosicion(c.fechaFC,dimL,vCli);
    insertar(vCli,dimL,pos,c);
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

procedure cantPorCaT(vC: vCont);
var
  i: integer;
begin
  for i := 1 to max do
    case i of
      1: if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria A de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      2: if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria B de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      3: if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria C de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      4: if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria D de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      5: if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria E de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
      6: if (vC[i] > 0) then
          writeln('Hay ', vC[i],' clientes con categoria F de monotributo')
        else
          writeln('No hay clientes registrados en esa categoria de monotributo');
    end;
end;

function cantClientes(vCli: vClientes; prom: real):integer;
var
  i,aux: integer;
begin
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
  i, j, p, item: integer;
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
    writeln('La ',i,'° ciudad con mayor cantidad de clientes tiene el codigo: ',vCiu[i].cod);
end;

procedure procesarVector(vCli: vClientes; var vCiu: vCiudades; var vC: vCont; var vM: vMeses);
var
  i: rango_clientes;
  cantAnio,cantMes,max_Contratos,max_anio,cantCli: integer;
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

          vC[vCli[i].catMono] = vC[vCli[i].catMono] + 1; {cuenta cantidad de clientes por categoria de monotributo}
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
      writeln('En el anio, ',corte_anio,' se firmaron ',cantAnio,' contratos.');
      maximo(corte_anio,cantAnio,max_anio,max_Contratos);
  
  end;

  ordenarVector(vCiu); {ordeno de mayor a menor el vector}
  imprimir10Max(vCiu); {imprimo los codigos de las 10 ciudades con mas clientes}
  writeln('La cantidad de clientes que superan mensualmente el monto promedio entre todos los clientes es: ',cantCli);
  writeln('La mayor cantidad de contratos se firmo en el anio ',max_anio)
  cantPorCaT(vC);


end;

{programa principal}
var
  vCli: vClientes; 
  vC: vCont; 
  vCiu: vCiudades; 
  vM: vMeses;
begin
  inicializarVCatecogrias(vC);
  inicializarVmeses(vM);
  inicializarVciudades(vCiu);
  cargarVector(vCli); //se dispone
  procesarVector(vCli,vCiu,vC,vM);
end.


{https://github.com/OmgCopito95/CADP/blob/main/Ejercicios%20de%20Ayuda/Ejercicios%20Resueltos/Pr%C3%A1ctica%204%20-%20Vectores/ejercicio5.pas}