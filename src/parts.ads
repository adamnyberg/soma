with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Parts is
  type Part_Type is private;
  type Vector_Type is private;

  function Get(Str : in Unbounded_String; ID : in Positive) return Part_Type;

  function Create_Vector(X, Y, Z : in Integer := 0) return Vector_Type;
  function Create_Part(Rotation : in Vector_Type := Create_Vector;
                       Position : in Vector_Type := Create_Vector)
    return Part_Type;

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
    X, Y, Z : Natural;
  end record;

  procedure Rotate_X(Part : in out Part_Type);
  procedure Rotate_Y(Part : in out Part_Type);
  procedure Rotate_Z(Part : in out Part_Type);
end Parts;
