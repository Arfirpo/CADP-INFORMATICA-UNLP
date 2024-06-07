program nombrePrograma;

const
  dimF_generos = 5;

type
{subrangos}
  rango_g = 1..dimF_generos;
  str30 = string[30];

  lSessions = ^nSessions;

  session = record
    tit: str30;
    nArt: str30;
    gen: rango_g;
    estAnio: integer;
    cantRep: longint;
  end;

  nSessions = record
    dato: session;
    sig: lSessions;
  end;

  genero = record
    cod: rango_g;
    cantRepro: longint;
  end;

  vGeneros = array[rango_g] of genero;

{modulos}
procedure inicializarV(var vC: vCont);
var
  i: rango_g;
begin
  for i := 1 to dimF_generos do begin
    vC[i].cod := i;
    vC[i].cantRep := 0;
  end;
end;

procedure generarListaS(var l: lSessions);
begin
  // se dispone
end;



function cumpleB(genero: rango_g; reproducciones: longint ):boolean;

  function digM5(rep: longint):boolean;
  var
    dig,cantDig: integer;
  begin

    cantDig := 0:
    while rep <> 0 do begin
      dig := rep mod 10;
      cantDig := cantDig + dig;
      rep := rep div 10;
    end;

    digM5 := (cantDig mod 5 = 0);
  end;

begin
  cumpleB := ((genero = 1) or (genero = 3)) and (digM5(reproducciones));
end;

procedure insertarOrdenado(var l: lSessions; s: session);
var
  nue,ant,act: lSessions;
begin
  new(nue);
  nue^.dato := s;
  ant := l;
  act := l;
  while (l <> nil) and (s.estAnio > l^.dato.estAnio) do begin
    ant := act;
    act := act^.sig;
  end;
  if (act = ant) then
    l := nue
  else
    ant^.sig := nue;
  nue^.sig := act;
end;

procedure procesarLS(l: lSessions; var l2: lSessions; var vC: vCont);
var
  genMin1,genMin2: rango_g;
begin
  genMin1 := 0; genMin2 := 0;
  while (l <> nil) do begin
    
    vC[l^.dato.gen].cantRep := vC[l^.dato.gen].cantRep + l^.dato.cantRep;

    if(cumpleB(l^.dato.gen,l^.dato.cantRep)) then
      insertarOrdenado(l2,l^.dato);
    l := l^.sig;
  end;
end;





{p. Principal}
var
  pri,pri2: lSessions;
  vC: vCont;

begin
  pri := nil; pri2 := nil;
  inicializarV(vC);
  generarListaS(pri); //se dispone
  procesarLS(pri,pri2,vC);
  procesarL2(pri2);
end.
