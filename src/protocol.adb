-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TJa.Sockets; use TJa.Sockets;
with Packets; use Packets;

package body Protocol is
  procedure Initiate(Socket : in Socket_Type; Packet : in Packet_Type) is
  begin
    if Packet.Message = To_Unbounded_String("OK") then
      -- TODO: Add some randomness to nickname to avoid infinite loop
      -- if the nickname is taken or invalid.
      Put_Line(Socket, Packets.Assemble(NICKNAME_HEADER, To_Unbounded_String("adjh")));
    else
      raise Time_To_Die;
    end if;
  end Initiate;

  procedure Confirm(Socket : in Socket_Type; Packet : in Packet_Type) is
  begin
    if Packet.Message = To_Unbounded_String("INVALID") or else
       Packet.Message = To_Unbounded_String("UNAVAILABLE") then
      Initiate(Socket, Packet);
    end if;
  end Confirm;
end Protocol;
