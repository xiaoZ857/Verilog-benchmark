
module TopModule (
  input clk,
  input load,
  input [511:0] data,
  output reg [511:0] q
);
  reg [511:0] next_q;

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end else begin
      q <= next_q;
    end
  end

  always @(*) begin
    next_q = q; // Default: no change

    for (int i = 0; i < 512; i++) begin
      // Determine left and right neighbors, handling boundaries
      int left_neighbor = (i == 0) ? 0 : q[i-1];
      int right_neighbor = (i == 511) ? 0 : q[i+1];

      // Determine next state based on Rule 110 table
      case ({left_neighbor, q[i], right_neighbor})
        3'b111: next_q[i] = 0;
        3'b110: next_q[i] = 1;
        3'b101: next_q[i] = 1;
        3'b100: next_q[i] = 0;
        3'b011: next_q[i] = 1;
        3'b010: next_q[i] = 1;
        3'b001: next_q[i] = 1;
        3'b000: next_q[i] = 0;
        default: next_q[i] = 0; // Should never happen, but good to have a default
      endcase
    end
  end
endmodule
