with Ada.Unchecked_Deallocation;
package body DLX is
--  procedure Put_Row(Row : in Linked_Matrix_Pointer; Amount : in Integer) is
--    Curr : Linked_Matrix_Pointer := Row.Right;
--    Prev : Linked_Matrix_Pointer := Row;
--  begin
--    Put(Row.Data.Row,1);
--    loop
--	for I in Prev.Data.Column + 1..Curr.Data.Column - 1 loop
--	  Put(0,4);
--	end loop;
--	exit when Curr.Data.Column = 0;
--	Put(1,4);
--	Prev := Curr;
--	Curr := Curr.Right;
--	if Curr.Data.Column = 0 then
--	  for I in Prev.Data.Column + 2..Amount loop
--	    Put(0,4);
--	  end loop;
--	end if;
--
--    end loop;
--  end Put_Row;

--  procedure Put(Header : in Linked_Matrix_Pointer) is
--    Temp : Linked_Matrix_Pointer := Header;
--    Prev : Linked_Matrix_Pointer := Temp;
--    Num_Of_Cols : Integer := 0;
--  begin
--    if Is_Empty(Header) then
--      Put("The Matrix is empty!");
--      return;
--    end if;
--    loop
--      for I in Prev.Data.Column+2 ..Temp.Data.Column loop
--	Put(0,1);
--	Put("   ");
--      end loop;
--      Put(Temp.Data.Column,1);
--      Put("   ");
--      Prev := Temp;
--      Temp := Temp.Right;
--      Num_Of_Cols := Num_Of_Cols + 1;
--      exit when Temp.Data.Column = 0;
--    end loop;
--    Temp := Header.Down;
--    loop
--      New_Line(2);
--      Put_Row(Temp, Num_Of_Cols);
--      Temp := Temp.Down;
--      exit when Temp.Data.Row = 0;
--    end loop;
--  end Put;

