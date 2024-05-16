
Program ejercicio1;

Var 
  num1, num2: integer;
Begin
  write('Ingresar un valor de numero: ');
  readln(num1);
  write('Ingresar otro valor: ');
  readln(num2);
  If (num1 < num2)
    Then
    writeln('El numero mayor es ', num2)
  Else
    If (num1 = num2)
      Then
      writeln('Los numeros leidos son iguales')
  Else
    writeln('El numero mayor es ', num1);
End.
