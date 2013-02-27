-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Bits; use Bits;

package body Figures is
  -- TOTALLY NOT WORKING AT THE MOMENT
  -- function Parse_Part(Part_Str : in Unbounded_String) return Figure_Type is
  procedure Parse_Part(Part_Str : in Unbounded_String) is
    Space_Index : Natural;
  begin
    Space_Index := Index(Part_Str, " ");
    Put(Space_Index, 0);
    --return Figure_Type'();
  end Parse_Part;
end Figures;
