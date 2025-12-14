
module TopModule (
  input clk,
  input a,
  output reg [2:0] q // 3-bit register to store the count
);

always @(posedge clk) begin
    if (a == 1'b1) begin
        q <= q + 1'b1; // Increment q on rising edge of clk when a is high
    end
end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
