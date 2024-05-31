{La oficina de becas y subsidios desea optimizar los distintos tipos de ayuda financiera que se brinda a
alumnos de la UNLP. Para ello, esta oficina cuenta con un registro detallado de todos los viajes
realizados por una muestra de 1300 alumnos durante el mes de marzo. De cada viaje se conoce el
código de alumno (entre 1 y 1300), día del mes, Facultad a la que pertenece y medio de transporte (1.
colectivo urbano; 2. colectivo interurbano; 3. tren universitario; 4. tren Roca; 5. bicicleta). Tener en
cuenta que un alumno puede utilizar más de un medio de transporte en un mismo día.
Además, esta oficina cuenta con una tabla con información sobre el precio de cada tipo de viaje.
Realizar un programa que lea la información de los viajes de los alumnos y los almacene en una
estructura de datos apropiada. La lectura finaliza al ingresarse el código de alumno -1, que no debe
procesarse.
Una vez finalizada la lectura, informar:
a. La cantidad de alumnos que realizan más de 6 viajes por día
b. La cantidad de alumnos que gastan en transporte más de $80 por día.
c. Los dos medios de transporte más utilizados.
d. La cantidad de alumnos que combinan bicicleta con algún otro medio de transporte.}


program ejercicio14P6;

const
  dimF_alu = 1300;
  dimF_trans = 7;
  dimF_mes = 31;

type
  cod = -1..dimF_alu;
  dias = 1..31;
  str30 = string[30];
  rango_trans = 1..dimF_trans;

rTrans = record
  nro: 1..dimF_trans;
  tipo: str30;
  precio: real;
end;

  viaje = record
    codigo: cod;
    dia: dias;
    fac: str30;
    trans: integer;
  end;

  lViajes = ^nViajes;

  nViajes = record
    dato: viaje;
    sig: lViajes;
  end;

  vAlu = array[1..dimF_alu] of lViajes; //vector de 1300 alumnos, contiene la lista de todos sus viajes.
  vTrans = array[rango_trans] of rTrans; //vector de los 7  transportes, contiene precio de cada medio.
  vCont = array[rango_trans] of integer;//vector contador por cantidad de usos de cada transporte.

{modulos}

procedure cargarVector(var v: vTrans; var c: vCont);

  procedure leerTransporte(var t: rTrans; i: rango_trans);
  begin
    with t do begin
      nro := i; 
      write('Ingrese tipo de transporte: ');
      readln(tipo);
      write('Ingrese el precio del pasaje: ');
      readln(precio);
      while (precio = 0) do begin
      write('Ingrese el precio del pasaje: ');
      readln(precio);  
      end;      
    end;   
  end;

var
  i: rango_trans;
  t: rTrans;
begin
  for i := 1 to rango_trans do
    leerTransporte(t,i);
    v[i] := t;
    c[i] := 0;
end;

procedure generarListaV(var vL: vAlu; var cT: vCont;);

  procedure inicializarLista(var l: lViajes);
  begin
    l := nil;
  end;

  procedure leerViaje(var v: viaje);
  begin
    with v do begin
      write('Ingrese el codigo de alumno: ');
      readln(codigo);
      if codigo <> -1 then begin
        repeat
        write('Ingrese dia del viaje: ');
        readln(dia);          
        until (dia >= 1 and dia <= 31);
        write('Ingrese el nombre de la facultad a la que asiste el alumno: ');
        readln(fac);
        repeat
          write('Ingrese el medio de transporte utilizado: ');
          readln(trans);
        until((trans >= 1) and (trans <= 7));
      end;
    end;
  end;

  procedure insertarOrdenado(var l: lViajes; v: viaje);
  var
    nue,ant,act: lViajes;
  begin
    new(nue);
    nue^.dato := v;
    act := l;
    ant := l;
    while (act <> nil) and ((v.dia > act^.dato.dia) or ((v.dia = act^.dato.dia) and (v.trans > act^.dato.trans))) do begin
      ant := act;
      act := act^.sig;
    end;
    if (ant = act) then
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;


