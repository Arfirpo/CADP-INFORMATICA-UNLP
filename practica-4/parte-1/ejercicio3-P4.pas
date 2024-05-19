Program ejercicio3P4;

const
  dimF = 8;

Type 
  vNum = array [1..dimF] of integer;


{procedimiento para cargar el vector numerico}
procedure cargarVector(var v: vNum; var dimL: integer);
Var
  num: integer;
  i: integer;
Begin
  dimL := 0;
  for i := 1 to dimF do
    begin
      write('Ingrese un numero: ');
      read(num);
      v[i] := num;
      dimL := diml +1;
    end;
end;

{procedimiento para cargar variables X e Y}
procedure cargarXY(var x,y: integer);
begin
  write('Ingrese la posicion X: ');
  readln(x);
  write('Ingrese la posicion Y: ');
  readln(y);
  writeln('X vale: ',x,' e Y vale: ',y);
end;

{a. procedimiento para imprimir el vector completo}
procedure imprimirTot(v: vNum);
Var
  i: integer;
Begin
  for i := 1 to dimF do
    write(v[i],' ');
    writeln(' ');
end;


{b. procedimiento para imprimir el vector completo, del ultimo al primero}
procedure imprimirTotInv(v: vNum);
var
  i: integer;
begin
  for i := dimF downto 1 do
    write(v[i],' ');
  writeln(); 
end;

{c. procedimiento para imprimir el vector desde la mitad, hasta la primer posicion}
{c. procedimiento para imprimir el vector desde la mitad + 1, hasta la ultima posicion}
procedure imprimirMid(v: vNum; dimL: integer);
var
  i: integer;
begin
  for i:= (dimL div 2) downto 1 do
    write(v[i],' ');
  writeln();

  for i:= ((diml div 2) + 1) to dimL do
    write(v[i],' ');
    writeln(); 
end;


{d. procedimiento para imprimir el vector desde x hasta y, o desde y hasta x}
procedure imprimirXY(v: vNum;x,y: integer);
var
  i: integer;
begin
  cargarXY(x,y);
  if x < y then
      for i:= x to y do
      begin
        write(v[i],' ');        
      end
  else 
    if x > y then
      for i:= x downto y do
        begin
          write(v[i],' ');
        end;
  writeln();
end;

{e. utilizando el modulo del inciso d. para rehacer los incisos a., b. y c.}
procedure imprimirXYplus1(v: vNum; dimL,x,y: integer);
var
  i: integer;
begin
  x := 1;
  y := dimL;
  {ejercicio a. rehecho}
  for i:= x to y do
    begin
      write(v[i],' ');        
    end;

  writeln();

  {ejercicio b. rehecho}
  for i:= y downto x do
    begin
      write(v[i],' ');
    end;

  writeln();

  {ejercicio c. rehecho}
  for i:= (y div 2){}ghjk mn 0 1 downto x do
    begin
      write(v[i],' ');
    end;

  writeln();

  for i:= ((y div 2) + x) to y do
    write(v[i],' ');
    writeln();  
end;



{programa principal}
Var 
  dimL,x,y: integer;
  v: vNum;
Begin
  dimL := 0;
  x := 0;
  y := 0;
  cargarVector(v,dimL);
  imprimirTot(v);               //3.a
  imprimirTotInv(v);            //3.b
  imprimirMid(v,dimL);          //3.c
  imprimirXY(v,x,y);            //3.d
  imprimirXYplus1(v,dimL,x,y)   //3.e
End.