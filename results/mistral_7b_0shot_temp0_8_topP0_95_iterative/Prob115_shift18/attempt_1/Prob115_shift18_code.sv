
module TopModule (
  input clk,
  input load,
  input ena,
  input [1:0] amount,
  input [63:0] data,
  output reg [63:0] q
);

always @(posedge clk) begin
  if (load)
    q <= data;
  else if (ena) begin
    case (amount)
      2'b00 : begin
         if (ena_lsh)
           q <= {q[62], 0} + q[63]; // Left shift by 1 bit
         else if (ena_lsh8)
           q <= {q[55:63], 0}; // Left shift by 8 bits
       end
      2'b01 : begin
         if (ena_lsh8)
           q <= q << 8; // Left shift by 8 bits
       end
      2'b10 : begin
         if (ena_rsh)
           q <= {q[62], q[63]} >> 1; // Arithmetic right shift by 1 bit
       end
      2'b11 : begin
         if (ena_rsh8)
           q <= q >> 8; // Arithmetic right shift by 8 bits
       end
    endcase
  end
end

// Declare internal signals for shift enable conditions
reg ena_lsh, ena_lsh8, ena_rsh, ena_rsh8;

always @(posedge clk) begin
  ena_lsh <= (ena & amount[0]) | (!ena & amount[1]); // Shift left enable
  ena_lsh8 <= amount[1]; // Shift left by 8 bits enable
  ena_rsh <= (ena & ~amount[0]) & ~amount[1]; // Shift right enable
  ena_rsh8 <= !ena & amount[0]; // Shift right by 8 bits enable
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
