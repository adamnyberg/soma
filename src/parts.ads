package Parts is
  type Part_Type is private;
  type Rotation_Vector_Type is private;

  function Create_Rotation_Vector(X, Y, Z : in Integer) return Rotation_Vector_Type;
  procedure Rotate(Part : in out Part_Type; Rotation_Vector : in Rotation_Vector_Type);
private
  type Part_Type is null;
  type Rotation_Vector_Type is record
    X, Y, Z : Normal;
  end record;

  function Rotate_X(Part : in out Part_Type) return Part_Type;
  function Rotate_Y(Part : in out Part_Type) return Part_Type;
  function Rotate_Z(Part : in out Part_Type) return Part_Type;
end Parts;
