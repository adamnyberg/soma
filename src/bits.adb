-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Misc; use Misc;
package body Bits is
  function Parse(Str : Unbounded_String) return Bits_Type is
    Bits_Seq : Bits_Type(1..Integer(Float'Ceiling(Float(Length(Str))/
	    Float(BITS_LENGTH))));
  begin
    if Length(Str) < BITS_LENGTH then
      -- TODO: Find a nicer way to convert a binary string
      -- representation into an integer.
      Bits_Seq(1) := Unsigned_Type( Integer'Value("2#" & To_String(Str) & "#") );
      return Bits_Seq;
    else
      --for I in reverse Bits_Seq'Range loop --Ändrade till reverse - fyller på bakifrån
	--if I /=Bits_Seq'Last then
	  --Bits_Seq(I) := Unsigned_Type( Integer'Value("2#" & Unbounded_Slice(Str, 
	--	(I-1)*BITS_LENGTH+1, I*BITS_LENGTH) & "#"));
	--else
	  --Specialbehandla sista fallet, då den inte är en hel 32 bitare. Var ska
	  --nollorna in?
	  --Bits_Seq(I) :=
	--end if;
      -- TODO: Add support for bit sequences longer than 32
      return Bits_Seq;
    end if;
  end Parse;

  function Read_Bit(Bits : Bits_Type; Index : Integer) return Integer is
    Pos_Bit : Unsigned_Type := 2**((Index+1) rem BITS_LENGTH-1);
    Resulting_Bit : Unsigned_Type;
    begin
      Resulting_Bit := Bits(1) and Pos_Bit;
      Resulting_Bit := Bits(Bits'Last + 1 - Integer(Float'Ceiling(Float(Index+1)/
	      Float(BITS_LENGTH)))) and Pos_Bit;
      if Resulting_Bit /= 0 then
	return 1;
      else
	return 0;
      end if;
    end Read_Bit;

end Bits;
