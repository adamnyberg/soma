-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Vector is
  type Vector_Type is record
    X, Y, Z : Natural := 0;
  end record;

  function Parse(Raw_Vector : in Unbounded_String) return Vector_Type;
end Vector;
