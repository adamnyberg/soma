-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

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

  procedure Give_Up(Socket : in Socket_Type; Figure_ID : in Unbounded_String) is
  begin
    Put_Line(Socket, Packets.Assemble(GIVEUP_HEADER, Figure_ID));
  end Give_Up;

  procedure Answer(Packet : in Packet_Type) is
  begin
    -- Make put more vackert
    Put(Packet.Message);
  end Answer;

  procedure Done(Packet : in Packet_Type) is
  begin
    -- Make put more vackert
    Put(Packet.Message);
  end Done;

  procedure Highscore(Packet : in Packet_Type) is
  begin
    -- Make put more vackert
    Put(Packet.Message);
  end Highscore;

  procedure All_Done(Packet : in Packet_Type) is
  begin
    -- Make put more vackert
    Put(Packet.Message);
  end Answer;

  procedure Terminator(Packet : in Packet_Type) is
  begin
    -- Make put more vackert
    Put(Packet.Message);
  end Terminator;
end Protocol;
