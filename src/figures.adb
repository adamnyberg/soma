-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Vector;
with Bits;
with Misc;

package body Figures is
  function Parse(Raw_Figure : in Unbounded_String) return Figure_Type is
    Start : Unbounded_String;
    Rest : Unbounded_String;

    Figure : Figure_Type(1);
  begin
    Misc.Split( Raw_Figure, " ", Start, Rest );
    Figure.ID := Integer'Value(To_String( Start ));

    Misc.Split( Rest, " ", Start, Rest );
    Figure.Dimension := Vector.Parse( Start );
    Figure.Structure := Bits.Parse( Rest );

    return Figure;
  end Parse;
end Figures;
