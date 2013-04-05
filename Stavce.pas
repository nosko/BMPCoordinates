unit Stavce;
//  stavec uzly a elementy vychadzajúc z makier ANSYS

interface

 uses Dialogs, Messages, SysUtils;


const MaxPocetStavcov=24;
const MaxPocetUzlov=10000+MaxPocetStavcov*6000;
type MalePole=array[1..MaxPocetStavcov] of single;

Procedure UzlyStavca(PocetStavcov:longint);
Procedure Nini(MaxPocet:longint);
Procedure NINC(NovyUzol,N1,N2:longint; PercVzd:double);
Procedure N(UZOL:longint; x,y,z:double);
Function Sind(Degree:double):double;   // sinus in degrees
Function Cosd(Degree:double):double;
Function TANd(Degree:double):double;
Procedure ngeN(KolkoKrat,PosunCis ,iOD,iDO,Krok:longint; delX, delY, delZ:single);
Procedure Stavsel1(PERCEN:single; ZAKCIS:longint);
Procedure S_stavn03;

var
PocetStavcov, POMDIM, POSUNC,CSS,IZ                             : longint;
XSUR,YSUR,ZSUR,XROT,YROT,ZROT,PERC,PERC1,a,b,c,dd,uhol,ZI       : single;
ZZ{,AAA,BBB,CCC,DDD,XXX,YYY,ZZZ,ALX,ALY,ALZ}                      : MalePole;
{
*dim,ZZ,,12              ! Pomocne pole Z suradnic hladin stavca a platnicky
*dim,AAA,,32             ! Pomocne pole rozmerov stavca
*dim,BBB,,32             ! Pomocne pole rozmerov stavca
*dim,CCC,,32             ! Pomocne pole rozmerov stavca
*dim,DDD,,32             ! Pomocne pole rozmerov stavca
*dim,XXX,,32             ! Pomocne pole suradnic pociatku lokalnej SS stavca
*dim,YYY,,32             ! Pomocne pole suradnic pociatku lokalnej SS stavca
*dim,ZZZ,,32             ! Pomocne pole suradnic pociatku lokalnej SS stavca
*dim,ALX,,32             ! Pomocne pole rotacie okolo osi X, uhol alfa
*dim,ALY,,32             ! Pomocne pole rotacie okolo osi Y, uhol alfa
*dim,ALZ,,32             ! Pomocne pole rotacie okolo osi Z, uhol alfa
}

 NX,NY,NZ                : Array of single;


implementation

uses Matrix;


Procedure Nini(MaxPocet:longint);
begin
   SetLength(NX,0);
   SetLength(NY,0);
   SetLength(NZ,0);

   SetLength(NX,MaxPocet+1);
   SetLength(NY,MaxPocet+1);
   SetLength(NZ,MaxPocet+1);
end;

Procedure N(UZOL:longint; x,y,z:double);
begin
   if UZOL > MaxPocetUzlov-1 then
      begin
        ShowMessage('UZOL='+SysUtils.IntToStr(UZOL)+'   Maximum index number of NX[UZOL], NY[UZOL] or NZ[UZOL] array exceeded '+SysUtils.IntToStr(MaxPocetUzlov-1)+'!.  Halt anyway.');
        Halt;
      end
   else
      begin
      NX[UZOL]:=x;
      NY[UZOL]:=y;
      NZ[UZOL]:=z;
      end;
end;

Procedure NINC(NovyUzol,N1,N2:longint; PercVzd:double);
var  dkx,dky,dkz,XB,YB,ZZB  :double;
begin
{
!       podprogram pre vypocet suradnic XB, YB, ZZB a definovanie Nbodu
!       leziaceho medzi
!       bodom N1=arg1 a N2=arg2 vo vzdialenosti arg3 (% vzdialenosti N1 N2)
!       od bodu N1
! vstupy:
!    NovyUzol             - cislo noveho (definovaneho) uzla
!    N1             - cislo uzla 1
!    N2             - cislo uzla 2
!    PercVzd             - % vzdialedosti N1-N2 noveho bodu od uzla 1
! vystupy:
!    XB,YB,ZZB        - suradnice noveho uzla
!}

  dkx:=(NX[N2]-NX[N1]);
  dky:=(NY[N2]-NY[N1]);
  dkz:=(NZ[N2]-NZ[N1]);
  XB:=NX[N1]+  dkx/100*PercVzd;
  YB:=NY[N1]+  dky/100*PercVzd;
  ZZB:=NZ[N1]+  dkz/100*PercVzd;
  N(NovyUzol,XB,YB,ZZB);
end;



Function SINd(Degree:double):double;   // Sinus in degrees
var rad: double;
begin
  rad:=Degree*PI/180;
  SINd:=sin(rad);
end;


Function COSd(Degree:double):double;   // Cosinus in degrees
var rad: double;
begin
  rad:=Degree*PI/180;
  COSd:=cos(rad);
end;



Function TANd(Degree:double):double;
var rad: double;
begin
  rad:=Degree*PI/180;
  TANd:=sin(rad)/cos(rad);
end;


