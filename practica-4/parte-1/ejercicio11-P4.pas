program ejercicio11P4;

{constantes globales}
const
    dimF = 4;   //cantidad total de fotos publicadas en ArgenPics.

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
  vComent = array[rango] of integer;  //vector que almacena cantidad de comentarios de cada foto.

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

{Procedimiento que recibe dos vectores: "pic"(registros) y c(contador) vacios y mediante una estructura for 
se carga el primero y se inicializa el segundo en cero, hasta el total de la dim. Fisica.}

procedure cargEinicVector(var pic: vFotos; var c: vComent);
var
  i: rango;
begin
  for i := 1 to dimF do
    begin
      leerFoto(pic,i);            //cargo por indice el vector de registros.
      c[i] := 0;                  //cargo por indice el vector contador.
    end;
end;

procedure masVista(clicks: integer; titulo: str30; var max: integer; var maxTit: str30);
begin
  if clicks > max then
    begin
      max := clicks;
      maxTit := titulo;
    end;    
end;

procedure recorrerVector(pic: vFotos; var c: vComent; var cantMg, max: integer; var maxTit: str30);
var
  i: rango;
begin  
  for i := 1 to dimF do
    begin
      //a.calcula cant. de clicks de cada foto y devuelve el titulo de la foto mas vista;
      masVista(pic[i].clicks,pic[i].tit,max,maxTit);
      //b.si el autor de la foto es igual al buscado, sumamos +1 al contador de me gustas.   
      if (pic[i].aut = 'art vandelay') then
        cantMg := cantMg + pic[i].mgs;
      //c. voy asignandole al vector contador, por indice, la cantidad de comentarios de cada registro foto.
      c[i] := pic[i].com;
    end;
end;

procedure informarVector(pic: vFotos; c: vComent; cantMg: integer; maxTit: str30);
var
  i: integer;
begin
  writeln('la foto mas vista de la pagina es "',maxTit,'"');
  writeln('Las fotos del autor Art Vandelay tuvieron un total de ',cantMg,' Me gusta');
  for i := 1 to dimF do
    writeln('La foto "', pic[i].tit,'" tuvo ',c[i],' comentarios');
end;

{programa principal}
var
  pic: vFotos;
  c: vComent;
  cantMg: integer;
  max: integer;
  maxTit: string;
begin
  max := -1;
  maxTit := '';
  cantMg := 0;
  cargEinicVector(pic,c);
  recorrerVector(pic,c,cantMg,max,maxTit);
  informarVector(pic,c,cantMg,maxTit);
end.