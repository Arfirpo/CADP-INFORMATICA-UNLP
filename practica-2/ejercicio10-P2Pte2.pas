program ejercicio10P2Pte2;

function esVocal(c: char): boolean;
begin
  esVocal := (c = 'a') or (c = 'A') or (c = 'e') or (c = 'E') or (c = 'i') or (c = 'I') or (c = 'o') or (c = 'O') or (c = 'u') or (c = 'U');
end;

function esAlfabetico(c: char): boolean;
begin
  esAlfabetico := (c in ['A'..'Z']) or (c in ['a'..'z']);
end;

procedure cumpleA(var cumpleA: boolean);
var
  c: char;
begin
  writeln('Ingrese la secuencia A:');
  readln(c);
  while (c <> '$') and (cumpleA) do 
  begin
    if not esVocal(c) then
      cumpleA := false
    else begin
      writeln('Ingrese la secuencia A:');
      readln(c);  
    end;
  end;
end;

procedure cumpleB(var cumpleB: boolean);
var
  c: char;
begin
  writeln('Ingrese la secuencia B:');
  readln(c);
  while (c <> '#') and (cumpleB) do 
  begin
    if esVocal(c) or not esAlfabetico(c) then
      cumpleB := false;
    if cumpleB then
    begin
      writeln('Ingrese la secuencia B:');
      readln(c);  
    end;
  end;
end;

var
  cumple: boolean;
begin
  cumple := true;
  cumpleA(cumple);
  if cumple then 
  begin
    cumpleB(cumple);
    if cumple then
      writeln('Se cumple con la secuencia')
    else
      writeln('No se cumple con la secuencia B');
  end
  else
    writeln('No se cumple la secuencia A');
end.