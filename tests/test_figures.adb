-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Figures; use Figures;
with Tests; use Tests;
with Bits; use Bits;
procedure Test_Figures is
  Test_Figure_Parse : Unbounded_String := To_Unbounded_String("123 1x8x10 10011");
  Test_Bits_Parse : Unbounded_String := To_Unbounded_String("10011");
  Figure : Figure_Type := Figures.Parse( Test_Figure_Parse );
  Test_Bits : Bits_Type := Bits.Parse( Test_Bits_Parse );
begin
  
  Test( Figure.ID, To_Unbounded_String("123") );
  Test( Figure.Dimension.X, 1 );
  Test( Figure.Dimension.Y, 8 );
  Test( Figure.Dimension.Z, 10 );

-- Tests Figure.Structure
  Test( Figure.Structure, Test_Bits);
end Test_Figures;
