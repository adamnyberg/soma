-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with DLX; use DLX;
with Parts; use Parts;
with Figures; use Figures;

package body Solver is
  function "="(Left, Right : Linked_Matrix) return Boolean is
  begin
    return Left.Data.Row = Right.Data.Row and Left.Data.Column = Right.Data.Column;
  end "=";

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

  procedure Generate_Row(
      Part : Part_Type;
      Figure : Figure_Type;
      Row : Integer;
      Column_Head : Linked_Matrix;
      Part_Column : Integer) is
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
      -- May cause huge memory problems
      Element := new Linked_Matrix'(( Column, Row, Part ));

      -- Find the 1 above, below, right and left in the matrix and
      -- (double) link them to the element
      Insert(Element, Column_Head.Up, Column_Head, Row_Head, Row_Head.Left);
    end loop;

    -- Add part one
    Element := new Linked_Matrix'(( Column, Row ));

    Insert(Element, Column_Head.Up, Column_Head, Row_Head, Row_Head.Left);
  end Generate_Row;

  function Generate_Matrix(Parts : Parts_Type_Pointer; Figure : Figure_Type) return Linked_Matrix is
    Original_Parts : Parts_Type_Pointer := Parts;
    Row : Integer := 1;
    Column : Integer := 0;

    -- Get the index for each *one* in the figure
    Figure_Ones : Index_Arr := Ones_Index(Figure.Structure);
    Column_Count : Integer := 0;
    Column_Head : Linked_Matrix;

    Header : Linked_Matrix;
  begin
    Header := new Linked_Matrix(( 0, 0 ));

    for One_Index in Figure_Ones'Range loop
      -- Insert column row
      -- TODO: This will not work, column head is not useful
      Column_Count := Column_Count + 1;
      Column_Head := new Linked_Matrix'(( Column_Count, 0 ));

      for Part in Parts'Range loop
        for Rot_X in 0..3 loop
          for Rot_Y in 0..3 loop
            for Rot_Z in 0..3 loop
              Rotate(Parts(Part), (Rot_X, Rot_Y, Rot_Z));
              Traverse(Parts(Part), Index_To_Vector(Figure_Ones(One_Index)));

              if Part_Does_Fit(Figure, Parts(Part)) then
                -- TODO: This will not work, column head will change
                Generate_Row(Parts(Part), Figure, Row, Column_Head, Part);
                Row := Row + 1;
              end if;

              Parts(Part) := Original_Parts(Part);
            end loop;
          end loop;
        end loop;
      end loop;
    end loop;

    return Header;
  end Generate_Matrix;

  procedure Solve(Parts : Parts_Type_Pointer; Figure : Figure_Type) is
    Solution : Linked_Resulting_List;
    Is_Solvable : Boolean;
  begin
    Solve_DLX(Generate_Matrix(Parts, Figure), Solution, Is_Solvable);
    Put(Is_Solvable);
  end;
end Solver;
