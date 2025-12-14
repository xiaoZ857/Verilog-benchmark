
module TopModule (
  input clk,
  input d,
  output reg q
);
always @(posedge clk) begin
    reg1 <= d; // Capture input at positive edge
end

always @(negedge clk) begin
    reg2 <= d; // Capture input at negative edge
end

// Update output q on both edges of the clock
always @(posedge clk or negedge clk) begin
    if (posedge clk)
        q <= reg1;
    else if (negedge clk)
        q <= reg2;
end

endmodule
