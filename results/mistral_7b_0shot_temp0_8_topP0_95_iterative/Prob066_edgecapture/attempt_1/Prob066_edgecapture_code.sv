
module TopModule (
  input clk,
  input reset,
  input [31:0] in,
  output reg [31:0] out
);

reg [31:0] prevIn;

always_comb begin
    assign out = in ^ prevIn; // XOR operation to detect changes from 1 to 0
    prevIn <= in; // store current input value for next clock cycle
end

always_ff @(posedge clk) begin
    if (reset) begin
        out <= 32'b0; // reset all output bits
    end
end

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
