unit mainwindow;
// Автор: ...
// Основной модуль программы
// Содержит обработчики событий главного окна
// F12 для переключения на форму (или Вид > Переключить форму\модуль)
// Посмотреть остальные модули проекта: Ctrl + F12 (или Проект > Модули)


{$mode objfpc}{$H+}
// {$H+} — устанавливает тип строк по умолчанию как AnsiString (длинные строки с динамическим управлением памятью).
// {$mode objfpc} — включает режим Object Pascal с поддержкой ООП.

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  Math,                     // модуль с математическими функциями и константами
  Menus, ExtCtrls,
  LCLType,                  // Модуль с константами для MessageBox
  logic;                    // подключение модуля с бизнес-логикой

type

  { TMainForm }

  // Класс TMainForm описывает окно программы
  // Класс - составной тип данных, определяемый программистом;
  // может содержать переменные (поля) и процедуры\функции (методы)
  TMainForm = class(TForm)
    // поля класса TMainForm:
    // здесь это всё компоненты на форме; они добавлены через дизайнер форм
    Button_calc: TButton;
    // Поля ввода:
    Edit_t: TEdit;       // параметр t - время
    Edit_a: TEdit;       // параметр a - начальный размер популяции
    Edit_tau: TEdit;     // параметр скорости роста популяции - tau

    // Подписи
    Label1: TLabel;
    Label_time: TLabel;
    Label_a: TLabel;
    Label_tau: TLabel;
    Label_res: TLabel;      // Показывает результат вычислений - размер популяции

    // Многострочное поле, для вывода отчётов о вычислении
    Memo_report: TMemo;

    // ! по названию компонентов можно догадаться для чего они используются

    MainMenu: TMainMenu;          // главное меню
    // Пункты меню (редактируются через дизайнер форм: ПКМ на MainMenu > редактор меню
    MenuItem_file: TMenuItem;
    MenuItem_help: TMenuItem;
    MenuItem_open: TMenuItem;
    MenuItem_save: TMenuItem;
    MenuItem_save_report: TMenuItem;
    MenuItem_exit: TMenuItem;

    // Компоненты для диалоговых окон выбора файла для открытия и сохранения
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;

    // Картинки. См. свойство Picture
    Image_plot: TImage;              // график
    Image_formula: TImage;           // формула

    // Обработчики событий:
    // Клик на кнопку Считать
    procedure Button_calcClick(Sender: TObject);
    // Обработчик события Создание формы. Вызывается один раз при старте программы.
    procedure FormCreate(Sender: TObject);
    // Обработчики событий - клики на пункты меню
    procedure MenuItem_exitClick(Sender: TObject);        // Выход
    procedure MenuItem_helpClick(Sender: TObject);        // Справка
    procedure MenuItem_openClick(Sender: TObject);        // Открыть файл с параметрами
    procedure MenuItem_saveClick(Sender: TObject);        // Сохранить файл с параметрами
    procedure MenuItem_save_reportClick(Sender: TObject); // Сохранить отчёт

     // считывает содержимое полей ввода в переменные; создана вручную
     // возвращает true если данные введены корректно
    function DataFromForm():boolean;

  private

  public

  end;


var
  // Переменная - главное окно программы
  MainForm: TMainForm;

  // основные данные программы
  a,tau, t, Y: Real;
  // a, tau - параметры уравнения роста популяции
  // t - момент времени, для которого вычисляется размер популяции
  // Y - размер популяции

  // ! Основные данные программы обязательно должны хранится в отдельных переменных,
  // а не исключительно в окне (лейблах и полях ввода) программы


implementation

// Указывается имя файла с описанием окна
{$R *.lfm}

{ TMainForm }

// выполняется перед отображением окна при запуске программы
procedure TMainForm.FormCreate(Sender: TObject);
// все процедуры и функции описанные в TMainForm выше должны приводится в
// разделе implementation с именем, которое начинается с TMainForm

begin

end;


// считывает содержимое полей ввода в переменные;
function TMainForm.DataFromForm():boolean;
const
  error_color = $b5b5ff;
   // $b5b5ff - шестнадцатеричное число (начинается с $) - цвет в формате BGR
   // todo: перенести в начало модуля, на видное место

begin
  // предположим, что пользователь не ошибётся при вводе данных
  result:=true;

  // функция TryStrToFloat пытается конвертировать строку в вещественное число (второй параметр)
  // если удаётся, то возвращает true. Если нет - false
  if TryStrToFloat(Edit_a.Text, a) = false then
    begin
    // todo: проверить само число

    Edit_a.Color:= TColor( error_color );

    // Так делать не нужно:
    // ShowMessage('Неправильно введён параметр a');

    // так лучше:
    Memo_report.Lines.Add('Параметр a введён неправильно');
    // ещё можно показать эту надпись в специальном лейбле или в строке состояния

    result:= false;
    end
  else
    Edit_a.Color:= clWhite;

  if TryStrToFloat(Edit_tau.Text, tau) = false then
      begin
      Edit_tau.Color:= TColor( error_color );
      Memo_report.Lines.Add('Параметр tau введён неправильно');
      result:= false;;
      end
    else
      Edit_a.Color:= clWhite;

    if TryStrToFloat(Edit_t.Text, t) = false then
      begin
      Edit_t.Color:= TColor( error_color );
      Memo_report.Lines.Add('Параметр t введён неправильно');
      result:= false;;
      end
    else
      Edit_a.Color:= clWhite;
end;



// Обработчик события - клик на пункт меню Выход
procedure TMainForm.MenuItem_exitClick(Sender: TObject);
begin
  MainForm.Close;   // закрывает окно, автоматически закроется и программа
end;


// Обработчик события - клик на пункт меню Показать информацию о программе
procedure TMainForm.MenuItem_helpClick(Sender: TObject);
begin
     Application.MessageBox('Программа вычисляет размер популяции по формуле Y = a * exp (t / tau ).  Автор: ... ',    // содержимое окна
                            'О Программе',                                                                              // заголовок окна
                            MB_OK);                                           // какие кнопки показывать

     //ShowMessage('Программа вычисляет размер популяции по формуле Y = a * exp (t / tau ).   Автор: ... ');
end;


// Обработчик события - клик на пункт меню Открыть файл с параметрами
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


// Обработчик события - клик на пункт меню Сохранить параметры
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


// Обработчик события - клик на пункт меню Сохранить отчёт
procedure TMainForm.MenuItem_save_reportClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    if SaveDialog.FileName <> '' then
      Memo_report.Lines.SaveToFile( SaveDialog.FileName );
end;


// основные вычисления - обработчик нажатия на кнопку Считать
procedure TMainForm.Button_calcClick(Sender: TObject);
begin
     // получение данных с формы
     if DataFromForm() then
       begin
         // вычисление
         Y:=calc_population(a, tau, t);

         // запись результата на форму
         Memo_report.Append(floattostr( a ) + '*exp(' + floattostr( t ) + ' / ' + floattostr( tau ) + ' ) = ' +
                                        floattostr( RoundTo(Y, -2) ) );
       end;
end;

end.

