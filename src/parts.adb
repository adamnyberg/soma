-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

package body Parts is
  function Parse_Part(Raw_Part : in Unbounded_String) return Part_Type is
    Start : Unbounded_String;
    Rest : Unbounded_String;
    Part_Size : Integer;
  begin
    Misc.Split( Raw_Part, " ", Start, Rest );
    Part_Size := Misc.Divide_With_Ceil(Length(Rest), Bits.BITS_LENGTH);
    declare
      Part : Part_Type(Part_Size);
    begin
      Part.Dimension := Vector.Parse( Start );
      Part.Structure := Bits.Parse( Rest );
      return Part;
    end;
  end Parse_Part;

  function Parse(Raw_Parts : in Unbounded_String) return Parts_Type is
    Start : Unbounded_String;
    Rest : Unbounded_String;
    Num_Parts : Positive;
  begin
    Misc.Split( Raw_Parts, " ", Start, Rest );
    Num_Parts := Integer'Value( To_String( Start ) );

    -- We don't know how many parts to create until after we parse the string
    declare
      New_Parts : Parts_Type(1..Num_Parts);
    begin
      for Part_Index in New_Parts'Range loop
        if Part_Index /= Num_Parts then
          Misc.Split( Rest, " ", Start, Rest, 1 );
        else
          Start := Rest;
        end if;

        New_Parts(Part_Index) := new Part_Type'(Parse_Part( Start ));
      end loop;

      return New_Parts;
    end;
  end Parse;

  function Part_Fit_In_Figure(Part : Part_Type; Figure : Figure_Type) return boolean is
    Part_Figure : Figure_Type;
    Bits : Bits_Type;
  begin
    Part_Figure = Add_Dimensions(Part, Figure);
    Bits := Part_Figure or Figure.Structure;

    return Bits = Figure.Structure;
  end Part_Fit_In_Figure;

  procedure Compile(Parts : Parts_Type) is
  begin
    null;
  end Compile;

  -- Moves the part 'vector' much, in each direction
  procedure Traverse(Part : in out Part_Type; Diff : in Vector_Type) is
  begin
    Part.Position := (
      X => (Part.Position.X + Diff.X),
      Y => (Part.Position.Y + Diff.Y),
      Z => (Part.Position.Z + Diff.Z));
  end Traverse;

  procedure Rotate(Part : in out Part_Type; Rotation : in Vector_Type) is
  begin
    for X in 1..Rotation.X loop
      Rotate_X(Part);
    end loop;

    if Rotation.Y = 3 then
      Rotate_Y_270(Part);
    else
      for Y in 1..Rotation.Y loop
	Rotate_Y(Part);
      end loop;
    end if;

    for Z in 1..Rotation.Z loop
      Rotate_Z(Part);
    end loop;
  end Rotate;

  procedure Rotate_X(Part : in out Part_Type) is
    Index : Integer := 1;
    Tmp : Integer;
    Tmp_Structure : Bits_Type := Part.Structure;
    X : Integer := Part.Dimension.X;
    Y : Integer := Part.Dimension.Y;
    Z : Integer := Part.Dimension.Z;
  begin
    for I in reverse 1..Y loop
      for J in 0..Z-1 loop
        for K in 1..X loop
          Set_Bit(Part.Structure, Index, Read_Bit(Tmp_Structure, X*(I+J*Y-1)+K));
          Index := Index + 1;
        end loop;
      end loop;
    end loop;

    Tmp := Part.Dimension.Y;
    Part.Dimension.Y := Part.Dimension.Z;
    Part.Dimension.Z := Tmp;
  end Rotate_X;

  procedure Rotate_Y(Part : in out Part_Type) is
    Index : Integer := 1;
    Tmp : Integer;
    Tmp_Structure : Bits_Type := Part.Structure;
    X : Integer := Part.Dimension.X;
    Y : Integer := Part.Dimension.Y;
    Z : Integer := Part.Dimension.Z;
  begin
    for I in 0..X-1 loop
      for J in 1..Y loop
        for K in 0..Z-1 loop
          Set_Bit(Part.Structure, Index, Read_Bit(Tmp_Structure, K*X*Y+J*X-I));
          Index := Index + 1;
        end loop;
      end loop;
    end loop;
    New_Line;

    Tmp := Part.Dimension.Z;
    Part.Dimension.Z := Part.Dimension.X;
    Part.Dimension.X := Tmp;
  end Rotate_Y;

  procedure Rotate_Y_270(Part : in out Part_Type) is
    Index : Integer := 1;
    Tmp : Integer;
    Tmp_Structure : Bits_Type := Part.Structure;
    X : Integer := Part.Dimension.X;
    Y : Integer := Part.Dimension.Y;
    Z : Integer := Part.Dimension.Z;
  begin
    for I in reverse 0..X-1 loop
      for J in 1..Y loop
        for K in reverse 0..Z-1 loop
          Set_Bit(Part.Structure, Index, Read_Bit(Tmp_Structure, K*X*Y+J*X-I));
          Index := Index + 1;
        end loop;
      end loop;
    end loop;

    Tmp := Part.Dimension.Z;
    Part.Dimension.Z := Part.Dimension.X;
    Part.Dimension.X := Tmp;
  end Rotate_Y_270;

  procedure Rotate_Z(Part : in out Part_Type) is
    Index : Integer := 1;
    Tmp : Integer;
    Tmp_Structure : Bits_Type := Part.Structure;
    X : Integer := Part.Dimension.X;
    Y : Integer := Part.Dimension.Y;
    Z : Integer := Part.Dimension.Z;
  begin
    for I in 0..Z-1 loop
      for J in 0..X-1 loop
        for K in 1..Y loop
          Set_Bit(Part.Structure, Index, Read_Bit(Tmp_Structure, K*X-J+I*X*Y));
          Index := Index + 1;
        end loop;
      end loop;
    end loop;

    Tmp := Part.Dimension.Y;
    Part.Dimension.Y := Part.Dimension.X;
    Part.Dimension.X := Tmp;
  end Rotate_Z;
end Parts;
