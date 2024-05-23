{Nota: el programa esta CORREGIDO, los errores se destacan en comentario al lado de la linea de codigo donde estaba dicho error.}

program ejercicio2P6;

type
  
  lista = ^nodo;

  persona = record
    dni: Longint;
    nom: string;
    ape: string;
  end;

  nodo = record
    dato: persona;
    sig: lista;
  end;

{modulos}

procedure leerPersona(var p: persona); //1.-El registro persona debe pasarse por referencia (var) porque se busca modificarlo ingresando datos a sus campos.
begin
  write('Ingrese Dni: ');
  readln(p.dni);
  if p.dni <> 0 then
  begin
    write('Ingrese nombre: ');
    readln(p.nom);
    write('Ingrese apellido: ');
    readln(p.ape);
  end;
end;

procedure agregarAdelante(var l: lista; p: persona); //2.- Este proceso CREA los nodos, por lo tanto la lista debe pasarse por referencia para ser modificada.
var
  aux: lista;
begin
  new(aux);  //3.- Faltaba el new. Debe pedirse un espacio en memoria para la variable auxiliar antes de modificar la lista.
  aux^.dato := p;
  aux^.sig := l;
  l := aux;
end;

procedure generarLista(var L: lista);
var
  p: persona; //4.- el tipo era "nodo" y debe ser tipo "persona" (que es el registro que luego completara el proceso leerPersona).
begin
  leerPersona(p);
  while(p.dni <> 0) do
  begin
    agregarAdelante(l,p);
    leerPersona(p);  //5.-Faltaba el proceso. Una vez que agregamos un registro persona en un nodo, se debe leer otro registro para continuar la ejecución del while.
  end;
end;

procedure imprimirInformacion(l: lista); 
{6.- Se elimino el "var" al lado del parametro tipo lista. Si vamos a recorrer una lista y no queremos modificar sus nodos,
corresponde recorrer una "copia" (pasar por valor la lista)}

begin
  while l <> nil do
  begin
    writeln('DNI: ',l^.dato.dni,'. Nombre: ',l^.dato.nom,'. Apellido: ',l^.dato.ape,'. '); 
    //7 y 8.- Se modifico: "l^.nombre" y "l^.apellido". Para acceder correctamente a esos datos del registro persona debe consignarse: "l^.dato.nombre" y "l^.dato.apellido".
    l := l^.sig;
  end;
end;

{programa principal}

var
  l: lista;
begin
  l := nil;  //9.- Faltaba inicialización de lista.
  generarLista(l);
  imprimirInformacion(l);
end.
