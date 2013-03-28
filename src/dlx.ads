
package DLX is
  type Linked_Resulting_List is private;
  type Linked_Resulting_List_Pointer is access Linked_Resulting_List;
  procedure Delete_Node(Node : in Linked_Matrix);
  procedure Reset_Node(Node : in Linked_Matrix);
  procedure Delete_Row(Node : in Linked_Matrix);
  procedure Reset_Row(Node : in Linked_Matrix);
  procedure Delete_Column(Node : in Linked_Matrix);
  procedure Reset_Column(Node : in Linked_Matrix);
  procedure Delete_DLX(Node : in Linked_Matrix);
  procedure Reset_DLX(Node : in Linked_Matrix);
  procedure Solve_DLX(Header : in Linked_Matrix;
    Selected : in out Linked_Resulting_List_Pointer; Solved : out Boolean);
private
  type Linked_Resulting_List is
    record
      Row : Linked_Matrix;
      Part : Integer;
      Traversed, Rotated : Vector;
      Next : Linked_Resulting_List_Pointer;
    end record;
end DLX;