Procedure NRX(arg1:longint; arg2:single; arg3:longint);
var gama, x0,y0,z0               :single;
    l1, m1,n1,l2,m2,n2,l3,m3,n3  :single;
begin
{
!    Makro zmeni suradnice UZLOV
!    arg1    cislo uzla, ktoreho suradnice chceme rotaciou zmenit
!    arg2    uhol rotacie okolo osi X
!    arg3    ak je nenulovy, potom ho pouzije na oznacenie noveho uzla po rotacii
}
gama:=arg2*PI/180;  //   rotacia okolo osi X
l1:=1;              //!  cos uhla novej osi x0 ku povodnej osi X
m1:=0;              //!  cos uhla novej osi x0 ku povodnej osi Y
n1:=0;              //!  cos uhla novej osi x0 ku povodnej osi Z
l2:=0;              //!  cos uhla novej osi y0 ku povodnej osi X
m2:=cos(gama);      //!  cos uhla novej osi y0 ku povodnej osi Y
n2:=cos(PI/2-gama); //!  cos uhla novej osi y0 ku povodnej osi Z
l3:=0;              //!  cos uhla novej osi z0 ku povodnej osi X
m3:=cos(gama+PI/2); //!  cos uhla novej osi z0 ku povodnej osi Y
n3:=cos(gama);      //!  cos uhla novej osi z0 ku povodnej osi Z

x0:=l1*NX[arg1]+m1*NY[arg1]+n1*NZ[arg1];
y0:=l2*NX[arg1]+m2*NY[arg1]+n2*NZ[arg1];
z0:=l3*NX[arg1]+m3*NY[arg1]+n3*NZ[arg1];
if arg3=0 then  N(arg1,x0,y0,z0)
          else  N(arg3,x0,y0,z0);
end; //NRX


Procedure NRY(arg1:longint; arg2:single; arg3:longint);
var gama, x0,y0,z0               :single;
    l1, m1,n1,l2,m2,n2,l3,m3,n3  :single;
begin
{
!    Makro zmeni suradnice UZLOV
!    arg1    cislo uzla, ktoreho suradnice chceme rotaciou zmenit
!    arg2    uhol rotacie okolo osi Y
!    arg3    ak je nenulovy, potom ho pouzije na oznacenie noveho uzla po rotacii
}
gama:=arg2*PI/180;  //   rotacia okolo osi Y
l1:=cos(gama);      //!  cos uhla novej osi x0 ku povodnej osi X
m1:=0;              //!  cos uhla novej osi x0 ku povodnej osi Y
n1:=cos(PI/2-gama); //!  cos uhla novej osi x0 ku povodnej osi Z
l2:=0;              //!  cos uhla novej osi y0 ku povodnej osi X
m2:=1;              //!  cos uhla novej osi y0 ku povodnej osi Y
n2:=0;              //!  cos uhla novej osi y0 ku povodnej osi Z
l3:=cos(gama+PI/2); //!  cos uhla novej osi z0 ku povodnej osi X
m3:=0;              //!  cos uhla novej osi z0 ku povodnej osi Y
n3:=cos(gama);      //!  cos uhla novej osi z0 ku povodnej osi Z
x0:=l1*NX[arg1]+m1*NY[arg1]+n1*NZ[arg1];
y0:=l2*NX[arg1]+m2*NY[arg1]+n2*NZ[arg1];
z0:=l3*NX[arg1]+m3*NY[arg1]+n3*NZ[arg1];
if arg3=0 then  N(arg1,x0,y0,z0)
          else  N(arg3,x0,y0,z0);
end; //NRY

Procedure NRZ(arg1:longint; arg2:single; arg3:longint);
var gama, x0,y0,z0               :single;
    l1, m1,n1,l2,m2,n2,l3,m3,n3  :single;
begin
{
!    Makro zmeni suradnice UZLOV
!    arg1    cislo uzla, ktoreho suradnice chceme rotaciou zmenit
!    arg2    uhol rotacie okolo osi Z
!    arg3    ak je nenulovy, potom ho pouzije na oznacenie noveho uzla po rotacii
}
gama:=arg2*PI/180;  //   rotacia okolo osi Z
l1:=cos(gama);      //!  cos uhla novej osi x0 ku povodnej osi X
m1:=cos(PI/2-gama); //!  cos uhla novej osi x0 ku povodnej osi Y
n1:=0;              //!  cos uhla novej osi x0 ku povodnej osi Z
l2:=cos(gama+PI/2); //!  cos uhla novej osi y0 ku povodnej osi X
m2:=cos(gama);      //!  cos uhla novej osi y0 ku povodnej osi Y
n2:=0;              //!  cos uhla novej osi y0 ku povodnej osi Z
l3:=0; //!  cos uhla novej osi z0 ku povodnej osi X
m3:=0;              //!  cos uhla novej osi z0 ku povodnej osi Y
n3:=1;              //!  cos uhla novej osi z0 ku povodnej osi Z
x0:=l1*NX[arg1]+m1*NY[arg1]+n1*NZ[arg1];
y0:=l2*NX[arg1]+m2*NY[arg1]+n2*NZ[arg1];
z0:=l3*NX[arg1]+m3*NY[arg1]+n3*NZ[arg1];
if arg3=0 then  N(arg1,x0,y0,z0)
          else  N(arg3,x0,y0,z0);
