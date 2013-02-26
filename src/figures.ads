-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Bits; use Bits;

package Figures is
  type Figure_Type is private;
  type Vector_Type is private;

  function Parse_Part(Str : in Unbounded_String) return Part_Type;
  function Create_Vector(X, Y, Z : in Natural := 0) return Vector_Type;
private
  type Figure_Type is tagged record
    ID : Positive;
    Structure : Bits_Type;
    Dimension : Vector_Type;
  end record;

  type Vector_Type is record
    X, Y, Z : Natural;
  end record;
end Figures;
