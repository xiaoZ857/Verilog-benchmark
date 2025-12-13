
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
    ff <= 16'b0;
    q <= 16'b0; // Ensure output is also reset
  end else begin
    // Update only the enabled bytes in ff
    if (byteena[1]) begin
      ff[15:8] <= d[15:8];
    end
    if (byteena[0]) begin
      ff[7:0] <= d[7:0];
    end

    // Update q only when there is a change in ff due to byteena
    if (byteena[1]) begin
      q[15:8] <= ff[15:8]; // Update upper byte of q
    end else begin
      q[15:8] <= q[15:8]; // Retain current value if not updated
    end

    if (byteena[0]) begin
      q[7:0] <= ff[7:0]; // Update lower byte of q
    end else begin
      q[7:0] <= q[7:0]; // Retain current value if not updated
    end
  end
end

endmodule
