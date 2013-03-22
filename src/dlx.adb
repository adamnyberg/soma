

package DLX is
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
      if Temp.IS_HEADER = FALSE then --HÄR
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
    while Temp /= Col_Header loop
      Ones := Ones + 1;
      Temp := Temp.Up;
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

  function Fewest_Ones_All(Header : in Linked_Matrix) return Linked_Matrix is
    Column : Linked_Matrix := Header.Right;
    Temp : Linked_Matrix := Column.Right;
  begin
    while Temp /= Header loop
      Column := Fewest_Ones_2(Column,Temp);
      Temp := Temp.Right;
    end loop;
  end Fewest_Ones_All;
  
  procedure Solve_DLX(Header : in Linked_Matrix;
    Selected : in out Linked_Resulting_List_Pointer; Solved : out Boolean) is

    Head : Linked_Matrix;
    Selected_Col : Linked_Matrix;
    Selected_Row : Linked_Matrix;
    Selected_Node : Linked_Matrix;
    Resulting_Matrices : Linked_Resulting_List_Pointer;
  begin
    if Is_Empty(Header) then
      --Solution Found! Return Resulting_Matrices
      return True;
    elsif Count_Ones(Fewest_Ones_All(Header)) = 0 then
      --GO BACK!/Give up;
      Reset_DLX(Last(Resulting_Matrices).Row);
      Remove_Last(Resulting_Matrices);
    else
      Selected_Col := Fewest_Ones_All(Header);
      Selected_Node := Selected_Col.Down;
      Resulting_Matrices.Right := Get_Row_Header_Info(Selected_Node);
      Delete_DLX(Selected_Node);
      Solve_DLX(Header, Resulting_Matrices);
    end if;
  end Solve_DLX;
end DLX;
