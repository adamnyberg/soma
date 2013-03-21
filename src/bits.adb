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

  procedure Fill_With_Zeroes(Bits : Bits_Type; Dimension : Vector_Type) is
  begin
    null;
  end Fill_With_Zeroes;

  function Compare(Bits1, Bits2 : Bits_Type) return Boolean is
  begin
    null;
  end Compare;

  function "xor"(Bits1, Bits2 : Bits_Type) return Bits_Type is
  begin
    null;
  end "xor";

  function Is_Zero(Bits : Bits_Type) return Boolean is
  begin
    null;
  end Is_Zero;

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
