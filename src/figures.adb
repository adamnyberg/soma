-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu
package body Figures is
  function Get_Volume(Figure : Figure_Type) return Integer is
  begin
    return Ones_Index(Figure.Structure)'Length;
  end Get_Volume;

  function Parse(Raw_Figure : in Unbounded_String) return Figure_Type is
    Figure_ID : Unbounded_String;
    Rest : Unbounded_String;
    Dimension : Unbounded_String;
    Bits_Str : Unbounded_String;
    Figure_Size : Integer;
  begin
    Misc.Split( Raw_Figure, " ", Figure_ID, Rest );
    Misc.Split( Rest, " ", Dimension, Bits_Str );
    Figure_Size := Misc.Divide_With_Ceil(Length(Bits_Str), Bits.BITS_LENGTH);
    declare
      Figure : Figure_Type(Figure_Size);
    begin
      Figure.ID := Figure_ID; 
      Figure.Dimension := Vector.Parse( Dimension );
      Figure.Structure := Bits.Parse( Bits_Str );
      return Figure;
    end;
  end Parse;
end Figures;
