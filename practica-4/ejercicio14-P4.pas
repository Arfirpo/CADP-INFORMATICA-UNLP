program ejercicio13P4;
{
  https://github.dev/OmgCopito95/CADP/blob/main/A%C3%B1os/2023/Consultas%20Pr%C3%A1cticas/Viernes%205-5/project1.lpr

}

const
  dimF = 1000;      // cantidad de proyectos de software mas activos de 2017.
  dimF2 = 5;        // cantidad de desarrolladores de un proyecto de software.
  vH_Af = 35.20;    // valor hora analista funcional.
  vH_P = 27.45;     // valor hora programador.
  vH_Abd = 31.03;   // valor hora administrador de base de datos.
  vH_As = 44.28;    // valor hora arquitecto de software.
  vH_Ars = 39.87;   // valor hora administrador de redes y seguridad.
  condicion = -1;   //condicion para finalizar el programa.


type
  str30 = string[30];
  codigo = 1..1000;
  tipo = 1..dimF2;
  rangoProy = 1..dimF;
  rangoD = 1..5;

  vProyecto = array[rangoD] of participantes;  //vector de registros.
  vPro17 = array[rangoP] of vProyecto;         //vecotr de vectores.

  participantes = record
    pais: str30;
    cod: codigo;
    nomP: str30;
    rol: tipo;
    ht: real;
  end;

  arquis = record
    montoTotal: real;
    cantArquis: integer;
  end;

{modulos}


  {programa principal}
  var
    
  begin
    
  end.

  {--------------------------------------------------------------------------------}

  {14- El repositorio de código fuente más grande en la actualidad, GitHub, desea estimar el monto invertido en
los proyectos que aloja. Para ello, dispone de una tabla con información de los desarrolladores que
participan en un proyecto de software, junto al valor promedio que se paga por hora de trabajo:
CÓDIGO ROL DEL DESARROLLADOR VALOR/HORA (USD)
1 Analista Funcional 35,20
2 Programador 27,45
3 Administrador de bases de datos 31,03
4 Arquitecto de software 44,28
5 Administrador de redes y seguridad 39,87
Nota: los valores/hora se incluyen a modo de ejemplo
Realizar un programa que procese la información de los desarrolladores que participaron en los 1000
proyectos de software más activos durante el año 2017. De cada participante se conoce su país de
residencia, código de proyecto (1 a 1000), el nombre del proyecto en el que participó, el rol que cumplió en
dicho proyecto (1 a 5) y la cantidad de horas trabajadas. La lectura finaliza al ingresar el código de proyecto
-1, que no debe procesarse. Al finalizar la lectura, el programa debe informar:
a) El monto total invertido en desarrolladores con residencia en Argentina.
b) La cantidad total de horas trabajadas por Administradores de bases de datos.
c) El código del proyecto con menor monto invertido.
d) La cantidad de Arquitectos de software de cada proyecto.}

program project1;

const
  cantProy = 1000;

type
  rangoVec = 1..5;
  rangoProy = 1..cantProy;
  cadena20 = string[20];

  desarrollador = record
    cod: rangoVec;
    rol: cadena20;
    valor_hora: real;
  end;

  participante = record
    paisRes: cadena20;
    codProy: rangoProy;
    nomProy: cadena20;
    rolCumplido: rangoVec;
    cantHorasTrab: integer;
  end;

  vec_desarrolladores = array[rangoVec] of desarrollador; // vector que almacena roles y tarifas por hora

  info = record
    montoTotal: real;
    cantArquitectos: integer;
  end;

  vectorProyectos = array[rangoProy] of info; // vector de proyectos que almacena monto total y cantidad de arquitectos



{modulos}
procedure inicializarVectorDeProyectos(var vp: vectorProyectos);
var
    i: rangoProy;
begin
    for i := 1 to cantProy do
    begin
        vp[i].montoTotal := 0;
        vp[i].cantArquitectos := 0;
    end;
end;

function arqSoftware(rol: rangoVec): integer;
begin
  if (rol = 4) then
    arqSoftware := 1
  else
    arqSoftware := 0;
end;

function adminBDHs(rol: rangoVec; horas: integer): integer;
begin
    if (rol = 3) then
        adminBDHs := horas
    else
        adminBDHs := 0;
end;

function invertidoArg(pais: cadena20; horas: integer; valorHora: real): real;
begin
    if (pais = 'ARGENTINA') then
        invertidoArg := horas * valorHora
    else
        invertidoArg := 0;
end;

procedure leerParticipante(var p: participante);
begin
    with p do
    begin
        writeln('CODIGO DEL PROYECTO:');
        readln(codProy);
        if (codProy <> -1) then
        begin
            writeln('PAIS DE RESIDENCIA:');
            readln(paisRes);
            writeln('NOMBRE DEL PROYECTO:');
            readln(nomProy);
            writeln('ROL:');
            readln(rolCumplido);
            writeln('HORAS TRABAJADAS:');
            readln(cantHorasTrab);
        end;
    end;
end;

function obtenerMinimo(vp: vectorProyectos): rangoProy;
var
    i, minIndex: rangoProy;
    minMonto: real;
begin
    minMonto := vp[1].montoTotal;
    minIndex := 1;
    for i := 2 to cantProy do
    begin
        if vp[i].montoTotal < minMonto then
        begin
            minMonto := vp[i].montoTotal;
            minIndex := i;
        end;
    end;
    obtenerMinimo := minIndex;
end;

procedure imprimirCantidadArquitectos(vp: vectorProyectos);
var
  i: rangoProy;
begin
  for i := 1 to cantProy do
    writeln('Proyecto ', i, ' tiene ', vp[i].cantArquitectos, ' arquitectos de software.');
end;

var
  vD: vec_desarrolladores;
  vP: vectorProyectos;
  totalAdminBD: integer;
  montoTotalArg: real;
  p: participante;
  codMinProy: rangoProy;

begin
  inicializarVectorDeProyectos(vP);
  totalAdminBD := 0;
  montoTotalArg := 0;

  leerParticipante(p);
  while (p.codProy <> -1) do
    begin
      // a) El monto total invertido en desarrolladores con residencia en Argentina.
      montoTotalArg := montoTotalArg + invertidoArg(p.paisRes, p.cantHorasTrab, vD[p.rolCumplido].valor_hora);
      // b) La cantidad total de horas trabajadas por Administradores de bases de datos.
      totalAdminBD := totalAdminBD + adminBDHs(p.rolCumplido, p.cantHorasTrab);
      // c) El código del proyecto con menor monto invertido.
      vP[p.codProy].montoTotal := vP[p.codProy].montoTotal + (p.cantHorasTrab * vD[p.rolCumplido].valor_hora);
      // d) La cantidad de Arquitectos de software de cada proyecto.
      vP[p.codProy].cantArquitectos := vP[p.codProy].cantArquitectos + arqSoftware(p.rolCumplido);
      leerParticipante(p); // Leer el siguiente participante
    end;

  // c) Determinar el proyecto con el menor monto invertido.
  codMinProy := obtenerMinimo(vP);

  // Mostrar resultados
  writeln('El monto total invertido en desarrolladores con residencia en Argentina es: $', montoTotalArg:6:2);
  writeln('Total de horas trabajadas por Administradores de bases de datos: ', totalAdminBD);
  writeln('El código del proyecto con menor monto invertido es: ', codMinProy);

  // d) Imprimir la cantidad de arquitectos de software para cada proyecto.
  imprimirCantidadArquitectos(vP);
end.
