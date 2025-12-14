
module TopModule (
  input clk,
  input resetn,
  input [1:0] byteena,
  input [15:0] d,
  output reg [15:0] q
);
always @(posedge clk or negedge resetn) begin
  if (!resetn) begin
    // Synchronous active-low reset
    q <= 16'b0;
  end else begin
    // Update lower byte of 'q' only when byteena[0] is high
    if (byteena[0]) begin
      q[7:0] <= d[7:0];
    end
    
    // Update upper byte of 'q' only when byteena[1] is high
    if (byteena[1]) begin
      q[15:8] <= d[15:8];
    end
  end
end

endmodule
