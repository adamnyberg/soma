-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Parts; use Parts;
with Figure; use Figure;

-- TODO: Ones_Index, Part_Does_Fit, Insert
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

  procedure Solve(Parts : Parts_Type; Figure : Figure_Type) is
    Original_Parts : Parts_Type := Parts;
    Row : Integer := 1;
    Column : Integer := 0;
  begin
    -- Get the index for each one in the figure
    Ones := Ones_Index(Figure.Structure);

    for One_Index in Ones'Range loop
      -- Insert column row

      for Part in Parts'Range loop
        for Rot_X in 0..3 loop
          for Rot_Y in 0..3 loop
            for Rot_Z in 0..3 loop
              Rotate(Parts(Part), (Rot_X, Rot_Y, Rot_Z));
              Traverse(Parts(Part), Index_To_Vector(Ones(One_Index)));

              if Part_Does_Fit(Figure, Parts(Part)) then
                Column := Ones(Ones_Index);
                -- Generate linked matrix element
                -- Find the 1 above, below, right and left in the matrix and (double) link them to the element
                Insert(Element, Up, Down, Right, Left);

                Row := Row + 1;
              end if;

              Parts(Part) := Original_Parts(Part);
            end loop;
          end loop;
        end loop;
      end loop;
      Parts := Original_Parts;
    end loop;

    -- use dlx on matrix
  end Solve;
end Solver;
