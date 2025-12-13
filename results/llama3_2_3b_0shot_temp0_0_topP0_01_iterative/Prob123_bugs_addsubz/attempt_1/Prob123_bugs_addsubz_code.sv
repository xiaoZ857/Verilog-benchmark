
module TopModule (
  input do_sub,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out,
  output reg result_is_zero
);
// Implement the Verilog module based on the following description.
// Assume that signals are positive clock/clk triggered unless otherwise stated.

synthesis verilog_input_version verilog_2001

module top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    always @(*) begin
        case (do_sub)
            0: out = a+b;
            1: out = a-b;
        endcase

        if (~out)
            result_is_zero = 1;
    end

endmodule

// Test module to test the top_module
module test_top_module (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    assign out = top_module::out;
    assign result_is_zero = top_module::result_is_zero;

endmodule

// Testbench to test the top_module
module test_top_module_tb (
    input do_sub,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out,
    output reg result_is_zero
);

    reg do_sub_test;
    reg [7:0] a_test;
    reg [7:0] b_test;

    initial begin
        do_sub_test = 1'b1;
        a_test = 8'd10;
        b_test = 8'd20;
    end

    assign out = top_module::out;
    assign result_is_zero = top_module::result_is_zero;

    always @(posedge clk) begin
        // Add your test cases here
        do_sub_test <= do_sub;
        a_test <= a;
        b_test <= b;
    end

endmodule
