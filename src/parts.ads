-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Vector; use Vector;
with Bits; use Bits;
with Misc;
with Figures; use Figures;

package Parts is
  type Part_Type (Structure_Bits : Natural) is record
    Position : Vector_Type := (1, 1, 1);
    Rotation : Vector_Type := (0, 0, 0);
    Dimension : Vector_Type;
    Structure : Bits_Type(Structure_Bits);
    ID : Integer;
  end record;
  type Part_Type_Pointer is access Part_Type;
  type Index_Arr is array (Natural range <>) of Integer;
  type Parts_Type is array(Integer range <>) of Part_Type_Pointer;

  function Get_Volume(The_Parts : Parts_Type) return Integer;
  function Parse_Part(Raw_Part : in Unbounded_String) return Part_Type;
  function Parse(Raw_Parts : in Unbounded_String) return Parts_Type;

  function Part_Fit_In_Figure(Part : Part_Type; Figure : Figure_Type) return boolean;
  function Add_Dimensions(Part : Part_Type; Figure : Figure_Type) return Figure_Type;
  function Overlap_Indices(Part : Part_Type; Figure : Figure_Type) return Bits.Index_Arr;

  procedure Traverse(Part : in out Part_Type; Diff : in Vector_Type);
  procedure Move(Part : in out Part_Type; Pos : in Vector_Type);
  procedure Rotate(Part : in out Part_Type; Rotation : in Vector_Type);
private
  procedure Rotate_X(Part : in out Part_Type);
  procedure Rotate_Y(Part : in out Part_Type);
  procedure Rotate_Y_270(Part : in out Part_Type);
  procedure Rotate_Z(Part : in out Part_Type);
end Parts;
