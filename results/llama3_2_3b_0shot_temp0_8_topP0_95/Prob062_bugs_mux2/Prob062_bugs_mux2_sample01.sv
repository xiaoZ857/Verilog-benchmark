
module TopModule (
  input sel,
  input [7:0] a,
  input [7:0] b,
  output reg [7:0] out
);
module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

    always @(posedge clk) begin
        if (sel == 1) 
            out = b;
        else if (sel == 0)
            out = a;
    end
endmodule

module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output reg [7:0] out
);

    reg [7:0] out;

    always @(posedge clk) begin
        if (sel == 1)
            out = b;
        else if (sel == 0)
            out = a;
    end
endmodule

// VERILOG-EVAL: abnormal backticks count
