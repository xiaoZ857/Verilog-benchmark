
module TopModule (
  input [2:0] in,
  output [1:0] out
);
  logic [2:0] count;
  assign count = in;

  always @* begin
    if (in[0] == 1) begin
      count[0] = 1;
    end else begin
      count[0] = 0;
    end
    if (in[1] == 1) begin
      count[1] = 1;
    end else begin
      count[1] = 0;
    end
    if (in[2] == 1) begin
      count[2] = 1;
    end else begin
      count[2] = 0;
    end
  end

  assign out = count[1:0];

// VERILOG-EVAL: endmodule not found
