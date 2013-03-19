-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Misc;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

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

  function Read_Bit(Bits : Bits_Type; Index : Integer) return Integer is
    Pos_Bit : Unsigned_Type := 2**((Index-1) rem BITS_LENGTH);
    Resulting_Bit : Unsigned_Type;
    Element_In_Bits : Integer := Bits.Bits'Last + 1 - Divide_With_Ceil(Index, BITS_LENGTH);
  begin
    Resulting_Bit := Bits.Bits(Element_In_Bits) and Pos_Bit;
    --Put(Integer(Bits.Bits(1)), Base=>2);
    --Put(" ------- ");
    --Put(Integer(Bits.Bits(2)), Base=>2);
    --Put(" ------- ");
    --Put(Integer(Bits.Bits(3)), Base=>2);
    --Put(" ------- ");
    --Put(Integer(Pos_Bit), Base=>2);
    --Put(" ------- ");
    --Put(Integer(Resulting_Bit), Base=>2);
    --New_Line;
    if Resulting_Bit /= 0 then
      return 1;
    else
      return 0;
    end if;
  end Read_Bit;

  function To_String(Bits : Bits_Type) return String is
    Str : Unbounded_String := To_Unbounded_String("");
    First_Index : Integer := Bits.Bits'Length*BITS_LENGTH;
    Last_Index : Integer := First_Index-Bits.Length+1;
  begin
    for I in reverse Last_Index..First_Index loop
      -- (2) at the end removes the extra space
      Str := Str & Integer'Image(Read_Bit(Bits, I))(2);
    end loop;
    return To_String(Str);
  end To_String;
end Bits;
