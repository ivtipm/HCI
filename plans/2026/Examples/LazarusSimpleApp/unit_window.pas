unit unit_window;
// Автор: ....
// Задание: https://github.com/ivtipm/HCI/blob/master/plans/2025/plan.md#%D0%B7%D0%B0%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-2-%D0%BF%D1%80%D0%BE%D1%81%D1%82%D0%B0%D1%8F-%D0%BF%D1%80%D0%BE%D0%B3%D1%80%D0%B0%D0%BC%D0%BC%D0%B0-%D1%81-gui

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  geometry // модуль для вычислений
  ;

type


  { TMainForm }
  // TMainForm -- тип данных (класс), описывабщий главное окно
  TMainForm = class(TForm)
    // Поля класса (здесь это всё элементы интерфейса)
    Button_cacl: TButton;
    Edit_a: TEdit;       // Поле для длины основания треугольника
    Edit_h: TEdit;       // Поле для высоты
    Image: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label_s: TLabel;     // Label для вывода площади
    Memo_report: TMemo;

    // Обработчики событий:
    // Обработчик событий нажатие для кнопки
    procedure Button_caclClick(Sender: TObject);
  private

  public

  end;



var
  // Переменная MainForm - окно программы
  MainForm: TMainForm;



implementation

{$R *.lfm}

{ TMainForm }




// Обрабочик события - нажатие на кнопку
procedure TMainForm.Button_caclClick(Sender: TObject);
var
  // длина оснвоания, высота, площадь трегольника
  a, h, s : Real;
  is_error: boolean;
begin
     is_error := False;

     ///
     if not TryStrToFloat( Edit_a.Text, a ) then
        begin
          a := 0;
          Memo_report.Lines.Append('Ошибка задания длины основания');
          is_error := True;
        end;

     if not TryStrToFloat( Edit_h.Text, h ) then
        begin
          h := 0;
          Memo_report.Lines.Append('Ошибка задания высоты');
          is_error := True;
        end;


     if a < 0 then
        begin
           Memo_report.Lines.Append('Длина основания не может быть отрицательной');
           is_error := True;
        end;


     if h < 0 then
        begin
           Memo_report.Lines.Append('Высота не может быть отрицательной');
           is_error := True;
        end;


     if is_error = False then
        begin
           s := triangle_area( a, h );

           Label_s.Caption := FloatToStr( s );

           Memo_report.Lines.Append( 'a = ' + FloatToStr(a) + ', h = '  + FloatToStr(h) + '; S = ' + FloatToStr(s) );
          // см. Format
     end;

end;

end.

