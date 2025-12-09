
module TopModule (
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

  // Temporary register to hold the next state of the cells.
  reg [511:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      // Load new data into q on a high load signal.
      q <= data;
    end else begin
      // Update each cell according to Rule 110.
      next_q[0] = (q[1:0] == 3'b011) | (q[1:0] == 3'b101) |
                  (q[1:0] == 3'b110) | (q[2:0] == 3'b001) |
                  (q[2:0] == 3'b010);

      for (int i = 1; i < 511; i = i + 1) begin
        next_q[i] = (q[(i+1):(i-1)] == 3'b011) | 
                    (q[(i+1):(i-1)] == 3'b101) |
                    (q[(i+1):(i-1)] == 3'b110) | 
                    (q[(i+2):(i)]   == 3'b001) |
                    (q[(i+2):(i)]   == 3'b010);
      end

      next_q[511] = (q[0:510][510:509] == 3'b011) | 
                    (q[0:510][510:509] == 3'b101) |
                    (q[0:510][510:509] == 3'b110) | 
                    q[1];

      // Update the current state with the next state.
      q <= next_q;
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
