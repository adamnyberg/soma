-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Parts; use Parts;
with Figures; use Figures;
with Tests; use Tests;
with Solver; use Solver;

procedure Test_Solver is

--  Test_Figure : Figure_Type := Figures.Parse(To_Unbounded_String("1 2x2x2 11111111"));
--  Test_Parts : Parts_Type := Parts.Parse(To_Unbounded_String("3 1x2x2 1101 1x2x2 1101 2x1x1 11"));

  --Funkar ej - Put fastnar på (21,1379) när row 1338 resetas:
  --Test_Figure : Figure_Type := Figures.Parse(To_Unbounded_String("1 5x2x5 10001111110000011111000001111100000111111000111111"));
  --Test_Parts : Parts_Type := Parts.Parse(To_Unbounded_String("8 2x2x1 1110 3x2x1 111100 3x2x1 111010 3x2x1 110011 2x2x2 11101000 2x2x2 11001010 2x2x2 11000101 2x1x1 11"));

  -- Funkar ej! Ger fel antal parts tillbaka!
  Test_Figure : Figure_Type := Figures.Parse(To_Unbounded_String("1 5x2x5 10001111110000011111000001111100000111111000111111"));
  Test_Parts : Parts_Type := Parts.Parse(To_Unbounded_String("8 2x2x1 1110 3x2x1 111100 3x2x1 111010 3x2x1 110011 2x2x2 11101000 2x2x2 11001010 2x2x2 11000101 2x1x1 11"));

  --Funkar ej - Put fastnar på (24,1785):
  --Test_Figure : Figure_Type := Figures.Parse(To_Unbounded_String("1 3x3x3 111111111111111111111111111"));
  --Test_Parts : Parts_Type := Parts.Parse(To_Unbounded_String("8 2x2x1 1110 3x2x1 111100 3x2x1 111010 3x2x1 110011 2x2x2 11101000 2x2x2 11001010 2x2x2 11000101 2x1x1 11"));

--  Test_Figure : Figure_Type := Figures.Parse(To_Unbounded_String("1 3x2x2 010111010111"));
--  Test_Parts : Parts_Type := Parts.Parse(To_Unbounded_String("2 2x2x2 11000101 3x2x1 001111"));

--  Test_Figure : Figure_Type := Figures.Parse(To_Unbounded_String("1 8x1x1 11111111"));
--  Test_Parts : Parts_Type := Parts.Parse(To_Unbounded_String("8 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1"));

  --Test_Figure : Figure_Type := Figures.Parse(To_Unbounded_String("1 5x2x1 1111110101"));
  --Test_Parts : Parts_Type := Parts.Parse(To_Unbounded_String("8 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1 1x1x1 1"));

  --Header : Linked_Matrix_Pointer;
  Solution : Unbounded_String;
begin
  --Put_Matrix(Header);
  Solution := Solve(Test_Parts, Test_Figure);
  New_Line;
  Put(To_String(Solution));
end Test_Solver;
