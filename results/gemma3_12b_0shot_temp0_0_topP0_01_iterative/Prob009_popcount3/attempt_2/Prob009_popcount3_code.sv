
module TopModule (
  input [2:0] in,
  output [1:0] out
);
  logic [2:0] count;
  assign count = in;

  always @* begin
    count[0] = in[0];
    count[1] = in[1];
    count[2] = in[2];
    
    if (in[0]) count[0] = 1;
    else count[0] = 0;
    if (in[1]) count[1] = 1;
    else count[1] = 0;
    if (in[2]) count[2] = 1;
    else count[2] = 0;
  end

  assign out = count[1:0];

// VERILOG-EVAL: endmodule not found
