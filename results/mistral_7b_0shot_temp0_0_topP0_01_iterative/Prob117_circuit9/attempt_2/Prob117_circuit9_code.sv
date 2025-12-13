
module TopModule (
  input clk,
  input a,
  output reg [2:0] q
);
always @(posedge clk) begin
  if (a) begin
    if (q == 3'b100) begin // Changed from 'b10010' to 'b100' as per the waveform
      q <= 3'b000; // reset counter when counting from 6 to 0
    end
    else begin
      q <= q + 1; // increment counter when counting up
    end
  end
  else begin
    q <= 3'b000; // reset counter when a is low
  end
end

// timescale directive should be outside the module definition
timescale of 1ns / 1ps

endmodule
