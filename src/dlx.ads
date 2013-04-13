with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Matrix; use Matrix;
with Parts; use	Parts;

package DLX is
  RESET_DLX_ERROR : exception;
  type Linked_Resulting_List;
  type Linked_Resulting_List_Pointer is access Linked_Resulting_List;
  type Linked_Resulting_List is
    record
      Previous : Linked_Resulting_List_Pointer;
      Row : Linked_Matrix_Pointer;
      Part : Part_Type_Pointer;
      Next : Linked_Resulting_List_Pointer;
    end record;
--  type Linked_Deleted_Rows;
--  type Linked_Deleted_Rows_Pointer is access Linked_Deleted_Rows;
--  type Linked_Deleted_Rows is
--    record
--      Previous : Linked_Deleted_Rows_Pointer;
--      Row : Linked_Matrix_Pointer;
--      Next : Linked_Deleted_Rows_Pointer;
--    end record;
--  function Is_Empty(Header : in Linked_Matrix_Pointer) return Boolean;
--  procedure Put_Row(Row : in Linked_Matrix_Pointer; Amount : in Integer);
--  procedure Put(Header : in Linked_Matrix_Pointer);
--  procedure Delete_Node(Node : in Linked_Matrix);
--  procedure Reset_Node(Node : in Linked_Matrix);
--  procedure Delete_Row(Node : in Linked_Matrix);
--  procedure Reset_Row(Node : in Linked_Matrix);
--  procedure Delete_Column(Node : in Linked_Matrix);
--  procedure Reset_Column(Node : in Linked_Matrix);
  procedure Delete_DLX(Node : in Linked_Matrix_Pointer);
  procedure Reset_DLX(Node : in Linked_Matrix_Pointer; Start : in Linked_Matrix_Pointer := Null);
  --function Count_Ones(Col_Header : in Linked_Matrix) return Integer;
  --function Fewest_Ones_2(Col_Header1, Col_Header2 : in Linked_Matrix) return Linked_Matrix;
  --function Fewest_Ones_All(Header : in Linked_Matrix) return Linked_Matrix;
  function Has_A_Column_Without_Ones(Header: in Linked_Matrix_Pointer) return Boolean;
  function Last(Resulting_List : in Linked_Resulting_List_Pointer)
		  return Linked_Resulting_List_Pointer;
  procedure Swap(Left, Right: in Linked_Resulting_List_Pointer);
  procedure Sort(List : in out Linked_Resulting_List_Pointer);
  function Get_Row_Header_Info(Node : in Linked_Matrix_Pointer) return Linked_Resulting_List;
  function Choose_Next_Row(Previous : in Linked_Matrix_Pointer) return Linked_Matrix_Pointer;
  --function Choose_Next_One(Header : in Linked_Matrix; Previous : in Linked_Matrix)
--	return Linked_Matrix;
  procedure Put(Linked_List: in Linked_Resulting_List_Pointer);
  function Count_Col(Header : in Linked_Matrix_Pointer) return Integer;
  procedure Solve_DLX(Header : in Linked_Matrix_Pointer;
    Selected : in out Linked_Resulting_List_Pointer; Solved : out Boolean);
end DLX;
