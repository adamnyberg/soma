with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Parts is
  type Part_Type is private;
  type Vector_Type is private;

  function Get(Str : in Unbounded_String; ID : in Positive) return Part_Type;

  function Create_Part(Rotation : in Vector_Type := (X => 0, Y => 0, Z => 0);
                       Position : in Vector_Type := (X => 0, Y => 0, Z => 0))
    return Part_Type;
  function Create_Vector(X, Y, Z : in Integer := (X => 0, Y => 0, Z => 0))
    return Vector_Type;

  procedure Rotate(Part : in out Part_Type; Vector : in Vector_Type);
  -- Also known as "Move"
  procedure Traverse(Part : in out Part_Type; Vector : in Vector_Type);
private
  type Part_Type is record
    ID : Positive;
    Rotation : Vector_Type;
    Position : Vector_Type;
  end record;
  type Vector_Type is record
    X, Y, Z : Normal;
  end record;

  function Rotate_X(Part : in out Part_Type) return Part_Type;
  function Rotate_Y(Part : in out Part_Type) return Part_Type;
  function Rotate_Z(Part : in out Part_Type) return Part_Type;
end Parts;
