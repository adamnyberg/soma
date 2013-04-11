with DLX; use DLX; --Endast för PUT-test, ska tas bort
with Ada.Text_IO; use Ada.Text_IO; --Samma för denna
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO; --Samma för denna
package body Matrix is
  procedure Test_Node(Node : in Linked_Matrix_Pointer) is
    NODE_ERROR : exception;
  begin
     if (Node.Up.Down /= Node) or else (Node.Down.Up /= Node)
       or else (Node.Right.Left /= Node) or else (Node.Left.Right /= Node) then
       New_Line(2);
       Put("(");
       Put(Node.Data.Column,1);
       Put(", ");
       Put(Node.Data.Row,1);
       Put(")");
--       raise NODE_ERROR;
     end if;
     if (Node.Up.Down /= Node) then
       New_Line;
       Put("Up ");
       Put("(");
       Put(Node.Up.Data.Column,1);
       Put(", ");
       Put(Node.Up.Data.Row,1);
       Put(")");
       Put("(");
       Put(Node.Up.Down.Data.Column,1);
       Put(", ");
       Put(Node.Up.Down.Data.Row,1);
       Put(")");
     end if;
     if (Node.Down.Up /= Node) then
       New_Line;
       Put("Down ");
       Put("(");
       Put(Node.Down.Data.Column,1);
       Put(", ");
       Put(Node.Down.Data.Row,1);
       Put(")");
       Put("(");
       Put(Node.Down.Up.Data.Column,1);
       Put(", ");
       Put(Node.Down.Up.Data.Row,1);
       Put(")");
     end if;
     if (Node.Right.Left /= Node) then
       New_Line;
       Put("Right ");
       Put("(");
       Put(Node.Right.Data.Column,1);
       Put(", ");
       Put(Node.Right.Data.Row,1);
       Put(")");
       Put("(");
       Put(Node.Right.Left.Data.Column,1);
       Put(", ");
       Put(Node.Right.Left.Data.Row,1);
       Put(")");
     end if;
     if (Node.Left.Right /= Node) then
       New_Line;
       Put("Left");
       Put("(");
       Put(Node.Left.Data.Column,1);
       Put(", ");
       Put(Node.Left.Data.Row,1);
       Put(")");
       Put("(");
       Put(Node.Left.Right.Data.Column,1);
       Put(", ");
       Put(Node.Left.Right.Data.Row,1);
       Put(")");
     end if;
     if (Node.Up.Down /= Node) or else (Node.Down.Up /= Node)
       or else (Node.Right.Left /= Node) or else (Node.Left.Right /= Node) then
       raise NODE_ERROR;
     end if;
  end Test_Node;

  procedure Test_Column(Col : in Linked_Matrix_Pointer) is
    Curr : Linked_Matrix_Pointer := Col;
  begin
    loop
      Test_Node(Curr);
      Curr := Curr.Down;
      exit when Curr = Col;
    end loop;
  end Test_Column;

  procedure Test_Row(Row : in Linked_Matrix_Pointer) is
    Curr : Linked_Matrix_Pointer := Row;
  begin
    loop
      Test_Node(Curr);
      Curr := Curr.Right;
      exit when Curr = Row;
    end loop;
  end Test_Row;

  procedure Test_Matrix(Header : in Linked_Matrix_Pointer) is
    Curr : Linked_Matrix_Pointer := Header;
  begin
    loop
--      Put("R");
      Test_Row(Curr);
      Curr := Curr.Down;
      exit when Curr = Header;
    end loop;
    loop
--      Put("Col");
      Test_Column(Curr);
      Curr := Curr.Right;
      exit when Curr = Header;
    end loop;
--    New_Line;
--    Put("Matrix is all right");
  end Test_Matrix;
  function Is_Empty(Header : in Linked_Matrix_Pointer) return Boolean is
  begin
    if Header.Right = Header then
      return True;
    else
      return False;
    end if;
  end Is_Empty;

  procedure Put_Row(Row : in Linked_Matrix_Pointer; Amount : in Integer) is
    Curr : Linked_Matrix_Pointer := Row.Right;
    Prev : Linked_Matrix_Pointer := Row;
  begin
    Put(Row.Data.Row,1);
    loop
	for I in Prev.Data.Column + 1..Curr.Data.Column - 1 loop
	  Put(0,4);
	end loop;
	exit when Curr.Data.Column = 0;
	Put(1,4);
