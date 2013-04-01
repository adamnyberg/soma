-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Parts; use Parts;
with Figure; use Figure;

package body Solver is
  procedure Insert(Anchor, Up, Down, Right, Left : Linked_Matrix_Pointer) is
  begin
    if Anchor /= null and Up /= null and Down /= null and Right /= null and Left /= null then
      Up.Down := Anchor;
      Down.Up := Anchor;
      Right.Left := Anchor;
      Left.Right := Anchor;
      Anchor.Up := Up;
      Anchor.Down := Down;
      Anchor.Right := Right;
      Anchor.Left := Left;
    end if;
  end Insert;

  procedure Generate_Row(Part : Part_Type; Figure : Figure_Type; Row : Integer; Column_Head : Linked_Matrix) is
    Element : Linked_Matrix;

    -- Get the index of the ones (blocks) where
    -- the part is located in the figure
    -- TODO: Make sure the parameters are called in this order
    Part_Ones_In_Figure : Index_Arr := Overlap_Indices(Parts(Part), Figure);
    Row_Head : Linked_Matrix := new Linked_Matrix'(( 0, Row ));
    Column : Integer;
  begin
    for One in Part_Ones_In_Figure'Range loop
      Column := Part_Ones_In_Figure(One);

      -- Generate linked matrix element
      Element := new Linked_Matrix'(( Column, Row ));

      -- Find the 1 above, below, right and left in the matrix and
      -- (double) link them to the element
      Insert(Element, Column_Head.Up, Column_Head, Row_Head, Row_Head.Left);
    end loop;

    -- TODO: Add part one
  end Generate_Row;

  procedure Solve(Parts : Parts_Type; Figure : Figure_Type) is
    Original_Parts : Parts_Type := Parts;
    Row : Integer := 1;
    Column : Integer := 0;

    -- Get the index for each one in the figure
    Figure_Ones : Index_Arr := Ones_Index(Figure.Structure);
    Column_Count : Integer := 0;
    Column_Head : Linked_Matrix;
  begin
    for One_Index in Figure_Ones'Range loop
      -- Insert column row
      Column_Count := Column_Count + 1;
      Column_Head := new Linked_Matrix'(( Column_Count, 0 ));

      for Part in Parts'Range loop
        for Rot_X in 0..3 loop
          for Rot_Y in 0..3 loop
            for Rot_Z in 0..3 loop
              Rotate(Parts(Part), (Rot_X, Rot_Y, Rot_Z));
              Traverse(Parts(Part), Index_To_Vector(Figure_Ones(One_Index)));

              if Part_Does_Fit(Figure, Parts(Part)) then
                Generate_Row(Parts(Part), Figure, Row, Column_Head);
                Row := Row + 1;
              end if;

              Parts(Part) := Original_Parts(Part);
            end loop;
          end loop;
        end loop;
      end loop;
    end loop;

    -- TODO: use dlx on matrix
  end Solve;
end Solver;
