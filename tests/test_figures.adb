-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Figures; use Figures;

procedure Test_Figures is
  Figure_Parse_Str : String := "123 1x8x10 10011";
  Figure : Figure_Type(1);
begin
  Figure := Parse(To_Unbounded_String( Figure_Parse_Str ));
  Put(Figure.ID);
end Test_Figures;
