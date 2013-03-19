-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Tests; use Tests;
with Bits; use Bits;
with Ada.Text_IO; use Ada.Text_IO;
procedure Test_Bits is
  Test_Bits_Parse : Unbounded_String := To_Unbounded_String("10011");
  Bits_Seq : Bits_Type(1..1);--Declare length
begin
  Bits_Seq := Parse( Test_Bits_Parse );
  Test( Bits.To_String(Bits_Seq), Test_Bits_Parse );
  --Bits_Seq := Parse(To_Unbounded_String("10001110011011010011000011011001101"));
  --for I in reverse 0..34 loop
    --Put("----- " & Integer'Image(Read_Bit(Bits_Seq, I)) & " -----");
    --New_Line;
  --end loop;
end Test_Bits;
