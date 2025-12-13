
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

assign out = sel[2:0] == 3'b000 ? {8'd1, {7:0}8'd1} : 
               sel[2:0] == 3'b001 ? {8'd1, {7:0}8'd2} : 
               sel[2:0] == 3'b010 ? {8'd1, {7:0}8'd3} : 
               sel[2:0] == 3'b011 ? {8'd1, {7:0}8'd4} : 
               sel[2:0] == 3'b100 ? {8'd1, {7:0}8'd5} : 
               sel[2:0] == 3'b101 ? {8'd1, {7:0}8'd6} : 
               sel[2:0] == 3'b110 ? {8'd1, {7:0}8'd7} : 
               sel[2:0] == 3'b111 ? {8'd1, {7:0}8'd8} : 
               sel[2:0] == 3'b000 ? {sel[1:0], sel[0:0], {7:0}8'd9} : 
               sel[2:0] == 3'b001 ? {sel[1:0], sel[0:0], {7:0}8'd10} : 
               sel[2:0] == 3'b010 ? {sel[1:0], sel[0:0], {7:0}8'd11} : 
               sel[2:0] == 3'b011 ? {sel[1:0], sel[0:0], {7:0}8'd12} : 
               sel[2:0] == 3'b100 ? {sel[1:0], sel[0:0], {7:0}8'd13} : 
               sel[2:0] == 3'b101 ? {sel[1:0], sel[0:0], {7:0}8'd14} : 
               sel[2:0] == 3'b110 ? {sel[1:0], sel[0:0], {7:0}8'd15} : 
               sel[2:0] == 3'b111 ? {sel[1:0], sel[0:0], {7:0}8'd16} : 
               sel[2:0] == 3'b000 ? {sel[1:0], sel[0:0], {7:0}8'd17} : 
               sel[2:0] == 3'b001 ? {sel[1:0], sel[0:0], {7:0}8'd18} : 
               sel[2:0] == 3'b010 ? {sel[1:0], sel[0:0], {7:0}8'd19} : 
               sel[2:0] == 3'b011 ? {sel[1:0], sel[0:0], {7:0}8'd20} : 
               sel[2:0] == 3'b100 ? {sel[1:0], sel[0:0], {7:0}8'd21} : 
               sel[2:0] == 3'b101 ? {sel[1:0], sel[0:0], {7:0}8'd22} : 
               sel[2:0] == 3'b110 ? {sel[1:0], sel[0:0], {7:0}8'd23} : 
               sel[2:0] == 3'b111 ? {sel[1:0], sel[0:0], {7:0}8'd24} : 
               sel[2:0] == 3'b000 ? {sel[1

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
