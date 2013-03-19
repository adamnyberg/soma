-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

package body Parts is
  function Parse_Part(Raw_Part : in Unbounded_String) return Part_Type is
    Start : Unbounded_String;
    Rest : Unbounded_String;
    Part_Size : Integer;
  begin
    Misc.Split( Raw_Part, " ", Start, Rest );
    Part_Size := Misc.Divide_With_Ceil(Length(Rest), Bits.BITS_LENGTH);
    declare
      Part : Part_Type(Part_Size);
    begin
      Part.Dimension := Vector.Parse( Start );
      Part.Structure := Bits.Parse( Rest );
      return Part;
    end;
  end Parse_Part;

  function Parse(Raw_Parts : in Unbounded_String) return Parts_Type is
    Start : Unbounded_String;
    Rest : Unbounded_String;
    Num_Parts : Positive;
  begin
    Misc.Split( Raw_Parts, " ", Start, Rest );
    Num_Parts := Integer'Value( To_String( Start ) );

    -- We don't know how many parts to create until after we parse the string
    declare
      New_Parts : Parts_Type(Num_Parts);
    begin
      for Part_Index in New_Parts'Range loop
        if Part_Index /= Num_Parts then
          Misc.Split( Rest, " ", Start, Rest, 1 );
        else
          Start := Rest;
        end if;

        New_Parts(Part_Index) := Parse_Part( Start );
      end loop;

      return New_Parts;
    end;
  end Parse;

  procedure Rotate(Part : in out Part_Type; Rotation : in Vector_Type) is
  begin
    for X in Rotation.X loop
      Rotate_X(Part);
    end loop;

    for Y in Rotation.Y loop
      Rotate_Y(Part);
    end loop;

    for Z in Rotation.Z loop
      Rotate_Z(Part);
    end loop;
  end Rotate;

  -- Moves the part 'vector' much, in each direction
  procedure Traverse(Part : in out Part_Type; Diff : in Vector_Type) is
  begin
    Part.Position := (
      X => (Part.Position.X + Vector.X),
      Y => (Part.Position.Y + Vector.Y),
      Z => (Part.Position.Z + Vector.Z));
  end Traverse;

  procedure Rotate_X(Part : in out Part_Type) is
  begin
    null;
  end;

  procedure Rotate_Y(Part : in out Part_Type) is
  begin
    null;
  end;

  procedure Rotate_Z(Part : in out Part_Type) is
  begin
    null;
  end;
end Parts;
