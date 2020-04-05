unit logic;
// модуль с основной логикой работы программы (безнес-локигой)
// здесь описываются все процедуры, которые работают с данными пользователя:
// получение (вычисление) новых данных, сохранение и загрузка в файл

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

  
  function calc_population(a, tau, t: Real): real;                // вычисляет размер популяции через время t
  procedure save_params(a, tau, t: Real; filename: string);       // сохр. a, tau, t в текстовый файл filename (по цифре на строку файла).
  procedure load_params(var a, tau, t: Real; filename: string);   // загруж из файла filename a, tau, t (должны быть в отдельных строках)


implementation

  function calc_population(a, tau, t: Real): real;
  begin
       if tau <> 0 then
           result:= a * exp( t / tau )
       else
           result := 0;
  end;

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

  procedure load_params(var a, tau, t: Real; filename: string);
  var
    //buf: string;
    f: text;
  begin
      assign(f, filename);
      reset(f);
      readln(f, a); //a := strtofloat(buf);
      readln(f, tau); //tau := strtofloat(buf);
      readln(f, t);   //t := strtofloat(buf);
      close(f);
  end;

end.

