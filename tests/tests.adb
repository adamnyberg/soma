-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Tests is
  procedure Test(El1, El2 : Unbounded_String) is begin
    if El1 /= El2 then
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1, El2 : String) is begin
    if El1 /= El2 then
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1, El2 : Integer) is begin
    if El1 /= El2 then
      raise Test_Fail;
    end if;
  end Test;

  procedure Test(El1 : Unbounded_String; El2 : String) is begin
    if El1 /= To_Unbounded_String(El2) then
      raise Test_Fail;
    end if;
  end Test;
end Tests;