end; //NRZ


Procedure OtocX(arg1,arg2,arg3:single; arg4,arg5:longint);
var  II           :longint;
begin
{
!  arg1    RotX      zatial navyse
!  arg2    RotY
!  arg3    RotZ      zatial navyse
!  arg4    cislo uzla zaciatocne
!  arg5    cislo uzla koncove
}
// definovanie suradnic - ROTACIA
for II:=arg4 to arg5 do
   begin
    NRX(II,arg1,0);
   end;
end;  // OtocX

Procedure OtocY(arg1,arg2,arg3:single; arg4,arg5:longint);
var  II           :longint;
begin
{
!  arg1    RotX      zatial navyse
!  arg2    RotY
!  arg3    RotZ      zatial navyse
!  arg4    cislo uzla zaciatocne
!  arg5    cislo uzla koncove
}
// definovanie suradnic - ROTACIA
for II:=arg4 to arg5 do
   begin
    NRY(II,arg2,0);
   end;
end;  // OtocY



Procedure OtocZ(arg1,arg2,arg3:single; arg4,arg5:longint);
var  II           :longint;
begin
{
!  arg1    RotX      zatial navyse
!  arg2    RotY
!  arg3    RotZ      zatial navyse
!  arg4    cislo uzla zaciatocne
!  arg5    cislo uzla koncove
}
// definovanie suradnic - ROTACIA
for II:=arg4 to arg5 do
   begin
    NRZ(II,arg3,0);
   end;
end;  // OtocZ

Procedure NS(arg1:longint; arg2,arg3,arg4:double);
var x0,y0,z0 :double;
{!      posun osi X,Y,Z (delta)......SHIFT
!       arg1    cislo uzla, ktoreho suradnice chceme posunom zmenit
!       arg2    delta X
!       arg3    delta Y
!       arg4    delta Z}
begin
x0:=NX[arg1]+ arg2 ;
y0:=NY[arg1]+ arg3 ;
z0:=NZ[arg1]+ arg4 ;
N(arg1,x0,y0,z0);
end; // NS


Procedure Posun(arg1,arg2,arg3:single; arg4,arg5:longint);
var  II           :longint;
begin
{!  arg1    posunX
!   arg2    posunY
!   arg3    posunZ
!   arg4    cislo uzla zaciatocne
!   arg5    cislo uzla koncove}
for II:=arg4 to arg5 do
   begin
    NS(II,arg1,arg2,arg3);
   end;
end;  // Posun



Procedure S_PLATN01;
var  RR,XS,YS,ALF   :double;
     IP,II          :longint;
begin
IZ:=3600+CSS-POSUNC;  // Spodna podstava stavca cisla uzlov;
ZI:=ZSUR-(c/2+dd);    // Suradnica v smere osi z;
                      // Nacitanie uzlov stavca v jednej rovine z, parametre a,b,c,IZ,ZI;
N(     1+IZ,  0,0,ZI);
N(     2+IZ,  b/4,0,ZI);
N(     3+IZ,  0,b/12,ZI);
N(     5+IZ,  b/8,0,ZI);
NINC(  4+IZ,  5+IZ,1+IZ,50);
N(     6+IZ,  0,-NY[3+IZ],NZ[1+IZ]);
N(     8+IZ,  0,b/6,ZI);
NINC( 10+IZ,  2+IZ,8+IZ,50);
NINC(  9+IZ,  10+IZ,3+IZ,50);
N(    11+IZ,  0,-NY[8+IZ],ZI);
N(    12+IZ,  NX[9+IZ],-NY[9+IZ],ZI);
N(    13+IZ,  NX[10+IZ],-NY[10+IZ],ZI);
N(    14+IZ,  0,b/4,ZI);
NINC( 15+IZ,  2+IZ,14+IZ,70);
N(    17+IZ,  0,-NY[14+IZ],ZI);
N(    18+IZ,  NX[15+IZ],-NY[15+IZ],ZI);
N(    20+IZ,  0,3*b/8,ZI);
NINC( 21+IZ,  2+IZ,20+IZ,70);
N(    22+IZ,  0,-NY[20+IZ],ZI);
NINC( 23+IZ,  2+IZ,22+IZ,70);
N(    24+IZ,  0,b/2,ZI);
N(    25+IZ,  b/12,NY[20+IZ],ZI);
NINC( 26+IZ,  2+IZ,24+IZ,50);
NINC( 16+IZ,  26+IZ,10+IZ,50);
N(    19+IZ,  NX[16+IZ],-NY[16+IZ],ZI);
N(    27+IZ,  0,-NY[24+IZ],ZI);
N(    28+IZ,  NX[25+IZ],-NY[25+IZ],ZI);
N(    29+IZ,  NX[26+IZ],-NY[26+IZ],ZI);
N(    30+IZ,  b/8,5*b/8,ZI);
NINC( 31+IZ,  2+IZ,30+IZ,80);
N(    32+IZ,  b/6,NY[20+IZ],ZI);
NINC( 33+IZ,  2+IZ,30+IZ,50);
NINC( 34+IZ,  2+IZ,30+IZ,25);
N(    35+IZ,  NX[30+IZ],-NY[30+IZ],ZI);
N(    36+IZ,  NX[31+IZ],-NY[31+IZ],ZI);
N(    37+IZ,  NX[32+IZ],-NY[32+IZ],ZI);
N(    38+IZ,  NX[33+IZ],-NY[33+IZ],ZI);
N(    39+IZ,  NX[34+IZ],-NY[34+IZ],ZI);
N(    40+IZ,  b/4,3*b/4,ZI);
NINC( 41+IZ,  2+IZ,40+IZ,85);
NINC( 42+IZ,  2+IZ,40+IZ,70);
N(    43+IZ,  b/4,NY[20+IZ],ZI);

