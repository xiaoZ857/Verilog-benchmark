
module TopModule (
  input [254:0] in,
  output reg [7:0] out
);
  
  reg [7:0] count;
  
  initial begin
    count = 0;
    for (int i = 0; i < 255; i++) begin
      if (in[i]) count++;
    end
    out = count;
  end
  
endmodule

// VERILOG-EVAL: errant inclusion of module definition
