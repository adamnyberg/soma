-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

package Bits is
private
  type Unsigned_Type is mod 2**32;
  type Bits_Type is array (Natural range <>) of Unsigned_Type;
end Bits;
