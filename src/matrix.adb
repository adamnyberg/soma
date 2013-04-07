with DLX; use DLX; --Endast för PUT-test, ska tas bort
with Ada.Text_IO; use Ada.Text_IO; --Samma för denna
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO; --Samma för denna
package body Matrix is
  function Is_Empty(Header : in Linked_Matrix_Pointer) return Boolean is
  begin
    New_Line;
    Put("Is_Empty");
    if Header.Right = Header then
      Put("-True");
      return True;
    else
      Put("-False");
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
    loop
      New_Line(2);
      Put_Row(Temp, Num_Of_Cols);
      Temp := Temp.Down;
      exit when Temp.Data.Row = 0;
    end loop;
  end Put;
  procedure Delete_Node(Node : in Linked_Matrix_Pointer) is
  begin
    Node.Left.Right := Node.Right;
    Node.Right.Left := Node.Left;
    Node.Up.Down := Node.Down;
    Node.Down.Up := Node.Up;
  end Delete_Node;

  procedure Reset_Node(Node : in Linked_Matrix_Pointer) is
  begin
    Put("    E");
    Put("(");
    Put(Node.Data.Column, 1);
    Put(", ");
    Put(Node.Data.Row,1);
    Put(")");
    Node.Left.Right:= Node;
    Node.Right.Left:= Node;
    Node.Up.Down:= Node;
    Node.Down.Up:= Node;
  end Reset_Node;

  procedure Delete_Row(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node;
  begin
    Delete_Node(Temp);
    loop
      Temp := Temp.Right;
      Delete_Node(Temp);
      exit when Temp.Right.all = Temp.all;
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
  end Reset_Row;

  procedure Delete_Column(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node;
  begin
    Delete_Node(Temp);
    loop
      Temp := Temp.Up;
      Delete_Node(Temp);
      exit when Temp.Up.all = Temp.all;
    end loop;
  end Delete_Column;

  procedure Reset_Column(Node : in Linked_Matrix_Pointer) is
    Temp : Linked_Matrix_Pointer := Node;
  begin
    loop
      Reset_Node(Temp);
      Temp := Temp.Up;
      exit when Temp= Node;
      Reset_Node(Node);
    end loop;
  end Reset_Column;

end Matrix;
