-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

package body Figures is
  function Parse(Raw_Figure : in Unbounded_String) return Figure_Type is
    Figure_ID : Unbounded_String;
    Rest : Unbounded_String;
    Dimension : Unbounded_String;
    Bits_Str : Unbounded_String;
    Figure_Size : Integer;
  begin
    Misc.Split( Raw_Figure, " ", Figure_ID, Rest );
    Misc.Split( Rest, " ", Dimension, Bits_Str );
    Figure_Size := Misc.Divide_With_Ceil(Length(Rest), Bits.BITS_LENGTH);
    declare
      Figure : Figure_Type(Figure_Size);
    begin
      Figure.ID := Figure_ID; 
      Figure.Dimension := Vector.Parse( Dimension );
      Put(To_String(Bits_Str));
      Figure.Structure := Bits.Parse( Bits_Str );
      return Figure;
    end;
  end Parse;
end Figures;