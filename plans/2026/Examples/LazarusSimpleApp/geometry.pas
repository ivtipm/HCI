unit geometry;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

// Возвращает площадь треугольника, вычесленную по длине основания base и высоте height
function triangle_area( base: Real; height: Real ): Real;


implementation


// Возвращает площадь треугольника, вычесленную по длине основания base и высоте height
function triangle_area( base: Real; height: Real ): Real;
var s: Real;
begin
     s := base * height / 2.0;
     result := s;
end;


end.

