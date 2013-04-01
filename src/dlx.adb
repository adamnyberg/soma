

package DLX is
  procedure Put_Row(Row : in Linked_Matrix; Amount : Integer) is
    Curr : Linked_Matrix := Row.Right;
    Prev : Linked_Matrix := Row;
  begin
    Put(Row.Data.Row & "  ");
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
      Curr := Curr.Right;
    end loop;
  end Put_Row;

  procedure Put(Header : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix := Header.Cols;
    Num_Of_Cols : Integer := 0;
  begin
    if Is_Empty(Header) then
      Put("The Matrix is empty!");
      return;
    end if;
    loop
      Put(Temp.Data.Cols & "  ");
      Temp := Temp.Right;
      Num_Of_Cols := Num_Of_Cols + 1;
      exit when Temp.Data.Column = 1;
    end loop;
    Temp := Header.Rows;
    loop
      New_Line(2);
      Put_Row(Temp, Num_Of_Cols);
      Temp := Temp.Down;
      exit when Temp.Data.Rows = 1;
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
    Node.Left.Right := Node;
    Node.Right.Left := Node;
    Node.Up.Down := Node;
    Node.Down.Up := Node;
  end Reset_Node;

  procedure Delete_Row(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node;
  begin
    loop
      Delete_Node(Temp);
      Temp := Temp.Right;
      exit when Temp.Right = Temp;
      Delete_Node(Temp);
    end loop;
  end Delete_Row;

  procedure Reset_Row(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node.Left;
  begin
    loop
      Reset_Node(Temp);
      Temp := Temp.Left;
      exit when Temp = Node;
      Reset_Node(Node);
    end loop;
  end Reset_Row;

  procedure Delete_Column(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node;
  begin
    loop
      Delete_Node(Temp);
      Temp := Temp.Up;
      exit when Temp.Up = Temp;
      Delete_Node(Temp);
    end loop;
  end Delete_Column;

  procedure Reset_Column(Node : in Linked_Matrix) is
    Temp : Linked_Matrixi := Node.Down;;
  begin
    loop
      Reset_Node(Temp);
      Temp := Temp.Down;
      exit when Temp = Node;
      Reset_Node(Node);
    end loop;
  end Reset_Column;

  procedure Delete_DLX(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node.Up;
  begin
    Delete(Node);
    loop
      if Temp.Data.Rows /= 0 then --HÄR
	Delete_Row(Temp);
      else
	Delete_Node(Temp);
      end if;
      exit when Temp.Up = Temp;
    end loop;

    if Node.Right /= Node then
      Delete_DLX(Node.Right);
    end if;

    if False then
    Delete_Node(Node);
    Delete_Node(Temp);
    while Temp.Up /= Temp loop
      Delete_Row(Temp.Up);
    end loop;

    --loop
    --  Delete_Row(Temp);
    --  Temp := Temp.Up;
    --  exit when Temp = Node;
    --end loop;

    Temp := Node.Right;
    Delete_Node(Temp);
    while Temp.Right /= Temp loop
      Delete_Column(Temp.Right);
    end loop;
    --loop
    --  Delete_Column(Temp);
    --  Temp := Temp.Right;
    --  exit when Temp := Node;
    --end loop;
    end if;
  end Delete_DLX;

  procedure Reset_DLX(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node.Up;
  begin
    Reset(Node);
    loop
      Reset_Row(Temp);
      Temp := Temp.Up;
      exit when Temp = Node;
    end loop;

    if Node.Right /= Node then
      Reset_DLX(Node.Right);
    end if;
  end Reset_DLX;

  function Count_Ones(Col_Header : in Linked_Matrix) return Integer is
    Temp : Linked_Matrix := Col_Header.Down;
    Ones : Integer := 0;
  begin
    loop
      Ones := Ones + 1;
      Temp := Temp.Down;
      exit when Temp.Data.Rows = 0;
    end loop;
    return Ones;
  end Count_Ones;

  function Fewest_Ones_2(Col_Header1, Col_Header2 : in Linked_Matrix) return Linked_Matrix is
  begin
    if Count_Ones(Col_Header1) > Count_Ones(Col_Header2) then
      return Col_Header1;
    else
      return Col_Header2;
    end if;
  end Fewest_Ones;

  function Fewest_Ones_All(Header : in Linked_Matrix_Pointer) return Linked_Matrix is
    Column : Linked_Matrix := Header.Cols;
    Temp : Linked_Matrix := Column.Right;
  begin
    loop
      Column := Fewest_Ones_2(Column,Temp);
      Temp := Temp.Right;
      exit when Temp.Data.Rows = 1;
    end loop;
    return Column;
  end Fewest_Ones_All;

  function Has_A_Column_Without_Ones(Header : in Linked_Matrix_Pointer) return Boolean is
    Temp : Linked_Matrix := Header.Cols;
  begin
    loop
      if Temp.Down.Data.Row = 0 then
	return True;
      end if;
      Temp := Temp.Right;
      exit when Temp.Data.Cols = 1;
    end loop;
  end Has_A_Column_Without_Ones;

  function Is_Empty(Header : in Linked_Matrix_Pointer) return Boolean is
    if Header.Right:= Null then
      return True;
    else
      return False;
    end if;
  end Is_Empty;

  function Last(Resulting_List : in Linked_Resulting_List_Pointer) 
		  return Linked_Resulting_List_Pointer is
    Curr, Temp : Linked_Resulting_List_Pointer := Resulting_List;
  begin
    if Curr.next := Null then
      return Curr;
    else
      Curr := Curr.Next;
    end if;
  end Last;

  function Get_Row_Header_Info(Node : in Linked_Matrix) return Linked_Resulting_List is
    Curr : Linked_Resulting_List;
    Temp : Linked_Matrix := Node;
  begin
    while Temp.Data.Cols /= 0 loop
      Temp := Temp.Left;
    end loop;

    Curr.Row := Temp;
    Curr.Part := Temp.Part;
    Curr.Position := Temp.Position;
    Curr.Rotated := Temp.Rotated;
    Curr.Next := Null;
    return Curr;
  end Get_Row_Header_Info;

  function Choose_Next_Row(Previous : in Linked_Matrix) return Linked_Matrix is
  begin
    return Previous.Down;
  end Choose_Next_Row;

  function Choose_Next_One(Header : in Linked_Matrix_Pointer; Previous : in Linked_Matrix)
	return Linked_Matrix is
    Node : Linked_Matrix;
  begin
    if Previous.Down.IS_HEADER then
      Node := Previous.Down.Right.Down;
    else
      Node := Previous.Down;
    end if;

    if Node.Left.Data.Cols = 0 then--ROW_HEADER then
      return Previous.Down.Right.Down;
    else
      return Choose_Next_One(Node);
    end if;
  end Choose_Next_One;

  procedure Free is
    new Ada.Unchecked_Deallocation(Linked_Matrix, Linked_Matrix_Pointer);

  procedure Remove_Last(Linked_List : in out Linked_Resulting_List_Pointer) is
    Semi_Last, Garbage : Linked_Matrix_Pointer;
  begin
    Semi_Last := Linked_List;
    while Semi_Last.Next.Next /= Null loop
      Semi_Last := Semi_Last.Next;
    end loop;
    Garbage := Semi_Last;
    Semi_Last.Next := Null;
    Free(Garbage);
  end Remove_Last;

  procedure Solve_DLX(Header : in Linked_Matrix_Pointer;
    Selected : in out Linked_Resulting_List_Pointer := Null; Solved : out Boolean) is
    Selected_Row : Linked_Matrix := Header.Rows.Up;;
    Selected_Node : Linked_Matrix;
    Solution : Linked_Resulting_List_Pointer;
  begin
    while not Solved loop
      if Is_Empty(Header) then
	--Solution Found! Return Resulting_Matrices
	Solved := True;
      elsif Has_Only_Zeros_Column(Header)
	or else Selected_Row.Data.Row = Header.Rows.Data.Row then
	--GO BACK!/Give up (When there is atleast one row with no ones or
	--all rows have been selected once.
	Reset_DLX(Last(Solution).Row);
	Remove_Last(Solution);
	exit;
      else
	Selected_Row := Choose_Next_Row(Selected_Row);
	Selected_Node := Selected_Row.Right;
	Last(Solution).Next := new Get_Row_Header_Info'(Selected_Node);
	Delete_DLX(Selected_Node);
	Solve_DLX(Header, Solution, Solved);
      end if;
    end loop;
  end Solve_DLX;
end DLX;
