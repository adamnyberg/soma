-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Bits is
  type Unsigned_Type is private;
  type Bits_Raw_Type is array (Natural range <>) of Unsigned_Type;
  type Bits_Type(Num_Bits_Raw_Type : Natural) is record
    Bits : Bits_Raw_Type(1..Num_Bits_Raw_Type);
    Length : Natural;
  end record;
  BITS_LENGTH : constant Positive := 32;

  function Parse(Str : Unbounded_String) return Bits_Type;
private
  type Unsigned_Type is mod 2**BITS_LENGTH;
end Bits;
