
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);
// Priority Encoder Module
module PriorityEncoder (
    // Input (8-bit vector)
    input [7:0] in,

    // Output (2-bit priority)
    output reg [2:0] pos
);

    reg [3:0] val;
    assign pos = val;

    always @(posedge clk) begin
        val <= {in[3], in[2], in[1], in[0]};
    end

endmodule

// VERILOG-EVAL: abnormal backticks count
