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
  Test_Parts : Parts_Type := Parts.Parse(Test_Parts_Parse);
  Test_Vector : Vector_Type := (2, 3, 4);
begin
  Test( Test_Parts(1).Dimension.X, 1 );
  Test( Test_Parts(1).Dimension.Y, 8 );
  Test( Test_Parts(1).Dimension.Z, 10 );
  Test( Test_Parts(2).Dimension.X, 2 );
  Test( Test_Parts(2).Dimension.Y, 3 );
  Test( Test_Parts(2).Dimension.Z, 1 );

  Traverse(Test_Part, Test_Vector);
  Test( Test_Part.Position.X, 2 );
  Test( Test_Part.Position.Y, 3 );
  Test( Test_Part.Position.Z, 4 );

  Traverse(Test_Part, Test_Vector);
  Test( Test_Part.Position.X, 4 );
  Test( Test_Part.Position.Y, 6 );
  Test( Test_Part.Position.Z, 8 );
end Test_Parts;
