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
    Figure_Size : Integer;
  begin
    Misc.Split( Raw_Figure, " ", Start, Rest );
    Figure_Size := Integer(Float'Ceiling(Float(Length(Rest))/Float(Bits.BITS_LENGTH)));
    declare
      Figure : Figure_Type(Figure_Size);
    begin
      Figure.ID := Integer'Value(To_String( Start ));

      Misc.Split( Rest, " ", Start, Rest );
      Figure.Dimension := Vector.Parse( Start );
      Figure.Structure := Bits.Parse( Rest );

      return Figure;
    end;
  end Parse;
end Figures;
