PROGRAM super_calculadora;
USES
  CRT;

FUNCTION Suma(n1,n2:real):real;
 BEGIN
   Suma:= n1+n2;
 END;


FUNCTION Resta(n1,n2:real):real;
 BEGIN
   Resta:= n1-n2;
 END;


FUNCTION Multiplicacion(n1,n2:real):real;
 BEGIN
   Multiplicacion:= n1*n2;
 END;

FUNCTION Divisor(n:real):real;
 BEGIN
    WHILE (n=0) DO BEGIN
      writeln ('Proporcione un numero distinto de 0');
      readln (n);
    END;
    Divisor:=n;
 END;

FUNCTION Division(n1,n2:real):real;
 BEGIN
   n2:= Divisor(n2);
   Division := n1/n2;
 END;

FUNCTION Potencia(n1,n2:real):real;
 VAR
   aux:real;
 BEGIN
   aux:=1;
   WHILE (n2 > 0) DO BEGIN
     aux:= aux * n1;
     n2:=  n2-1;
   END;
   Potencia:= aux;
 END;

FUNCTION MultiplicacionRusa (n1, n2: longInt): longInt;
 VAR
   aux: longInt;
 BEGIN
   aux:= 0;
   WHILE (n2 <> 0) DO BEGIN
      IF ODD (n2) THEN
        aux:= aux + n1;
      n1 := n1 * 2;
      n2 := n2 DIV 2;
   END;
   MultiplicacionRusa:=aux;
 END;

FUNCTION OperacionValida (l: char): boolean;
 BEGIN
   OperacionValida := (l = '+') OR (l =  '-') OR (l = '*') OR (l = '/') OR (l = 'P') OR (l = 'M');
 END;

FUNCTION OperacionARealizar: char;
 VAR
   aux: char;   valido: boolean;
 BEGIN
   REPEAT
     writeln ('Podras sumar, restar, multiplicar, dividir, elevar o calcular la multiplicacion rusa');
     writeln ('Introduciendo +, -, *, /, p, m');
     readln (aux);
     aux:= UPCASE (aux);
   UNTIL OperacionValida (aux);
   OperacionARealizar := aux;
 END;

FUNCTION Calculadora(n1, n2:real): real;
 VAR
   r: real;
   letra: char;
 BEGIN
    letra:= OperacionARealizar;
    CASE letra OF
       '+': r:= Suma (n1,n2);
       '-': r:= Resta (n1,n2);
       '*': r:= Multiplicacion (n1,n2);
       '/': r:= Division (n1,n2);
       'P': r:= Potencia (n1,n2);
       'M': r:= MultiplicacionRusa(ROUND(n1),ROUND(n2));
     END; {CASE}
   Calculadora := r;
 END;

PROCEDURE LeerDosNumeros (VAR n1, n2: real);
 BEGIN
    writeln ('Proporcione dos numeros');
    readln (n1, n2);
 END;

FUNCTION LeerUnNumero: real;
VAR
   n: real;
 BEGIN
    writeln ('Proporcione el segundo operando');
    readln (n);
    LeerUnNumero:=n;
 END;

PROCEDURE MensajeBienvenida;
 BEGIN
   writeln ('Bienvenido a nuestra calculadora');
   writeln ('Pulse 0 para usarla. Otra tecla servira para salir');
 END;

PROCEDURE MensajeContinuar;
 BEGIN
   writeln ('Desea seguir operando?');
   writeln ('Pulse 1 para conservar el resultado o 2 para resetear la calculadora');
   writeln ('Cualquier otra tecla servira para salir');
 END;

PROCEDURE Menu;
 VAR
   final, opcion : integer;
   numero1, numero2, resultado:real;
   salir, seguir : boolean;
 BEGIN
   MensajeBienvenida;
   readln (final);
   salir := final <> 0;
   WHILE (NOT salir) DO BEGIN
      LeerDosNumeros(numero1, numero2);
      resultado := Calculadora (numero1, numero2);
      writeln (resultado:0:2);
       REPEAT
         MensajeContinuar;
         readln (opcion);
         seguir := (opcion = 1) OR (opcion = 2);
         CASE opcion OF
           1: resultado := Calculadora (resultado, LeerUnNumero);
           2: BEGIN
               LeerDosNumeros(numero1, numero2);
               resultado := Calculadora (numero1, numero2);
              END
           ELSE
              salir := NOT seguir;
         END; {case}
         IF NOT salir THEN
           writeln (resultado:0:2);
       UNTIL (NOT seguir);
   END;{WHILE}
   writeln ('Hasta pronto');
 END; {Menu}

BEGIN {PP}
  Menu;
  READKEY;
END.