NINC( 45+IZ,  2+IZ,40+IZ,40);
NINC( 46+IZ,  2+IZ,40+IZ,20);
N(    47+IZ,  NX[40+IZ],-NY[40+IZ],ZI);
N(    48+IZ,  NX[41+IZ],-NY[41+IZ],ZI);
N(    49+IZ,  NX[42+IZ],-NY[42+IZ],ZI);
N(    50+IZ,  NX[43+IZ],-NY[43+IZ],ZI);
N(    52+IZ,  NX[45+IZ],-NY[45+IZ],ZI);
N(    53+IZ,  NX[46+IZ],-NY[46+IZ],ZI);


RR:=ABS(NY[40+IZ]-NY[2+IZ]);      //polomer;
XS:=NX[2+IZ]+RR*SINd(9);
YS:=RR*COSd(9);
N(    54+IZ,XS,YS,ZI);
N(    72+IZ,NX[54+IZ],-NY[54+IZ],ZI);

for II:=55 to 71 do
    begin
    IP:=II-55;
    ALF:=IP*9+18;
    XS:=NX[2+IZ]+RR*SINd(ALF);
    YS:=RR*COSd(ALF);
    N(    55+IP+IZ,XS,YS,ZI);                 // body na kruznici po obvode;
    NINC( 90+IP+IZ,2+IZ,II+IZ,85);            // okraj cortikalnej casti;
    NINC( 73+IP+IZ,90+IP+IZ,55+IP+IZ,50);     // polovica z cortikalnej casti;
    NINC(107+IP+IZ,2+IZ,II+IZ,40);
    end;


RR:=ABS(NY[46+IZ]-NY[2+IZ]);     // vnutorny okruh 1;
for II:=124 to 132 do
    begin
    IP:=II-124;
    ALF:=IP*18+18;
    XS:=NX[2+IZ]+RR*SINd(ALF);
    YS:=RR*COSd(ALF);
    N(124+IP+IZ,XS,YS,ZI);
    end;


NINC(133+IZ,2+IZ,54+IZ,90);
NINC(134+IZ,2+IZ,54+IZ,80);
NINC(135+IZ,2+IZ,54+IZ,40);
N(   136+IZ,NX[133+IZ],-NY[133+IZ],ZI);
N(   137+IZ,NX[134+IZ],-NY[134+IZ],ZI);
N(   138+IZ,NX[135+IZ],-NY[135+IZ],ZI);
N(   139+IZ,((b/4)+(3*b*TANd(27))/8),NY[20+IZ],ZI);
N(   140+IZ,NX[139+IZ],-NY[139+IZ],ZI);
N(   141+IZ,((b/4)+(3*b*TANd(36))/8),NY[20+IZ],ZI);
N(   142+IZ,NX[141+IZ],-NY[141+IZ],ZI);
N(   143+IZ,((b/4)+(3*b*TANd(18))/8),NY[20+IZ],ZI);
N(   144+IZ,NX[143+IZ],-NY[143+IZ],ZI);
N(   145+IZ,((b/4)+(3*b*TANd(9))/8),NY[20+IZ],ZI);
N(   146+IZ,NX[145+IZ],-NY[145+IZ],ZI);
NINC(147+IZ,42+IZ,43+IZ,50);
NINC(148+IZ,92+IZ,141+IZ,50);
N(   149+IZ,NX[148+IZ],-NY[148+IZ],ZI);
N(   150+IZ,((b/4)+(3*b*TANd(45))/8),NY[20+IZ],ZI);
N(   151+IZ,NX[150+IZ],-NY[150+IZ],ZI);

RR:=ABS(NY[147+IZ]-NY[2+IZ]);
for II:=153 to 163 do
    begin
    IP:=II-153;
    ALF:=IP*9+45;
    XS:=NX[2+IZ]+RR*SINd(ALF);
    YS:=RR*COSd(ALF);
    N(153+IP+IZ,XS,YS,ZI);
    end;


NINC(177+IZ,41+IZ,42+IZ,50);
RR:=ABS(NY[177+IZ]-NY[2+IZ]);
for II:=166 to 176 do
    begin
    IP:=II-166;
    ALF:=IP*9+45;
    XS:=NX[2+IZ]+RR*SINd(ALF);
    YS:=RR*COSd(ALF);
    N(166+IP+IZ,XS,YS,ZI);
    end;




