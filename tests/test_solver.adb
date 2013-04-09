-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Parts; use Parts;
with Figures; use Figures;
with Tests; use Tests;
with Solver; use Solver;

procedure Test_Solver is
  --Test_Figure : Figure_Type := Figures.Parse(To_Unbounded_String("1 2x2x1 1010"));
  --Test_Parts : Parts_Type := Parts.Parse(To_Unbounded_String("2 1x2x1 11 2x1x1 11"));
  Test_Figure : Figure_Type := Figures.Parse(To_Unbounded_String("1 1x2x1 1111"));
  Test_Parts : Parts_Type := Parts.Parse(To_Unbounded_String("1 1x2x1 11"));
  --Header : Linked_Matrix_Pointer;
begin
  --Put_Matrix(Header);
  Solve(Test_Parts, Test_Figure);
end Test_Solver;
