-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Tests; use Tests;
with Bits; use Bits;
with Misc; use Misc;
with Vector; use Vector;

procedure Test_Bits is
  Test_Bits_Parse : Unbounded_String := To_Unbounded_String("111111000001111111111111110");
  Test_Bits_Parse2 : Unbounded_String := To_Unbounded_String("01011010100101010101011010110110100");
begin
  declare
    Bits_Seq : Bits_Type := Parse( Test_Bits_Parse );
    Bits_Seq2 : Bits_Type := Parse( Test_Bits_Parse2 );
  begin
    Test(0, Read_Bit(Bits_Seq2, 1));
    Test(0, Read_Bit(Bits_Seq2, 6));
    Test(1, Read_Bit(Bits_Seq2, 12));
    Test(Test_Bits_Parse2, To_String(Bits_Seq2));
    Test(Test_Bits_Parse, To_String(Bits_Seq));
    Put(Bits_Seq, (3, 3, 3));
  end;
end Test_Bits;
