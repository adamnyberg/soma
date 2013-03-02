-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Figures; use Figures;

package Parts is
  type Part_Type is private;
  type Parts_Type is private;
  type Vector_Type is private;

  procedure Parse(Raw_Part : in Unbounded_String, Part : out Part_Type);
  procedure Parse(Raw_Parts : in Unbounded_String, Parts : out Parts_Type);
  procedure Rotate(Part : in out Part_Type; Vector : in Vector_Type);
  -- Also known as "Move"
  procedure Traverse(Part : in out Part_Type; Vector : in Vector_Type);
private
  subtype Part_Type is new Figure_Type with record
    Position : Vector_Type;
    Rotation : Vector_Type;
  end record;
  type Parts_Type is array(range <>) of Part_Type;

  procedure Rotate_X(Part : in out Part_Type);
  procedure Rotate_Y(Part : in out Part_Type);
  procedure Rotate_Z(Part : in out Part_Type);
end Parts;
