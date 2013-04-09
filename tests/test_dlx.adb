with DLX; use DLX;
with Matrix; use Matrix;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
procedure Test_DLX is
T_L_M, Temp ,Temp2 : Linked_Matrix_Pointer;
APA : Linked_Matrix_Pointer;
Solution : Linked_Resulting_List_Pointer;
Solved : Boolean;
begin
  --T_L_M.Data.Column := 0;
--  T_L_M.Data.Row:= 0;
  T_L_M := new Linked_Matrix;
  T_L_M.Right := new Linked_Matrix;
  Temp := T_L_M.Right;
  Temp.Left := T_L_M;
  Temp.Data.Column := 1;
  Temp.Data.Row := 0;
  for I in 2..3 loop
    Temp.Right := new Linked_Matrix;
    Temp.Right.Left := Temp;
    Temp := Temp.Right;
    Temp.Data.Column := I;
--  Temp.Data.Row := 0;
    Temp.Right := T_L_M;
    T_L_M.Left := Temp;
  end loop;
  
  T_L_M.Down := new Linked_Matrix;
  Temp := T_L_M.Down;
  Temp.Up := T_L_M;
  Temp.Down := T_L_M;
--  Temp.Data.Column := 0;
  Temp.Data.Row := 1;
  for I in 2..3 loop
    Temp.Down := new Linked_Matrix;
    Temp.Down.Up := Temp;
    Temp := Temp.Down;
--    Temp.Data.Column := 0;
    Temp.Data.Row := I;
    Temp.Down := T_L_M;
    T_L_M.Up := Temp;
  end loop;

  Temp.Right := new Linked_Matrix;
  Temp2 := Temp.Right;
  Temp2.Data.Column := 1;
  Temp2.Data.Row:= 3;
  Temp2.Left := Temp;
  Temp2.Up := new Linked_Matrix;
  Temp2.Up.Down := Temp2;
  Temp2.Down := T_L_M.Right;
  Temp2.Down.Up := Temp2;
  Temp2.Right := new Linked_Matrix;
  Temp2.Right.Left := Temp2;
  
  Temp2 := Temp2.Right;
  Temp2.Data.Column := 2;
  Temp2.Data.Row:= 3;
  Temp2.Up := new Linked_Matrix;
  Temp2.Up.Down := Temp2;
  Temp2.Down := T_L_M.Right.Right;
  Temp2.Down.Up := Temp2;
  Temp2.Right := Temp;
  Temp2.Right.Left := Temp2;
  
  Temp2 := Temp2.Up;
  Temp2.Data.Column := 2;
  Temp2.Data.Row:= 2;
  Temp2.Left := Temp.Up;
  Temp2.Left.Right := Temp2;
  Temp2.Right:= Temp.Up;
  Temp2.Right.Left := Temp2;
  Temp2.Up := T_L_M.Right.Right;
  Temp2.Up.Down := Temp2;

  Temp2 := Temp.Right.Up;
  Temp2.Data.Column := 1;
  Temp2.Data.Row := 1;
  Temp2.Left := T_L_M.Down;
  Temp2.Left.Right := Temp2;
  Temp2.Up := T_L_M.Right;
  Temp2.Up.Down := Temp2;
  Temp2.Right := new Linked_Matrix;
  Temp2.Right.Left := Temp2;

  Temp2 := Temp2.Right;
  Temp2.Data.Column := 3;
  Temp2.Data.Row := 1;
  Temp2.Up := T_L_M.Left;
  Temp2.Up.Down := Temp2;
  Temp2.Right := T_L_M.Down;
  Temp2.Right.Left := Temp2;
  Temp2.Down := Temp2.Up;
  Temp2.Down.Up := Temp2;
--  Put(T_L_M.Down.Down.Down.Right.Right.Right.Data.Column);
--  Put(T_L_M.Down.Down.Down.Right.Right.Right.Data.Row);
--  Put(T_L_M.Right.Up.Data.Column);
--  Put(T_L_M.Right.Up.Data.Row);
  New_Line;
  --Add 1 to (3,2)
--  Temp := new Linked_Matrix;
--  T_L_M.Left.Down.Down := Temp;
--  Temp.Data.Column := 3;
--  Temp.Data.Row := 2;
--  Temp.Up := T_L_M.Left.Down;
--  Temp.Up.Down := Temp;
--  Temp.Down := T_L_M.Left;
--  Temp.Down.Up := Temp;
--  Temp.Right := T_L_M.Down.Down;
--  Temp.Right.Left := Temp;
--  Temp.Left := Temp.Right.Right;
--  Temp.Left.Right := Temp;

  Put("     (");
  Put(T_L_M.Right.Right.Up.Data.Column, 1);
  Put(", ");
  Put(T_L_M.Right.Right.Up.Data.Row, 1);
  Put(")");
  New_Line;

  APA := T_L_M.Down.Down;
  Put(T_L_M);

    Delete_Row(APA);
    New_Line(3);
    Put("Delete Row");
    New_Line;
    Put(T_L_M);
    Reset_Row(APA);
    New_Line(3);
    Put("Reset Row");
    New_Line;
    Put(T_L_M);

    APA := T_L_M.Right.Right.Right;
    T_L_M.Right.Right.Up := T_L_M.Up.Left;
    Delete_Column(APA);
    New_Line(3);
    Put("Delete Column");
    New_Line;
    Put(T_L_M);
    New_Line(3);
    Put("Reset Column");
    New_Line;
    Reset_Column(APA);
    Put(T_L_M);

    APA := T_L_M.Down.Down.Right;
    Delete_DLX(APA);
    New_Line(3);
    Put("Delete DLX");
    New_Line;
    Put(T_L_M);

    New_Line;
    Put("------------");
    Put(APA.Down.Right.Up.Data.Column);
    Put(APA.Down.Right.Up.Data.Row);
    New_Line;

    Reset_DLX(APA);
    New_Line(3);
    Put("Reset DLX");
    New_Line;
    Put(T_L_M);


if False then
    Solve_DLX(T_L_M, Solution, Solved);
    New_Line;
    Put("++++++++++++++++++++++++");
    New_Line;
    if Solved then
      Put("A solution has been found!");
      new_Line;
      while Solution /= Null loop
	Put(Solution.Row.Data.Row, 1);
	Put("     ");
	Solution := Solution.Next;
      end loop;
      else
      Put("No solution!");
    end if;
end if;
end Test_DLX;
