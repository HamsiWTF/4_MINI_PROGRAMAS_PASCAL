PROGRAM Ahorcado;

USES
  CRT;
CONST
  INI = 1;
  ERRORES = 10;
  TOPE = 40;
TYPE
  TCadena = STRING [TOPE];
  TAyuda = ARRAY [INI..ERRORES] OF char;

PROCEDURE LeerCadena (VAR c: TCadena);
  VAR
   i: integer;
  BEGIN
    writeln ('Dame la cadena a ocultar');
    readln (c);
    FOR i:= 1 TO length(c) DO
      c[i] := UPCASE (c[i]);
  END; {LeerCadena para poner todos los caracteres en mayusculas}

PROCEDURE Ocultar (c: TCadena; VAR p: TCadena);
  VAR
   i: integer;
  BEGIN
   p := c;
   FOR i:= 1 TO length(p) DO
     IF c[i] = ' ' THEN
       p[i] := ' '
     ELSE
       p[i] := '-';
  END; {Ocultar la palabra a adivinar. Respeto los espacios en blanco que pueda haber}

PROCEDURE Mostrar (a: TAyuda; cont: integer);
 VAR
   i: integer;
 BEGIN
   FOR i:= INI TO cont DO
     write (a[i], ' ');
   writeln;
 END; {Mostrar el array de letras erroneas}

PROCEDURE Modificar (c: TCadena; l: char; VAR p: TCadena; VAR a: boolean);
 VAR
  i: integer;
 BEGIN
  a:= FALSE;
  FOR i:= INI TO length (c) DO
    IF (c[i] = l) THEN BEGIN
      a := TRUE;
      p[i] := l;
    END;
  END; {Modificar para introducir las letras acertadas en su lugar}

PROCEDURE Jugar;
 VAR
   cadena, palabra: TCadena;
   pistas: TAyuda;
   letra: char;  contador: integer;  acierto, victoria: boolean;
  BEGIN
    LeerCadena (cadena);
    CLRSCR;
    Ocultar (cadena, palabra);
    contador:= PRED(INI);
    REPEAT
      writeln ('Dame una letra');
      readln (letra);
      letra := UPCASE (letra);
      Modificar (cadena, letra, palabra, acierto);
      IF NOT acierto THEN BEGIN
         contador := SUCC (contador);
         pistas [contador] := letra;
         writeln ('Vuelve a intentarlo. Tienes ', contador, ' errores');
         writeln ('Ya has probado con...');
         Mostrar (pistas, contador);
      END;
      writeln (palabra);
      victoria := palabra = cadena;
    UNTIL (contador = ERRORES) OR (victoria);
    IF victoria THEN
      writeln ('Enhorabuena, has ganado')
    ELSE
      writeln ('Prueba otra vez. Lo siento, has perdido tras cometer ', contador, ' errores');
  END;

BEGIN {PP}
  Jugar;
  READKEY;
END.
