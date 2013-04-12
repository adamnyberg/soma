-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Parts; use Parts;
with Figures; use Figures;
with Matrix; use Matrix;

package Solver is
  type Data_Type is record
    Column : Integer := 0;
    Row : Integer := 0;
    Part : Part_Type_Pointer := null;
  end record;

  procedure Put_Matrix(Element : Linked_Matrix_Pointer);
  function Generate_Matrix(Parts : Parts_Type; Figure : Figure_Type) return Linked_Matrix_Pointer;
  function Solve(Parts : Parts_Type; Figure : Figure_Type) return Unbounded_String;
  type Column_Headers_Type is array (Natural range <>) of Linked_Matrix_Pointer;
end Solver;
