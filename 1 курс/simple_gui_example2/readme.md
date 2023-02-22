# Преобразование чисел и строк
- `StrToFloat`, `StrToInt`
- `TryStrToFLoat`
- `RoundTo(Y, -2)` — округление вещественного числа до двух знаков после запятой
- `FloatToStrF(number, ffFixed, 8, 4)` — преобразование числа number в строку с форматом ffFixed (вещественное число, без экпоненциальной записи), 4 знака после запятой, 8 позиций символов на всё число.  [ [doc](https://www.freepascal.org/docs-html/rtl/sysutils/floattostrf.html) ]
  - `FloatToStrF( pi, ffFixed,    5, 2)            // 3.14`
  - `FloatToStrF( pi, ffExponent, 5, 2)            // 3.1416E+00`
  - `FloatToStrF( pi, ffGeneral,  5, 2)            // 3.1416   (наиболее короткий вариант из ffFixed и ffFixed)`
  - `FloatToStrF( pi, ffcurrency, 5, 2)            // 3.14$    (используется валюта по умолчанию в ОС)`
  - `FloatToStrF( pi*1000, ffnumber,   5, 2)   // 3,141.59 (ffFixed, но добавлен разделитель для тысяч)`

# Внешний вид элементов интерфейса

**Задание цвета компоненту по коду**

```pascal
// для удобного изменения кода в одном месте стоит в модуле формы создать константу цвета
const
  error_color = $b5b5ff;   /// цвет для обозначения ошибки в формате BGR (не RGB!)
  // префикс $ нужен для записи числа в шестнадцатеричной системе счисления

Edit_a.Color:= TColor( error_color );
```

Для выбора цвета можно использовать палитру в google: https://www.google.com/search?q=%23ffb5b5

См. также цветовые константы в документации: https://wiki.freepascal.org/Colors


# Диалоговые окна
Application.MessageBox('Программа вычисляет размер популяции по формуле Y = a * exp (t / tau ).  Автор: ... ',    // содержимое окна
                            'О Программе',                                                                              // заголовок окна
                            MB_OK);                                           // какие кнопки показывать

     //ShowMessage('Программа вычисляет размер популяции по формуле Y = a * exp (t / tau ).   Автор: ... ');


# Настройка lazarus
- превратить окна Lazarus в панели (однооконный режим) - https://devlaz.ru/lazarus-%D0%B2-%D0%BE%D0%B4%D0%BD%D0%BE%D0%BC-%D0%BE%D0%BA%D0%BD%D0%B5/
- Не открывать проект при запуске: Tools > Options... > Enviroment: снять галочку "Open last project..."
- Использовать приятную глазу подсветку синтаксиса: Tools > Options... > Editor - Display - Colors: в выпадающем списке вверху выбрать Delphi вместо Default
- Запретить ставить курсор дальше конца строки: Tools > Options... > Editor - General: в разделе Caret (Text Cursor) убрать галочку для Allow caret to move past end of line
- Другие настройки: http://newpascal.org/docked.html
