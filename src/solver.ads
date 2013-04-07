-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Parts; use Parts;
with Figures; use Figures;

package Solver is
  type Data_Type is record
    Column : Integer := 0;
    Row : Integer := 0;
    Part : Part_Type_Pointer := null;
  end record;

  type Linked_Matrix;
  type Linked_Matrix_Pointer is access Linked_Matrix;
  type Linked_Matrix is record
    Data : Data_Type;
    Up : Linked_Matrix_Pointer := null;
    Down : Linked_Matrix_Pointer := null;
    Right : Linked_Matrix_Pointer := null;
    Left : Linked_Matrix_Pointer := null;
  end record;

  procedure Put_Matrix(Element : Linked_Matrix_Pointer);
  function Generate_Matrix(Parts : Parts_Type; Figure : Figure_Type) return Linked_Matrix_Pointer;
  procedure Solve(Parts : Parts_Type; Figure : Figure_Type);
  type Column_Headers_Type is array (Natural range <>) of Linked_Matrix_Pointer;
end Solver;
