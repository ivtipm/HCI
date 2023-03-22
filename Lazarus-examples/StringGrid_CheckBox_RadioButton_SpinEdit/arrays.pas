unit Arrays;
/// Модуль для работы с массивами

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const
  /// константа для размера статического массива
  Size = 1024;

type
  /// Тип - матрица
  Matrix = array[1..Size,1..Size] of Real;



/// заполняет матрицу mat размерности n*m случайными целыми числами в диапазоне от min до max
procedure matrix_random_int(var mat: matrix; n,m: integer; min,max: integer);
/// заполняет матрицу mat размерности n*m случайными веществ. числами в диапазоне от min до max
procedure matrix_random_real(var mat: matrix; n,m: integer; min,max: integer);

implementation

/// заполняет матрицу mat размерности n*m случайными целыми числами в диапазоне от min до max
procedure matrix_random_int(var mat: matrix; n,m: integer; min,max: integer);
var i, j: Integer;
begin
    for i:=1 to n do
        for j:=1 to m do
            mat[i,j] := random(max-min)+min;
end;


/// заполняет матрицу mat размерности n*m случайными веществ. числами в диапазоне от min до max
procedure matrix_random_real(var mat: matrix; n,m: integer; min,max: integer);
var i, j: Integer;
begin
    for i:=1 to n do
        for j:=1 to m do
            mat[i,j] := random(max-min)+min + random(10)/10;
end;

end.