--	Put("(");
--	Put(Curr.Data.Column,1);
--	Put(", ");
--	Put(Curr.Data.Row,1);
--	Put(")");
	Prev := Curr;
	Curr := Curr.Right;
	if Curr.Data.Column = 0 then
	  for I in Prev.Data.Column + 2..Amount loop
	    Put(0,4);
	  end loop;
	end if;

    end loop;
  end Put_Row;

  procedure Put(Header : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Header;
    Prev : Linked_Matrix_Pointer := Temp;
    Num_Of_Cols : Integer := 0;
  begin
    if Is_Empty(Header) then
      Put("The Matrix is empty!");
      return;
    end if;
    loop
      for I in Prev.Data.Column+2 ..Temp.Data.Column loop
	Put(0,1);
	Put("   ");
      end loop;
      Put(Temp.Data.Column,1);
      Put("   ");
      Prev := Temp;
      Temp := Temp.Right;
      Num_Of_Cols := Num_Of_Cols + 1;
      exit when Temp.Data.Column = 0;
    end loop;
    Temp := Header.Down;
    while Temp.Data.Row /= 0 loop
      New_Line(2);
      Put_Row(Temp, Num_Of_Cols);
      Temp := Temp.Down;
    end loop;
  end Put;

  function Is_Equal(Left, Right : Linked_Matrix_Pointer) return Boolean is
    Left_Temp : Linked_Matrix_Pointer := Left.Right;
    Right_Temp : Linked_Matrix_Pointer := Right.Right;
  begin
    loop
      if Left_Temp.Data.Column /= Right_Temp.Data.Column then
	return False;
      end if;
      Left_Temp := Left_Temp.Right;
      Right_Temp := Right_Temp.Right;
      exit when Left_Temp = Left or Right_Temp = Right;
    end loop;
    if Left_Temp = Left and Right_Temp = Right then
      return True;
    else
      return False;
    end if;
  end Is_Equal;

  procedure Delete_Equal_Rows(Header : in Linked_Matrix_Pointer) is
    Curr : Linked_Matrix_Pointer := Header.Down;
    Temp : Linked_Matrix_Pointer := Curr.Down;
    Row : Integer := 1;
  begin
    loop
      loop
	if Is_Equal(Curr, Temp) then
	  --Put(Curr.Data.Row);
	  --Put("  ");
	  --Put(Temp.Data.Row,1);
	  Delete_Row(Temp);
	end if;
	Temp := Temp.Down;
	exit when Temp = Header;
      end loop;
      Curr := Curr.Down;
      Temp := Curr.Down;
      exit when Curr = Header;
    end loop;
  end Delete_Equal_Rows;

  procedure Delete_Node(Node : in Linked_Matrix_Pointer) is
  begin
--       Put("(");
--       Put(Node.Data.Column,1);
--       Put(", ");
--       Put(Node.Data.Row,1);
--       Put(")");
--       New_Line;
    Node.Left.Right := Node.Right;
    Node.Right.Left := Node.Left;
    Node.Up.Down := Node.Down;
    Node.Down.Up := Node.Up;
  end Delete_Node;

  procedure Reset_Node(Node : in Linked_Matrix_Pointer) is
  begin
--       Put("(");
--       Put(Node.Data.Column,1);
--       Put(", ");
--       Put(Node.Data.Row,1);
--       Put(")");
--       New_Line;
    Node.Left.Right:= Node;
    Node.Right.Left:= Node;
    Node.Up.Down:= Node;
    Node.Down.Up:= Node;
    --Test_Node(Node);
  end Reset_Node;

  procedure Delete_Row(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node;
  begin
    Delete_Node(Temp);
    loop
      Temp := Temp.Right;
      Delete_Node(Temp);
      exit when Temp.Right = Temp;
    end loop;
  end Delete_Row;

  procedure Reset_Row(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node;
  begin
    loop
      Reset_Node(Temp);
      Temp := Temp.Right;
      exit when Temp = Node;
    end loop;
--    Test_Row(Node);
  end Reset_Row;

  procedure Delete_Column(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node;
  begin
    Delete_Node(Temp);
    loop
      Temp := Temp.Up;
      Delete_Node(Temp);
      exit when Temp.Up = Temp;
    end loop;
  end Delete_Column;

  procedure Reset_Column(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node;
  begin
    loop
      Reset_Node(Temp);
      Temp := Temp.Up;
      exit when Temp = Node;
      Reset_Node(Node);
    end loop;
  end Reset_Column;

end Matrix;
