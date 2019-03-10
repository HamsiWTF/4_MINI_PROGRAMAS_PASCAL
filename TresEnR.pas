PROGRAM TresEnRaya;
USES
  CRT;
CONST
  INI = 1;
  FIN = 3;
TYPE
  TTablero = ARRAY [INI..FIN, INI..FIN] OF char;

PROCEDURE Inicializar (VAR t: TTablero);
VAR
 i, j: integer;
BEGIN
 FOR i:= INI TO FIN DO
  FOR j:= INI TO FIN DO
    t[i,j] := '-';
END;

PROCEDURE Mostrar (t: TTablero);
VAR
 i, j: integer;
BEGIN
 writeln;
 FOR i:= INI TO FIN DO BEGIN
  FOR j:= INI TO FIN DO
    write (t[i,j], ' ');
  writeln;
 END;
 writeln;
END;

PROCEDURE JugarM (VAR t: TTablero);
VAR
 i, j: integer;
 valido: boolean;
BEGIN
 REPEAT
   writeln ('Dame coordenadas validas y vacias');
   readln (i, j);
   valido := (i >= INI) AND (i <= FIN) AND (j >= INI) AND (j <= FIN) AND (t[i,j] = '-');
 UNTIL valido;
 t[i,j] := 'X';
END;

PROCEDURE JugarA (VAR t: TTablero);
VAR
 i, j: integer;
 valido: boolean;
BEGIN
 REPEAT
   i:= RANDOM (FIN) + 1;
   j:= RANDOM (FIN) + 1;
   valido := (t[i,j] = '-');
 UNTIL valido;
 t[i,j] := 'O';
END;

FUNCTION VerificarH (t: TTablero; ficha: char): boolean;
VAR
 i, j: integer;
 ok: boolean;
BEGIN
  i := INI;
 REPEAT
   j := INI;
   ok := TRUE;
   REPEAT
     ok := (t[i, j] = ficha);
     j := SUCC (j);
   UNTIL (j = FIN + 1) OR (NOT ok);
   i := SUCC(i);
  UNTIL ( i = FIN + 1) OR (ok);
 VerificarH := ok;
END;

FUNCTION VerificarV (t: TTablero; ficha: char): boolean;
VAR
 i, j: integer;
 ok: boolean;
BEGIN
  j := INI;
 REPEAT
   i := INI;
   ok := TRUE;
   REPEAT
     ok := (t[i, j] = ficha);
     i := SUCC (i);
   UNTIL (i = FIN + 1) OR (NOT ok);
   j := SUCC(j);
  UNTIL ( j = FIN + 1) OR (ok);
 VerificarV := ok;
END;

FUNCTION VerificarDD (t: TTablero; ficha: char): boolean;
VAR
 i, j: integer;
 ok: boolean;
BEGIN
  i := INI; j := INI; ok := TRUE;
   REPEAT
     ok := (t[i, j] = ficha);
     i := SUCC (i);
     j := SUCC (j);
   UNTIL (i = FIN + 1) OR (NOT ok);
  VerificarDD := ok;
END;

FUNCTION VerificarDI (t: TTablero; ficha: char): boolean;
VAR
 i, j: integer;
 ok: boolean;
BEGIN
  i := INI; j := FIN; ok := TRUE;
   REPEAT
     ok := (t[i, j] = ficha);
     i := SUCC (i);
     j := PRED (j);
   UNTIL (i = FIN + 1) OR (NOT ok);
  VerificarDI := ok;
END;


FUNCTION Verificar (t: TTablero; ficha: char): boolean;
BEGIN
  Verificar := VerificarH (t, ficha) OR VerificarV (t, ficha) OR VerificarDD (t, ficha) OR VerificarDI (t, ficha);
END;

PROCEDURE Juego;
VAR
 tablero: TTablero;
 jugadas: integer;
 victoria: boolean;
BEGIN
  jugadas := INI; victoria:= FALSE;
  Inicializar (tablero);
  Mostrar (tablero);
  REPEAT
    IF ODD (jugadas) THEN BEGIN
     JugarM (tablero);
     Mostrar (tablero);
       IF (jugadas >= FIN*FIN DIV 2) THEN BEGIN
         victoria := Verificar (tablero, 'X');
         IF victoria THEN
            writeln ('Enhorabuena, has ganado');
       END;
    END
    ELSE BEGIN
     JugarA (tablero);
     Mostrar (tablero);
       IF (jugadas >= FIN*FIN DIV 2) THEN BEGIN
         victoria := Verificar (tablero, 'O');
         IF victoria THEN
            writeln ('Vaya, te ha ganado la maquina');
       END;
    END;
    jugadas := SUCC(jugadas);
  UNTIL (jugadas > FIN*FIN) OR victoria;

  IF NOT victoria THEN
    writeln ('Tablas!');

END;

BEGIN
 Randomize;
 Juego;
 READKEY;
END.
