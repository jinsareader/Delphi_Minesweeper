program mineproject;

uses
  Vcl.Forms,
  mineunit2 in 'mineunit2.pas',
  mineunit in 'mineunit.pas' {Form1},
  mineunit3 in 'mineunit3.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
