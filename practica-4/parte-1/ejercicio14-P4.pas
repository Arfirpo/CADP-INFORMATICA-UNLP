program ejercicio13P4;
{
  https://github.dev/OmgCopito95/CADP/blob/main/A%C3%B1os/2023/Consultas%20Pr%C3%A1cticas/Viernes%205-5/project1.lpr

}

const
  dimF = 1000;      // cantidad de proyectos de software mas activos de 2017
  vH_Af = 35.20;    // valor hora analista funcional.
  vH_P = 27.45;     // valor hora programador
  vH_Abd = 31.03;   // valor hora administrador de base de datos.
  vH_As = 44.28;    // valor hora arquitecto de software.
  vH_Ars = 39.87;   // valor hora administrador de redes y seguridad.
  condicion = -1;   //condicion para finalizar el programa.

type
  str30 = string[30];
  codigo = 1..1000;
  tipo = 1..5;

  desarrollador = record
    pais: str30;
    cod: codigo;
    nomP: str30;
    rol: tipo;
    ht: real;

  end;

{modulos}


  {programa principal}
  var
    
  begin
    
  end.