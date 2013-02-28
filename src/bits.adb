-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Bits is
  function Parse(Str : Unbounded_String) return Bits_Type is
    Bits_Seq : Bits_Type(1..1);
  begin
    -- TODO: Make the 32 a constant somewhere,
    -- so we just have to change it in one place.
    if Length(Str) < 32 then
      -- TODO: Find a nicer way to convert a binary string
      -- representation into an integer.
      Bits_Seq(1) := Unsigned_Type( Integer'Value("2#" & To_String(Str) & "#") );
      return Bits_Seq;
    else
      -- TODO: Add support for bit sequences longer than 32
      return Bits_Seq;
    end if;
  end Parse;
end Bits;
