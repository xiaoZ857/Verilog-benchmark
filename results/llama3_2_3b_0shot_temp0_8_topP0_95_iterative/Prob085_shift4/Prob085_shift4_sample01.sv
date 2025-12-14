
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);
always @(posedge clk or posedge areset) begin
    if (areset) begin
        prev_q <= 4'd0;
        carry <= 1'b0;
    end else if (load && load == ena) begin
        prev_q <= data[3:0];
        carry <= 1'b0;
    end else if (ena) begin
        // Right shift logic: clear q, set carry accordingly and shift right
        prev_q <= 4'd0;  // Clear shift register to zero
        carry <= q[3];  // Update carry with the most significant bit of q

        q <= {carry, prev_q[1:0]};  // Shift right by one bit
    end else begin
        prev_q <= 4'd0;
        carry <= 1'b0;
    end

    q <= prev_q;
end


// Always block for carry propagation
always @(posedge clk or posedge areset) begin
    if (areset) begin
        carry <= 1'b0;
    end else if (load && load == ena) begin
        // Clear the carry when new data is loaded
        carry <= data[2];
    end else if (ena) begin
        // Update the carry for next shift operation
        carry <= q[3];  // Use current value of q to update carry
    end
end

endmodule
