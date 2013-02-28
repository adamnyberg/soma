-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Bits is
  type Unsigned_Type is private;
  type Bits_Type is array (Natural range <>) of Unsigned_Type;

  function Parse(Str : Unbounded_String) return Bits_Type;
private
  type Unsigned_Type is mod 2**32;
end Bits;