NINC(179+IZ,134+IZ,145+IZ,50);
N(   180+IZ,NX[179+IZ],-NY[179+IZ],ZI);
NINC(181+IZ,90+IZ,143+IZ,50);
N(   182+IZ,NX[181+IZ],-NY[181+IZ],ZI);
NINC(183+IZ,91+IZ,139+IZ,50);
N(   184+IZ,NX[183+IZ],-NY[183+IZ],ZI);

// nsel,s,loc,z, ZI-0.001,ZI+0.001;

N(2679 ,NX[3622]- (NX[3650]-NX[3622]),  NY[3622], ZI);            //spojenie stavcovych vybezkov v klboch;
N(2649 ,NX[3620]- (NX[3643]-NX[3620]),  NY[3620], ZI);            //spojenie stavcovych vybezkov;

end;   //  S_PLATN01






Procedure S_stavn03;
var   IZ,II,IP,PosCis,JJ           : longint;
      ZI,RR,XS,YS,ALF,PerZuz       : single;
begin
// !!!!!!!!!!        UZLY STAVCA
IZ:=1200+CSS;           //  ! Spodna podstava stavca cisla uzlov
ZI:=ZSUR-c/2;           //  ! Suradnica v smere osi z
                        //  ! Nacitanie uzlov stavca v jednej rovine z, parametre a,b,c,IZ,ZI
N(     1+IZ,  0,0,ZI);
N(     2+IZ,  b/4,0,ZI);
N(     3+IZ,  0,b/12,ZI);
N(     5+IZ,  b/8,0,ZI);
N(     4+IZ,  5+IZ,1+IZ,50);
N(     6+IZ,  0,-Ny[3+IZ],Nz[1+IZ]);
N(     8+IZ,  0,b/6,ZI);
N(    10+IZ,  2+IZ,8+IZ,50);
N(     9+IZ,  10+IZ,3+IZ,50);
N(    11+IZ,  0,-Ny[8+IZ],ZI);
N(    12+IZ,  Nx[9+IZ],-Ny[9+IZ],ZI);
N(    13+IZ,  Nx[10+IZ],-Ny[10+IZ],ZI);
N(    14+IZ,  0,b/4,ZI);
N(    15+IZ,  2+IZ,14+IZ,70);
N(    17+IZ,  0,-Ny[14+IZ],ZI);
N(    18+IZ,  Nx[15+IZ],-Ny[15+IZ],ZI);
N(    20+IZ,  0,3*b/8,ZI);
N(    21+IZ,  2+IZ,20+IZ,70);
N(    22+IZ,  0,-Ny[20+IZ],ZI);
N(    23+IZ,  2+IZ,22+IZ,70);
N(    24+IZ,  0,b/2,ZI);
N(    25+IZ,  b/12,Ny[20+IZ],ZI);
N(    26+IZ,  2+IZ,24+IZ,50);
N(    16+IZ,  26+IZ,10+IZ,50);
N(    19+IZ,  Nx[16+IZ],-Ny[16+IZ],ZI);
N(    27+IZ,  0,-Ny[24+IZ],ZI);
N(    28+IZ,  Nx[25+IZ],-Ny[25+IZ],ZI);
N(    29+IZ,  Nx[26+IZ],-Ny[26+IZ],ZI);
N(    30+IZ,  b/8,5*b/8,ZI);
N(    31+IZ,  2+IZ,30+IZ,80);
N(    32+IZ,  b/6,Ny[20+IZ],ZI);
N(    33+IZ,  2+IZ,30+IZ,50);
N(    34+IZ,  2+IZ,30+IZ,25);
N(    35+IZ,  Nx[30+IZ],-Ny[30+IZ],ZI);
N(    36+IZ,  Nx[31+IZ],-Ny[31+IZ],ZI);
N(    37+IZ,  Nx[32+IZ],-Ny[32+IZ],ZI);
N(    38+IZ,  Nx[33+IZ],-Ny[33+IZ],ZI);
N(    39+IZ,  Nx[34+IZ],-Ny[34+IZ],ZI);

N(    40+IZ,  b/4,3*b/4,ZI);
N(    41+IZ,  2+IZ,40+IZ,85);
N(    42+IZ,  2+IZ,40+IZ,70);
N(    43+IZ,  b/4,Ny[20+IZ],ZI);

N(    45+IZ,  2+IZ,40+IZ,40);
N(    46+IZ,  2+IZ,40+IZ,20);
N(    47+IZ,  Nx[40+IZ],-Ny[40+IZ],ZI);
N(    48+IZ,  Nx[41+IZ],-Ny[41+IZ],ZI);
N(    49+IZ,  Nx[42+IZ],-Ny[42+IZ],ZI);
N(    50+IZ,  Nx[43+IZ],-Ny[43+IZ],ZI);
N(    52+IZ,  Nx[45+IZ],-Ny[45+IZ],ZI);
N(    53+IZ,  Nx[46+IZ],-Ny[46+IZ],ZI);


