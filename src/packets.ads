-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TJa.Calendar; use TJa.Calendar;
with TJa.Sockets; use TJa.Sockets;

package Packets is
  type Packet_Type is record
    Header : Character;
    Message : Unbounded_String;
  end record;

  function Assemble(Header : Character; Message : Unbounded_String) return String;
  function Disassemble(Raw_Packet : Unbounded_String) return Packet_Type;
private
  function Timestamp return Unbounded_String;
end Packets;
