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
end Misc;
