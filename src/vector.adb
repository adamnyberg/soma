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

  function To_Volume(Vector : Vector_Type) return Integer is  
  begin -- To_Volume
    return Vector.X * Vector.Y * Vector.Z;
  end To_Volume;

  function "-"(V1, V2 : Vector_Type) return Vector_Type is
  begin
    return (V1.X - V2.X + 1, V1.Y - V2.Y + 1, V1.Z - V2.Z + 1);
  end "-";

  -- function Sum_Vector(Vector1,Vector2 :in Vector_Type) return Vector_Type is
  --   X,Y,Z : Integer;  
  -- begin -- To_Volume
  --   Split(To_Unbounded_String(To_String( Vector )),"x",X,Rest);
  --   Split(Rest,"x",Y,Z);
  --   return (Integer'Value(To_String( X )),Integer'Value(To_String( Y )),Integer'Value(To_String( Z )));
  -- end Sum_Vector;
end Vector;
