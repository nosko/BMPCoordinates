unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32_Image, GR32, StdCtrls, GR32_Layers, INIFiles;

const Setts : String = 'config.ini';

type
  TfMain = class(TForm)
    //Img: TImage32;
    bLoad: TButton;
    bClose: TButton;
    Open: TOpenDialog;
    Label1: TLabel;
    fitPx: TEdit;
    fitReal: TEdit;
    Label2: TLabel;
    Button1: TButton;
    cbUnit: TComboBox;
    Button2: TButton;
    Button3: TButton;
    Img: TImage32;
    procedure bCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bLoadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure fitPxChange(Sender: TObject);
    procedure fitRealChange(Sender: TObject);
    procedure ImgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure cbUnitChange(Sender: TObject);
    procedure SaveConfig;
    procedure LoadConfig;
    procedure ImgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure ImgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer;
      Layer: TCustomLayer);
    procedure KresliStavce(Sender: TObject);
    Procedure nplotXZ(odStavca,PoStavec:longint; Mierka:single; Farba:longint);  //uzly stavca
    Procedure nplotYZ(odStavca,PoStavec:longint; Mierka:single; Farba:longint);
    Procedure lplotXZ(odStavca,PoStavec:longint; Mierka:single; Farba:longint);  // obrysy stavca
    Procedure lplotYZ(odStavca,PoStavec:longint; Mierka:single; Farba:longint);
    procedure IMGCSlateral(Sender: TObject);

  private
    { Private declarations }
    procedure Resize;
    procedure ChangeRuler;
  public
    { Public declarations }
  end;

var
  fMain                     : TfMain;
  Bmp                       : TBitmap;
  P1,P2                     : TPoint;
  floatPx, floatReal        : Extended;
  AppStatus                 : String;
  StlacenyButtonLeft        : boolean;
  Xorigin,Yorigin,Zorigin   : single;

implementation

uses ruler,stavce, Matrix;

{$R *.dfm}

{ TForm1 }

procedure TfMain.bCloseClick(Sender: TObject);
begin
Application.Terminate;
end;

procedure TfMain.bLoadClick(Sender: TObject);
begin
 if Open.Execute then begin
  Bmp.FreeImage;
  Bmp.LoadFromFile(Open.FileName);
  Resize;
  Img.SetupBitmap(True, clWhite32);
  Img.Bitmap.LoadFromFile(Open.FileName);
end;
end;

procedure TfMain.Button1Click(Sender: TObject);
begin
  //fRuler.Show;
  fRuler.ShowModal;
end;

procedure TfMain.KresliStavce(Sender: TObject);
var MierkaXZ,MierkaYZ      :single;
    Farba                  :longint;
begin

  UzlyStavca(3);
  MierkaXZ := 1000*floatPx / floatReal;
  Farba:=clRed;
  lplotXZ(1,3,MierkaXZ, Farba);

  Farba:=clBlue;
  MierkaYZ := 1000*floatPx / floatReal;
  lplotYZ(1,3,MierkaYZ,Farba);
end;

procedure TfMain.cbUnitChange(Sender: TObject);
begin
if AppStatus = 'Init' then Exit;
ChangeRuler;
end;

procedure TfMain.fitPxChange(Sender: TObject);
begin
if AppStatus = 'Init' then Exit;
if fitPx.Text = '' then Exit;
floatPx := StrToFloat(fitPx.Text);
ChangeRuler;
end;

procedure TfMain.fitRealChange(Sender: TObject);
begin
if AppStatus = 'Init' then Exit;
if fitReal.Text = '' then Exit;
floatReal := StrToFloat(fitReal.Text);
ChangeRuler;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
AppStatus := 'Init';
StlacenyButtonLeft:=false;
Bmp := TBitmap.Create;
Open.InitialDir := ExtractFilePath(Application.ExeName);

P1.X := 0;
P1.Y := 0;
P2.X := 0;
P2.Y := 0;

floatPx := 10;
floatReal := 1;

LoadConfig;

AppStatus := 'Loaded';
Nini(MaxPocetUzlov);   // inicializacia poli suradnic uzlov stavcov

end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
Bmp.Free;
SaveConfig;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
fRuler.Left := fMain.Width - fRuler.Width - 20;
fRuler.Top := fMain.Height - fRuler.Height - 20;
fRuler.Show;

Form1.Left := fMain.Width - Form1.Width - 20;
Form1.Top := fMain.Height - Form1.Height - fRuler.Height - 30;
Form1.Show;

