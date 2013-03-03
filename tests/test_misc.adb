-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Misc; use Misc;
with Tests; use Tests;

procedure Test_Misc is
  Test_Misc_Parse1, Test_Misc_Parse2 : Unbounded_String;
  Start : Unbounded_String;
  Rest : Unbounded_String;
begin
  Test_Misc_Parse1 := To_Unbounded_String("abc def");
  Misc.Split(Test_Misc_Parse1, " ", Start, Rest, 1);
	Test(Start, "abc");
	Test(Rest, "def");

  Test_Misc_Parse2 := To_Unbounded_String("abc def ghi jkl mno");
	Misc.Split(Test_Misc_Parse2, " ", Start, Rest, 3);
	Test(Start, "abc def ghi");
	Test(Rest, "jkl mno");
end Test_Misc;
