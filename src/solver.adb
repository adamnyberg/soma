-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with DLX; use DLX;
with Parts; use Parts;
with Figures; use Figures;
with Bits; use Bits;
with Vector; use Vector;
with Matrix; use Matrix;

package body Solver is
  procedure Put_Row(Element : Linked_Matrix_Pointer) is
  begin
    Put(Element.Data.Row, 2);
    Put(",");
    Put(Element.Data.Column, 2);

    if Element.Right /= null and then Element.Right.Data.Column /= 0 then
      Put("    ");
      Put_Row(Element.Right);
    end if;
  end Put_Row;

  procedure Put_Matrix(Element : Linked_Matrix_Pointer) is
  begin
    Put_Row(Element);
    New_Line;

    if Element.Down /= null and then Element.Down.Data.Row /= 0 then
      Put_Matrix(Element.Down);
    end if;
  end Put_Matrix;

  procedure Insert(Anchor, Up, Down, Right, Left : Linked_Matrix_Pointer) is
  begin
    if Anchor /= null and Up /= null and Down /= null and Right /= null and Left /= null then
      Anchor.Up := Up;
      Anchor.Down := Down;
      Anchor.Right := Right;
      Anchor.Left := Left;
      Up.Down := Anchor;
      Down.Up := Anchor;
      Right.Left := Anchor;
      Left.Right := Anchor;
    end if;
  end Insert;

  -- Generate column headers and connect them to the main header
  procedure Generate_Column_Headers(Column_Headers : in out Column_Headers_Type; Header : Linked_Matrix_Pointer) is
  begin
    for Column in reverse Column_Headers'Range loop
      -- Create column header
      Column_Headers(Column) := new Linked_Matrix;
      Column_Headers(Column).Data.Column := Column;

      Insert(Column_Headers(Column),
        Column_Headers(Column),
        Column_Headers(Column),
        Header.Right,
        Header
      );
    end loop;
  end Generate_Column_Headers;

  function Generate_Row(
      Part : Part_Type_Pointer;
      Figure : Figure_Type;
      Row : Integer;
      Column_Headers : Column_Headers_Type;
      Part_Column : Integer) return Linked_Matrix_Pointer is
    Element : Linked_Matrix_Pointer;
    Column : Integer;

    Part_Ones_In_Figure : Bits.Index_Arr := Overlap_Indices(Part.all, Figure);
    Row_Header : Linked_Matrix_Pointer := new Linked_Matrix;
  begin
    Insert(Row_Header, Row_Header, Row_Header, Row_Header, Row_Header);
    Row_Header.Data.Row := Row;
    Row_Header.Data.Part := Part;

    for One in Part_Ones_In_Figure'Range loop
      Column := Part_Ones_In_Figure(One);

      Element := new Linked_Matrix;
      Element.Data.Column := Column;
      Element.Data.Row := Row;
      Element.Data.Part := Part;

      -- Find the 1 above, below, right and left in the matrix and
      -- (double) link them to the element
      Insert(Element,
        Column_Headers(Column).Up,
        Column_Headers(Column),
        Row_Header,
        Row_Header.Left
      );
    end loop;

    -- Insert part column
    Element := new Linked_Matrix;
    Element.Data.Column := Part_Column;
    Element.Data.Row := Row;
    Element.Data.Part := Part;

    Insert(Element,
      Column_Headers(Part_Column).Up,
      Column_Headers(Part_Column),
      Row_Header,
      Row_Header.Left
    );

    return Row_Header;
  end Generate_Row;

  function Generate_Matrix(Parts : Parts_Type; Figure : Figure_Type) return Linked_Matrix_Pointer is
    -- Get the index for each *one* in the figure
    Figure_Ones : Bits.Index_Arr := Ones_Index(Figure.Structure);
    -- Will get column = 0, row = 0 by default
    Header : Linked_Matrix_Pointer := new Linked_Matrix;

    Num_Columns : Integer := Figure_Ones'Length + Parts'Length;
    Column_Headers : Column_Headers_Type(1..Num_Columns);
    Row : Integer := 1;

    Row_Header : Linked_Matrix_Pointer;
  begin
    -- Header setup
    Insert(Header, Header, Header, Header, Header);
    Generate_Column_Headers(Column_Headers, Header);

    -- Generate matrix
    for Part in Parts'Range loop
      for One_Index in Figure_Ones'Range loop
        for Rot_X in 0..3 loop
          for Rot_Y in 0..3 loop
            for Rot_Z in 0..3 loop
              declare
                Original_Part : Part_Type := Parts(Part).all;
              begin
                Rotate(Parts(Part).all, (Rot_X, Rot_Y, Rot_Z));
                Move(Parts(Part).all, Index_To_Vector(Figure.Dimension, Figure_Ones(One_Index)));

                if Part_Fit_In_Figure(Parts(Part).all, Figure) then
                  declare
                    Tmp_Part : Part_Type := Parts(Part).all;
                    New_Part_Pointer : Part_Type_Pointer := new Part_Type'(Tmp_Part);
                  begin
                    Row_Header := Generate_Row(New_Part_Pointer, Figure, Row, Column_Headers, Figure_Ones'Length + Part);
                  end;

                  -- Connect row header to rest of matrix
                  -- Note: The order in which this is done matters
                  Row_Header.Down := Header;
                  Row_Header.Up := Header.Up;
                  Header.Up.Down := Row_Header;
                  Header.Up := Row_Header;

                  Row := Row + 1;
                end if;

                Parts(Part).all := Original_Part;
              end;
            end loop;
          end loop;
        end loop;
      end loop;
    end loop;

    return Header;
  end Generate_Matrix;

  function To_String(Solution : Linked_Resulting_List_Pointer) return Unbounded_String is
    Result : Unbounded_String := To_Unbounded_String("");
    Solution_Copy : Linked_Resulting_List_Pointer := Solution;
  begin
    while Solution_Copy /= null loop
      --Put(Solution_Copy.Part.Structure, Solution_Copy.Part.Dimension);
      --New_Line;

      -- TODO: Fix this ugly solution
      declare
        Pos : Vector_Type;
      begin
        Pos.X := Solution_Copy.Part.Position.X - 1;
        Pos.Y := Solution_Copy.Part.Position.Y - 1;
        Pos.Z := Solution_Copy.Part.Position.Z - 1;

        Result := Result & To_Unbounded_String("!") &
          To_Simple_String(Solution_Copy.Part.Rotation) &
          To_Simple_String(Pos);
      end;

     if Solution_Copy.Next /= null then
        Result := Result & To_Unbounded_String(" ");
      end if;

      Solution_Copy := Solution_Copy.Next;
    end loop;

    return Result;
  end To_String;

  function Solve(Parts : Parts_Type; Figure : Figure_Type) return Unbounded_String is
    Solution : Linked_Resulting_List_Pointer;
    Is_Solvable : Boolean;
    Header : Linked_Matrix_Pointer := Generate_Matrix(Parts, Figure);
  begin
    for Part in Parts'Range loop
      Put(To_String(Parts(Part).Structure));
      Put(" ");
      Put(To_Simple_String(Parts(Part).Dimension));
      New_Line;
    end loop;
    Put(To_String(Figure.Structure));

    New_Line;
    Put(Count_Col(Header));
    New_Line;

    if Count_Col(Header) > 1 then
      Delete_Equal_Rows(Header);
    end if;
    New_Line;
    Put(Count_Col(Header));
    New_Line;
    --Put(Count_Col(Header));
    Test_Matrix(Header);
    Put_Matrix(Header);

    Solve_DLX(Header, Solution, Is_Solvable);
    Sort(Solution);

    if Is_Solvable then
      while False loop
      --while Solution /= Null loop
        New_Line;
        Put("-----------------------");
        New_Line;
        Put(To_Simple_String(Solution.Part.Position));
        New_Line;
        Put(To_Simple_String(Solution.Part.Rotation));
        New_Line;

        Solution := Solution.Next;
      end loop;

      Put(To_String(To_Unbounded_String("S ") & Figure.ID &
             To_Unbounded_String(" ") & To_String(Solution)));

      return To_Unbounded_String("S ") & Figure.ID &
             To_Unbounded_String(" ") & To_String(Solution);
    else
      return To_Unbounded_String("G ") & Figure.ID;
    end if;
  end;
end Solver;