RR:=(ABS(Ny[40+IZ]-Ny[2+IZ]));
XS:=(Nx[2+IZ]+RR*SINd(9));
YS:=(RR*COSd(9));
N(    54+IZ,XS,YS,ZI);
N(    72+IZ,Nx[54+IZ],-Ny[54+IZ],ZI);
For II:=55 to 71 do
    begin
    IP:=(II-55);
    ALF:=(IP*9+18);
    XS:=(Nx[2+IZ]+RR*SINd(ALF));
    YS:=(RR*COSd(ALF));
    N(    55+IP+IZ,XS,YS,ZI);             // ! body na kruznici po obvode);
    N( 90+IP+IZ,2+IZ,II+IZ,85);           // ! okraj cortikalnej casti);
    N( 73+IP+IZ,90+IP+IZ,55+IP+IZ,50);    // ! polovica z cortikalnej casti);
    N(107+IP+IZ,2+IZ,II+IZ,40);
    end;

RR:=(ABS(Ny[46+IZ]-Ny[2+IZ]));              // ! vnutorny okruh 1);
For II:=124 to 132 do
    begin
    IP:=(II-124);
    ALF:=(IP*18+18);
    XS:=(Nx[2+IZ]+RR*SINd(ALF));
    YS:=(RR*COSd(ALF));
    N(124+IP+IZ,XS,YS,ZI);
    end;

N(   133+IZ,2+IZ,54+IZ,90);
N(   134+IZ,2+IZ,54+IZ,80);
N(   135+IZ,2+IZ,54+IZ,40);
N(   136+IZ,Nx[133+IZ],-Ny[133+IZ],ZI);
N(   137+IZ,Nx[134+IZ],-Ny[134+IZ],ZI);
N(   138+IZ,Nx[135+IZ],-Ny[135+IZ],ZI);
N(   139+IZ,((b/4)+(3*b*TANd(27))/8),Ny[20+IZ],ZI);
N(   140+IZ,Nx[139+IZ],-Ny[139+IZ],ZI);
N(   141+IZ,((b/4)+(3*b*TANd(36))/8),Ny[20+IZ],ZI);
N(   142+IZ,Nx[141+IZ],-Ny[141+IZ],ZI);
N(   143+IZ,((b/4)+(3*b*TANd(18))/8),Ny[20+IZ],ZI);
N(   144+IZ,Nx[143+IZ],-Ny[143+IZ],ZI);
N(   145+IZ,((b/4)+(3*b*TANd(9))/8),Ny[20+IZ],ZI);
N(   146+IZ,Nx[145+IZ],-Ny[145+IZ],ZI);
N(   147+IZ,42+IZ,43+IZ,50);
N(   148+IZ,92+IZ,141+IZ,50);
N(   149+IZ,Nx[148+IZ],-Ny[148+IZ],ZI);
N(   150+IZ,((b/4)+(3*b*TANd(45))/8),Ny[20+IZ],ZI);
N(   151+IZ,Nx[150+IZ],-Ny[150+IZ],ZI);

RR:=(ABS(Ny[147+IZ]-Ny[2+IZ]));
For II:=153 to 163 do
    begin
    IP:=(II-153);
    ALF:=(IP*9+45);
    XS:=(Nx[2+IZ]+RR*SINd(ALF));
    YS:=(RR*COSd(ALF));
    N(153+IP+IZ,XS,YS,ZI);
    end;

N(177+IZ,41+IZ,42+IZ,50);
RR:=(ABS(Ny[177+IZ]-Ny[2+IZ]));
For II:=166 to 176 do
    begin
    IP:=(II-166);
    ALF:=IP*9+45;
    XS:=Nx[2+IZ]+RR*SINd(ALF);
    YS:=RR*COSd(ALF);
    N(166+IP+IZ,XS,YS,ZI);
    end;

N(179+IZ,134+IZ,145+IZ,50);
N(   180+IZ,Nx[179+IZ],-Ny[179+IZ],ZI);
N(181+IZ,90+IZ,143+IZ,50);
N(   182+IZ,Nx[181+IZ],-Ny[181+IZ],ZI);
N(183+IZ,91+IZ,139+IZ,50);
N(   184+IZ,Nx[183+IZ],-Ny[183+IZ],ZI);

for jj:=2 to 9 do                                       //! generovanie uzlov vyssich rezov tela stavca a ich zuzenie
  begin
  POSCIS:=(JJ-1)*300;
  ngeN(2,POSCIS ,IZ+1,IZ+184,1,0,0,(ZSUR+ZZ[JJ]-ZI));   //  selektovanie a zuzenie uzlov ku stredu stavca vo vyssich rezoch
  PERZUZ:=2/(c*c)*(195-2*PERC)*ZZ[JJ]*ZZ[JJ]-5/c*ZZ[JJ]+PERC;
  STAVSEL1(PERZUZ,IZ+POSCIS);                           // 1. parameter je percento zuzenia,. 2.parameter zakl. cislo
  end;                                                  //! koniec generovania uzlov vyssich rezov
end;    //  S_stavN03

