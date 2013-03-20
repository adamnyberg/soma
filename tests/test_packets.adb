-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Tests; use Tests;
with Packets; use Packets;
with TJa.Calendar; use TJa.Calendar;
with TJa.Sockets; use TJa.Sockets;

procedure Test_Packets is
	Message : Unbounded_String := To_Unbounded_String("12 3x4x2 110101011111101111000001");
	Raw_Packet : Unbounded_String := To_Unbounded_String("01:01:01 F 12 3x4x2 110101011111101111000001");
	Assembled_String : String := Assemble( 'F', Message );
	Disassembled_Packet : Packet_Type := Disassemble( Raw_Packet );
begin

	-- Test of Assemble
	Test( Assembled_String(10..Assembled_String'Last), To_Unbounded_String("F ") & Message );

	-- Test of Disassemble
  Test( Disassembled_Packet.Header, 'F');
  Test( Disassembled_Packet.Message, Message);
end Test_Packets;