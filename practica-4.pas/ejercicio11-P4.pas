program ejercicio11P4;

{constantes globales}

dimF = 200   //cantidad total de fotos publicadas en ArgenPics.

{tipos de datos definidos por el programador}

type
  {subrangos}
  rango = 1..dimF;       //defino un subrango acotando los valores de integers de 1 a la 200 (dim. fisica).
  str30 = string[30];   //subrango acotando cadenas de string a 30 caracteres.
  
  {registros}
  foto = record         //creo un registro "foto" para almacenar los datos de cada foto a procesar.
    tit: str30;
    aut: str30;
    mgs: integer;
    clicks: integer;
    com: integer;
  end;

  {vectores}
  vFotos = array[rango] of foto;  //vector que almacena registros de tipo foto.

{modulos}

//Procedimiento que recibe un registro tipo foto vacio y lo devuelve con los campos cargados.
procedure leerFoto(var pic: vFotos; i: integer);            
begin
  write('Ingrese titulo de la foto: ');
  readln(pic[i].tit);
  write('Ingrese autor de la foto: ');
  readln(pic[i].aut);
  write('Ingrese cantidad de "Me gusta" de la foto: ');
  readln(pic[i].mgs);
  write('Ingrese cantidad de clicks de la foto: ');
  readln(pic[i].clicks);
  write('Ingrese cantidad de comentarios de la foto: ');
  readln(pic[i].com);
end;

//Procedimiento que recibe un vector "vFotos" vacio y, mediante una estructura for, lo carga hasta el total de la dim. Fisica con registros tipo foto.
procedure cargarVector(var pic: vFotos);
var
  i: rango;
begin
  for i := 1 to dimF do
    leerFoto(pic,i);
end;

procedure masVista(clicks: integer; titulo: str30; var max: integer; var maxTit: str30);
begin
  if clicks > max then
    begin
      max := clicks;
      maxTit := titulo;
    end;    
end;

procedure recorrerVector(pic: vFotos);
var
  i: rango;
  max, cantMg: integer;
  maxTit: string;
begin
  max := -1;
  maxTit := '';
  for i := 1 to dimF do
    begin
      //a.calcula cant. de clicks de cada foto y devuelve el titulo de la foto mas vista;
      masVista(pic[i].clicks,pic[i].tit,max,maxTit);
      //b.si el autor de la foto es igual al buscado, sumamos +1 al contador de me gustas.   
      if (pic[i].aut = 'art vandelay') then
        cantMg := cantMg +1;
      //c. ¿deberia usar un vector contador?
    end;
end;



{programa principal}
var
  pic: vFotos;
begin
  cargarVector(pic);
  recorrerVector(pic);
end;