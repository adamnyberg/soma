-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Misc;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Vector; use Vector;

package body Bits is
  function Parse(Str : Unbounded_String) return Bits_Type is
    Bits_Seq : Bits_Type( Divide_With_Ceil(Length( Str ), BITS_LENGTH) );
    Start : Unbounded_String;
    Rest : Unbounded_String := Str;
    Zero_Padding_Removal_Shifter : Integer := 1;
  begin
    Bits_Seq.Length := Length(Str);
    for B in Bits_Seq.Bits'Range loop
      Bits_Seq.Bits(B) := 0; -- Maybe remove
      if B = Bits_Seq.Bits'Last then
        Start := Misc.Unbounded_Slice(Rest, 1);
        Zero_Padding_Removal_Shifter := 2**(BITS_LENGTH - Length(Start));
      else
        Start := Misc.Unbounded_Slice(Rest, 1, BITS_LENGTH);
        Rest := Misc.Unbounded_Slice(Rest, BITS_LENGTH+1);
      end if;

      Bits_Seq.Bits(B) := Unsigned_Type( Integer'Value("2#" & To_String(Start) & "#")*Zero_Padding_Removal_Shifter);
    end loop;
    return Bits_Seq;
  end Parse;

  procedure Set_Bit(
    Bits : in out Bits_Type;
    In_Index : in Natural;
    Bit : in Natural) is

    Index : Integer := Bits.Bits'Length*BITS_LENGTH - In_Index + 1;
    Pos_Bit : Unsigned_Type := 2**((Index-1) rem BITS_LENGTH);
    Element_In_Bits : Integer := Bits.Bits'Last + 1 - Divide_With_Ceil(Index, BITS_LENGTH);
  begin
    if Bit = 0 then
      -- GNAT bugfix
      -- (Bits.Bits(Element_In_Bits) and Pos_Bit) xor Bits.Bits(Element_In_Bits) is the same as
      -- Bits.Bits(Element_In_Bits) and not Pos_Bit
      Bits.Bits(Element_In_Bits) := (Bits.Bits(Element_In_Bits) and Pos_Bit) xor Bits.Bits(Element_In_Bits);
    elsif Bit = 1 then
      Bits.Bits(Element_In_Bits) := Bits.Bits(Element_In_Bits) or Pos_Bit;
    end if;
  end Set_Bit;

  function Read_Bit(Bits : Bits_Type; In_Index : Integer) return Integer is
    Index : Integer := Bits.Bits'Length*BITS_LENGTH - In_Index + 1;
    Pos_Bit : Unsigned_Type := 2**((Index-1) rem BITS_LENGTH);
    Resulting_Bit : Unsigned_Type;
    Element_In_Bits : Integer := Bits.Bits'Last + 1 - Divide_With_Ceil(Index, BITS_LENGTH);
  begin
    Resulting_Bit := Bits.Bits(Element_In_Bits) and Pos_Bit;
    if Resulting_Bit /= 0 then
      return 1;
    else
      return 0;
    end if;
  end Read_Bit;

  function Read_Bit(Bits : Bits_Type; Bits_Dimension, Vector_Index : Vector_Type) return Integer is
  begin
    return Read_Bit( Bits, Vector_To_Index( Bits_Dimension, Vector_Index ) );
  end Read_Bit;

  procedure Set_Bit(Bits : in out Bits_Type;
                      Bits_Dimension : in Vector_Type;
                      Vector_Index : in Vector_Type;
                      Bit : in Natural) is
  begin
    Set_Bit(Bits,Vector_To_Index(Bits_Dimension,Vector_Index),Bit);
  end Set_Bit;

  function Ones_Index(Bits : in Bits_Type) return Index_Arr is
    Arr : Index_Arr(1..Bits.Length);
    Index : Integer := 0;
  begin
    for I in 1..Bits.Length loop
      if Read_Bit(Bits,I) = 1 then
        Index := Index + 1;
        Arr(Index) := I;
      end if;
    end loop;

    return Arr(1..Index);
  end Ones_Index;

  function "or"(Bits1, Bits2 : Bits_Type) return Bits_Type is
    Bits : Bits_Type(Bits1.Bits'Length);
  begin
    --if Bits1.Length /= Bits2.Length then
      --raise Exception("Hur fan tänkte du här?");
    --end if;
    Bits.Length := Bits1.Length;
    for I in Bits.Bits'Range loop
      Bits.Bits(I) := Bits1.Bits(I) or Bits2.Bits(I);
    end loop;

    return Bits;
  end "or";

  function "and"(Bits1, Bits2 : Bits_Type) return Bits_Type is
    Bits : Bits_Type(Bits1.Bits'Length);
  begin
    --if Bits1.Length /= Bits2.Length then
      --raise Exception("Hur fan tänkte du här?");
    --end if;
    Bits.Length := Bits1.Length;
    for I in Bits.Bits'Range loop
      Bits.Bits(I) := Bits1.Bits(I) and Bits2.Bits(I);
    end loop;

    return Bits;
  end "and";

  function "="(Bits1, Bits2 : Bits_Type) return Boolean is
  begin
    --if Bits1.Length /= Bits2.Length then
      --raise Exception("Hur fan tänkte du här?");
    --end if;
    for I in Bits1.Bits'Range loop
      if Bits1.Bits(I) /= Bits2.Bits(I) then
        return false;
      end if;
    end loop;

    return true;
  end "=";

  function Vector_To_Index(Dimension : Vector_Type; Vector_Index : Vector_Type) return Natural is
  begin
    return Dimension.X*( Dimension.Y*Vector_Index.Z - Vector_Index.Y ) + Vector_Index.X;
  end Vector_To_Index;

  function Index_To_Vector(Dimension : Vector_Type; Index : Natural) return Vector_Type is
    X, Y, Z : Natural;
  begin
    X := Index rem Dimension.X;
    if X = 0 then
      X := Dimension.X;
    end if;
    Y := 1 + Dimension.Y - Divide_With_Ceil(Index rem (Dimension.X * Dimension.Y), Dimension.X);
    Z := Divide_With_Ceil(Index, Dimension.X*Dimension.Y);
    return (X, Y, Z);
  end Index_To_Vector;

  function To_String(Bits : Bits_Type) return String is
    Str : Unbounded_String := To_Unbounded_String("");
  begin
    for I in 1..Bits.Length loop
      -- (2) at the end removes the extra space
      Str := Str & Integer'Image(Read_Bit(Bits, I))(2);
    end loop;
    return To_String(Str);
  end To_String;

  procedure Put(Bits : in Bits_Type; Dimension : in Vector_Type) is
    Bits_Str : String := To_String(Bits);
  begin
    Put("Length of bits: ");
    Put(Bits.Length, 0);
    New_Line(2);

    Put("Dimension: ");
    Put(To_String(Dimension));
    New_Line(2);

    for I in Bits_Str'Range loop
      Put(Bits_Str(I));
      if I mod Dimension.X = 0 then
        New_Line;
      end if;
      if I mod (Dimension.X * Dimension.Y) = 0 then
        New_Line;
      end if;
    end loop;
  end Put;
end Bits;
