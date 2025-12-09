
module TopModule (
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q
);

reg [3:0] q_prev = 1; // Initialize the previous values of Q

// Asynchronous positive edge triggered reset
always @(posedge clk or areset) begin
    if (areset) {
        // Reset the shift register to zero
        q <= 4'd0;
        q_prev <= 1;
    } else {
        // If clock is rising, move the previous value of Q one bit to the left
        q_prev <= q;
        // Load data into the shift register if load input is asserted
        if (load) {
            q <= data;
        }
        // Shift right by one bit if ena input is asserted
        if (ena) {
            // If both load and ena inputs are asserted, don't change Q
            if (!load) {
                q <= {q[2:0], 1'b0};
            } else {
                // Otherwise, move the previous value of Q to the right and clear the most significant bit
                q_prev <= q_prev[2:0];
                q <= {q_prev, 1'b0};
            }
        }
    end
end

// Assign output q
assign q = q_prev;

endmodule

// VERILOG-EVAL: errant inclusion of module definition
