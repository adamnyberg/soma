-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Misc; use Misc;
with Tests; use Tests;

procedure Test_Misc is
  --Declare
  Test_Misc_Parse1, Test_Misc_Parse2, Test_Misc_Parse3 : Unbounded_String;
  Start : Unbounded_String;
  Rest : Unbounded_String;
begin
  --Tests Misc.Unbounded_Slice
  Test_Misc_Parse1 := To_Unbounded_String("abcdef");
  Test(Misc.Unbounded_Slice(Test_Misc_Parse1, 1, 3), "abc");
  Test(Misc.Unbounded_Slice(Test_Misc_Parse1, 4, 6), "def");
  Test(Misc.Unbounded_Slice(Test_Misc_Parse1, 4), "def");

  --Tests Misc.Split
  Test_Misc_Parse2 := To_Unbounded_String("abc def");
  Misc.Split(Test_Misc_Parse2, " ", Start, Rest, 0);
  Test(Start, "abc");
  Test(Rest, "def");

  --Tests Misc.Split
  Test_Misc_Parse3 := To_Unbounded_String("abc def ghi jkl mno");
  Misc.Split(Test_Misc_Parse3, " ", Start, Rest, 2);
  Test(Start, "abc def ghi");
  Test(Rest, "jkl mno");

  --Tests Misc.Divicede_With_Ceil
  Test(Misc.Divide_With_Ceil(5,2),3);
end Test_Misc;