--  procedure Delete_Node(Node : in Linked_Matrix) is
--  begin
--    New_Line;
--    Put("Delete_Node");
--    Node.Left.Right := Node.Right;
--    Node.Right.Left := Node.Left;
--    Node.Up.Down := Node.Down;
--    Node.Down.Up := Node.Up;
--  end Delete_Node;
--
--  procedure Reset_Node(Node : in Linked_Matrix) is
--  begin
--    Node.Left.Right.all := Node;
--    Node.Right.Left.all := Node;
--    Node.Up.Down.all := Node;
--    Node.Down.Up.all := Node;
--  end Reset_Node;
--
--  procedure Delete_Row(Node : in Linked_Matrix) is
--    Temp : Linked_Matrix := Node;
--  begin
--    New_Line;
--    Put("Delete_Row");
--    loop
--      Delete_Node(Temp);
--      Temp := Temp.Right.all;
--      exit when Temp.Right.all = Temp;
--      Delete_Node(Temp);
--    end loop;
--  end Delete_Row;
--
--  procedure Reset_Row(Node : in Linked_Matrix) is
--    Temp : Linked_Matrix := Node.Left.all;
--  begin
--    loop
--      Reset_Node(Temp);
--      Temp := Temp.Left.all;
--      exit when Temp = Node;
--      Reset_Node(Node);
--    end loop;
--  end Reset_Row;
--
--  procedure Delete_Column(Node : in Linked_Matrix) is
--    Temp : Linked_Matrix := Node;
--  begin
--    New_Line;
--    Put("Delete_Column");
--    loop
--      Delete_Node(Temp);
--      Temp := Temp.Up.all;
--      exit when Temp.Up.all = Temp;
--      Delete_Node(Temp);
--    end loop;
--  end Delete_Column;
--
--  procedure Reset_Column(Node : in Linked_Matrix) is
--    Temp : Linked_Matrix := Node.Down.all;
--  begin
--    loop
--      Reset_Node(Temp);
--      Temp := Temp.Down.all;
--      exit when Temp = Node;
--      Reset_Node(Node);
--    end loop;
--  end Reset_Column;

  procedure Delete_DLX(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node.Up;
  begin
    Delete_Node(Node);
    if Temp.Data.Column /= 0 then
      loop
	if Temp.Data.Row /= 0 then
	  Delete_Row(Temp);
	else
	  Delete_Node(Temp);
	end if;
	exit when Temp.Up = Temp;
	Temp := Temp.Up;
      end loop;
    end if;
    if not (Node.Right = Node) then
      Delete_DLX(Node.Right);
    end if;
  end Delete_DLX;

  procedure Reset_DLX(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node.Up;
  begin
    Put("Reset_DLX");
    New_Line;
    Put("     A");
    Put("(");
    Put(Node.Data.Column,1   );
    Put(", ");
    Put(Node.Data.Row,1);
    Put(")");
    Reset_Node(Node);
    if Temp.Data.Column /= 0 then
      loop
	exit when Temp = Node;
	if Temp.Data.Row /= 0 then
	  Put("     B");
	  Put("(");
	  Put(Temp.Data.Column,1   );
	  Put(", ");
	  Put(Temp.Data.Row, 1);
	  Put(")");
	  Reset_Row(Temp);
	else
	  Put("     C");
	  Put("(");
	  Put(Temp.Data.Column,1   );
	  Put(", ");
	  Put(Temp.Data.Row, 1);
	  Put(")");
	  Reset_Node(Temp);
	end if;
	Temp := Temp.Up;
      end loop;
    end if;
    if not (Node.Right.Down.Up = Node.Right) then
      New_Line;
      Put("D");
      Reset_DLX(Node.Right);
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
    New_Line;
    Put("Has_A_Column_Without_Ones");
    loop
      if Temp.Down.Data.Row = 0 then
	Put("-True");
	return True;
      end if;
      Temp := Temp.Right;
      exit when Temp.Data.Column = 0;
    end loop;
    Put("-False");
    return False;
  end Has_A_Column_Without_Ones;

--  function Is_Empty(Header : in Linked_Matrix_Pointer) return Boolean is
--  begin
--    New_Line;
--    Put("Is_Empty");
--    if Header.Right = Header then
--      Put("-True");
--      return True;
--    else
--      Put("-False");
--      return False;
--    end if;
--  end Is_Empty;

  function Last(Resulting_List : in Linked_Resulting_List_Pointer) 
		  return Linked_Resulting_List_Pointer is
    Curr, Temp : Linked_Resulting_List_Pointer := Resulting_List;
  begin
    New_Line;
    Put("Last");
    if Curr /= Null then
      Put("777777777777777");
      loop
	if Curr.next = Null then
	  Put("888888888");
	  New_Line;
	  return Curr;
	else
	  Curr := Curr.Next;
	end if;
      end loop;
    end if;
	  Put("999999999999");
	  New_Line;
    return Curr;
  end Last;

  function Get_Row_Header_Info(Node : in Linked_Matrix_Pointer) return Linked_Resulting_List is
    Curr : Linked_Resulting_List;
    Temp : Linked_Matrix_Pointer := Node;
  begin
    New_Line;
    Put("Get_Row_Header_Info");
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
    New_Line;
    Put("Choose_Next_Row");
    return Previous.Up;
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
    New_Line;
    Put("Remove_Last");
    Put(Linked_List);
    Second_Last := Linked_List;
    New_Line;
    Put(Second_Last.Row.Data.Row);
    New_Line;
    if Second_Last.Next /= Null then
      Put("GG");
      while Second_Last.Next.Next /= Null loop
	Put("HGH");
	Second_Last:= Second_Last.Next;
      end loop;
      Garbage := Second_Last.Next;
      Second_Last := Null;
      Free(Garbage);
    else
      Garbage := Linked_List.Next;
      Linked_List := Null;
      Free(Garbage);
    end if;
  end Remove_Last;

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

  procedure Solve_DLX(Header : in Linked_Matrix_Pointer;
    Selected : in out Linked_Resulting_List_Pointer; Solved : out Boolean) is
    Selected_Row : Linked_Matrix_Pointer := Header;
    Selected_Node : Linked_Matrix_Pointer;
  begin
    Put(Selected);
    loop
      New_Line;
      Put("------------");
      New_Line;
      Put(Header);
      New_Line;
      Put("------------");
      New_Line;
      if Is_Empty(Header) then
	--Solution Found! Return Resulting_Matrices
	Put("SOLVED TRUE");
	Solved := True;
      elsif Has_A_Column_Without_Ones(Header)
	or else Selected_Row = Header.Down then
	--GO BACK!/Give up (When there is atleast one row with no ones or
	--when all rows have been selected once.
	Put("GO BACK!");
	Reset_DLX(Last(Selected).Row);
	Put(Selected);
	Remove_Last(Selected);
	Put(Selected);
	exit;
      else
	Selected_Row := Choose_Next_Row(Selected_Row);
	New_Line;
	Put("Current Selected: ");
	Put(Selected_Row.Data.Row);
	Selected_Node := Selected_Row;
	if Selected = Null then
	  Selected := new Linked_Resulting_List'(Get_Row_Header_Info(Selected_Node));
	else
	  Last(Selected).Next := new Linked_Resulting_List'(Get_Row_Header_Info(Selected_Node));
	end if;
	Delete_DLX(Selected_Node);
	New_Line(4);

	Put(Selected.Row.Data.Row);
	Put("????????");
	if Selected = Null then
	  Put("SOL NULL");
	else
	  Put("SOL NOT NULL");
	end if;
	New_Line;
	Solve_DLX(Header, Selected, Solved);
      end if;
      exit when Solved;
    end loop;
  end Solve_DLX;
end DLX;
