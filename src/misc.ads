-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package Misc is
	function Unbounded_Slice(
      Source : in Unbounded_String;
      Low : in Positive;
      High : in Natural)
        return Unbounded_String;
  procedure Split(Str : in Unbounded_String;
    Pattern : in String;
    Start : out Unbounded_String;
    Rest : out Unbounded_String;
    Skip : in Natural := 0);
  function Divide_With_Ceil(Int1, Int2 : Integer) return Integer;
end Misc;
