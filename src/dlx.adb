with Ada.Unchecked_Deallocation;
package body DLX is
  procedure Put_Row(Row : in Linked_Matrix; Amount : Integer) is
    Curr : Linked_Matrix := Row.Right.all;
    Prev : Linked_Matrix := Row;
  begin
    Put(Row.Data.Row);
    Put("  ");
    loop
      if Curr.Data.Column = 0 then
	for I in Prev.Data.Column + 1..Amount loop
	  Put(0);
	  Put("  ");
	end loop;
	exit;
      end if;
      for I in Prev.Data.Column + 1..Curr.Data.Column loop
	Put(0);
	Put("  ");
      end loop;
      Put(1);
      Prev := Curr;
      Curr := Curr.Right.all;
    end loop;
  end Put_Row;

  procedure Put(Header : in Linked_Matrix) is
    Temp : Linked_Matrix := Header.Right.all;
    Num_Of_Cols : Integer := 0;
  begin
    if Is_Empty(Header) then
      Put("The Matrix is empty!");
      return;
    end if;
    loop
      Put(Temp.Data.Column);
      Put("  ");
      Temp := Temp.Right.all;
      Num_Of_Cols := Num_Of_Cols + 1;
      exit when Temp.Data.Column = 1;
    end loop;
    Temp := Header.Down.all;
    loop
      New_Line(2);
      Put_Row(Temp, Num_Of_Cols);
      Temp := Temp.Down.all;
      exit when Temp.Data.Row = 1;
    end loop;
  end Put;

  procedure Delete_Node(Node : in Linked_Matrix) is
  begin
    Node.Left.Right := Node.Right;
    Node.Right.Left := Node.Left;
    Node.Up.Down := Node.Down;
    Node.Down.Up := Node.Up;
  end Delete_Node;

  procedure Reset_Node(Node : in Linked_Matrix) is
  begin
    Node.Left.Right.all := Node;
    Node.Right.Left.all := Node;
    Node.Up.Down.all := Node;
    Node.Down.Up.all := Node;
  end Reset_Node;

  procedure Delete_Row(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node;
  begin
    loop
      Delete_Node(Temp);
      Temp := Temp.Right.all;
      exit when Temp.Right.all = Temp;
      Delete_Node(Temp);
    end loop;
  end Delete_Row;

  procedure Reset_Row(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node.Left.all;
  begin
    loop
      Reset_Node(Temp);
      Temp := Temp.Left.all;
      exit when Temp = Node;
      Reset_Node(Node);
    end loop;
  end Reset_Row;

  procedure Delete_Column(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node;
  begin
    loop
      Delete_Node(Temp);
      Temp := Temp.Up.all;
      exit when Temp.Up.all = Temp;
      Delete_Node(Temp);
    end loop;
  end Delete_Column;

  procedure Reset_Column(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node.Down.all;
  begin
    loop
      Reset_Node(Temp);
      Temp := Temp.Down.all;
      exit when Temp = Node;
      Reset_Node(Node);
    end loop;
  end Reset_Column;

  procedure Delete_DLX(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node.Up.all;
  begin
    Delete_Node(Node);
    loop
      if Temp.Data.Row /= 0 then
	Delete_Row(Temp);
      else
	Delete_Node(Temp);
      end if;
      exit when Temp.Up.all = Temp;
    end loop;

    if not (Node.Right.all = Node) then
      Delete_DLX(Node.Right.all);
    end if;

    --if False then
    --Delete_Node(Node);
    --Delete_Node(Temp);
    --while Temp.Up.Data.Row /= Temp.Data.Row
    --  and Temp.Up.Data.Column /= Temp.Data.Column loop
    --  Delete_Row(Temp.Up);
    --end loop;

    --loop
    --  Delete_Row(Temp);
    --  Temp := Temp.Up;
    --  exit when Temp = Node;
    --end loop;

    --Temp := Node.Right.all;
    --Delete_Node(Temp);
    --while Node.Right.Data.Row /= Node.Data.Row
    --  and Node.Right.Data.Column /= Node.Data.Column loop
    --  Delete_Column(Temp.Right);
    --end loop;
    ----loop
    ----  Delete_Column(Temp);
    ----  Temp := Temp.Right;
    ----  exit when Temp := Node;
    ----end loop;
    --end if;
  end Delete_DLX;

  procedure Reset_DLX(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node.Up.all;
  begin
    Reset_Node(Node);
    loop
      Reset_Row(Temp);
      Temp := Temp.Up.all;
      exit when Temp = Node;
    end loop;

    if not (Node.Right.all = Node) then
      Reset_DLX(Node.Right.all);
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

  function Has_A_Column_Without_Ones(Header : in Linked_Matrix) return Boolean is
    Temp : Linked_Matrix := Header.Right.all;
  begin
    loop
      if Temp.Down.Data.Row = 0 then
	return True;
      end if;
      Temp := Temp.Right.all;
      exit when Temp.Data.Column = 1;
    end loop;
    return False;
  end Has_A_Column_Without_Ones;

  function Is_Empty(Header : in Linked_Matrix) return Boolean is
  begin
    if Header.Right = Null then
      return True;
    else
      return False;
    end if;
  end Is_Empty;

  function Last(Resulting_List : in Linked_Resulting_List_Pointer) 
		  return Linked_Resulting_List_Pointer is
    Curr, Temp : Linked_Resulting_List_Pointer := Resulting_List;
  begin
    loop
      if Curr.next = Null then
	return Curr;
      else
	Curr := Curr.Next;
      end if;
    end loop;
  end Last;

  function Get_Row_Header_Info(Node : in Linked_Matrix) return Linked_Resulting_List is
    Curr : Linked_Resulting_List;
    Temp : Linked_Matrix := Node;
  begin
    while Temp.Data.Column /= 0 loop
      Temp := Temp.Left.all;
    end loop;

    Curr.Row := Temp;
    Curr.Part := Temp.Data.Part;
    Curr.Next := Null;
    return Curr;
  end Get_Row_Header_Info;

  function Choose_Next_Row(Previous : in Linked_Matrix) return Linked_Matrix is
  begin
    return Previous.Down.all;
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
    Second_Last:= Linked_List;
    while Second_Last.Next.Next /= Null loop
      Second_Last:= Second_Last.Next;
    end loop;
    Garbage := Second_Last;
    Second_Last.Next := Null;
    Free(Garbage);
  end Remove_Last;

  procedure Solve_DLX(Header : in Linked_Matrix;
    Selected : in out Linked_Resulting_List_Pointer; Solved : out Boolean) is
    Selected_Row : Linked_Matrix := Header.Down.Up.all;
    Selected_Node : Linked_Matrix;
    Solution : Linked_Resulting_List_Pointer;
  begin
    while not Solved loop
      if Is_Empty(Header) then
	--Solution Found! Return Resulting_Matrices
	Solved := True;
      elsif Has_A_Column_Without_Ones(Header)
	or else Selected_Row.Data.Row = Header.Down.Data.Row then
	--GO BACK!/Give up (When there is atleast one row with no ones or
	--all rows have been selected once.
	Reset_DLX(Last(Solution).Row);
	Remove_Last(Solution);
	exit;
      else
	Selected_Row := Choose_Next_Row(Selected_Row);
	Selected_Node := Selected_Row.Right.all;
	Last(Solution).Next := new Linked_Resulting_List'(Get_Row_Header_Info(Selected_Node));
	Delete_DLX(Selected_Node);
	Solve_DLX(Header, Solution, Solved);
      end if;
    end loop;
  end Solve_DLX;
end DLX;
