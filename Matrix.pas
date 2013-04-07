unit Matrix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GR32_Image;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    aaaField: TEdit;
    bbbField: TEdit;
    cccField: TEdit;
    dddField: TEdit;
    xxxField: TEdit;
    yyyField: TEdit;
    zzzField: TEdit;
    alxField: TEdit;
    alyField: TEdit;
    alzField: TEdit;
    Button1: TButton;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Image321: TImage32;
    ZUZField: TEdit;
    Label35: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ZapisDatabazu(index:integer);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure loadData;
    procedure initTextFields;
  end;

var
  Form1: TForm1;
  AAA,BBB,CCC,DDD,XXX,YYY,ZZZ,ZZY,ALX,ALY,ALZ,ZUZ: array[1..24] of single;
  AktualnaPolozka                                          : Integer;
  KreslitOdStavca,KreslitPoStavec,AktualneDefinovanyStavec : Integer;
  NazovVstupu                                               : string;


implementation

uses main;

{$R *.dfm}

procedure TForm1.ZapisDatabazu(index:integer);
begin
    AAA[index]:= StrToFloat(aaaField.Text);   // stavec L5
    BBB[index]:= StrToFloat(bbbField.Text);
    CCC[index]:= StrToFloat(cccField.Text);

    XXX[index]:= StrToFloat(xxxField.Text);
    YYY[index]:= StrToFloat(yyyField.Text);
    ZZZ[index]:= StrToFloat(zzzField.Text);
    ZZY[index]:= StrToFloat(dddField.Text);
    ALX[index]:= StrToFloat(alxField.Text);
    ALY[index]:= StrToFloat(alyField.Text);
    ALZ[index]:= StrToFloat(alzField.Text);
    ZUZ[index]:= StrToFloat(zuzField.Text);
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
    // Prvy prvok v listboxe ma index 0, pole su indexovane od 1
    AktualneDefinovanyStavec := 25-(ListBox1.ItemIndex+1);
    Form1.ZapisDatabazu(AktualneDefinovanyStavec);
    Fmain.PopisPrace.Text:='c'+IntToStr(AktualneDefinovanyStavec);
    NazovVstupu:='c';
end;



procedure TForm1.initTextFields;
begin
    aaaField.Text:= FloatToStrF(AAA[1],ffFixed,5,3);
    bbbField.Text:= FloatToStrF(BBB[1],ffFixed,5,3);
    cccField.Text:= FloatToStrF(CCC[1],ffFixed,5,3);
    dddField.Text:= FloatToStrF(ZZY[1],ffFixed,5,3);
    xxxField.Text:= FloatToStrF(XXX[1],ffFixed,5,3);
    yyyField.Text:= FloatToStrF(YYY[1],ffFixed,5,3);
    zzzField.Text:= FloatToStrF(ZZZ[1],ffFixed,5,3);
    alxField.Text:= FloatToStrF(ALX[1],ffFixed,5,3);
    alyField.Text:= FloatToStrF(ALY[1],ffFixed,5,3);
    alzField.Text:= FloatToStrF(ALZ[1],ffFixed,5,3);
    zuzField.Text:= FloatToStrF(ZUZ[1],ffFixed,5,3);
end;


procedure TForm1.ListBox1Click(Sender: TObject);
var index:  Integer;
begin
    // Prvy prvok v listboxe ma index 0, pole su indexovane od 1
    index := 25-(ListBox1.ItemIndex+1);
    aaaField.Text:= FloatToStrF(AAA[index],ffFixed,5,3);
    bbbField.Text:= FloatToStrF(BBB[index],ffFixed,5,3);
    cccField.Text:= FloatToStrF(CCC[index],ffFixed,5,3);
    dddField.Text:= FloatToStrF(ZZY[index],ffFixed,5,3);
    xxxField.Text:= FloatToStrF(XXX[index],ffFixed,5,3);
    yyyField.Text:= FloatToStrF(YYY[index],ffFixed,5,3);
    zzzField.Text:= FloatToStrF(ZZZ[index],ffFixed,5,3);
    alxField.Text:= FloatToStrF(ALX[index],ffFixed,5,3);
    alyField.Text:= FloatToStrF(ALY[index],ffFixed,5,3);
    alzField.Text:= FloatToStrF(ALZ[index],ffFixed,5,3);
    zuzField.Text:= FloatToStrF(ZUZ[index],ffFixed,5,3);
    AktualnaPolozka:= ListBox1.ItemIndex;
    AktualneDefinovanyStavec:=index;
