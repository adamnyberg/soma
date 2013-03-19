-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Vector; use Vector;
with Parts; use Parts;
with Tests; use Tests;

procedure Test_Parts is
  Test_Parts_Parse : Unbounded_String :=
    To_Unbounded_String("3 1x8x10 10011 2x3x1 101011011 1x1x1 1010");

  Test_Part_Parse : Unbounded_String :=
    To_Unbounded_String("2x3x1 101011011");  
  Test_Part : Part_Type := Parts.Parse_Part(Test_Part_Parse);
  

  
  Test_Part_Parse2 : Unbounded_String :=
    To_Unbounded_String("2x3x1 101011");
  Test_Part_Parse3 : Unbounded_String :=
    To_Unbounded_String("2x4x3 101010110010000000110000");
  -- Need to compare structure of the part before and after rotation
  
  -- Test_Bits_Parse : Unbounded_String := To_Unbounded_String("101011");
  -- Test_Bits_Parse2 : Unbounded_String := To_Unbounded_String("101010110010000000110000");


  Rotate_Test_Part : Part_Type := Parts.Parse_Part(Test_Part_Parse2);
  Rotate_Test_Part2 : Part_Type := Parts.Parse_Part(Test_Part_Parse3); 
  -- Rotate_Test_Bits : Bits_Type(1) := Bits.Parse(Test_Bits_Parse);
  -- Rotate_Test_Bits2 : Bits_Type(1) := Bits.Parse(Test_Bits_Parse2);

  X_Rotate_Test_Vector : Vector_Type := (1,0,0);
  Y_Rotate_Test_Vector : Vector_Type := (0,1,0);
  Z_Rotate_Test_Vector : Vector_Type := (0,0,1);
  Vector1,Vector2,Vector3 : Vector_Type;
  Vector4,Vector5,Vector6 : Vector_Type;
  -- Bits1,Bits2,Bits3 : Bits_Type(1);
  -- Bits4,Bits5,Bits6 : Bits_Type(1);

  Test_Parts : Parts_Type := Parts.Parse(Test_Parts_Parse);
  Test_Vector : Vector_Type := (2, 3, 4);
  
begin
  Test( Test_Parts(1).Dimension.X, 1 );
  Test( Test_Parts(1).Dimension.Y, 8 );
  Test( Test_Parts(1).Dimension.Z, 10 );
  Test( Test_Parts(2).Dimension.X, 2 );
  Test( Test_Parts(2).Dimension.Y, 3 );
  Test( Test_Parts(2).Dimension.Z, 1 );
  
  -------------------------------------------------------

  Rotate(Rotate_Test_Part, X_Rotate_Test_Vector);
  Vector1 := (2,1,3);
  Test( Rotate_Test_Part.Dimension, Vector1);
  
  Rotate_Test_Part := Parts.Parse_Part(Test_Part_Parse2);
  Rotate(Rotate_Test_Part, Y_Rotate_Test_Vector);
  Vector2 := (1,3,2);
  Test( Rotate_Test_Part.Dimension, Vector2);

  Rotate_Test_Part := Parts.Parse_Part(Test_Part_Parse2);
  Rotate(Rotate_Test_Part, Z_Rotate_Test_Vector);
  Vector3 := (3,2,1);
  Test( Rotate_Test_Part.Dimension, Vector3);
  
  -------------------------------------------------------

  Rotate(Rotate_Test_Part2, X_Rotate_Test_Vector);
  Vector4 := (2,3,4);
  Test( Rotate_Test_Part2.Dimension, Vector4);
  
  Rotate_Test_Part2 := Parts.Parse_Part(Test_Part_Parse3);
  Rotate(Rotate_Test_Part2, Y_Rotate_Test_Vector);
  Vector5 := (3,4,2);
  Test( Rotate_Test_Part2.Dimension, Vector5);

  Rotate_Test_Part2 := Parts.Parse_Part(Test_Part_Parse3);
  Rotate(Rotate_Test_Part2, Z_Rotate_Test_Vector);
  Vector6 := (4,2,3);
  Test( Rotate_Test_Part2.Dimension, Vector6);

  -------------------------------------------------------

  Traverse(Test_Part, Test_Vector);
  Test( Test_Part.Position.X, 2 );
  Test( Test_Part.Position.Y, 3 );
  Test( Test_Part.Position.Z, 4 );

  Traverse(Test_Part, Test_Vector);
  Test( Test_Part.Position.X, 4 );
  Test( Test_Part.Position.Y, 6 );
  Test( Test_Part.Position.Z, 8 );
end Test_Parts;
