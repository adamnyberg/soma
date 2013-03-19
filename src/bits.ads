-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Vector; use Vector;
with Misc; use Misc;

package Bits is
  type Unsigned_Type is private;
  type Bits_Raw_Type is array (Natural range <>) of Unsigned_Type;

  type Bits_Type(Num_Bits_Raw_Type : Natural) is record
    Bits : Bits_Raw_Type(1..Num_Bits_Raw_Type);
    Length : Natural;
  end record;

  BITS_LENGTH : constant Positive := 31;

  function Parse(Str : Unbounded_String) return Bits_Type;
  function Read_Bit(Bits : Bits_Type; Index : Integer) return Integer;

  function To_String(Bits : Bits_Type) return String;

  procedure Put(Bits : in Bits_Type; Dimesion : in Vector_Type);
private
  type Unsigned_Type is mod 2**BITS_LENGTH;
end Bits;
