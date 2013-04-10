with Parts; use Parts;
package Matrix is
  type Data_Type is record
    Column : Integer := 0;
    Row : Integer := 0;
    Part : Part_Type_Pointer;
  end record;

  type Linked_Matrix;
  type Linked_Matrix_Pointer is access Linked_Matrix;
  type Linked_Matrix is record
    Data : Data_Type;
    Up : Linked_Matrix_Pointer := null;
    Down : Linked_Matrix_Pointer := null;
    Right : Linked_Matrix_Pointer := null;
    Left : Linked_Matrix_Pointer := null;
  end record;
  procedure Test_Node(Node : in Linked_Matrix_Pointer);
  procedure Test_Column(Col : in Linked_Matrix_Pointer);
  procedure Test_Row(Row : in Linked_Matrix_Pointer);
  procedure Test_Matrix(Header : in Linked_Matrix_Pointer);
  function Is_Empty(Header : in Linked_Matrix_Pointer) return Boolean;
  procedure Put_Row(Row : in Linked_Matrix_Pointer; Amount : in Integer);
  procedure Put(Header : in Linked_Matrix_Pointer);
  function Is_Equal(Left, Right : Linked_Matrix_Pointer) return Boolean;
  procedure Delete_Equal_Rows(Header : in Linked_Matrix_Pointer);
  procedure Delete_Node(Node : in Linked_Matrix_Pointer);
  procedure Reset_Node(Node : in Linked_Matrix_Pointer);
  procedure Delete_Row(Node : in Linked_Matrix_Pointer);
  procedure Reset_Row(Node : in Linked_Matrix_Pointer);
  procedure Delete_Column(Node : in Linked_Matrix_Pointer);
  procedure Reset_Column(Node : in Linked_Matrix_Pointer);
end Matrix;
