-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with TJa.Sockets; use TJa.Sockets;
with Packets; use Packets;
with Ada.Text_IO; use Ada.Text_IO;

package Protocol is
  INITIATE_HEADER : constant Character := 'I';
  NICKNAME_HEADER : constant Character := 'N';
  CONFIRM_HEADER : constant Character := 'C';
  PARTS_HEADER : constant Character := 'P';
  FIGURE_HEADER : constant Character := 'F';
  SOLUTION_HEADER : constant Character := 'S';
  GIVEUP_HEADER : constant Character := 'G';
  ANSWER_HEADER : constant Character := 'A';
  DONE_HEADER : constant Character := 'D';
  HIGHSCORE_HEADER : constant Character := 'U';
  ALLDONE_HEADER : constant Character := 'O';
  TERMINATE_HEADER : constant Character := 'T';

  Time_To_Die : exception;

  procedure Initiate(Socket : in Socket_Type; Packet : in Packet_Type;
                     Add_Random_Tail : in Boolean := False);
  procedure Confirm(Socket : in Socket_Type; Packet : in Packet_Type);
  procedure Give_Up(Socket : in Socket_Type; Figure_ID : in Unbounded_String);
  procedure Answer(Packet : in Packet_Type);
  procedure Done(Packet : in Packet_Type);
  procedure Highscore(Packet : in Packet_Type);
  procedure All_Done(Packet : in Packet_Type);
  procedure Terminator(Packet : in Packet_Type);

end Protocol;
