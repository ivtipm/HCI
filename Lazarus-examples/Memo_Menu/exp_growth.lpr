program exp_growth;
// Автор: ...
// Основной файл программы. Создаёт и показывает окно.


{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, mainwindow, logic;
  { you can add units after this }

{$R *.res}


begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);    // Создание окна
  Application.Run;                                // Запуск главного цикла обработки сообщений
end.

