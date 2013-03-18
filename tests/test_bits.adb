-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Tests; use Tests;
with Bits; use Bits;

procedure Test_Bits is
  Test_Bits_Parse : Unbounded_String := To_Unbounded_String("10011");
  Bits_Seq : Bits_Type(1..1);
begin
  Bits_Seq := Parse( Test_Bits_Parse );
  Test( To_Unbounded_String(Bits_Seq), Test_Bits_Parse );
end Test_Bits;
