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
  type Index_Arr is array (Natural range <>) of Integer;

  type Bits_Type(Num_Bits_Raw_Type : Natural) is record
    Bits : Bits_Raw_Type(1..Num_Bits_Raw_Type);
    Length : Natural;
  end record;

  BITS_LENGTH : constant Positive := 31;

  function Parse(Str : Unbounded_String) return Bits_Type;
  procedure Set_Bit(Bits : in out Bits_Type; In_Index : in Natural; Bit : in Natural);
  function Read_Bit(Bits : Bits_Type; In_Index : Integer) return Integer;
  procedure Set_Bit(Bits : in out Bits_Type;
                      Bits_Dimension : in Vector_Type;
                      Vector_Index : in Vector_Type;
                      Bit : in Natural);

  function Read_Bit(Bits : Bits_Type; Bits_Dimension, Vector_Index : Vector_Type) return Integer;
  function Ones_Index(Bits : in Bits_Type) return Index_Arr;
  -- procedure Fill_With_Zeroes(Bits : Bits_Type; Dimension : Vector_Type);
  -- function Compare(Bits1, Bits2 : Bits_Type) return Boolean;
  function "or"(Bits1, Bits2 : Bits_Type) return Bits_Type;
  function "and"(Bits1, Bits2 : Bits_Type) return Bits_Type;
  function "="(Bits1, Bits2 : Bits_Type) return Boolean;
  -- function "xor"(Bits1, Bits2 : Bits_Type) return Bits_Type;
  -- function Is_Zero(Bits : Bits_Type) return Boolean;

  function Vector_To_Index(Dimension : Vector_Type; Vector_Index : Vector_Type) return Natural;
  function Index_To_Vector(Dimension : Vector_Type; Index : Natural) return Vector_Type;
  function To_String(Bits : Bits_Type) return String;
  procedure Put(Bits : in Bits_Type; Dimension : in Vector_Type);
private
  type Unsigned_Type is mod 2**BITS_LENGTH;
end Bits;
