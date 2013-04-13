-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TJa.Sockets; use TJa.Sockets;
with Protocol; use Protocol;
with Packets; use Packets;
with Figures; use Figures;
with Parts; use Parts;
with Misc;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Soma is
  -- Get the whole line from a socket into an unbounded string
  procedure Get_Line(Socket : in Socket_Type; Str : out Unbounded_String) is
    Buffer_Size : constant := 2000;
    Buffer : String(1..Buffer_Size);
    Last : Positive := Buffer_Size;
  begin
    Str := To_Unbounded_String("");
    while Last = Buffer_Size loop
      Get_Line(Socket, Buffer, Last);
      Append(Source => Str, New_Item => Buffer(1..Last));
    end loop;
  end Get_Line;

  Socket : Socket_Type;
  Raw_Packet : Unbounded_String;
  Packet : Packet_Type;

  type Parts_Type_Pointer is access Parts.Parts_Type;
  type Figure_Type_Pointer is access Figures.Figure_Type;
  New_Parts : Parts_Type_Pointer;
  Figure : Figure_Type_Pointer;

  Start : Unbounded_String;
  Rest  : Unbounded_String;
begin
  Initiate(Socket);
  Connect(Socket, "localhost", 4444);

  loop
    Get_Line(Socket, Raw_Packet);
    Packet := Packets.Disassemble(Raw_Packet);

    --Ada.Text_IO.Put_Line(To_String( Packet.Message ));
    case Packet.Header is
      when INITIATE_HEADER =>
        Protocol.Initiate(Socket, Packet);
      when CONFIRM_HEADER =>
        Protocol.Confirm(Socket, Packet);
      when PARTS_HEADER =>
        New_Parts := new Parts_Type'(Parts.Parse(Packet.Message));
        Put(To_String(Packet.Message));
        New_Line;
      when FIGURE_HEADER =>
        Figure := new Figure_Type'(Figures.Parse(Packet.Message));
        Put(To_String(Packet.Message));
        New_Line;

        --Misc.Split(Packet.Message, " ", Start, Rest);
        --Protocol.Figure(Socket, Start);

        Protocol.Solve(Socket, Figure.all, New_Parts.all);
      when ANSWER_HEADER =>
        Protocol.Answer(Packet);
      when DONE_HEADER =>
        Protocol.Done(Packet);
      when HIGHSCORE_HEADER =>
        Protocol.Highscore(Packet);
      when ALLDONE_HEADER =>
        Protocol.All_Done(Packet);
      when TERMINATE_HEADER =>
        Protocol.Terminator(Packet);
        exit;
      when others => Ada.Text_IO.Put(Packet.Header); exit;
    end case;
    New_Line(2);
  end loop;

  Close(Socket);
end Soma;
