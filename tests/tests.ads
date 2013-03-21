-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Vector; use Vector;
with Bits; use Bits;

package Tests is
  Test_Fail : exception;
  procedure Test(El1, El2 : Unbounded_String);
  procedure Test(El1, El2 : String);
  procedure Test(El1, El2 : Integer);
  procedure Test(El1, El2 : Character);
  procedure Test(El1 : Unbounded_String; El2 : String);
  procedure Test(El1 : String; El2 : Unbounded_String);
  procedure Test(El1, El2 : Vector_Type);
  Procedure Test(El1, El2 : Bits_Type);
end Tests;
