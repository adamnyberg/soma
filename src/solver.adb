-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Parts; use Parts;
with Figure; use Figure;

package body Solver is
  --Linked_Matrix
  procedure Solve(Parts : Parts_Type; Figure : Figure_Type) is
  begin
    -- generate matrix node

    --Ones := ;-- Get all the index for each in figure

    for One in Ones'Range loop;
      for Part in Parts'Range loop
        for Rot_X in 0..3 loop
          for Rot_Y in 0..3 loop
            for Rot_Z in 0..3 loop
              Rotate(Parts(Part), (Rot_X, Rot_Y, Rot_Z));
              Traverse(Parts(Part), (X, Y, Z));

              if Part_Does_Fit(Figure, Parts(Part)) then
                -- Generate linked matrix element
                -- Find the 1 above, below, rightand left in the matrix and (double) link them to the element
              end if;
            end loop;
          end loop;
        end loop;
      end loop;
    end loop;

    -- use dlx on matrix
  end Solve;
end Solver;
