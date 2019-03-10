PROGRAM ejercicio;

CONST
 INI = 1;
 FIN = 7;

TYPE
 TLista = ARRAY [INI..FIN] OF integer;

VAR
 lista: TLista;
 aux: integer;

PROCEDURE Inicializar (VAR v: TLista);
VAR
 i: integer;
BEGIN
 FOR i:= INI TO FIN DO
   v[i] := 0;
END;

PROCEDURE Mostrar (v: TLista);
VAR
 i: integer;
BEGIN
 FOR i:= INI TO FIN DO
   write (v[i], ' ');
 writeln;
END;

FUNCTION Verificar (v: TLista; n: integer): boolean;
VAR
 i: integer; aux: boolean;
BEGIN
   i := 0; {PRED (INI);}
 REPEAT
   i := SUCC (i);
   aux:= v[i] = n;
 UNTIL (aux {= TRUE}) OR (v[i] = 0) OR (i = FIN);
 Verificar := aux;
END;

PROCEDURE RellenarAutomatico (VAR v: TLista);
VAR
  i, aux: integer;
BEGIN
  i := INI;
  REPEAT
   aux := RANDOM (49) + 1;
   IF (NOT Verificar(v, aux)) THEN BEGIN
     v[i] := aux;
     i := SUCC (i);
   END;
  UNTIL (i = FIN+1);
END;

PROCEDURE RellenarManual (VAR v: TLista);
VAR
  i, aux: integer;
  valido: boolean;
BEGIN
  i := INI;
  REPEAT
   writeln ('Dame el numero ', i);
   readln (aux);
   valido := (aux > 0) AND (aux < 50);
   IF (valido) AND (NOT Verificar(v, aux)) THEN BEGIN
     v[i] := aux;
     i := SUCC (i);
   END;
  UNTIL (i = FIN+1);
END;

PROCEDURE Ordenar (VAR v: TLista);
VAR
  i, j, aux: integer;
BEGIN
  FOR i:= INI TO FIN - 1 DO
    FOR j := INI TO (FIN - i)  DO
      IF (v[j] > v[j+1]) THEN BEGIN
         aux := v [j + 1];
         v [j + 1] := v [j];
         v [j] := aux;
      END;
END;

FUNCTION BusquedaBinaria (v: TLista; n: integer): boolean;
VAR
   extremoInferior, extremoSuperior, centro: integer;
   aux: boolean;
BEGIN
   extremoInferior := INI; extremoSuperior := FIN; aux := FALSE;
   WHILE (NOT aux) AND (extremoSuperior >= extremoInferior) DO BEGIN
      centro := (extremoSuperior + extremoInferior) DIV 2;
      IF  v[centro] = n THEN
         aux := TRUE
      ELSE
         IF  v[centro] < n THEN
             extremoInferior := SUCC(centro)
         ELSE
             extremoSuperior := PRED(centro);
   END; {WHILE}
   BusquedaBinaria := aux;
END; {BusquedaBinaria}

FUNCTION ContarAciertos (v, l : TLista): integer;
VAR
  aux, i: integer;

BEGIN
  aux := 0;
  FOR i:= INI TO FIN DO BEGIN
     IF Verificar (v, l [i]) THEN
       aux := SUCC(aux);
  END;
  ContarAciertos := aux;
END;

PROCEDURE CelebrarSorteo (VAR v: TLista);
BEGIN
 RellenarAutomatico (v);
 Ordenar (v);
END;

PROCEDURE Menu;
VAR
 apuesta, sorteo: TLista;
 opcion: char;
BEGIN
 writeln ('Bienvenido a la loteria primitiva');
 writeln ('Si desea hacer una apuesta manual, pulse 1, si desea hacerla aleatoria, pulse 2');
 readln (opcion);
 CASE opcion OF
  '1': RellenarManual (apuesta);
  '2': RellenarAutomatico (apuesta)
 ELSE
    writeln ('Opcion no valida');
 END; {CASE}
 Ordenar (apuesta);
 Mostrar (apuesta);
 CelebrarSorteo (sorteo);
 Mostrar (sorteo);
 Writeln (ContarAciertos(apuesta, sorteo));
 END;

BEGIN
 Randomize;
 Menu;
 readln;
END.
