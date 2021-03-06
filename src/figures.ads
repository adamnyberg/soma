-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Vector; use Vector;
with Bits; use Bits;
with Misc;


package Figures is
  type Figure_Type (Structure_Bits : Natural) is record
    ID : Unbounded_String;
    Dimension : Vector_Type;
    Structure : Bits_Type(Structure_Bits);
  end record;

  function Get_Volume(Figure : Figure_Type) return Integer;
  function Parse(Raw_Figure : in Unbounded_String) return Figure_Type;
end Figures;
