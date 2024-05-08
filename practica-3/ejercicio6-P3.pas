Program ejercicio6P3;

Type 
  str20 = string[20];
  microprocesadores = Record
    marca: str20;
    linea: str20;
    cores: integer;
    velocidad: real;
    tamanioNan: integer;
  End;

{compara, entre marcas, las dos con mas cores}
Procedure maxMarcas(marca: str20; cores: integer; Var max1,max2: integer; Var maxMarca1,maxMarca2: str20);
Begin
  If cores > max1 Then
    Begin
      max2 := max1;
      maxMarca2 := maxMarca1;
      max1 := cores;
      maxMarca1 := marca;
    End
  else
    if cores > max2 Then
      Begin
        max2 := cores;
        maxMarca2 := marca;
      end;
End;

{compara, dentro de la marca, el procesador con mas cores}
Procedure maxCores(marca: str20; cores: integer; Var max: integer; Var maxMarca: str20);
Begin
  If cores > max Then
    Begin
      max := cores;
      maxMarca := marca;
    End
End;

{lee por teclado los datos del registro}
Procedure leerMicros(Var micro: microprocesadores);
Begin
      write('Ingrese la cantidad de cores del procesador: ');
      readln(micro.cores);
  If micro.cores <> 0 Then
    Begin
      write('Ingrese la marca del procesador: ');
      readln(micro.marca);
      write('Ingrese la linea del procesador: ');
      readln(micro.linea);
      write('Ingrese la velocidad del reloj: ');
      readln(micro.velocidad);
      write('Ingrese el tamanio en nanometros: ');
      readln(micro.tamanioNan);
    End;
End;

Var 
  micro: microprocesadores;
  max,max1,max2, cantPro: integer;
  maxMarca,maxMarca1,maxMarca2,marca: str20;
Begin
  // SECTOR 1- ACA VAN TODAS LAS VARIABLES QUE SE USAN PARA CONTABILIZAR LOS TOTALES ENTRE TODOS LOS DATOS LEIDOS
  max1 := -1;
  max2 := -1;
  maxMarca1 := '';
  maxMarca2 := '';
  leerMicros(micro);
  While micro.cores <> 0 Do
    Begin
      marca := micro.marca; //corte de control
       // SECTOR 2- ACA VAN TODAS LAS VARIABLES QUE SE DEBEN INICIALIZAR CUANDO CAMBIA DE MARCA (OSEA CUANDO TE PIDEN ALGO POR MARCA)
      cantPro := 0;
      max := -1;
      maxMarca := '';
      // SECTOR 3- ACA SE VAN A ESTAR PROCESANDO TODOS LOS DATOS (EN ESTE CASO TODOS LOS MICROPROCESADORES)
      While (micro.marca = marca) And (micro.cores <> 0) Do
        Begin
          if micro.tamanioNan = 14 then
            maxCores(micro.marca,micro.cores,max,maxMarca);
          if (micro.cores > 2) and (micro.tamanioNan <= 22) then
            writeln('El procesador de marca ',micro.marca, ' y linea ',micro.linea, ' posee transistores de a lo sumo 22nm');
          if ((micro.cores > 1) and ((micro.marca = 'amd') or (micro.marca = 'intel')) and (micro.velocidad >= 2)) then
            cantPro := cantPro+1;
          leerMicros(micro);
        End;
      // SECTOR 4- ACA VA TODO LO QUE ME PIDEN ACTUALIZAR O INFORMAR POR MARCA
      maxMarcas(maxMarca,max,max1,max2,maxMarca1,maxMarca2);
      if ((marca = 'amd') or (marca = 'intel')) then
        writeln('La cantidad de procesadores multicore de ',marca, ' cuyos relojes alcanzan velocidades de al menos 2Ghz, es: ',cantPro)
    End;
  // SECTOR 5- ACA INFORMO TODO LO QUE ME PIDEN EN GENERAL Y SIN QUE DEPENDA DEL CORTE DE CONTROL DE MARCA
  writeln('Las dos marcas con mayor cantidad de procesadores, con transistores de 14 nm son: ',maxMarca1,' y ',maxMarca2);
End.
