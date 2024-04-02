unit main_window;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls,

  Packages           // модуль с основной логикой
  ;

type

  { TMainForm }

  TMainForm = class(TForm)
    Button_add: TButton;
    Button_show: TButton;
    Label_todo: TLabel;
    StringGrid: TStringGrid;

    procedure Button_addClick(Sender: TObject);
    procedure Button_showClick(Sender: TObject);
    ///
    procedure packs_to_grid(var mas: ArrOfPack);
  private

  public

  end;

var
  MainForm: TMainForm;

  data: ArrOfPack;                // статический массив значений для таблицы
  // вся работа с данными должна быть работой с этим массивом, не с таблицой на экране

  n: integer = 0;                 // номер последнего элемента в массиве


implementation

{$R *.lfm}

{ TMainForm }


// Записывает все данные из массива в таблицу
procedure TMainForm.packs_to_grid(var mas: ArrOfPack);
var i: integer;
begin
     StringGrid.RowCount := n+1;

     for i:=1 to n do
        begin
             StringGrid.cells[1,i] := data[i].from;
             StringGrid.cells[2,i] := data[i].addr;
             StringGrid.cells[3,i] := FloatToStr(data[i].mass);
             // индексы: сначала номер столбца, потом строки!

             // todo: нумеровать строки таблицы
        end;

end;

// Пример: Добаляет новую запись в массив
procedure TMainForm.Button_addClick(Sender: TObject);
var p: Package;
begin
     p.from := 'El coronel';
     p.addr := 'Bogotá';
     p.mass := 1 + random(9);

     inc(n);
     data[n] := p;

     // todo: считывать данные из полей ввода
     // todo: проверка данных при считывании
end;


// Для примера: отображение массива в таблицу
procedure TMainForm.Button_showClick(Sender: TObject);
begin
  packs_to_grid(data);
end;

// todo: пример выделения (закраски) строки или ячейки

// todo: описание основных свойств таблицы


end.

