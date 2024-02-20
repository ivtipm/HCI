unit logic;
// Автор: 
// модуль с основной логикой работы программы (безнес-локигой)
// здесь описываются все процедуры, которые работают с данными пользователя:
// получение (вычисление) новых данных, сохранение и загрузка в файл

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
  // ! здесь не нужны модули элементов графического интерфейса
  // Этот модуль должен быть независим от пользовательского интерфейса

  
  /// вычисляет размер популяции через время t, 
  /// a - начальный рамер, tau - параметр скорости роста
  function calc_population(a, tau, t: Real): real;                
  /// сохр. a, tau, t в текстовый файл filename, каждый параметр с новой строки.
  procedure save_params(a, tau, t: Real; filename: string);       
  /// загруж. из файла filename параметры a, tau, t (должны быть в отдельных строках)
  procedure load_params(var a, tau, t: Real; filename: string);   


implementation
  // ! документирующие комментарии для процедур и функций приводятся
  // и при объявлении и при определении

  // ! в документирующих комментариях есть объяснения для всех параметров

  /// вычисляет размер популяции через время t, 
  /// a - начальный рамер, tau - параметр скорости роста
  function calc_population(a, tau, t: Real): real;
  begin
       if tau <> 0 then
           result:= a * exp( t / tau )
       else
           result := 0;
  end;

  /// сохр. a, tau, t в текстовый файл filename, каждый параметр с новой строки.
  procedure save_params(a, tau, t: Real; filename: string);
  var
    f: text;
  begin
       assign(f, filename);
       rewrite(f);
       writeln(f, a);
       writeln(f, tau);
       writeln(f, t);
       close(f);
  end;


  /// загруж. из файла filename параметры a, tau, t (должны быть в отдельных строках)
  procedure load_params(var a, tau, t: Real; filename: string);
  var
    //buf: string;
    f: text;
  begin
      assign(f, filename);
      reset(f);
      readln(f, a);   //a := strtofloat(buf);
      readln(f, tau); //tau := strtofloat(buf);
      readln(f, t);   //t := strtofloat(buf);
      close(f);
  end;

end.

