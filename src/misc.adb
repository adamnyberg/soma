-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TJa.Sockets; use TJa.Sockets;

package body Misc is
  -- Get the whole line from a socket into an unbounded string
  procedure Get_Line(Socket : in Socket_Type; Str : out Unbounded_String) is
    Buffer_Size : constant := 2000;
    Buffer : String(1..Buffer_Size);
    Last : Positive := Buffer_Size;
  begin
    Str := To_Unbounded_String("");
    while Last = Buffer_Size loop
      Get_Line(Socket, Buffer, Last);
      Append(Source => Str, New_Item => Buffer(1..Last));
    end loop;
  end Get_Line;

  function Unbounded_Slice(
      Source : in Unbounded_String;
      Low : in Positive;
      High : in Natural)
        return Unbounded_String is
  begin
    return To_Unbounded_String( Slice(Source, Low, High) );
  end Unbounded_Slice;

  -- Takes in an unbounded string, splits it at the "Skip"th instance of Pattern.
  -- The part before the space is put into Start, the rest is put into Rest.
  procedure Split(Str : in Unbounded_String;
    Pattern : in String;
    Start : out Unbounded_String;
    Rest : out Unbounded_String;
    Skip : in Positive := 1) is

    Tmp_Str : Unbounded_String;
    Space_Index : Natural := 0;
  begin
    for I in 1..Skip loop
      Tmp_Str := Unbounded_Slice(Str, Space_Index+1, Length(Str));
      Space_Index := Space_Index + Index(Tmp_Str, Pattern);
    end loop;

    Start := Unbounded_Slice( Str, 1, Space_Index-1 );
    Rest := Unbounded_Slice( Str, Space_Index+1, Length(Str) );
  end Split;
end Misc;