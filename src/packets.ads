with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TJa.Calendar; use TJa.Calendar;
with TJa.Sockets; use TJa.Sockets;

package Packets is
  type Packet_Type is private;

  function Assemble_Packet(Packet : Packet_Type)
    return Unbounded_String;
  function Disassemble_Packet(Raw_Packet : Unbounded_String)
    return Packet_Type;
private
  type Packet_Type is record
    Header : Character;
    Message : Unbounded_String;
  end record;

  function Timestamp return Unbounded_String;
end Packets;
