
module TopModule (
  input  wire clk,
  input  wire resetn,
  input  wire in,
  output reg [3:0] out
);

// Positive edge clocking with synchronous reset
always @(posedge clk or posedge resetn) begin
  if (resetn == 1) begin // active-low reset
    out <= 4'd0; // reset to all zeros
  else begin
    out[3] <= in; // shift register logic here
    out[2] <= out[3];
    out[1] <= out[2];
    out[0] <= out[1];
  end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
