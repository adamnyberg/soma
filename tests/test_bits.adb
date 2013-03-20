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
  Test_Bits_Parse3 : Unbounded_String := To_Unbounded_String("1010");
  Test_Bits_Parse4 : Unbounded_String := To_Unbounded_String("1110");
begin
  declare
    Bits_Seq : Bits_Type := Parse( Test_Bits_Parse );
    Bits_Seq2 : Bits_Type := Parse( Test_Bits_Parse2 );
    Bits_Seq3 : Bits_Type := Parse( Test_Bits_Parse3 );
    Bits_Seq3_Ref : Bits_Type := Parse( Test_Bits_Parse4 );
  begin
    Test(0, Read_Bit(Bits_Seq2, 1));
    Test(0, Read_Bit(Bits_Seq2, 6));
    Test(1, Read_Bit(Bits_Seq2, 12));
    Test(Test_Bits_Parse2, To_String(Bits_Seq2));
    Test(Test_Bits_Parse, To_String(Bits_Seq));
    Put(Bits_Seq, (3, 3, 3));

    -- Set 1 on 0
    Set_Bit(Bits_Seq3,2,1);
    Test(Bits_Seq3, Bits_Seq3_Ref);

    -- Set 0 on 0
    Bits_Seq3 := Parse( Test_Bits_Parse3 );
    Bits_Seq3_Ref := Parse(To_Unbounded_String("1010"));
    Set_Bit(Bits_Seq3,2,0);
    Test(Bits_Seq3, Bits_Seq3_Ref);

    -- Set 1 on 1
    Bits_Seq3 := Parse( Test_Bits_Parse3 );
    Bits_Seq3_Ref := Parse(To_Unbounded_String("1010"));
    Set_Bit(Bits_Seq3,1,1);
    Test(Bits_Seq3, Bits_Seq3_Ref);

    -- Set 0 on 1
    Bits_Seq3 := Parse( Test_Bits_Parse3 );
    Bits_Seq3_Ref := Parse(To_Unbounded_String("0010"));
    Set_Bit(Bits_Seq3,1,0);
    Test(Bits_Seq3, Bits_Seq3_Ref);
  end;
end Test_Bits;
