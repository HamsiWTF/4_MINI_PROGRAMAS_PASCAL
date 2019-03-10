PROGRAM Calculadora;
VAR
    numero1, numero2, selector: integer;

FUNCTION Suma (n1, n2:integer):integer;
    BEGIN
        Suma:=n1+n2;
    END;
FUNCTION Resta (n1, n2:integer):integer;
    BEGIN
        Resta:=n1-n2;
    END;
FUNCTION Multiplicacion (n1, n2:integer):integer;
    BEGIN
        Multiplicacion:=n1*n2;
    END;
FUNCTION Division (n1, n2:integer):real;
    BEGIN
        Division:=n1/n2;
    END;
FUNCTION SumaLenta (n1, n2:integer):integer;
    BEGIN
        WHILE (n1>0)OR(n1<0) DO BEGIN
            n1 := n1 - 1;
            n2:= n2 + 1;
        END;
        SumaLenta:=n2;
    END;
FUNCTION RestaLenta (n1, n2:integer):integer;
    BEGIN
        WHILE (n2>0)OR(n2<0) DO BEGIN
            n2 := n2 - 1;
            n1:= n1 - 1;
        END;
        RestaLenta:=n1;
    END;
FUNCTION MultiplicacionPorSumas (n1, n2:integer):integer;
    VAR
        aux:integer;
    BEGIN
    aux:=0;
        FOR n2:=n2 downto 1 DO BEGIN
            aux:=aux+n1;
        END;
        MultiplicacionPorSumas:=aux;
    END;
FUNCTION DivisionPorRestas (n1, n2:integer):integer;
    BEGIN
        IF (n2>n1) THEN
            DivisionPorRestas:=0
        ELSE
            DivisionPorRestas:=DivisionPorRestas(n1-n2, n2)+1;
    END;
FUNCTION Potencia(n1,n2:integer):integer;
 VAR
   aux:integer;
 BEGIN
   aux:=1;
   WHILE (n2 > 0) DO BEGIN
     aux:= aux * n1;
     n2:=  n2-1;
   END;
   Potencia:= aux;
 END;
FUNCTION MultiplicacionRusa (n1, n2: integer): integer; //o integer o longInt en ambos sitios
 VAR
   aux: integer; //o integer o longInt
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

PROCEDURE Menu;
    BEGIN
        writeln('Que operacion desea realizar?');
        writeln('1-Suma');
        writeln('2-Resta');
        writeln('3-Multiplicacion');
        writeln('4-Division');
        writeln('5-Potencia');
        writeln('6-Suma lenta');
        writeln('7-Resta lenta');
        writeln('8-Multiplicacion por sumas');
        writeln('9-Divison por restas');
        writeln('10-Multiplicacion rusa');
        writeln('0-Salir');
    END;
PROCEDURE RecogerDatos(VAR n1,n2: integer);
    BEGIN
        writeln ('Dame dos numeros');
        readln(n1,n2);
    END;
BEGIN
    REPEAT
        RecogerDatos(numero1,numero2);
        Menu;
        readln(selector);
        CASE selector OF
            1:
                writeln(Suma(numero1,numero2));
            2:
                writeln(Resta(numero1,numero2));
            3:
                writeln(Multiplicacion(numero1,numero2));
            4:
                BEGIN
                    IF(numero2=0) THEN
                        writeln('Infinito')
                    ELSE
                        writeln(Division(numero1,numero2));
                END;
            5:
                BEGIN
                    IF(numero2=0)AND(numero1=0) THEN
                        writeln('Infinito')
                    ELSE IF (numero2<0) THEN
                        writeln('1/', Potencia(numero1,numero2))
                    ELSE
                        writeln(Potencia(numero1,numero2));
                END;
            6:
                writeln(SumaLenta(numero1,numero2));
            7:
                writeln(RestaLenta(numero1,numero2));
            8:
                writeln(MultiplicacionPorSumas(numero1,numero2));
            9:
                writeln(DivisionPorRestas(numero1,numero2));
            10:
                writeln(MultiplicacionRusa(numero1,numero2))

            ELSE
                writeln('Selecciona una operacion correcta')
        END;
    UNTIL (selector=0);
    readln();
END.

