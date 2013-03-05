-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Vector; use Vector;
with Bits; use Bits;

package Parts is
  type Part_Type (Structure_Bits : Natural) is record
    Position : Vector_Type;
    Rotation : Vector_Type;
    Dimension : Vector_Type;
    Structure : Bits_Type(1..Structure_Bits);
  end record;
  type Parts_Type is array(Integer range <>) of Part_Type(1);

  function Parse_Part(Raw_Part : in Unbounded_String) return Part_Type;
  function Parse(Raw_Parts : in Unbounded_String) return Parts_Type;

  procedure Rotate(Part : in out Part_Type; Vector : in Vector_Type);
  procedure Traverse(Part : in out Part_Type; Vector : in Vector_Type);
private
  procedure Rotate_X(Part : in out Part_Type);
  procedure Rotate_Y(Part : in out Part_Type);
  procedure Rotate_Z(Part : in out Part_Type);
end Parts;
