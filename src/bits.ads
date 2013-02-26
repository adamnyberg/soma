package Bits is
private
  type Unsigned_Type is mod 2**32;
  type Bits_Type is array (Natural range <>) of Unsigned_Type;
end Bits;
