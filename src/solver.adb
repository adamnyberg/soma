-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TJa.Sockets; use TJa.Sockets;
with Protocol; use Protocol;
with Packets; use Packets;
with Figures; use Figures;
with Misc;

with Ada.Text_IO;

procedure Solver is
  Socket : Socket_Type;
  Raw_Packet : Unbounded_String;
  Packet : Packet_Type;
begin
  Initiate(Socket);
  Connect(Socket, "localhost", 3333);

  loop
    Misc.Get_Line(Socket, Raw_Packet);
    Packet := Packets.Disassemble(Raw_Packet);

    Ada.Text_IO.Put_Line(To_String( Packet.Message ));
    case Packet.Header is
      when INITIATE_HEADER => Protocol.Initiate(Socket, Packet);
      when CONFIRM_HEADER => Protocol.Confirm(Socket, Packet);
      when others => Ada.Text_IO.Put(Packet.Header); exit;
    end case;
  end loop;

  Close(Socket);
end Solver;
