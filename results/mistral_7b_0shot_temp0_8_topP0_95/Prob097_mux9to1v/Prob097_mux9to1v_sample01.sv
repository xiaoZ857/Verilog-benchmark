
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

assign out = (sel == 0) ? a :
             (sel == 1) ? b :
             (sel == 2) ? c :
             (sel == 3) ? d :
             (sel == 4) ? e :
             (sel == 5) ? f :
             (sel == 6) ? g :
             (sel == 7) ? h :
             (sel == 8) ? i :
             // For the unused cases (sel=9 to 15), set all output bits to '1'
             'b1111_1111_1111_1111;

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
