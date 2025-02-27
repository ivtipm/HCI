# 29 апреля
## Лабораторное занятие. TStringGrid

В этот раз планировалось проектирование интерфейса в Figma. Но планы на этой неделе немного поменялись. В курсовой работе по программированию вам пригодится компонент TStringGrid из Lazarus (Delphi). А раз на ЧМВ мы начали изучать Lazarus (Delphi),  то вполне можно рассмотреть и  TStringGrid.

1. Это задание можно делать на Delphi 10 или Lazarus
1.  Изучить документацию Lazarus или Delphi 10 по классу TStringGrid
1. Изучить [пример](https://github.com/ivtipm/HCI/tree/master/1%20%D0%BA%D1%83%D1%80%D1%81) TStringGrid example
2. Для одной двух из разработанных ранее программ:
- Добавить таблицу TStringGrid в окно. TMemo можно убрать.
- Редактировать привязки для  TStringGrid
В таблицу должны выводится исходные данные и результат вычислений.  Например, если в программе исходные данные числа A и B, а результат – число X, то в таблице должно быть три столбца:  A, B, X.
После расчётов данные должны выводится в одну строку таблицы.
- Редактировать количество и названия столбцов TStringGrid: ПКМ на StringGrid → Редактировать StringGrid.
- Задать число строк равное нулю для StringGrid в инспекторе объектов: RowCount: 1. Таким образом останется только заголовок таблицы.
- Создать запись которая будут хранить все исходные параметры и результат вычислений. Для примера, приведённого выше, запись будет такой:
```pascal
// Запись - «Расчёт»
type Calculation = record
    A,B: real; // исходные данные
    X: type2;  // результат
end;
```
Запись должна быть объявлена в модуле логики программы.

- Все данные о расчётах должны хранится в массиве из записей в модуле формы:
```Pascal
var
    calculations: array[1..128] of Calculation;
```
- После того как пользователь нажмёт на кнопку «Вычислить», происходят вычисления, затем результаты записываются в новый элемент массива  calculations и только потом, они добавляются на TstringGrid. (см. пример)

Порядок действий именно такой потому, что использовать исключительно TtringGrid для хранения данных – плохая идея. Окно программы должно отвечать только за взаимодействие с пользователем, а не хранить данные. Т.е. выполнять принцип единственной ответственности.

- Исходный код программы добавить в новую папку репозитория (с названием 29 april). В папке должен быть и скриншот окна программы.


[вернуться к списку заданий](https://github.com/ivtipm/HCI/blob/master/Tasks-2020-spring/Tasks.%202020-spring.md)
