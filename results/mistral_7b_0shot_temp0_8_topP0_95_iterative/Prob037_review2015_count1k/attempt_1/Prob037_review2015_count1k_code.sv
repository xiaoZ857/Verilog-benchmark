
module TopModule (
  input wire clk,
  input wire reset,
  output reg [2:0] hundreds, // thousand's place counter
  output reg [1:0] tens,     // tens place counter
  output reg units            // unit's place counter
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    hundreds <= 0;
    tens <= 0;
    units <= 0;
  end else begin
    if (hundreds == 9) begin
      hundreds <= 0;
      tens <= tens + 1;
    end
    if ((hundreds < 9) && (tens == 9)) begin
      tens <= 0;
      units <= units + 1;
    end
    if ((hundreds < 9) && (tens < 9)) begin
      // Do nothing, the counter will increment naturally
    end
  end
end

assign q = {hundreds, tens, units};

// VERILOG-EVAL: errant inclusion of module definition
// VERILOG-EVAL: endmodule not found
