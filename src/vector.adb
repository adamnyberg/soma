-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Misc; use Misc;

package body Vector is
  function Parse(Raw_Vector : in Unbounded_String) return Vector_Type is
    Start : Unbounded_String;
    Rest : Unbounded_String;

    Vector : Vector_Type;
  begin
    Split( Raw_Vector, "x", Start, Rest );
    Vector.X := Integer'Value(To_String( Start ));

    Split( Rest, "x", Start, Rest );
    Vector.Y := Integer'Value(To_String( Start ));
    Vector.Z := Integer'Value(To_String( Rest ));

    return Vector;
  end Parse;

  function To_String(Vector : Vector_Type) return String is
  begin
     return "X: " & Integer'Image(Vector.X) &
       ", Y: " & Integer'Image(Vector.Y) &
       ", Z: " & Integer'Image(Vector.Z);
  end To_String;
end Vector;
