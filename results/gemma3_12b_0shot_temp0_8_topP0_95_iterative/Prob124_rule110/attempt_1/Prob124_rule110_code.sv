
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
    for (int i = 0; i < 512; i++) begin
      // Determine left and right neighbors, handling boundary conditions
      int left = (i == 0) ? 0 : q[i-1];
      int right = (i == 511) ? 0 : q[i+1];
      int center = q[i];

      // Determine next state based on Rule 110 table
      case ({left, center, right})
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

// VERILOG-EVAL: errant inclusion of module definition
