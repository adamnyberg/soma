-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Bits; use Bits;

package Figures is
  type Vector_Type is private;
  type Figure_Type (Structure_Bits : Natural) is tagged record
    ID : Positive;
    Dimension : Vector_Type;
    Structure : Bits_Type(1..Structure_Bits);
  end record;

  function Parse(Raw_Figure : in Unbounded_String) return Figure_Type;
private
  type Vector_Type is record
    X, Y, Z : Natural;
  end record;
end Figures;
