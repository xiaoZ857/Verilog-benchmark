
module TopModule (
  input [7:0] in,
  output reg [2:0] pos
);

  always @(in) begin
    if (in[0] == 1) begin
      pos = 0;
    end else if (in[1] == 1) begin
      pos = 1;
    end else if (in[2] == 1) begin
      pos = 2;
    end else if (in[3] == 1) begin
      pos = 3;
    end else if (in[4] == 1) begin
      pos = 4;
    end else if (in[5] == 1) begin
      pos = 5;
    end else if (in[6] == 1) begin
      pos = 6;
    end else if (in[7] == 1) begin
      pos = 7;
    end else begin
      pos = 0; // No bits are high
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
