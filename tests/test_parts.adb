-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Vector; use Vector;
with Parts; use Parts;
with Tests; use Tests;
with Bits; use Bits;
with Figure; use Figure;

procedure Test_Parts is
  --Creates Test_Parts
  Test_Parts_Parse : Unbounded_String :=
    To_Unbounded_String("3 1x8x10 10011 2x3x1 101011011 1x1x1 1010");
  Test_Parts : Parts_Type := Parts.Parse(Test_Parts_Parse);
  --Creates Test_Part
  Test_Part_Parse : Unbounded_String :=
    To_Unbounded_String("2x3x1 101011011");
  Test_Part : Part_Type := Parts.Parse_Part(Test_Part_Parse);

  -------------------------------------------------------------------

  Test_Part_Parse2 : Unbounded_String :=
    To_Unbounded_String("2x3x1 101011");
  Test_Part_Parse3 : Unbounded_String :=
    To_Unbounded_String("2x4x3 101010110010000000110000");
  Test_Part_Parse4 : Unbounded_String :=
     To_Unbounded_String("1x3x3 011110010");
  Rotate_Test_Part : Part_Type := Parts.Parse_Part(Test_Part_Parse2);
  Rotate_Test_Part2 : Part_Type := Parts.Parse_Part(Test_Part_Parse3); 
  Rotate_Test_Part3 : Part_Type := Parts.Parse_Part(Test_Part_Parse4);

  -------------------------------------------------------------------
  --Rotation vectors

  X_Rotate_Test_Vector : Vector_Type := (1,0,0);
  Y_Rotate_Test_Vector : Vector_Type := (0,1,0);
  Y_Rotate_270_Test_Vector : Vector_Type := (0,3,0);
  Z_Rotate_Test_Vector : Vector_Type := (0,0,1);

  -------------------------------------------------------
  --
  -- TEST EVERYTHING AGAIN WITH PART BIGGER THAN 31 BIT
  --
  -------------------------------------------------------

  Part1 : Part_Type := Parts.Parse_Part(To_Unbounded_String("3x3x4 101010110001110001110011001111000110"));
