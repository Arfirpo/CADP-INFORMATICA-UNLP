Program ejercicio6P3;

Type 
  str20 = string[20];
  centrosDeInvestigacion = Record
    siglas: str20;
    uni: str20;
    invest: integer;
    bec: integer;
  End;

{compara, entre centros, las dos con menos becarios}
Procedure centMinBeca(nombre: str20; cantBec: integer; Var min1,min2: integer; Var minCentro1,minCentro2: str20);
Begin
  If cantBec < min1 Then
    Begin
      min2 := min1;
      minCentro2 := minCentro1;
      min1 := cantBec;
      minCentro1 := nombre;
    End
  else
    if cantBec < min2 Then
      Begin
        min2 := cantBec;
        minCentro2 := nombre;
      end;
End;

{compara entre universidades y devuelve la universidad con más investigadores}
Procedure uniMaxInvest(universidad: str20; cantInvest: integer; Var max1: integer; Var maxUni: str20);
Begin
  If cantInvest > max1 Then
    Begin
      max1 := cantInvest;
      maxUni := universidad;
    End
End;

{lee por teclado los datos del registro}
Procedure leerCentros(Var centro: centrosDeInvestigacion);
Begin
      write('Ingrese la cantidad de investigadores del centro: ');
      readln(centro.invest);
  If centro.invest <> 0 Then
    Begin
      write('Ingrese las siglas del centro: ');
      readln(centro.siglas);
      write('Ingrese la universidad a la que pertenece: ');
      readln(centro.uni);
      write('Ingrese la cantidad de becarios que posee el centro: ');
      readln(centro.bec);
    End;
End;

Var 
  centro: centrosDeInvestigacion;
  max,max1,min,min1,min2,cantInvest,cantCentros: integer;
  universidad,maxUni,minCentro1,minCentro2: str20;
Begin
  // SECTOR 1- ACA VAN TODAS LAS VARIABLES QUE SE USAN PARA CONTABILIZAR LOS TOTALES ENTRE TODOS LOS DATOS LEIDOS
  min1 := 9999;
  min2 := 9999;
  max1 := -1;
  minCentro1 := '';
  minCentro2 := '';
  maxUni := '';

  leerCentros(centro);


  While centro.invest <> 0 Do
    Begin
      universidad := centro.uni; //corte de control x universidad
       // SECTOR 2- ACA VAN TODAS LAS VARIABLES QUE SE DEBEN INICIALIZAR CUANDO CAMBIA DE UNIVERSIDAD (OSEA CUANDO TE PIDEN ALGO POR UNIVERSIDAD)
      cantCentros := 0;
      cantInvest := 0;


      // SECTOR 3- ACA SE VAN A ESTAR PROCESANDO TODOS LOS DATOS (EN ESTE CASO TODOS LOS MICROPROCESADORES)
      While (centro.uni = universidad) And (centro.invest <> 0) Do
        Begin
          cantCentros := cantCentros +1;
          cantInvest := cantInvest + centro.invest;
          centMinBeca(centro.siglas,centro.bec,min1,min2,minCentro1,minCentro2);
          leerCentros(centro);
        End;

      // SECTOR 4- ACA VA TODO LO QUE ME PIDEN ACTUALIZAR O INFORMAR POR UNIVERSIDAD
      writeln('La universidad ',universidad, ' tiene ',cantCentros,' centros de investigación en total');
      uniMaxInvest(universidad,cantInvest,max1,maxUni);
      
      
    End;


  // SECTOR 5- ACA INFORMO TODO LO QUE ME PIDEN EN GENERAL Y SIN QUE DEPENDA DEL CORTE DE CONTROL DE MARCA
  writeln('La universidad ',maxUni, ' es la que mayor numero de investigadores tiene en sus centros');
  writeln('Los dos centros con menor cantidad de becarios son: ',minCentro1,' y ',minCentro2);
End.
