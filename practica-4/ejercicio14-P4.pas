program ejercicio13P4;

const
  dimF = 1000;
  dimF2 = 5;
  condicion = -1;

type
  str30 = string[30];
  rango = 1..dimF;
  rango2 = 1..dimF2;

  desarrolladores = record
    cod:  rango2;
    rol:  str30;
    vHora:  real;
  end;

  datos = record
    mInv: real;
    cantA: integer;
  end;

  participantes = record
    pais: str30;
    cod: integer;
    nomP: str30;
    rol: rango2;
    ht: integer;
  end;

  vDatos = array[rango] of datos; 
  vSalarios = array[rango2] of desarrolladores;

function invArg(hTrab: real; pais:str30; salario: real): real;
begin
  if pais = 'argentina' then
    invArg := hTrab * salario
  else
    invArg := 0; // Manejar el caso cuando pais no es 'argentina'
end;

function totAbd(hTrab: integer; rol: rango2): integer;
begin
  if rol = 3 then
    totAbd := hTrab
  else
    totAbd := 0; // Asegurar un valor de retorno por defecto
end;

function totArq(rol: rango2): integer;
begin
  if rol = 3 then
    totArq := 1
  else
    totArq := 0;
end;

procedure leerSalarios(var sal: desarrolladores);
begin
  write('Ingresar el código de desarrollador: ');
  readln(sal.cod);
  write('Ingresar el rol de desarrollador: ');
  readln(sal.rol);
  write('Ingresar el valor hora de desarrollador: ');
  readln(sal.vHora);
end;

procedure leerParticipante(var p: participantes);
begin
  writeln('Ingresar el código del proyecto en el que participó: ');
  readln(p.cod);
  if p.cod <> -1 then
  begin
    write('Ingresar el país del participante: ');
    readln(p.pais);
    write('Ingresar el rol de desarrollador: ');
    readln(p.rol);
    write('Ingresar la cantidad de horas trabajadas: ');
    readln(p.ht);
    write('Ingresar el nombre del proyecto en el que participó: ');
    readln(p.nomP);
  end;
end;

function obtenerMinimo(const d: vDatos): rango;
var
  i, minIndex: rango;
  minMonto: real;
begin
  minMonto := d[1].mInv;
  minIndex := 1;
  for i := 2 to dimF do
  begin
    if d[i].mInv < minMonto then
    begin
      minMonto := d[i].mInv;
      minIndex := i;
    end;
  end;
  obtenerMinimo := minIndex; // Devolver el índice del mínimo
end;

procedure cargarVecSal(var s: vSalarios);
var
  i: rango2;
begin
  for i := 1 to dimF2 do
  begin
    writeln('Ingrese el salario para el código ', i);
    leerSalarios(s[i]);  
  end;
end;

procedure inicializarVecDatos(var d: vDatos);
var
  i: rango;
begin
  for i := 1 to dimF do
  begin
    d[i].mInv := 0;
    d[i].cantA := 0;
  end;
end;

procedure imprimirArq(const d: vDatos);
var
  i: rango;
begin
  for i := 1 to dimF do
    writeln('El proyecto ', i, ' tiene ', d[i].cantA, ' arquitectos de software.');
end;

var
  s: vSalarios;
  d: vDatos;
  mInvArg: real;
  hTrabABD: integer;
  p: participantes;
  codMinProy: rango;

begin
  cargarVecSal(s);
  inicializarVecDatos(d);
  mInvArg := 0;
  hTrabABD := 0;
  leerParticipante(p);
  while (p.cod <> -1) do
  begin
    mInvArg := mInvArg + invArg(p.ht, p.pais, s[p.rol].vHora);
    hTrabABD := hTrabABD + totAbd(p.ht, p.rol);
    d[p.cod].mInv := d[p.cod].mInv + (p.ht * s[p.rol].vHora);
    d[p.cod].cantA := d[p.cod].cantA + totArq(p.rol);
    leerParticipante(p);
  end;
  codMinProy := obtenerMinimo(d);

  writeln('El monto total invertido en desarrolladores con residencia argentina es ', mInvArg);
  writeln('La cantidad total de horas trabajadas por Administradores de bases de datos es ', hTrabABD);
  writeln('El código del proyecto con menor monto invertido es ', codMinProy);

  imprimirArq(d);
end.
