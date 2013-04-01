-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Parts; use Parts;
with Figure; use Figure;

package Solver is
  type Linked_Matrix;
  type Linked_Matrix_Pointer is access Linked_Matrix;
  type Linked_Matrix is record
    Up : Linked_Matrix_Pointer := null;
    Down : Linked_Matrix_Pointer := null;
    Right : Linked_Matrix_Pointer := null;
    Left : Linked_Matrix_Pointer := null;
    -- TODO: Data, Type
  end;

  procedure Solve(Parts : Parts_Type; Figure : Figure_Type);
end Solver;
