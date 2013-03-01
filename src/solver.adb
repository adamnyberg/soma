-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with TJa.Sockets; use TJa.Sockets;

procedure Solver is
  Socket : Socket_Type;
begin
  Initiate(Socket);
  Connect(Socket, "localhost", 3333);
end Solver;