Form1.loadData;
Form1.initTextFields;

ChangeRuler;
end;

procedure TfMain.Resize;
begin
 Img.Top := 40;
 Img.Left := 0;
 Img.ClientHeight := Bmp.Height;
 Img.ClientWidth := Bmp.Width;
end;

procedure TfMain.SaveConfig;
var f : TINIFile;
begin
f := TINIFile.Create(ExtractFilePath(Application.ExeName)+Setts);
f.WriteString('App','Units', cbUnit.Text);
f.WriteString('App','fitPx', fitPx.Text);
f.WriteString('App','fitReal', fitReal.Text);
f.Free;
end;

procedure TfMain.LoadConfig;
var f : TINIFile;
begin
f := TINIFile.Create(ExtractFilePath(Application.ExeName)+Setts);
cbUnit.Text := f.ReadString('App','Units', 'mm');
fitPx.Text := f.ReadString('App','fitPx', '10');
fitReal.Text := f.ReadString('App','fitReal', '1');
f.Free;
end;

procedure TfMain.ChangeRuler;
begin
  fRuler.ShowPointsCoordinates;
end;


procedure TfMain.IMGCSlateral(Sender: TObject);
begin
   Xorigin:=P1.X;
   Zorigin:=P1.Y;
   fMain.Img.Canvas.Pen.Color:=clYellow;
   fMain.Img.Canvas.Pen.Width:=15;
   fMain.Img.Canvas.MoveTo(P1.X,P1.Y);
   fMain.Img.Canvas.LineTo(P1.X,P1.Y);
   fMain.Img.Canvas.Pen.Color:=clBlack;
   fMain.Img.Canvas.Pen.Width:=2;
   fMain.Img.Canvas.MoveTo(P1.X,P1.Y);
   fMain.Img.Canvas.LineTo(P1.X,P1.Y);
end;



procedure TfMain.ImgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 if Button= mbLeft then
  begin
  if not StlacenyButtonLeft then
    begin
    P1.X := X;
    P1.Y := Y;
    end;
  StlacenyButtonLeft:=true;
  ChangeRuler;
  end;
end;

procedure TfMain.ImgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer; Layer: TCustomLayer);
begin
if StlacenyButtonLeft then
  begin
  fMain.Img.Repaint;
  P2.X := X;
  P2.Y := Y;
  fMain.Img.Canvas.Pen.Color:=clRed;
  fMain.Img.Canvas.Pen.Width:=1;
  fMain.Img.Canvas.MoveTo(P1.X,P1.Y);
  fMain.Img.Canvas.LineTo(P2.X,P2.Y);
  ChangeRuler;
  end;
  ChangeRuler;
end;

procedure TfMain.ImgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
 StlacenyButtonLeft:=false;
 if Button= mbLeft then
  begin
//  StlacenyButtonLeft:=false;
//  fMain.Img.Repaint;
  P2.X := X;
  P2.Y := Y;
  fMain.Img.Canvas.Pen.Color:=clBlue;
  fMain.Img.Canvas.Pen.Width:=5;
  if (p1.x<>p2.X) and (p1.Y <> p2.y) then
     begin
     fMain.Img.Canvas.MoveTo(P1.X,P1.Y);
     fMain.Img.Canvas.LineTo(P2.X,P2.Y);
     end;
  ChangeRuler;
  end;
end;

Procedure BodXZ(Uzol:longint; Mierka:single; Farba, Hrubka:longint);
var
     x,y     :integer;
begin
 fMain.Img.Canvas.Pen.Color:=Farba;
 fMain.Img.Canvas.Pen.Width:=Hrubka;
 x:=400- Round(NX[Uzol]*Mierka);
 y:=400- Round(NZ[Uzol]*Mierka);
 fMain.Img.Canvas.MoveTo(x,y);
 fMain.Img.Canvas.LineTo(x,y);
 end;

Procedure CiaraXZ(Uzol:longint; Mierka:single; Farba, Hrubka:longint);
var
     x,y     :integer;
begin
 fMain.Img.Canvas.Pen.Color:=Farba;
 fMain.Img.Canvas.Pen.Width:=Hrubka;
 x:=400- Round(NX[Uzol]*Mierka);
 y:=400- Round(NZ[Uzol]*Mierka);
 fMain.Img.Canvas.LineTo(x,y);
 end;



