-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Vector; use Vector;
with Bits; use Bits;
with Misc;

package Figures is
  type Figure_Type (Structure_Bits : Natural) is record
    ID : Positive;
    Dimension : Vector_Type;
    Structure : Bits_Type(1..Structure_Bits);
  end record;

  function Parse(Raw_Figure : in Unbounded_String) return Figure_Type;
end Figures;
