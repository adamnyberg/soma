-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with DLX; use DLX;
with Parts; use Parts;
with Figure; use Figure;

package body Solver is
  procedure Insert(Anchor, Up, Down, Right, Left : Linked_Matrix_Pointer) is
  begin
    if Anchor /= null and then Up /= null and Down /= null and Right /= null and Left /= null then
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
      Column_Headers : Column_Headers_Type;
      Part_Column : Integer) is

    Element : Linked_Matrix;
    Column : Integer;

    -- Get the index of the ones (blocks) where
    -- the part is located in the figure
    Part_Ones_In_Figure : Index_Arr := Overlap_Indices(Parts(Part), Figure);
    Row_Head : Linked_Matrix := new Linked_Matrix'(( 0, Row ));
  begin
    for One in Part_Ones_In_Figure'Range loop
      Column := Part_Ones_In_Figure(One);

      -- Generate linked matrix element
      -- May cause huge memory problems
      Element := new Linked_Matrix'(( Column, Row, Part ));

      -- Find the 1 above, below, right and left in the matrix and
      -- (double) link them to the element
      Insert(Element, Column_Headers(Column).Up, Column_Headers(Column),
                      Row_Head, Row_Head.Left);
    end loop;

    -- Add part one
    Element := new Linked_Matrix'(( Part_Column, Row ));

    Insert(Element, Column_Head.Up, Column_Head, Row_Head, Row_Head.Left);
  end Generate_Row;

  -- Generate column headers and connect them to the main header
  procedure Generate_Column_Head(Column_Headers : out Column_Headers_Type; Header : Linked_Matrix) is
    Column_Count : Integer := 0;
  begin
    for Column in Column_Headers'Range loop
      -- Insert column header
      Column_Count := Column_Count + 1;
      Column_Headers(Column_Count) := new Linked_Matrix'(( Column_Count, 0 ));

      -- TODO
      if Column_Count = 1 then
        Header.Right := Column_Headers(Column_Count);
        Insert(Column_Headers(Column_Count), Column_Headers, );
      else
        Insert(Column_Headers(Column_Count), null, null, Column_Headers(Column_Count-1));
      end if;
    end loop;

    Insert(Column_Headers(Column_Count), null, Column_Header());
  end Generate_Column_Head;

  function Generate_Matrix(Parts : Parts_Type; Figure : Figure_Type) return Linked_Matrix is
    Original_Parts : Parts_Type := Parts;
    Row : Integer := 1;

    -- Get the index for each *one* in the figure
    Figure_Ones : Index_Arr := Ones_Index(Figure.Structure);

    Header : Linked_Matrix;
    Column_Headers : Column_Headers_Type(Figure.Length + Parts'Length);
  begin
    Header := new Linked_Matrix(( 0, 0 ));
    Generate_Column_Headers(Column_Headers, Header);

    for One_Index in Figure_Ones'Range loop
      for Part in Parts'Range loop
        for Rot_X in 0..3 loop
          for Rot_Y in 0..3 loop
            for Rot_Z in 0..3 loop
              Rotate(Parts(Part), (Rot_X, Rot_Y, Rot_Z));
              Traverse(Parts(Part), Index_To_Vector(Figure_Ones(One_Index)));

              if Part_Does_Fit(Figure, Parts(Part)) then
                Generate_Row(Parts(Part), Figure, Row, Column_Header, Figure.Length + Part);
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

  procedure Solve(Parts : Parts_Type; Figure : Figure_Type) is
    Solution : Linked_Resulting_List;
    Is_Solvable : Boolean;
  begin
    Solve_DLX(Generate_Matrix(Parts, Figure), Solution, Is_Solvable);
    Put(Is_Solvable);
  end;
end Solver;