Procedure ngeN(KolkoKrat,PosunCis ,iOD,iDO,Krok:longint; delX, delY, delZ:single);
var ii,kk :longint;
begin
  for kk:=1 to (Kolkokrat-1) do
   begin
   for ii:=iOD to iDO do
     begin
     N(ii+kk*PosunCis,NX[ii]+kk*delX, NY[ii]+kk*delY, NZ[ii]+kk*delZ);
     end; // ii
   end;   // kk
end;    // ngeN

Procedure Stavsel1(PERCEN:single; ZAKCIS:longint);
var   ii,POCET,NU         :longint;
      Pod                 :array[1..10000] of longint;
begin
POD[  1]:=ZAKCIS+  24;
POD[  2]:=ZAKCIS+  27;
POD[  3]:=ZAKCIS+  30;
POD[  4]:=ZAKCIS+  31;
POD[  5]:=ZAKCIS+  35;
POD[  6]:=ZAKCIS+  36;
POD[  7]:=ZAKCIS+  40;
POD[  8]:=ZAKCIS+  41;
POD[  9]:=ZAKCIS+  42;
POD[ 10]:=ZAKCIS+  47;
POD[ 11]:=ZAKCIS+  48;
POD[ 12]:=ZAKCIS+  49;
POD[ 13]:=ZAKCIS+  54;
POD[ 14]:=ZAKCIS+  55;
POD[ 15]:=ZAKCIS+  56;
POD[ 16]:=ZAKCIS+  57;
POD[ 17]:=ZAKCIS+  58;
POD[ 18]:=ZAKCIS+  59;
POD[ 19]:=ZAKCIS+  60;
POD[ 20]:=ZAKCIS+  61;
POD[ 21]:=ZAKCIS+  62;
POD[ 22]:=ZAKCIS+  63;
POD[ 23]:=ZAKCIS+  64;
POD[ 24]:=ZAKCIS+  65;
POD[ 25]:=ZAKCIS+  66;
POD[ 26]:=ZAKCIS+  67;
POD[ 27]:=ZAKCIS+  68;
POD[ 28]:=ZAKCIS+  69;
POD[ 29]:=ZAKCIS+  70;
POD[ 30]:=ZAKCIS+  71;
POD[ 31]:=ZAKCIS+  72;
POD[ 32]:=ZAKCIS+  73;
POD[ 33]:=ZAKCIS+  74;
POD[ 34]:=ZAKCIS+  75;
POD[ 35]:=ZAKCIS+  76;
POD[ 36]:=ZAKCIS+  77;
POD[ 37]:=ZAKCIS+  78;
POD[ 38]:=ZAKCIS+  79;
POD[ 39]:=ZAKCIS+  80;
POD[ 40]:=ZAKCIS+  81;
POD[ 41]:=ZAKCIS+  82;
POD[ 42]:=ZAKCIS+  83;
POD[ 43]:=ZAKCIS+  84;
POD[ 44]:=ZAKCIS+  85;
POD[ 45]:=ZAKCIS+  86;
POD[ 46]:=ZAKCIS+  87;
POD[ 47]:=ZAKCIS+  88;
POD[ 48]:=ZAKCIS+  89;
POD[ 49]:=ZAKCIS+  90;
POD[ 50]:=ZAKCIS+  91;
POD[ 51]:=ZAKCIS+  92;
POD[ 52]:=ZAKCIS+  93;
POD[ 53]:=ZAKCIS+  94;
POD[ 54]:=ZAKCIS+  95;
POD[ 55]:=ZAKCIS+  96;
POD[ 56]:=ZAKCIS+  97;
POD[ 57]:=ZAKCIS+  98;
POD[ 58]:=ZAKCIS+  99;
POD[ 59]:=ZAKCIS+ 100;
POD[ 60]:=ZAKCIS+ 101;
POD[ 61]:=ZAKCIS+ 102;
POD[ 62]:=ZAKCIS+ 103;
POD[ 63]:=ZAKCIS+ 104;
POD[ 64]:=ZAKCIS+ 105;
POD[ 65]:=ZAKCIS+ 106;
POD[ 66]:=ZAKCIS+ 133;
POD[ 67]:=ZAKCIS+ 134;
POD[ 68]:=ZAKCIS+ 136;
POD[ 69]:=ZAKCIS+ 137;
POD[ 80]:=ZAKCIS+ 148;
POD[ 81]:=ZAKCIS+ 149;
POD[ 82]:=ZAKCIS+ 167;
POD[ 83]:=ZAKCIS+ 168;
POD[ 84]:=ZAKCIS+ 169;
POD[ 85]:=ZAKCIS+ 170;
POD[ 86]:=ZAKCIS+ 171;
POD[ 87]:=ZAKCIS+ 172;
POD[ 88]:=ZAKCIS+ 173;
POD[ 89]:=ZAKCIS+ 174;
POD[ 90]:=ZAKCIS+ 175;
POD[ 91]:=ZAKCIS+ 179;
POD[ 92]:=ZAKCIS+ 180;
POD[ 93]:=ZAKCIS+ 181;
POD[ 94]:=ZAKCIS+ 182;
POD[ 95]:=ZAKCIS+ 183;
POD[ 96]:=ZAKCIS+ 184;

