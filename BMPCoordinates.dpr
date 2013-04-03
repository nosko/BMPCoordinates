program BMPCoordinates;

uses
  Forms,
  main in 'main.pas' {fMain},
  ruler in 'ruler.pas' {fRuler},
  Stavce in 'Stavce.pas',
  Matrix in 'Matrix.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfRuler, fRuler);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
