unit main_window;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tmain_form }

  // пользовательский тип данных, описывающий главно окно
  Tmain_form = class(TForm)

    // поля, отчвечающие за элементы интерфеса
    Button_random_num: TButton;
    Edit_max_num: TEdit;
    Label1: TLabel;
    Label_random_num: TLabel;

    // обработчик события
    procedure Button_random_numClick(Sender: TObject);

  private

  public

  end;


var

  // переменная, представляющая главно окно
  main_form: Tmain_form;

  // для харанения числа
  num: integer;


implementation

{$R *.lfm}

{ Tmain_form }

// обработчик события: нажатие на кнопку
procedure Tmain_form.Button_random_numClick(Sender: TObject);
var
  max: integer;
begin
   // StrToInt -- преобразование из строки в integer
   max := StrToInt( Edit_max_num.Text );

   num := random( max );

   // StrToInt -- преобразование из integer в строку
   Label_random_num.Caption := IntToStr( num );
end;

end.