Procedure BodYZ(Uzol:longint; Mierka:single; Farba, Hrubka:longint);
var
     x,y     :integer;
begin
 fMain.Img.Canvas.Pen.Color:=Farba;
 fMain.Img.Canvas.Pen.Width:=Hrubka;
 x:=800- Round(NY[Uzol]*Mierka);
 y:=400- Round(NZ[Uzol]*Mierka);
 fMain.Img.Canvas.MoveTo(x,y);
 fMain.Img.Canvas.LineTo(x,y);
 end;

Procedure CiaraYZ(Uzol:longint; Mierka:single; Farba, Hrubka:longint);
var
     x,y     :integer;
begin
 fMain.Img.Canvas.Pen.Color:=Farba;
 fMain.Img.Canvas.Pen.Width:=Hrubka;
 x:=800- Round(NY[Uzol]*Mierka);
 y:=400- Round(NZ[Uzol]*Mierka);
 fMain.Img.Canvas.LineTo(x,y);
 end;

Procedure KresliBodyStavcaProjekciaXZ(Stavec:longint; Mierka:single; Farba, Hrubka:longint);
var j:longint;
begin
   for j:= Stavec*6000+1200 to Stavec*6000+9800 do BodXZ(j,Mierka,Farba,Hrubka);
end;

Procedure KresliBodyStavcaProjekciaYZ(Stavec:longint; Mierka:single; Farba, Hrubka:longint);
var j:longint;
begin
   for j:= Stavec*6000+1200 to Stavec*6000+9800 do BodYZ(j,Mierka,Farba,Hrubka);
end;

Procedure KresliObvodStavcaProjekciaXZ(ZC:longint; Mierka:single; Farba:longint);
var j, Hrubka   :longint;

begin
   Hrubka:=1;
   BodXZ  (ZC+  1,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+  3,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+  8,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 14,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 20,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 24,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 30,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 40,Mierka,Farba,Hrubka);
   for j:= 54 to 63 do   CiaraXZ(ZC+ j,Mierka,Farba,Hrubka);
   Hrubka:=2;
   for j:= 64 to 72 do   CiaraXZ(ZC+ j,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 47,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 35,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 27,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 22,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 17,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+ 11,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+  6,Mierka,Farba,Hrubka);
   CiaraXZ(ZC+  1,Mierka,Farba,Hrubka);
end; //KresliObvodStavcaProjekciaXZ

Procedure KresliObvodStavcaProjekciaYZ(ZC:longint; Mierka:single; Farba:longint);
var j, Hrubka   :longint;
begin
   Hrubka:=2;
   BodYZ  (ZC+  1,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+  3,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+  8,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 14,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 20,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 24,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 30,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 40,Mierka,Farba,Hrubka);
   Hrubka:=1;
   for j:= 54 to 72 do   CiaraYZ(ZC+ j,Mierka,Farba,Hrubka);
   Hrubka:=2;
   CiaraYZ(ZC+ 47,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 35,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 27,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 22,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 17,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+ 11,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+  6,Mierka,Farba,Hrubka);
   CiaraYZ(ZC+  1,Mierka,Farba,Hrubka);
end; //KresliObvodStavcaProjekciaYZ

Procedure KresliZvisleLinieStavcaProjekciaXZ(ZC:longint; Mierka:single; Farba:longint);
var j, Hrubka   :longint;
  Procedure Linia(C:longint);
  var k:longint;
    begin
    BodXZ(C,Mierka,Farba,Hrubka);
    for k := 1 to 9 do CiaraXZ(C+300*(k-1),Mierka,Farba,Hrubka);
    end;
begin
   Hrubka:=1;
   Linia(ZC+  1);
   Linia(ZC+  3);
   Linia(ZC+  8);
   Linia(ZC+ 14);
   Linia(ZC+ 20);
   Linia(ZC+ 24);
   Linia(ZC+ 30);
   Linia(ZC+ 40);
   for j:= 54 to 63 do Linia(ZC+ j);
   Hrubka:=2;
   for j:= 64 to 72 do Linia(ZC+ j);
   Linia(ZC+ 47);
   Linia(ZC+ 35);
   Linia(ZC+ 27);
   Linia(ZC+ 22);
   Linia(ZC+ 17);
   Linia(ZC+ 11);
   Linia(ZC+  6);
   Linia(ZC+  1);
end; //KresliZvisleLinieStavcaProjekciaXZ

