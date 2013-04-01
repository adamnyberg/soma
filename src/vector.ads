-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Vector is
  type Vector_Type is record
    X, Y, Z : Natural := 0;
  end record;

  function Parse(Raw_Vector : in Unbounded_String) return Vector_Type;
  function To_String(Vector : Vector_Type) return String;
  function To_Volume(Vector : Vector_Type) return Integer;
  function Sum_Vector(Vector1,Vector2 : in Vector_Type) return Vector_Type;
end Vector;
