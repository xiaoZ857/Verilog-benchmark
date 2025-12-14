
module TopModule (
  input clk,
  input reset,
  output reg [3:0] q
);
reg [3:0] q;
reg [9:0] count;

always_ff @(posedge clk) begin
  if (reset) begin
    count <= 1;
  } else if (count >= 10) begin
    count <= 0; // Wrap around to 0 after counting to 10
  } else begin
    count <= count + 1;
  end
end

assign q = count[3:0]; // Extract the lower 4 bits of the counter

// VERILOG-EVAL: endmodule not found