var
  vA: vAlu;
  rV: viaje;
  c_dias: dias;
  c_trans: rango_trans;
  i: integer;
begin
  for i := 1 to dimF_alu do  //inicializo la lista de cada alumno en nil.
    inicializarLista(v[rV.cod]); 
  leerViaje(rV); //leo un viaje.
  while (rV.cod <> -1) do begin  //si el codigo de alumno es valido.
    c_Dias := rV.dia; //corte de control por dia del mes.
    
    while (rV.cod <> -1) and (rV.dia = c_dias) do begin //mientras el dia del viaje sea el mismo.
      c_trans := rV.trans.nro; //corte de control por medio de transporte
      
      while (rV.cod <> -1) and (rV.dia = c_dias) and (rV.trans = c_trans) do begin ////mientras el transporte sea el mismo.
        insertarOrdenado(v[rV.cod],rV); //agrego el viaje a la lista ordenada de menor a mayor por dia y transp.
        leerViaje(rV); //leo otro viaje
      end;
      cT[c_trans] := cT[c_trans] +1;
    end;
  end;
end;

procedure procesarAlu(lV: lViajes; vT: vTrans; var cumpleA,cumpleB: boolean);
var
  aux: lViajes
  c_dias: dias;
  c_trans: rango_trans;
  cantViajes: integer;
  
  usaBici,usaOtro: boolean;
  gastoD: real;
begin
  cumpleA := false; cumpleB := false;
  aux := lV;
  gastoD := 0;
  cantViajes := 0;
  while aux <> nil do begin // Calcular gasto total y cantidad de viajes por día
    c_dias := aux^.dato.dia;
    while aux <> nil and (aux^.dato.dia = c_dias) do begin
      c_trans := aux^.dato.trans;

      while aux <> nil and (aux^.dato.dia = c_dias) and ((aux^.dato.trans = c_trans)) do begin
        gastoD := gastoD +vT[aux^.dato.trans].precio;
        aux := aux^.sig;
      end;
      cantViajes := cantViajes + 1;
    end;
  end;
    
  gastoD := gastoD / dimF_mes;//calculo el promedio de gasto por dia.
  cantViajes := cantViajes / dimF_mes; //calculo el promedio de viajes por dia.
  //si la cantidad de viajes diarios del alumno es mayor a 6
  if (cantViajes > 6) then cumpleA := true;
  if (gastoD > 80) then cumpleB := true;
    
end;

procedure maxUso(cant: integer; transp: str30; var max1, max2: integer; var maxT1, maxT2: str30);
begin
  if cant > max1 then begin
    max2 := max1;
    maxT2 := maxT1;
    max1 := cant;
    maxT1 := transp;
  end
  else if cant > max2 then begin
    max2 := cant;
    maxT2 := transp;
  end;
end;

{programa principal}
var
  vT: vTrans; 
  vL: vAlu; 
  vC: vCont;
  i,cantAluV,cantAluG,max1,max2,: integer;
  cumpleA,cumpleB,cumpleD: boolean;
  maxT1; maxT2: str30;

begin
  max1 := -1; max2 := -1;
  maxT1 := ''; maxT2 := '';
  cargarVector(vT,vC); //cargo la tabla de precios de cada transporte.
  generarListaV(vL,vC); //genera, para cada alumno, una lista ordenada (por dia y por medio de transporte).
  //todo lo que sigue puede ser: procesarLista().
  cantAluV:= 0; cantAluG := 0;
  for i := 1 to dimF_alu do begin
    if i <= dimF_trans then
      maxUso(vC[i],vT[i].tipo,max1,max2,maxT1,maxT2);
    procesarAlu(vL[i],vT,cumpleA,cumpleB,cumpleD); //trabaja el vector de listas, de cantidades y de precios.
    if
    if (cumpleA) then
      cantAluV := cantAluV +1;
    if (cumpleB) then
      cantAluG := cantAluG + 1;
  end;

  if cantAluV > 0 then
    writeline(cantAlu,' alumnos realizan mas de 6 viajes por dia.');
    
end.

















//-------------------------------------------------------------------------------------

{version para pruebas automatizadas}