POCET:=96;
  for II:=1 to POCET do    // uprava suradnic vyselektovanych uzlov (zuzenie stavca)
    begin
    NU:=POD[II];    //                   ! Cislo noveho uzla
    NINC(NU,ZAKCIS+2,NU,PERCEN);
    end;
end;      //  Stavsel1





Procedure UzlyStavca(PocetStavcov:longint);
Var  Stavec   :Longint;
     delxx,delyy,delzz   :single;

begin
//  PocetStavcov:=7;     {17}
POMDIM:=0 ;
POSUNC:=6000 ;

//    TYPY ELEMENTOV A MATERIALY

CSS:=POSUNC;              //////CISLO STAVCA//////           STAVEC L5
ZSUR:=0;                  // Z suradnica pociatku lok sur systemu stavca
PERC:=87.5;               // maximalne zuzenie stavca    v %
PERC1:=105;               // maximalne rozsirenie stavca v %
a :=AAA[1];               // v m
b :=BBB[1];               // v m
c :=CCC[1];               // v m
dd:=DDD[1];               // v m
S_PLATN01;       // spodne uzly PRVEJ platnicky
uhol:=ALY[1];
OTOCY(    0, uhol,     0, 1,CSS);
//  /gre,prvy       //////??????????????????????????????????
for STAVEC:=1 to PocetStavcov do
 begin
  CSS:=POSUNC*STAVEC;       //////CISLO STAVCA//////
  XSUR:=0;                  // X suradnica pociatku lok sur systemu stavca
  YSUR:=0;                  // Y suradnica pociatku lok sur systemu stavca
  ZSUR:=0;                  // Z suradnica pociatku lok sur systemu stavca
  XROT:=0;                  // ROTACIA okolo osi X
  YROT:=0;                  // ROTACIA okolo osi Y
  ZROT:=0;                  // ROTACIA okolo osi Z
  PERC:=87.5;               // maximalne zuzenie stavca    v %
  PERC1:=105;               // maximalne rozsirenie stavca v %
  a :=AAA[stavec];          // v m
  b :=BBB[stavec];          // v m
  c :=CCC[stavec];          // v m
  dd:=DDD[stavec];          // v m
  // uhol:=ALY(stavec);
  IZ:=3600+CSS-POSUNC;      // CISLA UZLOV na HORNEJ HRANE PREDCHADZAJUCEHO STAVCA
  ZI:=ZSUR-(c/2+dd);        // Suradnica v smere osi z
//  nsel,s,node,,CSS-POSUNC+3600 ,CSS-POSUNC+3600  +195   // 195 preto, lebo este vyssie cisla su pre vybezky
//  CM,UZLY1,node
  ZZ[2] :=-0.45*c        ; // hladiny z suradnic stavca
  ZZ[3] :=-0.30*c        ; // hladiny z suradnic stavca
  ZZ[4] :=-0.125*c       ; // hladiny z suradnic stavca
  ZZ[5] :=+0             ; // hladiny z suradnic stavca
  ZZ[6] :=+0.125*c       ; // hladiny z suradnic stavca
  ZZ[7] :=+0.30*c        ; // hladiny z suradnic stavca
  ZZ[8] :=+0.45*c        ; // hladiny z suradnic stavca
  ZZ[9] :=+0.500*c       ; // hladiny z suradnic stavca
  ZZ[10]:=-0.5*c-dd/4    ; // hladiny z suradnic platnicky
  ZZ[11]:=-0.5*c-dd/2    ; // hladiny z suradnic platnicky
  ZZ[12]:=-0.5*c-3*dd/4  ; // hladiny z suradnic platnicky

  S_stavn03;       // generovanie UZLOV STAVCA zmeni sa hodnota IZ:=1200+CSS

 { *IF,STAVEC,EQ,1,THEN
    ZUZSTX,NZ(IZ+2401)-NZ(IZ+1),NZ(IZ+2463)-NZ(IZ+63)+c/4
    !ZUZSTY,NZ(IZ+2402)-NZ(IZ+2),NZ(IZ+2440)-NZ(IZ+40)+c/4
  *ENDIF

  /input,S_VYBEZ,N1       ! ZADNE A BOCNE                                                      STAVCOVE VYBEZKY

  *IF,STAVEC,EQ,1,THEN   !    BODY NA KOSTRCI PRE UCHYTENIE SVALOV
    N,9900,NX(8920),NY(8920),NZ(8920)-(c+dd)
    N,9901,NX(8899),NY(8899),NZ(8899)-(c+dd)
  *ENDIF
 }

  delxx:=XXX[stavec]-XXX[1] ;
  delzz:=ZZZ[stavec]-ZZZ[1] ;
  delyy:=YYY[stavec]-YYY[1] ;
  OTOCX( ALX[stavec],    0,    0, CSS,CSS+posunc*2);
  OTOCY(    0, ALY[stavec],    0, CSS,CSS+posunc*2);
  OTOCZ(    0,    0, ALZ[stavec], CSS,CSS+posunc*2);

 // allsel
 // nplot
 // !        delx   dely    delz     ZAC     KON
  POSUN(  delXX, delyy  , delzz ,  CSS,   CSS+posunc);

 end;  // STAVEC

end;   //


end.
