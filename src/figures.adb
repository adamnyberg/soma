-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Bits; use Bits;

package body Figures is
  -- Takes in an unbounded string, splits it at the first instance of Spliter.
  -- The part before the space is put into Start,
  -- the rest is put into Rest.
  procedure Split(Str : in Unbounded_String;
                  Spliter : in String;
                  Start : out Unbounded_String;
                  Rest : out Unbounded_String) is

    Space_Index : Natural;
  begin
    Space_Index := Index(Str, Spliter);

    Start := To_Unbounded_String( Slice( Str, 1, Space_Index-1 ) );
    Rest := To_Unbounded_String( Slice( Str, Space_Index+1, Length(Str) ) );
  end Split;

  function Parse(Raw_Figure : in Unbounded_String) return Figure_Type is
    Start : Unbounded_String;
    Rest : Unbounded_String;

    ID : Positive;
    Dimension : Vector_Type;
    -- TODO: This technique of initializing bits_type
    -- and figures is very awkward, needs a more dynamic API
    Structure : Bits_Type(1..1);
    Figure : Figure_Type(1);
  begin
    Split( Raw_Figure, " ", Start, Rest );
    ID := Integer'Value( To_String(Start) );

    Split( Rest, "x", Start, Rest );
    Dimension.X := Integer'Value(To_String( Start ));

    Split( Rest, "x", Start, Rest );
    Dimension.Y := Integer'Value(To_String( Start ));

    Split( Rest, " ", Start, Rest );
    Dimension.Z := Integer'Value(To_String( Start ));
    Structure := Bits.Parse(Rest);

    Figure.ID := ID;
    Figure.Dimension := Dimension;
    Figure.Structure := Structure;

    return Figure;
  end Parse;
end Figures;
