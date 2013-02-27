-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Figures; use Figures;

procedure Figures_Test is
begin
  Figures.Parse_Part( To_Unbounded_String("123 ") );
end Figures_Test;
