
module TopModule (
  // Clock and Reset Inputs
  input clk,  // Positive Edge Triggered Clock
  input [7:0] d,
  input areset,

  // Q Output of D Flip-Flops (Regized)
  output reg [7:0] q
);

reg [7:0] q_prev[8]; // Store the previous state in q_prev

// Asynchronous Reset for all DFFs
always @(posedge clk or negedge areset) begin
  if (areset) begin
    #10  // Allow some setup time
    $display("Resetting module");
    for (int i = 0; i < 8; i++) begin
      q_prev[i] = 0;
    end
  end else if (clk == 1'b1) begin
    // On the next positive clock edge, update the Q output of each DFF
    for (int i = 0; i < 8; i++) begin
      q_prev[i] = q[i]; // Store the previous state in q_prev
      if (i == 7) begin // Assign only the lower bits to q
        q[0:0] <= d[0:0];
      end else begin // Update q_prev and q for remaining bits
        $display("q%d = %d", i, q[i]);
        q_prev[i + 1] <= q[i + 1]; 
        q[i + 1] <= d[i + 1];
      end
    end
  end
end

// Update the output signals
assign q[0:0] = q_prev[7]; // Assign the lower bits of q as the output signal

endmodule

// VERILOG-EVAL: errant inclusion of module definition
