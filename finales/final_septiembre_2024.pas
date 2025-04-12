{
1) Una empresa dispone de la información de las asistencias de sus empleados durante un periodo de tiempo. De cada empleado se conoce: dni, apellido y nombre, codigo de departamento en el que trabaja (entre 1 y 100), fecha y si estuvo presente o no ese dia (no todos los dias se pasa asistecia y los empleados pueden haber estado trabajando o haber faltado). ESTA ESTRUCTURA SE ENCUENTRA ORDENADA POR CÓDIGo DE DEPARTAMENTO. Se pide realizar un programa que informe el departamento con mas empleados presentes durante el período evaluado por la empresa
}

program ejercicio1;

const max_deptos = 100;

type
  rango_deptos = 1..max_deptos;

  Fecha = record
    dia: 1..31;
    mes: 1..12;
    anio: 1925..2025;
  end;

  empleado = record
    dni: integer;
    apeYnom: String[20];
    cod_Depto: rango_deptos;
  end;

  asistencia = record
    emp: empleado;
    fecha: Fecha;
    presente: boolean;
  end;

  lAsistencia = ^nAsistencia;

  nAsistencia = record
    dato: asistencia;
    sig: lAsistencia;
  end;

{modulos}

  procedure leerFecha(var f: Fecha);
  begin
    with f do begin
      write('Dia: '); readln(dia);      
      write('Mes: '); readln(mes);      
      write('Anio: '); readln(anio);      
    end;
  end;

  procedure generarLista(var l: lAsistencia);
  var a: asistencia;
  begin
    // se dispone
  end;

  procedure procesarLista(l: lAsistencia);


    procedure actualizarMaximo(cant_presente: integer; var max_presente: integer; cod_act: rango_deptos; var max_cod);
    begin
      //seguir aca
    end;

  var 
    fIni,fFin: Fecha;
    cant_presente,max_presente: Integer;
    cod_act: rango_deptos;
    max_cod: integer;
  begin
    Writeln('Ingrese fecha de inicio (Periodo de asistencias): '); leerFecha(fIni);
    Writeln('Ingrese fecha de final (Periodo de asistencias): ');
    leerFecha(fFin);
    max_cod := -1;
    while(l <> Nil) do begin
      cod_act: l^.dato.emp.cod_Depto;
      cant_presente := 0;
      while(l <> nil) and (l^.dato.emp.cod_Depto = cod_act) do begin
        if((((l^.dato.fecha.anio >= fIni.anio) and (l^.dato.fecha.anio <= fFin.anio)) and ((l^.dato.fecha.mes >= fIni.mes) and (l^.dato.fecha.mes <= fFin.mes)) and ((l^.dato.fecha.dia >= fIni.dia) and (l^.dato.fecha.dia <= fFin.dia))) and (l^.dato.presente)) then begin
          cant_presente := cant_presente + 1;
        end;
      end;
      actualizarMaximo(cant_presente,max_presente,cod_act,max_cod);
    end;
  end;





{programa principal}
var
  pri: lAsistencia;
begin
  pri := nil;
  generarLista(pri);
  procesarLista(pri);
End.