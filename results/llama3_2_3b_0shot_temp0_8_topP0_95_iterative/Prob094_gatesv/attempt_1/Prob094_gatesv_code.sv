
module TopModule (
  input [3:0] in,
  output [2:0] out_both,
  output [3:1] out_any,
  output [3:0] out_different
);

    // Initialize output vectors to '0's
    assign out_both = 0;
    assign out_any[2:0] = 0;
    assign out_different[3:0] = 0;

    // Calculate out_both
    always @(posedge clk) begin
        out_both[0] = in[0] & in[1];
        out_both[1] = in[1] & in[2];
        out_both[2] = in[2] & in[3];
    end

    // Calculate out_any
    always @(posedge clk) begin
        out_any[0] = (in[0] | in[1]);
        out_any[1] = (in[1] | in[2]);
        out_any[2] = (in[2] | in[3]);
        out_any[2] &= ~in[1]; // Ensure only one 1 is set
    end

    // Calculate out_different
    always @(posedge clk) begin
        out_different[0] = in[0] ^ in[1];
        out_different[1] = in[1] ^ in[2];
        out_different[2] = in[2] ^ in[3];
        out_different[2] &= ~in[0]; // Ensure only one 1 is set
    end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
