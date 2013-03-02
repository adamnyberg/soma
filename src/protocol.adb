-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with TJa.Sockets; use TJa.Sockets;
with Packets; use Packets;

package body Protocol is
  procedure Initiate(Socket : in Socket_Type; Packet : in Packet_Type) is
  begin
    if Packet.Message = "OK" then
      -- TODO: Add some randomness to nickname to avoid infinite loop
      -- if the nickname is taken or invalid.
      Put_Line(Socket, Packet.Assemble(NICKNAME_HEADER, "adjh"));
    else
      raise Time_To_Die;
    end if;
  end Initiate;

  procedure Confirm(Socket : in Socket_Type; Packet : in Packet_Type) is
  begin
    case Packet.Message is
      when "INVALID" => Initiate(Socket, Packet);
      when "UNAVAILABLE" => Initiate(Socket, Packet);
  end Confirm;
end Protocol;
