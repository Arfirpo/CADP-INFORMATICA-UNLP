program ejercicio5P4Pte2;

const
  dimF_Clientes = 500;


type
  rango_clientes = 1..dimF_Clientes;
  dias = 1..31;
  mes = 1..12;
  str30 = string[30];
  categoria = A..F;
  ciudades = 1..2400;

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
    cod: ciudades;
    cantClientes: integer;
  end;


  vClientes = array[rango_clientes] of cliente; //se dispone
  vCont = array[categoria] of integer;
  vContratos = array[rango_clientes] of contrato;
  vCiudades = array[ciudades] of ciudad;


{modulos}

procedure inicializarVector(var vC: vCont);
var
  i: integer; 
begin
  for i := 1 to 6 do
    vC[i] := 0;
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
    insertar(vCli,dimL,pos,c)
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


procedure procesarVector(vCli: vClientes; var vCiu: vCiudades; var vC: vCont; var vContr: vContratos);
var
  i: rango_clientes;
begin
  i := 1;{inicializar variables totales}
  while (i < dimF_Clientes) do begin
    corte_anio := vCli[i].fechaFC.anio; {corte de control por año}

    while (i < dimF_Clientes) and (vCli[i].fechaFC.anio = corte_anio) do begin
      corte_mes := vCli[i].fechaFC.mes;

      i := i +1;
    end;

  end;


end;

var
  vCli: vClientes; vC: vCont; vCiu: vCiudades;
begin
  inicializarVector(vC);
  cargarVector(vCli); //se dispone
  procesarVector(vCli,vCiu,vC, vContr);
end.
