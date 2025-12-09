
module TopModule (
  input [7:0] in,
  output reg [31:0] out
);

always @(posedge clk)
begin
  out <= {signExtend(in[7]), in}; // Concatenate sign bit and original number
end

function bit [31:0] signExtend;
  input [7:0] s;
  begin
    if (s[7]) // If the most significant bit is set, replicate it for all bits
      signExtend = {s[7], s};
    else // Else, fill with zeros
      signExtend = {0, s};
  end
endfunction

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
