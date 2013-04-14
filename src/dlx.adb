with Ada.Unchecked_Deallocation;
package body DLX is

  procedure Delete_DLX(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node.Up;
  begin
--    New_Line;
--    Put("A");
--    Put("     (");
--    Put(Node.Data.Column);
--    Put(", ");
--    Put(Node.Data.Row);
--    Put(")");
----    Test_Column(Node);
--    Test_Node(Node);
    Delete_Node(Node);
    if Temp.Data.Column /= 0 then
      loop
--	New_Line;
--	Put("b");
--	if Temp.Data.Column = 14 then
--	  Put("     (");
--	  Put(Temp.Down.Data.Column,1);
--	  Put(", ");
--	  Put(Temp.Down.Data.Row,1);
--	  Put(")");
--	end if;
	if Temp.Data.Row /= 0 then
	  Delete_Row(Temp);
	else
--	  Put("Header");
	  Delete_Node(Temp);
	end if;
--	Put(Temp.Down.Data.Column);
--	Put(", ");
--	Put(Temp.Down.Data.Row,1);
--	Put(Temp.Data.Column);
--	Put(", ");
--	Put(Temp.Data.Row,1);
--	Put(Temp.Up.Data.Column);
--	Put(", ");
--	Put(Temp.Up.Data.Row,1);
	exit when Temp.Up = Temp;
	Temp := Temp.Up;
      end loop;
    end if;
    if Node.Right /= Node then
      Delete_DLX(Node.Right);
    end if;
  end Delete_DLX;

  procedure Reset_DLX(Node : in Linked_Matrix_Pointer; Start : in Linked_Matrix_Pointer := Null) is
    Temp : Linked_Matrix_Pointer := Node.Up;
    Start_Temp : Linked_Matrix_Pointer := Start;
  begin
    if Start = Null then
      Start_Temp := Node;
    end if;
    Reset_Node(Node);
--    Put("(");
--    Put(Node.Data.Column, 1);
--    Put(", ");
--    Put(Node.Data.Row, 1);
--    Put(")");
--    Test_Node(Node);
    if Temp.Data.Column /= 0 then
      loop
	exit when Temp = Node;
	if Temp.Data.Row /= 0 then
	  Reset_Row(Temp);
	else
	  Reset_Node(Temp);
	end if;
	Temp := Temp.Up;
      end loop;
    end if;
    if (Node.Right /= Start_Temp) then
--      Put("A");
--      New_Line;
      Reset_DLX(Node.Right, Start_Temp);
--      Put("B");
--      Test_Node(Node.Right);
    end if;
  end Reset_DLX;

  --function Count_Ones(Col_Header : in Linked_Matrix) return Integer is
 --   Temp : Linked_Matrix := Col_Header.Down;
 --   Ones : Integer := 0;
 -- begin
 --   loop
 --     Ones := Ones + 1;
 --     Temp := Temp.Down;
 --     exit when Temp.Data.Rows = 0;
 --   end loop;
 --   return Ones;
 -- end Count_Ones;

  --function Fewest_Ones_2(Col_Header1, Col_Header2 : in Linked_Matrix) return Linked_Matrix is
  --begin
  --  if Count_Ones(Col_Header1) > Count_Ones(Col_Header2) then
  --    return Col_Header1;
  --  else
  --    return Col_Header2;
  --  end if;
  --end Fewest_Ones_2;

  --function Fewest_Ones_All(Header : in Linked_Matrix) return Linked_Matrix is
  --  Column : Linked_Matrix := Header.Right;
  --  Temp : Linked_Matrix := Column.Right;
  --begin
  --  loop
  --    Column := Fewest_Ones_2(Column,Temp);
  --    Temp := Temp.Right;
  --    exit when Temp.Data.Rows = 1;
  --  end loop;
  --  return Column;
  --end Fewest_Ones_All;

  function Has_A_Column_Without_Ones(Header : in Linked_Matrix_Pointer) return Boolean is
    Temp : Linked_Matrix_Pointer := Header.Right;
  begin
    loop
      if Temp.Down.Data.Row = 0 then
	return True;
      end if;
      Temp := Temp.Right;
      exit when Temp.Data.Column = 0;
    end loop;
    return False;
  end Has_A_Column_Without_Ones;

  function Last(Resulting_List : in Linked_Resulting_List_Pointer)
		  return Linked_Resulting_List_Pointer is
    Curr, Temp : Linked_Resulting_List_Pointer := Resulting_List;
  begin
    if Curr /= Null then
      loop
	if Curr.next = Null then
	  return Curr;
	else
	  Curr := Curr.Next;
	end if;
      end loop;
    end if;
    return Curr;
  end Last;

  function Get_Row_Header_Info(Node : in Linked_Matrix_Pointer) return Linked_Resulting_List is
    Curr : Linked_Resulting_List;
    Temp : Linked_Matrix_Pointer := Node;
  begin
--    New_Line;
    while Temp.Data.Column /= 0 loop
      Temp := Temp.Left;
    end loop;
    Curr.Row := Temp;
    Curr.Part := Temp.Data.Part;
    Curr.Next := Null;
    return Curr;
  end Get_Row_Header_Info;

  function Choose_Next_Row(Previous : in Linked_Matrix_Pointer) return Linked_Matrix_Pointer is
  begin
    return Previous.Down;
  end Choose_Next_Row;

  --function Choose_Next_One(Previous : in Linked_Matrix)
  --	return Linked_Matrix is
  --    Node : Linked_Matrix;
  --  begin
  --    if Previous.Down.Data.Row = 0 then
  --      Node := Previous.Down.Right.Down;
  --    else
  --      Node := Previous.Down;
  --    end if;
  --
  --    if Node.Left.Data.Cols = 0 then--ROW_HEADER then
  --      return Previous.Down.Right.Down;
  --    else
  --      return Choose_Next_One(Node);
  --    end if;
  --  end Choose_Next_One;

  procedure Free is
    new Ada.Unchecked_Deallocation(Linked_Resulting_List, Linked_Resulting_List_Pointer);

  procedure Remove_Last(Linked_List : in out Linked_Resulting_List_Pointer) is
    Second_Last, Garbage : Linked_Resulting_List_Pointer;
  begin
    Second_Last := Linked_List;
    if Second_Last.Next /= Null then
      while Second_Last.Next.Next /= Null loop
        Second_Last:= Second_Last.Next;
      end loop;
      Garbage := Second_Last.Next;
      Second_Last.Next.Previous := Null;
      Second_Last.Next := Null;
      Free(Garbage);
    else
      Garbage := Linked_List;
      Linked_List := Null;
      Free(Garbage);
    end if;
  end Remove_Last;

  procedure Swap(Left, Right : in Linked_Resulting_List_Pointer) is
    Temp1, Temp2 : Linked_Resulting_List_Pointer;
  begin
    Temp1 := Right.Next;
    Right.Next.Previous := Left;
    Right.Next := Left;
    Right.Previous := Left.Previous;
    Temp2 := Right;
    Left.Next := Temp1;
    Left.Previous := Temp2;
    Left.Previous.Previous.Next := Temp2;
  end Swap;

  procedure Sort(List : in out Linked_Resulting_List_Pointer) is
    Prev, Curr, Temp1, Temp2 : Linked_Resulting_List_Pointer;
  begin
    if List = Null or else List.Next = Null then
      Null;
    else
      Prev := List.Next;
      if List.Part.ID > Prev.Part.ID then
	Temp1 := Prev.Next;
	Prev.Next.Previous := List;
	Prev.Next := List;
	Prev.Previous := List.Previous;
	Temp2 := Prev;
	List.Next := Temp1;
	List.Previous := Temp2;
	List := Temp2;
      end if;
      if List.Next.Next = Null then
	Null;
      else
	Prev := List.Next;
	Curr := List.Next.Next;
	loop
	  if Prev.Part.ID > Curr.Part.ID then
	    Swap(Prev, Curr);
	    Curr := Prev;
	    Prev := Prev.Previous;
	  else
	    Prev := Curr;
	    Curr := Curr.Next;
	  end if;
	  exit when Curr = Null;
	end loop;
      end if;
    end if;
  end Sort;

  procedure Put(Linked_List : in Linked_Resulting_List_Pointer) is
    Curr, Prev : Linked_Resulting_List_Pointer := Linked_List;
  begin
    New_Line;
    Put("Selected:");
    while Curr /= Null loop
      Put(" ");
      Put(Curr.Row.Data.Row,1);
      Curr := Curr.Next;
    end loop;
  end Put;

  function Count_Col(Header : in Linked_Matrix_Pointer) return Integer is
    Temp : Linked_Matrix_Pointer := Header.Down;
    Columns : Integer := 0;
  begin
    loop
      Columns := Columns + 1;
      Temp := Temp.Down;
      exit when Temp = Header;
    end loop;
    return Columns;
  end Count_Col;

--  function Last(Linked_List : Linked_Deleted_Rows_Pointer) return Linked_Deleted_Rows_Pointer is
--    Temp : Linked_Deleted_Rows_Pointer := Linked_List;
--  begin
--      if Temp /= Null then
--	loop
--	  exit when Temp.Next = Null;
--	  Temp := Temp.Next;
--	end loop;
--      end if;
--      return Temp;
--  end Last;

--  procedure Free is
--    new Ada.Unchecked_Deallocation(Linked_Deleted_Rows, Linked_Deleted_Rows_Pointer);

--  procedure Reset_All(Linked_List : in Linked_Deleted_Rows_Pointer) is
--    Last_Element : Linked_Deleted_Rows_Pointer := Last(Linked_List);
--    Second_Last : Linked_Deleted_Rows_Pointer;
--  begin
--    if Last_Element /= Null then
--      while Last_Element.Previous /= Null loop
--	Second_Last := Last_Element.Previous;
--	Reset_Row(Last_Element.Row);
--
--	Last_Element.Previous.Next := Null;
--	Free(Last_Element);
--	Last_Element := Second_Last;
--      end loop;
--    end if;
--  end Reset_All;

  procedure Solve_DLX(Header : in Linked_Matrix_Pointer;
    Selected : in out Linked_Resulting_List_Pointer; Solved : out Boolean) is
    Selected_Row : Linked_Matrix_Pointer := Header;
    Selected_Node : Linked_Matrix_Pointer;
    Selected_Temp1, Selected_Temp2 : Linked_Resulting_List_Pointer;
--    Deleted_Rows : Linked_Deleted_Rows_Pointer := Null;
  begin
    Put(Selected);
--    loop
      if Is_Empty(Header) then
	Solved := True;
	Null;
      elsif Has_A_Column_Without_Ones(Header) then
	Null;
      else
	Selected_Row := Choose_Next_Row(Selected_Row);
	Selected_Node := Selected_Row;
	if Selected = Null then
	  Selected := new Linked_Resulting_List'(Get_Row_Header_Info(Selected_Node));
	else
	  Selected_Temp1 := Last(Selected);
	  Selected_Temp1.Next := new Linked_Resulting_List'(Get_Row_Header_Info(Selected_Node));
	  Selected_Temp2 := Selected_Temp1.Next;
	  Selected_Temp2.Previous := Selected_Temp1;
--	  Last(Selected).Next := new Linked_Resulting_List'(Get_Row_Header_Info(Selected_Node));
	end if;
	Delete_DLX(Selected_Node);
	Solve_DLX(Header, Selected, Solved);
--	exit when Solved;
	if not Solved then
	  Reset_DLX(Last(Selected).Row);
	  Remove_Last(Selected);
	  Delete_Row(Selected_Row); --If a solution can't be found when this row is chosen first, the row is in no solution.

	  Solve_DLX(Header, Selected, Solved);
--	  exit when Solved;
	  if not Solved then
	    Reset_Row(Selected_Row);
	  end if;
	end if;
      end if;

--  end loop;
end Solve_DLX;
end DLX;
