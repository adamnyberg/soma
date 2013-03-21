

procedure DLX is
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
      exit when Temp = Node;
    end loop;
  end Delete_Row;

  procedure Reset_Row(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node;
  begin
    loop
      Reset_Node(Temp);
      Temp := Temp.Right;
      exit when Temp = Node;
    end loop;
  end Reset_Row;

  procedure Delete_Column(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node;
  begin
    loop
      Delete_Node(Temp);
      Temp := Temp.Up;
      exit when Temp = Node;
    end loop;
  end Delete_Column;

  procedure Reset_Column(Node : in Linked_Matrix) is
    Temp : Linked_Matrix;
  begin
    loop
      Reset_Node(Temp);
      Temp := Temp.Up;
      exit when Temp = Node;
    end loop;
  end Reset_Column;

  procedure Delete_DLX(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node.Up;
  begin
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
  end Delete_DLX;

  procedure Reset_DLX(Node : in Linked_Matrix) is
    Temp : Linked_Matrix := Node.Up;
  begin
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
  end Reset_DLX;

  Head : Linked_Matrix;
begin
 Null;
end DLX;
