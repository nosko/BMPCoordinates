unit ruler;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, main, MAth;

type
  TfRuler = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    pX1: TLabel;
    pY1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    pY2: TLabel;
    pX2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    dpX: TLabel;
    Label5: TLabel;
    dpY: TLabel;
    Label9: TLabel;
    dY: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    dX: TLabel;
    Label12: TLabel;
    delta: TLabel;
    Label11: TLabel;
    fPxReal: TLabel;
    fit: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Clear;
    procedure ShowPointsCoordinates;
  end;

var
  fRuler: TfRuler;

implementation

{$R *.dfm}

{ TfRuler }

procedure TfRuler.Clear;
begin
  pX1.Caption := '';
  pY1.Caption := '';
  pX2.Caption := '';
  pY2.Caption := '';
  dpX.Caption := '';
  dpY.Caption := '';
  dX.Caption := '';
  dY.Caption := '';
  delta.Caption := '';
  fPxReal.Caption  := '';
  fit.Caption := '';
end;

procedure TfRuler.ShowPointsCoordinates;
var Mierka, realX, realY : Extended;
begin
  pX1.Caption := FloatToStr(P1.X);
  pY1.Caption := FloatToStr(P1.Y);
  pX2.Caption := FloatToStr(P2.X);
  pY2.Caption := FloatToStr(P2.Y);

  dpX.Caption := FormatFloat('#.####',Abs(P2.X - P1.X));
  dpY.Caption := FormatFloat('#.####',Abs(P2.Y - P1.Y));

  Mierka := floatPx / floatReal;
  fPxReal.Caption  := FormatFloat('#.####',floatPx) + 'px = ' + FormatFloat('#.##',floatReal) + fMain.cbUnit.Text;
  fit.Caption := FormatFloat('#.######',Mierka);

  // realna vzdialenost
  realX := Abs(P2.X - P1.X) / Mierka;
  realY := Abs(P2.Y - P1.Y) / Mierka;
  dX.Caption := FloatToStr(realX) + ' '+ fMain.cbUnit.Text;
  dY.Caption := FloatToStr(realY) + ' '+ fMain.cbUnit.Text;
  delta.Caption := FormatFloat('0.#####',SQRT(Power(realX,2)+Power(realY,2))) + ' '+ fMain.cbUnit.Text;
end;


end.
