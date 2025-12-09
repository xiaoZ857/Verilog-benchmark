
module TopModule (
  input clk, // Positive clock signal
  input shift_ena, // Enable data to be shifted in
  input count_ena, // Enable counting down
  input data, // Data to be shifted into the register
  output reg [3:0] q // Current value of the register
);
  
  always_posedge(clk) begin
    // If shift_ena is high and count_ena is low, shift data in
    if (shift_ena && !count_ena) begin
      q[0] = data;
    end
    
    // If both controls are high, no effect on the register value
    else if (shift_ena && count_ena) begin
      // Do nothing, as the priority of these control signals doesn't matter here
    end
    
    // If shift_ena is low and count_ena is high, decrement q and shift it back to the least significant bit position
    else if (!shift_ena && count_ena) begin
      if (q[0] == 1) begin
        q[3] = 0;
        for (int i = 2; i >= 0; i--) begin
          q[i+1] = q[i];
        end
      else begin // q[0] == 0, so we don't need to shift it back
        if (!count_ena) begin
          q[3] <= 1;
        end
      end
    end
  end
endmodule

// VERILOG-EVAL: errant inclusion of module definition
