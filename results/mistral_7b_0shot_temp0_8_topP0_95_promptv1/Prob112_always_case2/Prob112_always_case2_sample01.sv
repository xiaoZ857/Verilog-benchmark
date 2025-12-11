
module TopModule (
  input [3:0] in,
  output reg [1:0] pos
);
 ```verilog
always @* begin
    if (in[3] && !in[2] && !in[1] && !in[0])
        pos = 3'b101;
    else if (!in[3] && in[2] && !in[1] && !in[0])
        pos = 2'b10;
    else if (!in[3] && !in[2] && in[1] && !in[0])
        pos = 1'b1;
    else if (!in[3] && !in[2] && !in[1] && in[0])
        pos = 0'b0;
    else if (!in[3] && in[2] && in[1] && !in[0])
        pos = 3'b011;
    else if (!in[3] && in[2] && !in[1] && in[0])
        pos = 2'b01;
    else if (in[3] && !in[2] && in[1] && !in[0])
        pos = 3'b110;
    else if (in[3] && in[2] && in[1] && in[0])
        pos = 3'b111;
    else
        pos = 3'b000;
end

// VERILOG-EVAL: abnormal backticks count
// VERILOG-EVAL: endmodule not found
