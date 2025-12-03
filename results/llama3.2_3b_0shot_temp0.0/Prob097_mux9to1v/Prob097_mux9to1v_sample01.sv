

module TopModule (
  input [15:0] a,
  input [15:0] b,
  input [15:0] c,
  input [15:0] d,
  input [15:0] e,
  input [15:0] f,
  input [15:0] g,
  input [15:0] h,
  input [15:0] i,
  input [3:0] sel,
  output logic [15:0] out
);

assign out = (sel[2:0] == 3'b000) ? a : 
               (sel[2:0] == 3'b001) ? b : 
               (sel[2:0] == 3'b010) ? c : 
               (sel[2:0] == 3'b011) ? d : 
               (sel[2:0] == 3'b100) ? e : 
               (sel[2:0] == 3'b101) ? f : 
               (sel[2:0] == 3'b110) ? g : 
               (sel[2:0] == 3'b111) ? h : 
               (sel[2:0] == 3'b000) ? i : 16'd15;
endmodule
