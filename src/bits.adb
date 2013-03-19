-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

package body Bits is
  function Parse(Str : Unbounded_String) return Bits_Type is
    Bits_Seq : Bits_Type(1..Divide_With_Ceil(Length(Str), BITS_LENGTH));
    Length_Of_Last : Integer := Length(str) rem BITS_LENGTH;
    Start_Slice : Integer;
    End_Slice : Integer;
    Unbounded_Str_Slice : Unbounded_String;
    String_Slice : String(1..BITS_LENGTH);
    Value : Integer;
  begin
    if Length(Str) < BITS_LENGTH then
      -- TODO: Find a nicer way to convert a binary string
      -- representation into an integer.
      Bits_Seq(1) := Unsigned_Type( Integer'Value("2#" & To_String(Str) & "#") );
      return Bits_Seq;
    else
      for I in Bits_Seq'Range loop
	if I /=Bits_Seq'Last then
	  Start_Slice := (I-1)*BITS_LENGTH+1;
	  End_Slice := I*BITS_LENGTH;
	  Put_Line(Str);
	  Unbounded_Str_Slice := Unbounded_Slice(Str,1, 5);
	  String_Slice := To_String(Unbounded_Str_Slice);
	  Value := Integer'Value("2#" & String_Slice & "#");
	  Bits_Seq(I) := Unsigned_Type(Value);
	else
	  --Specialbehandla sista fallet, då den inte är en hel 32 bitare. Var ska
	  --nollorna in? Edit: Nu ska nollorna hamna sist.
	  Bits_Seq(I) := Unsigned_Type( Integer'Value("2#" & To_String(Unbounded_Slice(Str,
		  (I-1)*BITS_LENGTH+1, (I-1)*BITS_LENGTH+1+Length_Of_Last)) &
		  "#")*2**(32-Length_Of_Last));
	end if;
      end loop;
      -- TODO: Add support for bit sequences longer than 32
      return Bits_Seq;
    end if;
  end Parse;

  function Read_Bit(Bits : Bits_Type; Index : Integer) return Integer is
    Pos_Bit : Unsigned_Type := 2**((Index) rem BITS_LENGTH-1);
    Resulting_Bit : Unsigned_Type;
  begin
    Resulting_Bit := Bits(1) and Pos_Bit;
    Resulting_Bit := Bits(Bits'Last + 1 - Divide_With_Ceil(Index, BITS_LENGTH)) and Pos_Bit;
    if Resulting_Bit /= 0 then
      return 1;
    else
      return 0;
    end if;
  end Read_Bit;
  
  function To_String(Bits : Bits_Type) return String is
    Str : Unbounded_String := To_Unbounded_String("");
  begin
    for I in reverse 1.. Bits_Type.Length loop
      Str := Str & To_Unbounded_String(Read_Bit(Bits, I));
    end loop;
    return To_String(Str);
  end To_String;
end Bits;
