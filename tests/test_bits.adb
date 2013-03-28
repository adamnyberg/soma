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
--Creating bits strings
  Test_Bits_Parse : Unbounded_String := To_Unbounded_String("111111000001111111111111110");
  Test_Bits_Parse2 : Unbounded_String := To_Unbounded_String("01011010100101010101011010110110100");
  Test_Bits_Parse3 : Unbounded_String := To_Unbounded_String("1010");
  Test_Bits_Parse4 : Unbounded_String := To_Unbounded_String("1110");
  Test_Bits_Parse5 : Unbounded_String := To_Unbounded_String("111000110110");
  Test_Bits_Parse6 : Unbounded_String := To_Unbounded_String("111000110110");
begin
  declare
    --Parsing bits strings to create bits_type
    Bits_Seq : Bits_Type := Bits.Parse( Test_Bits_Parse );
    Bits_Seq2 : Bits_Type := Bits.Parse( Test_Bits_Parse2 );
    Bits_Seq3 : Bits_Type := Bits.Parse( Test_Bits_Parse3 );
    Bits_Seq3_Ref : Bits_Type := Bits.Parse( Test_Bits_Parse4 );
    Bits_Set_Bit : Bits_Type := Bits.Parse( Test_Bits_Parse5 );
    Bits_Set_Bit2 : Bits_Type := Bits.Parse( Test_Bits_Parse6 );
  begin
    --Tests Read_Bit
    Test(Read_Bit(Bits_Seq2, 1),0);
    Test(Read_Bit(Bits_Seq2, 6),0);
    Test(Read_Bit(Bits_Seq2, 12),1);
    
    --Tests Bits.Parse
    Test(Test_Bits_Parse2, To_String(Bits_Seq2));
    Test(Test_Bits_Parse, To_String(Bits_Seq));
    
    --Tests Bits.Put
    Put(Bits_Seq, (3, 3, 3));

    --Set 1 on 0
    Set_Bit(Bits_Seq3,2,1);
    Test(Bits_Seq3, Bits_Seq3_Ref);

    --Set 0 on 0
    Bits_Seq3 := Parse( Test_Bits_Parse3 );
    Bits_Seq3_Ref := Parse(To_Unbounded_String("1010"));
    Set_Bit(Bits_Seq3,2,0);
    Test(Bits_Seq3, Bits_Seq3_Ref);

    --Set 1 on 1
    Bits_Seq3 := Parse( Test_Bits_Parse3 );
    Bits_Seq3_Ref := Parse(To_Unbounded_String("1010"));
    Set_Bit(Bits_Seq3,1,1);
    Test(Bits_Seq3, Bits_Seq3_Ref);

    --Set 0 on 1
    Bits_Seq3 := Parse( Test_Bits_Parse3 );
    Bits_Seq3_Ref := Parse(To_Unbounded_String("0010"));
    Set_Bit(Bits_Seq3,1,0);
    Test(Bits_Seq3, Bits_Seq3_Ref);

    --Tests Vector_To_Index
    Test(Vector_To_Index((3,3,3),(2,3,2)),11);

    --Tests Index_To_Vector
    Test(Index_To_Vector((3,3,3), 14), (2,2,2));
    Test(Index_To_Vector((3,4,4), 14), (2,4,2));
    Test(Index_To_Vector((3,4,4), 18), (3,3,2));

    --Tests Set_Bit with vector_type as index
    Set_Bit(Bits_Set_Bit,(3,2,2),(3,2,2),1);
    Test(To_String(Bits_Set_Bit),"111000111110");
    Set_Bit(Bits_Set_Bit,(3,2,2),(2,2,2),0);
    Test(To_String(Bits_Set_Bit),"111000101110");

    --Tests Read_Bit with vector_type as index
    Test(Read_Bit(Bits_Set_Bit2,(3,2,2),(3,2,2)),0);
    Test(Read_Bit(Bits_Set_Bit2,(3,2,2),(2,2,2)),1);

  end;
end Test_Bits;
