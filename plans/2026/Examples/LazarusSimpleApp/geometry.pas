unit geometry;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

// Возвращает площадь треугольника, вычесленную по длине основания base и высоте height
function triangle_area( base: Real; height: Real ): Real;
// Загружает из файла с именем filename данные в переменные a и h
procedure load_triangle_data(filename: string; var a, h: Real);






implementation


// Возвращает площадь треугольника, вычесленную по длине основания base и высоте height
function triangle_area( base: Real; height: Real ): Real;
var s: Real;
begin
     s := base * height / 2.0;
     result := s;
end;


// Загружает из файла с именем filename данные в переменные a и h
procedure load_triangle_data(filename: string; var a, h: Real);
var
  file_data: Text; // файловая переменная
begin
     AssignFile(file_data, filename);
     reset( file_data );

     readln(file_data, a);
     readln(file_data, h);

     CloseFile(file_data);
end;

end.

