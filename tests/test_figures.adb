-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Figures; use Figures;
with Tests; use Tests;

procedure Test_Figures is
  Test_Figure_Parse : String := "123 1x8x10 10011";
  Figure : Figure_Type(1);
begin
  Figure := Figures.Parse(To_Unbounded_String( Test_Figure_Parse ));
  Test( Figure.ID, 123 );
  Test( Figure.Dimension.X, 1 );
  Test( Figure.Dimension.Y, 8 );
  Test( Figure.Dimension.Z, 10 );
end Test_Figures;
