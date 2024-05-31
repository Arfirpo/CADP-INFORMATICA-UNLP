{12. Una empresa desarrolladora de juegos para teléfonos celulares con Android dispone de información de
todos los dispositivos que poseen sus juegos instalados. De cada dispositivo se conoce la versión de
Android instalada, el tamaño de la pantalla (en pulgadas) y la cantidad de memoria RAM que posee
(medida en GB). 
La información disponible se encuentra ordenada por versión de Android. Realizar un
programa que procese la información disponible de todos los dispositivos e informe:

a. La cantidad de dispositivos para cada versión de Android.
b. La cantidad de dispositivos con más de 3 GB de memoria y pantallas de a lo sumo a 5 pulgadas.
c. El tamaño promedio de las pantallas de todos los dispositivos.}



program ejercicio12P6;

type
  lDisp = ^nDisp;

  disp = record
    android: real;
    size: real;
    ram: real;
  end;

  nDisp = record
    dato: disp;
    sig: lDisp;
  end;

{modulos}

procedure cargarLista(var l:lDisp);

  procedure leerDisp(var d: disp);
  begin
    with d do begin
      write('Ingrese la version de android del dispositivo: ');
      readln(android);
      if android <> 0 then begin
        write('Ingrese el tamaño de pantalla del dispositivo (en pulgadas): ');
        readln(size);
        write('Ingrese la cantidad de memoria RAM del dispositivo (en GB): ');
        readln(ram);
      end;
    end;
  end;

  procedure insertarOrdenado(var l: lDisp; d: disp);
  var
    ant,act,nue: lDisp;
  begin
    new(nue);
    nue^.dato := d;
    act := l;
    ant := l;
    while (act <> nil) and (d.android > act^.dato.android) do begin
      ant := act;
      act := act^.sig;
    end;
    if (act = ant) then 
      l := nue
    else
      ant^.sig := nue;
    nue^.sig := act;
  end;

var
  d: disp;
begin
  leerDisp(d);
  while d.android <> 0 do begin
    insertarOrdenado(l,d);
    leerDisp(d);
  end;
end;


//b. La cantidad de dispositivos con más de 3 GB de memoria y pantallas de a lo sumo a 5 pulgadas.
//c. El tamaño promedio de las pantallas de todos los dispositivos.

procedure procesarLista(l: lDisp);
var
  aux: lDisp; version,promSize: real; cant,cantTot,cumpleB: integer;
begin
  aux := l; promSize := 0; cumpleB := 0; cantTot := 0;
  // Aquí puedes agregar lógica para procesar la lista si es necesario
  while aux <> nil do begin
    cantTot := cantTot + 1;
    version := aux^.dato.android;
    cant := 0;
    while (aux <> nil) and (aux^.dato.android = version) do begin
      cant := cant +1;
      if (aux^.dato.ram > 3) and (aux^.dato.size <= 5) then
        cumpleB := cumpleB +1;
      promSize := promSize + aux^.dato.size;
      aux := aux^.sig;
    end;
    writeln(cant,' dispositivo/s poseen la version ',version:0:2,' de Android.');
  end;
  if cantTot > 0 then promSize := promSize / cantTot;
  writeln('La cantidad de dispositivos con mas de 3 GB de RAM y pantalla de a lo sump 5 pgd es: ',cumpleB);
  writeln('El tamaño promedio de las pantallas de todos los dispositivos es: ',promSize:0:2);
end;

{programa principal}
var
  pri: lDisp;
begin
  pri := nil;
  cargarLista(pri);
  procesarLista(pri);
end.







//-------------------------------------------------------------------------------------

{version para pruebas automatizadas}

program nombrePrograma;

uses
  sysUtils;

