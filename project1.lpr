program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, dbflaz, tachartlazaruspkg, Unit1, Unit2, Unit3
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
//  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
//  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

