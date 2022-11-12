program FoflonkerAdam_PAT2022_p;

uses
  Vcl.Forms,
  MainForm in 'Source\MainForm.pas' {Form1},
  AdminLoginForm in 'Source\AdminLoginForm.pas' {Form2},
  Team in 'Source\Team.pas',
  MainDatabase in 'Source\MainDatabase.pas',
  Fixture in 'Source\Fixture.pas',
  JsonSerializer in 'Source\JsonSerializer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
