
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);
`timescale 1ns / 1ps

always @(posedge clk) begin
  // Corrected the logic for defining shift enable conditions
  ena_lsh <= (ena & amount[0]) || (!ena & amount[1]); // Shift left enable
  ena_lsh8 <= amount[1]; // Shift left by 8 bits enable
  ena_rsh <= (ena & ~amount[0]) && ~amount[1]; // Shift right enable
  ena_rsh8 <= !ena & amount[0]; // Shift right by 8 bits enable
end

always @(posedge clk) begin
  if (load)
    q <= data;
  else if (ena) begin
    case (amount)
      2'b00 : begin
         if (ena_lsh || ena_lsh8) // Added the condition to handle both 1-bit and 8-bit left shifts
           q <= {q[62:60], q[59], 0} | q[63]; // Left shift by 1 bit, corrected concatenation order
       end
      2'b01 : begin
         if (ena_lsh8)
           q <= {q[55:47], {q[46], q[47], q[48], q[49], q[50], q[51], q[52], q[53], q[54], q[55]}, 0}; // Left shift by 8 bits, corrected concatenation order
       end
      2'b10 : begin
         if (ena_rsh || ena_rsh8) // Added the condition to handle both 1-bit and 8-bit right shifts
           q <= {q[62], q[61:59]} << 1; // Arithmetic right shift by 1 bit, corrected concatenation order
       end
      2'b11 : begin
         if (ena_rsh8)
           q <= {q[64:71]}; // Arithmetic right shift by 8 bits, corrected part select range
       end
    endcase
  end
end

endmodule
