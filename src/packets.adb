-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

package body Packets is
  function Assemble(Packet : Packet_Type) return Unbounded_String is
  begin
    return Timestamp & ' ' & Packet.Header & ' ' & Packet.Message;
  end Assemble;

  function Disassemble(Raw_Packet : Unbounded_String) return Packet_Type is
  begin
    return Packet_Type'(
      -- The first 9 characters of the raw packet is always a timestamp
      Header => To_String( Raw_Packet )(10),
      Message => Slice( Raw_Packet, 12, Length(Raw_Packet) )
    );
  end Disassemble;

  function Timestamp return Unbounded_String is
  begin
    return To_Unbounded_String( Get_Time( Clock ) );
  end Timestamp;
end Packets;
