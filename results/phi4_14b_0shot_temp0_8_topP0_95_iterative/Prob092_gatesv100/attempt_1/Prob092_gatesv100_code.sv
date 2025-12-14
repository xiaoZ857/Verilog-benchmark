
module TopModule (
  input [99:0] in,
  output reg [98:0] out_both,
  output reg [99:1] out_any,
  output reg [99:0] out_different
);

  integer i;

  always @(*) begin
    // Calculate out_both[98:0]
    for (i = 97; i >= 0; i = i - 1) begin
      out_both[i + 1] = in[i + 1] & in[i + 2];
    end
    
    // Calculate out_any[99:1]
    for (i = 0; i < 98; i = i + 1) begin
      out_any[i + 1] = in[i] | in[i + 1];
    end

    // Calculate out_different[99:0], considering wrap-around
    for (i = 0; i < 100; i = i + 1) begin
      out_different[i] = in[i] ^ in[(i - 1 + 100) % 100];
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
