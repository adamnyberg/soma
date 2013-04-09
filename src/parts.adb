-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Bits; use Bits; -- debugging only

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

  function Part_Fit_In_Figure(Part : Part_Type; Figure : Figure_Type) return Boolean is
    Part_Figure : Figure_Type := Add_Dimensions(Part, Figure);
  begin
    if (Part.Position.X + Part.Dimension.X) <= Figure.Dimension.X or else
       (Part.Position.Y + Part.Dimension.Y) <= Figure.Dimension.Y or else
       (Part.Position.Z + Part.Dimension.Z) <= Figure.Dimension.Z then
      return False;
    else
      return (Part_Figure.Structure or Figure.Structure) = Figure.Structure;
    end if;
  end Part_Fit_In_Figure;

  function Add_Dimensions(Part : in Part_Type; Figure : in Figure_Type) return Figure_Type is

    Part_Filled_With_Zeros : Figure_Type := Figure;
    Row : Integer := Figure.Dimension.Y;
    Column : Integer := 1;
    Layer : Integer := 1;
    Part_Index_Value : Natural;
    Pos : Vector_Type;

  begin
    for I in 1..Figure.Structure.Length loop
      if Row > Part.Dimension.Y + Part.Position.Y - 1 or Row < Part.Position.Y then
        Set_Bit(Part_Filled_With_Zeros.Structure, I, 0);
      elsif Column > Part.Dimension.X + Part.Position.X - 1 or Column < Part.Position.X then
        Set_Bit(Part_Filled_With_Zeros.Structure, I, 0);
      elsif Layer > Part.Dimension.Z + Part.Position.Z - 1 or Layer < Part.Position.Z then
        Set_Bit(Part_Filled_With_Zeros.Structure, I, 0);
      else
        Pos := Index_To_Vector(Figure.Dimension, I) - Part.Position;
        Part_Index_Value := Read_Bit( Part.Structure, Vector_To_Index( Part.Dimension, Pos ));
        Set_Bit( Part_Filled_With_Zeros.Structure, I, Part_Index_Value);
      end if;

      if I rem Figure.Dimension.X = 0 then
        Row := Row - 1;
      end if;
      Column := Column + 1;
      if I rem Figure.Dimension.Y = 0 then
        Column := 1;
      end if;

      if I rem (Figure.Dimension.X * Figure.Dimension.Y) = 0 then
        Layer := Layer + 1;
        Row := Figure.Dimension.Y;
      end if;

    end loop;
    return Part_Filled_With_Zeros;

  end Add_Dimensions;

  -- Get the indicies, with respect to figure ones, where the part fit in the figure
  function Overlap_Indices(Part : Part_Type; Figure : Figure_Type) return Bits.Index_Arr is
    Part_Figure : Figure_Type := Add_Dimensions(Part, Figure);
    Figure_Ones : Bits.Index_Arr := Ones_Index(Figure.Structure);

    Overlap : Bits.Index_Arr(Figure_Ones'Range);
    Num_Overlap_Ones : Integer := 0;
  begin
    for I in Figure_Ones'Range loop
      --Put(Part.Position.X);
      --Put(Part.Position.Y);
      --Put(Part.Position.Z);
      --New_Line;
      --Put(Part.Structure, Part.Dimension);
      --Put(Part_Figure.Structure, Part_Figure.Dimension);
      --New_Line(5);
      if Read_Bit(Part_Figure.Structure, Figure_Ones(I)) = 1 then
        Num_Overlap_Ones := Num_Overlap_Ones + 1;
        Overlap(Num_Overlap_Ones) := I;
      end if;
    end loop;

    return Overlap(1..Num_Overlap_Ones);
  end Overlap_Indices;

  -- Moves the part 'vector' much, in each direction
  procedure Traverse(Part : in out Part_Type; Diff : in Vector_Type) is
  begin
    Part.Position := (
      X => (Part.Position.X + Diff.X),
      Y => (Part.Position.Y + Diff.Y),
      Z => (Part.Position.Z + Diff.Z));
  end Traverse;

  procedure Move(Part : in out Part_Type; Pos : in Vector_Type) is
  begin
    -- TODO: Might work with just Part.Position := Pos
    Part.Position := ( X => Pos.X, Y => Pos.Y, Z => Pos.Z );
  end Move;

  procedure Rotate(Part : in out Part_Type; Rotation : in Vector_Type) is
  begin
    Part.Rotation := (
      X => (Part.Rotation.X + Rotation.X),
      Y => (Part.Rotation.Y + Rotation.Y),
      Z => (Part.Rotation.Z + Rotation.Z));

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