end;

procedure TForm1.loadData;
var i, nasob,Xcoor,Ycoor,Zcoor: Integer;
begin
  // TODO: load&save to/from file
    AAA[1]:=0.023;   // stavec L5
    BBB[1]:=0.015 ;
    CCC[1]:=0.0105;
    DDD[1]:=0.005 ;
    XXX[1]:=0     ;
    YYY[1]:=0     ;
    ZZZ[1]:=0     ;
    ALX[1]:=8     ;
    ALY[1]:=19;
    ALZ[1]:=0;

    AAA[2]:=0.021;   // stavec L4
    BBB[2]:=0.015;
    CCC[2]:=0.0115;
    DDD[2]:=0.004;
    XXX[2]:=0.001;
    YYY[2]:=0.003;
    ZZZ[2]:=0.012;   //////ZZZ[2]:=0.012 povodne "realne",0.015 posunute
    ALX[2]:=16;
    ALY[2]:=-3;
    ALZ[2]:=0;

    AAA[3]:=0.019;   // stavec L3
    BBB[3]:=0.014;
    CCC[3]:=0.011;
    DDD[3]:=0.0035;
    XXX[3]:=0.001;
    YYY[3]:=0.006;   //// povodne 0
    ZZZ[3]:=0.026;
    ALX[3]:=12;
    ALY[3]:=-8;
    ALZ[3]:=0;

    AAA[4]:=0.017;   // stavec L2
    BBB[4]:=0.014;
    CCC[4]:=0.0112;
    DDD[4]:=0.004;
    XXX[4]:=-0.002;
    YYY[4]:=0.008;   //// povodne 0
    ZZZ[4]:=0.04;
    ALX[4]:=-3;
    ALY[4]:=-12;
    ALZ[4]:=0 ;

    AAA[5]:=0.016;   // stavec L1
    BBB[5]:=0.013;
    CCC[5]:=0.0098;
    DDD[5]:=0.0032;
    XXX[5]:=-0.004;
    YYY[5]:=0.006;   //// povodne 0
    ZZZ[5]:=0.054;
    ALX[5]:=-8.75;
    ALY[5]:=-8.7;
    ALZ[5]:=0 ;

    AAA[6]:=0.015;   // stavec Th12
    BBB[6]:=0.0127;
    CCC[6]:=0.010;
    DDD[6]:=0.0031;
    XXX[6]:=-0.0056;
    YYY[6]:=0.003;
    ZZZ[6]:=0.0675;
    ALX[6]:=-15 ;
    ALY[6]:=-11.5;
    ALZ[6]:=0  ;

    AAA[7]:=0.013;   // stavec Th11
    BBB[7]:=0.0115;
    CCC[7]:=0.009 ;
    DDD[7]:=0.003 ;
    XXX[7]:=-0.0067;
    YYY[7]:=0 ;
    ZZZ[7]:=0.0805;
    ALX[7]:=-16;
    ALY[7]:=-9.5;
    ALZ[7]:=0 ;

    AAA[8]:=0.012;   // stavec Th10
    BBB[8]:=0.0112;
    CCC[8]:=0.0086;
    DDD[8]:=0.0029;
    XXX[8]:=-0.008;
    YYY[8]:=-0.002;
    ZZZ[8]:=0.092;
    ALX[8]:=-16 ;
    ALY[8]:=-2.5;
    ALZ[8]:=0 ;

    AAA[9]:=0.012;   // stavec Th9
    BBB[9]:=0.011;
    CCC[9]:=0.0085 ;
    DDD[9]:=0.002 ;
    XXX[9]:=-0.0082;
    YYY[9]:=-0.005;
    ZZZ[9]:=0.103;
    ALX[9]:=-6.25;
    ALY[9]:=0 ;
    ALZ[9]:=0;

    AAA[10]:=0.0115 ;    // stavec Th8
    BBB[10]:=0.0105 ;
    CCC[10]:=0.007  ;
    DDD[10]:=0.0022 ;
    XXX[10]:=-0.0072;
    YYY[10]:=-0.007 ;
    ZZZ[10]:=0.113  ;
    ALX[10]:=-1     ;
    ALY[10]:=1      ;
    ALZ[10]:=0      ;

    AAA[11]:=0.010  ;  // stavec Th7
    BBB[11]:=0.011  ;
    CCC[11]:=0.007  ;
    DDD[11]:=0.002   ;
    XXX[11]:=-0.007  ;
    YYY[11]:=-0.0065;
    ZZZ[11]:=0.123   ;
    ALX[11]:=-0.5    ;
    ALY[11]:=7       ;
    ALZ[11]:=0       ;

    AAA[12]:=0.0105  ; // stavec Th6
    BBB[12]:=0.0105  ;
    CCC[12]:=0.0072  ;
    DDD[12]:=0.002   ;
    XXX[12]:=-0.006  ;
    YYY[12]:=-0.005   ;
    ZZZ[12]:=0.132    ;
    ALX[12]:=6       ;
    ALY[12]:=6.3     ;
    ALZ[12]:=0       ;

    AAA[13]:=0.0105  ; // stavec Th5
    BBB[13]:=0.010   ;
    CCC[13]:=0.007   ;
    DDD[13]:=0.0016  ;
    XXX[13]:=-0.0045 ;
    YYY[13]:=-0.003  ; //// povodne 0
    ZZZ[13]:=0.142   ;
    ALX[13]:=9       ;
    ALY[13]:=9       ;
    ALZ[13]:=0       ;

    AAA[14]:=0.0105  ; // stavec Th4
    BBB[14]:=0.009   ;
    CCC[14]:=0.007   ;
    DDD[14]:=0.0016  ;
    XXX[14]:=-0.003  ;
    YYY[14]:=-0.001  ; //// povodne 0
    ZZZ[14]:=0.151    ;
    ALX[14]:=4       ;
    ALY[14]:=12      ;
    ALZ[14]:=0       ;

    AAA[15]:=0.0105  ; // stavec Th3
    BBB[15]:=0.0075  ;
    CCC[15]:=0.0079   ;
    DDD[15]:=0.0017   ;
    XXX[15]:=-0.0005 ;
    YYY[15]:=0       ; // povodne 0
    ZZZ[15]:=0.159   ;
    ALX[15]:=0.5     ;
    ALY[15]:=14      ;
    ALZ[15]:=0       ;

    AAA[16]:=0.012   ;// stavec Th2
    BBB[16]:=0.0068  ;
    CCC[16]:=0.007   ;
    DDD[16]:=0.002   ;
    XXX[16]:=0.0025  ;
    YYY[16]:=0.001   ;//// povodne 0
    ZZZ[16]:=0.1685  ;
    ALX[16]:=0       ;
    ALY[16]:=18      ;
    ALZ[16]:=0       ;

    AAA[17]:=0.0125  ; // stavec Th1
    BBB[17]:=0.0065  ;
    CCC[17]:=0.0062  ;
    DDD[17]:=0.0012  ;
    XXX[17]:=0.0045  ;
    YYY[17]:=0.002   ;
    ZZZ[17]:=0.1765  ;
    ALX[17]:=0       ;
    ALY[17]:=23      ;
    ALZ[17]:=0       ;


    nasob:=8000;     // docasne riadky
    Xcoor:=200;      // docasne riadky
    Ycoor:=800;      // docasne riadky
    Zcoor:=400;      // docasne riadky
    For i:=1 to 24 do
    begin
      AAA[i]:=AAA[i]*nasob;
      BBB[i]:=BBB[i]*nasob;
      CCC[i]:=CCC[i]*nasob;
      DDD[i]:=DDD[i]*nasob;
      XXX[i]:=Xcoor-XXX[i]*nasob;
      YYY[i]:=Ycoor-YYY[i]*nasob;
      ZZZ[i]:=Zcoor-ZZZ[i]*nasob;
    end;
    For i:=1 to 24 do
       begin
       ZZY[i]:=ZZZ[i];        // zuradnica z v projekcii yz zatial rovnaka ako suradnica z v projekcii xz
       ZUZ[i]:=0.125*BBB[i];  // zuzenie stavca 2.5% z rozmeru BBB
       end;

    // Vytvor selectbox a nastav ho na prvy element
    For i:=1 to 24 do  ListBox1.Items.Add(IntToStr(25-i));

    ListBox1.ItemIndex:=AktualnaPolozka;
end;

end.
