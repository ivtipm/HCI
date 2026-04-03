unit unit_window;
// Автор: ....
// Задание: https://github.com/ivtipm/HCI/blob/master/plans/2025/plan.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-2-%D0%BF%D1%80%D0%BE%D1%81%D1%82%D0%B0%D1%8F-%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B0-%D1%81-gui

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ActnList, Menus, geometry // модуль для вычислений
  ;

type


  { TMainForm }
  // TMainForm -- тип данных (класс), описывабщий главное окно
  TMainForm = class(TForm)

    Action_calc: TAction;
    ActionList: TActionList;

    // Поля класса (здесь это всё элементы интерфейса)
    Button_cacl: TButton;
    Edit_a: TEdit;       // Поле для длины основания треугольника
    Edit_h: TEdit;       // Поле для высоты
    Image: TImage;
    Image_background: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label_s: TLabel;     // Label для вывода площади

    Memo_report: TMemo;

    MainMenu: TMainMenu;
    MenuItem_load_report: TMenuItem;
    MenuItem_save_report: TMenuItem;
    MenuItem_author: TMenuItem;
    MenuItem_Exit: TMenuItem;
    MenuItem_Load: TMenuItem;
    MenuItem_Save: TMenuItem;
    MenuItem_File: TMenuItem;
    MenuItem_about: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;

    // Обработчики событий:
    // Обработчик событий нажатие для кнопки
    procedure Button_caclClick(Sender: TObject);
    procedure MenuItem_authorClick(Sender: TObject);
    procedure MenuItem_ExitClick(Sender: TObject);
    procedure MenuItem_LoadClick(Sender: TObject);
    procedure MenuItem_load_reportClick(Sender: TObject);
    procedure MenuItem_SaveClick(Sender: TObject);
    procedure MenuItem_save_reportClick(Sender: TObject);

    /// .....
    function read_and_check_values(): boolean;

  private

      // ...
      a, h: Real;

  public

  end;



var
  // Переменная MainForm - окно программы
  MainForm: TMainForm;

const
  // цвет обозначающий ошибку
  color_error = TColor( $503ed6  ); // формат цвета BGR
  // $ обозначает что число записано в системе счисления по основания не 10, а 16


implementation

{$R *.lfm}

{ TMainForm }


/// .....
function TMainForm.read_and_check_values(): boolean;
var
  is_error: boolean;
begin
     is_error := False;
     Edit_a.Font.Color := clBlack;
     Edit_h.Font.Color := clBlack;

          ///
          if not TryStrToFloat( Edit_a.Text, a ) then
             begin
               a := 0;
               Memo_report.Lines.Append('Ошибка задания длины основания');

               Edit_a.Font.Color := color_error;

               is_error := True;
             end;

          if not TryStrToFloat( Edit_h.Text, h ) then
             begin
               h := 0;
               Memo_report.Lines.Append('Ошибка задания высоты');
               Edit_h.Font.Color := color_error;
               is_error := True;
             end;


          if a < 0 then
             begin
                Memo_report.Lines.Append('Длина основания не может быть отрицательной');
                Edit_a.Font.Color := color_error;
                is_error := True;
             end;


          if h < 0 then
             begin
                Memo_report.Lines.Append('Высота не может быть отрицательной');
                Edit_h.Font.Color := TColor( $503ed6  );
                is_error := True;
             end;

          result := is_error;
end;


// Обрабочик события - нажатие на кнопку
procedure TMainForm.Button_caclClick(Sender: TObject);
var
  // длина оснвоания, высота, площадь трегольника
  s : Real;
  is_error: boolean;
begin

     is_error := read_and_check_values();

     if is_error = False then
        begin
           s := triangle_area( a, h );

           Label_s.Caption := FloatToStr( s );

           Memo_report.Lines.Append( 'a = ' + FloatToStr(a) + ', h = '  + FloatToStr(h) + '; S = ' + FloatToStr(s) );
          // см. Format
     end;

end;


// Обработчик события: Пунт меню Об авторе
procedure TMainForm.MenuItem_authorClick(Sender: TObject);
begin
     ShowMessage( 'Автор: Ветров С.В. ' );
end;


// Обработчик события: выход
procedure TMainForm.MenuItem_ExitClick(Sender: TObject);
begin
     Close;
end;


// Обработчик события: Загрузка данных в поля ввода из файла
procedure TMainForm.MenuItem_LoadClick(Sender: TObject);
begin

     if OpenDialog.Execute then
        begin
             load_triangle_data( OpenDialog.FileName, a, h );

             Edit_a.Text := FloatToStr(a);
             Edit_h.Text := FloatToStr(h);
        end;

end;


// Загрузка отчёта
procedure TMainForm.MenuItem_load_reportClick(Sender: TObject);
begin
     if OpenDialog.Execute then
     begin
          Memo_report.Lines.LoadFromFile( SaveDialog.FileName );
     end;
end;


// Обработчик события: Сохранение данных из полей ввода в файл
procedure TMainForm.MenuItem_SaveClick(Sender: TObject);
var
  filename: string;
  file_data: Text; // файловая переменная
begin

     if read_and_check_values() = False then
        begin

         if SaveDialog.Execute then                       // SaveDialog.Execute - показать окно выбора файла

         begin
         filename := SaveDialog.FileName;

         AssignFile ( file_data, filename );
         Rewrite( file_data );

         writeln(file_data, a);
         writeln(file_data, h);

         CloseFile( file_data );
         end;
        end;
end;


// Сохранение отчёта
procedure TMainForm.MenuItem_save_reportClick(Sender: TObject);
begin
      if SaveDialog.Execute then
      begin
           Memo_report.Lines.SaveToFile( SaveDialog.FileName );
      end;
end;

end.

