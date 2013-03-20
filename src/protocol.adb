-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TJa.Sockets; use TJa.Sockets;
with Packets; use Packets;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

package body Protocol is
  procedure Initiate(Socket : in Socket_Type; Packet : in Packet_Type;
                     Add_Random_Tail : in Boolean := False) is

    Gen : Generator;
    Random_Tail : Integer;
    Nickname : Unbounded_String := To_Unbounded_String("adjh");
  begin
    if Packet.Message = To_Unbounded_String("OK") then
      if Add_Random_Tail then
        Reset(Gen);

        Random_Tail := Integer(Random(Gen) * 10.0);
        Nickname := Nickname & " " & To_Unbounded_String(Integer'Image(Random_Tail));
      end if;

      Put_Line(Socket, Packets.Assemble(NICKNAME_HEADER, Nickname));
    else
      raise Time_To_Die;
    end if;
  end Initiate;

  procedure Confirm(Socket : in Socket_Type; Packet : in Packet_Type) is
  begin
    if Packet.Message = To_Unbounded_String("INVALID") or else
       Packet.Message = To_Unbounded_String("UNAVAILABLE") then
      Initiate(Socket, Packet, True);
    end if;
  end Confirm;

  procedure Give_Up(Socket : in Socket_Type; Figure_Id : in Positive) is
  begin
    Put_Line(Socket, Packets.Assemble(GIVEUP_HEADER, Figure_Id));
  end Give_Up;
end Protocol;