begin
  Test( Test_Parts(1).Dimension.X, 1 );
  Test( Test_Parts(1).Dimension.Y, 8 );
  Test( Test_Parts(1).Dimension.Z, 10 );
  Test( Test_Parts(2).Dimension.X, 2 );
  Test( Test_Parts(2).Dimension.Y, 3 );
  Test( Test_Parts(2).Dimension.Z, 1 );

  -------------------------------------------------------

  -- ROTATE X

  Rotate(Rotate_Test_Part3, X_Rotate_Test_Vector);
  Test( Rotate_Test_Part3.Dimension, (1, 3, 3) );
  Test( To_String(Rotate_Test_Part3.Structure), "100111010");

  Rotate(Rotate_Test_Part, X_Rotate_Test_Vector);
  Rotate(Rotate_Test_Part, X_Rotate_Test_Vector);
  Rotate(Rotate_Test_Part, X_Rotate_Test_Vector);
  Rotate(Rotate_Test_Part, X_Rotate_Test_Vector);
  Rotate(Rotate_Test_Part, X_Rotate_Test_Vector);
  Test( Rotate_Test_Part.Dimension, (2, 1, 3));

  Rotate(Rotate_Test_Part2, X_Rotate_Test_Vector);
  Test( Rotate_Test_Part2.Dimension, (2, 3, 4));
  Test( To_String(Rotate_Test_Part2.Structure), "110000100000101011100000");

  -- ROTATE Y

  Rotate_Test_Part := Parts.Parse_Part(Test_Part_Parse2);
  Rotate(Rotate_Test_Part, Y_Rotate_Test_Vector);
  Test( Rotate_Test_Part.Dimension, (1, 3, 2));

  Rotate_Test_Part2 := Parts.Parse_Part(
    To_Unbounded_String("2x4x3 101010110010000000110000"));
  Rotate(Rotate_Test_Part2, Y_Rotate_Test_Vector);
  Test( Rotate_Test_Part2.Dimension, (3, 4, 2));
  Test( To_String(Rotate_Test_Part2.Structure), "000001000100100111100100");

  -- ROTATE Y 270
  Rotate_Test_Part := Parts.Parse_Part(To_Unbounded_String("2x3x1 110010"));
  Rotate_Test_Part2 := Rotate_Test_Part; 
  for I in 1..3 loop
    Rotate( Rotate_Test_Part, Y_Rotate_Test_Vector);
  end loop;
  Rotate( Rotate_Test_Part2, Y_Rotate_270_Test_Vector);
  Test ( To_String(Rotate_Test_Part.Structure), To_String(Rotate_Test_Part2.Structure));
  Test ( Rotate_Test_Part.Dimension, Rotate_Test_Part.Dimension);
      --Rotates 270 4 times to 1080 degrees.
  Rotate_Test_Part := Parts.Parse_Part(To_Unbounded_String("2x3x1 110010"));
  Rotate( Rotate_Test_Part2, Y_Rotate_270_Test_Vector);
  Rotate( Rotate_Test_Part2, Y_Rotate_270_Test_Vector);
  Rotate( Rotate_Test_Part2, Y_Rotate_270_Test_Vector);
  Test ( To_String(Rotate_Test_Part.Structure), To_String(Rotate_Test_Part2.Structure));
  Test ( Rotate_Test_Part.Dimension, Rotate_Test_Part.Dimension);

  -- ROTATE Z

  Rotate_Test_Part := Parts.Parse_Part(Test_Part_Parse2);
  Rotate(Rotate_Test_Part, Z_Rotate_Test_Vector);
  Rotate(Rotate_Test_Part, Z_Rotate_Test_Vector);
  Rotate(Rotate_Test_Part, Z_Rotate_Test_Vector);
  Rotate(Rotate_Test_Part, Z_Rotate_Test_Vector);
  Rotate(Rotate_Test_Part, Z_Rotate_Test_Vector);
  Test( Rotate_Test_Part.Dimension, (3, 2, 1));

  Rotate_Test_Part2 := Parts.Parse_Part(Test_Part_Parse3);
  Rotate(Rotate_Test_Part2, Z_Rotate_Test_Vector);
  Test( Rotate_Test_Part2.Dimension, (4, 2, 3));
  Test( To_String(Rotate_Test_Part2.Structure), "000111110000010001000100");

  Rotate_Test_Part2 := Parts.Parse_Part(To_Unbounded_String("2x2x3 101101001011"));
  Rotate(Rotate_Test_Part2, Z_Rotate_Test_Vector);
  Test( Rotate_Test_Part2.Dimension, (2, 2, 3));
  Test( To_String(Rotate_Test_Part2.Structure), "011110000111");

  -------------------------------------------------------
  --Tests traverse
  Traverse(Test_Part, (2,3,4));
  Test( Test_Part.Position.X, 2 );
  Test( Test_Part.Position.Y, 3 );
  Test( Test_Part.Position.Z, 4 );
  --Tests traverse
  Traverse(Test_Part, (2,3,4));
  Test( Test_Part.Position.X, 4 );
  Test( Test_Part.Position.Y, 6 );
  Test( Test_Part.Position.Z, 8 );

  -------------------------------------------------------
  --
  -- TEST EVERYTHING AGAIN WITH PART BIGGER THAN 31 BIT
  --
  -------------------------------------------------------

  -- ROTATE X

  Rotate(Part1, (4, 0, 0));
  Test( To_String(Part1.Structure), "101010110001110001110011001111000110");


  -- ROTATE Y

  Rotate(Part1, (0, 4, 0));
  Test( To_String(Part1.Structure), "101010110001110001110011001111000110");

  -- ROTATE Z

  Rotate(Part1, (0, 0, 4));
  Test( To_String(Part1.Structure), "101010110001110001110011001111000110");

end Test_Parts;