Procedure KresliZvisleLinieStavcaProjekciaYZ(ZC:longint; Mierka:single; Farba:longint);
var j, Hrubka   :longint;
  Procedure Linia(C:longint);
  var k:longint;
    begin
    BodYZ(C,Mierka,Farba,Hrubka);
    for k := 1 to 9 do CiaraYZ(C+300*(k-1),Mierka,Farba,Hrubka);
    end;
begin
   Hrubka:=2;
   Linia(ZC+  1);
   Linia(ZC+  3);
   Linia(ZC+  8);
   Linia(ZC+ 14);
   Linia(ZC+ 20);
   Linia(ZC+ 24);
   Linia(ZC+ 30);
   Linia(ZC+ 40);
   Hrubka:=1;
   for j:= 54 to 72 do Linia(ZC+ j);
   Hrubka:=2;
   Linia(ZC+ 47);
   Linia(ZC+ 35);
   Linia(ZC+ 27);
   Linia(ZC+ 22);
   Linia(ZC+ 17);
   Linia(ZC+ 11);
   Linia(ZC+  6);
   Linia(ZC+  1);
end; //KresliZvisleLinieStavcaProjekciaYZ


Procedure TfMain.nplotXZ(odStavca,PoStavec:longint; Mierka:single; Farba:longint);
var   i,CS, Hrubka  :longint;
begin
   Hrubka:=1;
   for i:= odStavca to PoStavec do
     begin
     CS:=i*PosunC;
     KresliBodyStavcaProjekciaXZ(i,Mierka, Farba, Hrubka);
     end;
end;  // nplotXZ

Procedure TfMain.nplotYZ(odStavca,PoStavec:longint; Mierka:single; Farba:longint);
var   i,CS, Hrubka  :longint;
begin
   Hrubka:=1;
   for i:= odStavca to PoStavec do
     begin
     CS:=i*PosunC;
     KresliBodyStavcaProjekciaYZ(i,Mierka, Farba, Hrubka);
     end;
end;  // nplotYZ


Procedure TfMain.lplotXZ(odStavca,PoStavec:longint; Mierka:single; Farba:longint);
var   i,CS   :longint;
begin
   for i:= odStavca to PoStavec do
     begin
     CS:=i*PosunC;
     KresliObvodStavcaProjekciaXZ(CS+1200,Mierka,Farba);
     KresliObvodStavcaProjekciaXZ(CS+1500,Mierka,Farba);
     KresliObvodStavcaProjekciaXZ(CS+1800,Mierka,Farba);
     KresliObvodStavcaProjekciaXZ(CS+2100,Mierka,Farba);
     KresliObvodStavcaProjekciaXZ(CS+2400,Mierka,Farba);
     KresliObvodStavcaProjekciaXZ(CS+2700,Mierka,Farba);
     KresliObvodStavcaProjekciaXZ(CS+3000,Mierka,Farba);
     KresliObvodStavcaProjekciaXZ(CS+3300,Mierka,Farba);
     KresliObvodStavcaProjekciaXZ(CS+3600,Mierka,Farba);
     KresliZvisleLinieStavcaProjekciaXZ(CS+1200,Mierka,Farba);
     end;
end;  // lplotXZ

Procedure TfMain.lplotYZ(odStavca,PoStavec:longint; Mierka:single; Farba:longint);
var   i,CS :longint;
begin
   for i:= odStavca to PoStavec do
     begin
     Farba:=i;
     CS:=i*PosunC;
     KresliObvodStavcaProjekciaYZ(CS+1200,Mierka,Farba);
     KresliObvodStavcaProjekciaYZ(CS+1500,Mierka,Farba);
     KresliObvodStavcaProjekciaYZ(CS+1800,Mierka,Farba);
     KresliObvodStavcaProjekciaYZ(CS+2100,Mierka,Farba);
     KresliObvodStavcaProjekciaYZ(CS+2400,Mierka,Farba);
     KresliObvodStavcaProjekciaYZ(CS+2700,Mierka,Farba);
     KresliObvodStavcaProjekciaYZ(CS+3000,Mierka,Farba);
     KresliObvodStavcaProjekciaYZ(CS+3300,Mierka,Farba);
     KresliObvodStavcaProjekciaYZ(CS+3600,Mierka,Farba);
     KresliZvisleLinieStavcaProjekciaYZ(CS+1200,Mierka,Farba);
     end;
end;  // lplotYZ

end.