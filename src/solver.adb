-- adany869 Adam Nyberg, danth407 Daniel Rapp,
-- harpe493 Harald Petterson, jonta760 Jonas Tarassu

with Parts; use Parts;

package body Solver is

  Socket : Socket_Type;
  Raw_Packet : Unbounded_String;
  Packet : Packet_Type;
  New_Parts : Parts.Parts_Type_Pointer;
  Figure : Figures.Figure_Type(1);
begin
  Initiate(Socket);
  Connect(Socket, "localhost", 3333);

  loop
    Get_Line(Socket, Raw_Packet);
    Packet := Packets.Disassemble(Raw_Packet);
    New_Line;
    Put("Message: ");
    Ada.Text_IO.Put_Line(To_String( Packet.Message ));
    case Packet.Header is
      when INITIATE_HEADER =>
        Put("Init");
        Protocol.Initiate(Socket, Packet);
      when CONFIRM_HEADER =>
        Put("Confirm");
        Protocol.Confirm(Socket, Packet);
      when PARTS_HEADER =>
        Put("Parts");
        New_Parts := new Parts.Parts_Type'(Parts.Parse(Packet.Message));
      when FIGURE_HEADER =>
        Figure := Figures.Parse(Packet.Message);
        Put("Figure");
        Protocol.Give_Up(Socket, Figure.ID);
      when others => Ada.Text_IO.Put(Packet.Header); exit;
    end case;
  end loop;

  Close(Socket);
end Solver;
