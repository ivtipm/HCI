unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Menus, Grids,
  logic; // подкллючение модуля с бизнес-логикой

type

  { TMainForm }

  TMainForm = class(TForm)
    Button_calc: TButton;
    Edit_t: TEdit;
    Edit_a: TEdit;
    Edit_tau: TEdit;
    Label_time: TLabel;
    Label_a: TLabel;
    Label_tau: TLabel;
    Label_res: TLabel;
    MainMenu1: TMainMenu;
    MenuItem_file: TMenuItem;
    MenuItem_help: TMenuItem;
    MenuItem_open: TMenuItem;
    MenuItem_save: TMenuItem;
    MenuItem_save_report: TMenuItem;
    MenuItem_exit: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    StringGrid_report: TStringGrid;
    procedure Button_calcClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem_exitClick(Sender: TObject);
    procedure MenuItem_helpClick(Sender: TObject);
    procedure MenuItem_openClick(Sender: TObject);
    procedure MenuItem_saveClick(Sender: TObject);
    procedure MenuItem_save_reportClick(Sender: TObject);

    procedure DataFromForm();                   // считывает содержимое полей ввода в переменные
  private

  public

  end;

var
  MainForm: TMainForm;

  // основные данные программы
  a,tau, t, Y: Real;
  // a, tau - параметры уравнения роста популяции
  // t - момент времени, для которого вычисляется размер популяции
  // Y - размер популяции

  // Основные данные программы обязательно должны хранится в отдельных переменных,
  // а не исключительно в окне программы


  calculations: array [1..128] of Calculation; // хранит историю вычислений
  last_ind: integer;  // индекс последнего элеента записанного в массив calculations


implementation

{$R *.lfm}

{ TMainForm }

// Этот обработчик вызывается при создании формы,
// т.е. в  начале запуска программы
procedure TMainForm.FormCreate(Sender: TObject);
begin
  last_ind := 0;
end;


procedure TMainForm.DataFromForm();
begin
  // функция TryStrToFloat пытается конвертировать строку в вещественное число (второй параметр)
  // если удаётся, то возвращает true. Если нет - false
  if TryStrToFloat(Edit_a.Text, a) = false then
    begin
    Edit_a.Color:= clGradientActiveCaption;
    ShowMessage('Неправильно введён параметр a');
    exit;
    // сразу выходим из процедуры если поле ввода для a заполнено неправильно.
    // проверять остальные поля ввода не будем, ведь запускать вычисления нет смысла,
    // а если следующие поля ввода тоже заполнены неправильно,
    // то второе подряд сообщение об ошибке пользователю скорее всего не понравится.
    // Тем более велика вероятность, что пользователь обратит внимание на остальные поля ввода,
    // как только увидит что первое заполнено неверно
    end;

  if TryStrToFloat(Edit_tau.Text, tau) = false then
      begin
      ShowMessage('Неправильно введён параметр tau');
      exit;
      end;

    if TryStrToFloat(Edit_t.Text, t) = false then
      begin
      ShowMessage('Неправильно введён параметр t');
      exit;
      end;
end;



// Выход
procedure TMainForm.MenuItem_exitClick(Sender: TObject);
begin
  MainForm.Close;
end;


// показать информацию о программе
procedure TMainForm.MenuItem_helpClick(Sender: TObject);
begin
     ShowMessage('Программа вычисляет размер популяции по формуле Y = a * exp (t / tau ).   Автор: ... ');
end;


// Открыть файл с параметрами
procedure TMainForm.MenuItem_openClick(Sender: TObject);
begin
    if SaveDialog.Execute then
      begin
        if SaveDialog.FileName <> '' then  // пользователь мог не выбрать имя файла, а просто закрыть окно//
          begin
          load_params(a, tau, t, SaveDialog.FileName);
          Edit_a.Text   := floattostr( a );
          Edit_tau.Text := floattostr( tau );
          Edit_t.Text   := floattostr( t );
          end;
      end;

end;


// Сохранить параметры
procedure TMainForm.MenuItem_saveClick(Sender: TObject);
begin
    if SaveDialog.Execute then
        if SaveDialog.FileName <> '' then  // пользователь мог не выбрать имя файла, а просто закрыть окно
          begin
          // получение данных с формы
          DataFromForm();
          save_params(a,tau,t, SaveDialog.FileName);
          end;
end;


// Сохранить отчёт
procedure TMainForm.MenuItem_save_reportClick(Sender: TObject);
begin
  //if SaveDialog.Execute then
  //  if SaveDialog.FileName <> '' then
  //    Memo_report.Lines.SaveToFile( SaveDialog.FileName );
end;


// основные вычисления
procedure TMainForm.Button_calcClick(Sender: TObject);
var
  last_calc: Calculation;
begin
     // получение данных с формы
     DataFromForm();

     // вычисление
     Y:=calc_population(a, tau, t);

     last_calc.a:=a;
     last_calc.tau:=tau;
     last_calc.t:=t;
     last_calc.population:=Y;

     inc(last_ind);
     calculations[last_ind]:=last_calc;

     // запись результата на форму
     StringGrid_report.RowCount:= last_ind + 1;

     // код ниже можно вынести в отдельный метод и брать данные из calculations
     // при обрещения к ячейкам сначала идёт номер столбца, потом номер строки
     StringGrid_report.Cells[1, last_ind] := floattostr(a);
     StringGrid_report.Cells[2, last_ind] := floattostr(tau);
     StringGrid_report.Cells[3, last_ind] := floattostr(t);
     StringGrid_report.Cells[4, last_ind] := floattostr(round(Y*100)/100);
end;

end.

