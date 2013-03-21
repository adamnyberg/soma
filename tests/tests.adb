-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

--with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
--with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
--with Ada.Text_IO; use Ada.Text_IO;
--with Vector; use Vector;
--with Bits; use Bits;

package body Tests is

  procedure Test(El1, El2 : Unbounded_String) is begin
    if El1 /= El2 then
      Put_Line("Test failed.");
      Put_Line("Element 1:");
      Put(To_String(El1));
      New_Line;
      Put_Line("Element 2:");
      Put(To_String(El2));
      New_Line;
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1, El2 : String) is begin
    if El1 /= El2 then
      Put_Line("Test failed.");
      Put_Line("Element 1:");
      Put(El1);
      New_Line;
      Put_Line("Element 2:");
      Put(El2);
      New_Line;
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1, El2 : Integer) is begin
    if El1 /= El2 then
      Put_Line("Test failed.");
      Put_Line("Element 1:");
      Put(El1);
      New_Line;
      Put_Line("Element 2:");
      Put(El2);
      New_Line;
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1, El2 : Character) is begin
    if El1 /= El2 then
      Put_Line("Test failed.");
      Put_Line("Element 1:");
      Put(El1);
      New_Line;
      Put_Line("Element 2:");
      Put(El2);
      New_Line;
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1 : Unbounded_String; El2 : String) is begin
    if El1 /= To_Unbounded_String(El2) then
      Put_Line("Test failed.");
      Put_Line("Element 1:");
      Put(To_String(El1));
      New_Line;
      Put_Line("Element 2:");
      Put(El2);
      New_Line;
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1 : String; El2 : Unbounded_String) is begin
    if To_Unbounded_String(El1) /= El2 then
      Put_Line("Test failed.");
      Put_Line("Element 1:");
      Put(El1);
      New_Line;
      Put_Line("Element 2:");
      Put(To_String(El2));
      New_Line;
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1, El2 : Vector_Type) is begin
    if To_String(El1) /= To_String(El2) then
      Put_Line("Test failed.");
      Put_Line("Element 1:");
      Put(To_String(El1));
      New_Line;
      Put_Line("Element 2:");
      Put(To_String(El2));
      New_Line;
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1, El2 : Bits_Type) is begin
    if To_String(El1) /= To_String(El2) then
      Put_Line("Test failed.");
      Put_Line("Element 1:");
      Put(To_String(El1));
      New_Line;
      Put_Line("Element 2:");
      Put(To_String(El2));
      New_Line;
      raise Test_Fail;
    end if;
  end Test;
  
end Tests;
