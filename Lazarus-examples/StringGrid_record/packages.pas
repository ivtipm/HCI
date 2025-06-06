unit Packages;
// Модуль с основной логикой программы.
// Тут должны быть функции записи\чтения данных в\из файла, поиска и т.п. функции

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;


type
  // запись - Посылка
  Package = record
     from: string;   // имя получателя
     addr: string;   // адрес получателя
     mass: real;     // масса
     // можно добавить ещё поля
  end;

  // Тип для массива из посылок
  ArrOfPack = array[1..1024] of Package;



implementation

end.

