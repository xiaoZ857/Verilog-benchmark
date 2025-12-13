
module TopModule (
  input clk,
  input reset,
  input data,
  output start_shifting
);

  // Define states
  parameter S0 = 0;
  parameter S1 = 1;
  parameter S2 = 2;
  parameter S3 = 3;
  parameter S4 = 4;

  reg [2:0] state;  // 3-bit register for states
  reg start_shifting;

  // State transition and output logic
  always @(posedge clk) begin
    if (reset) begin
      state <= S0;
      start_shifting <= 0;
    end else begin
      case (state)
        S0:
          if (data == 1) begin
            state <= S1;
          end else begin
            state <= S0;
          end
        S1:
          if (data == 1) begin
            state <= S2;
          end else begin
            state <= S0;
          end
        S2:
          if (data == 0) begin
            state <= S3;
          end else begin
            state <= S1;  // On '1', go back to look for two consecutive '1's
          end
        S3:
          if (data == 1) begin
            state <= S4;
          end else begin
            state <= S0;
          end
        S4:
          state <= S4;  // Once sequence is found, stay here forever until reset
      endcase

      // Set start_shifting when in S4
      start_shifting = (state == S4);
    end
  end

endmodule

// VERILOG-EVAL: errant inclusion of module definition
