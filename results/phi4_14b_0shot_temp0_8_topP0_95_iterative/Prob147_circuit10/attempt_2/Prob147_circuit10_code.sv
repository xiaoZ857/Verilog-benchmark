
module TopModule (
  input clk,
  input a,
  input b,
  output q,
  output state
);
always @(posedge clk) begin
    // Determine next state based solely on inputs a and b
    if (a == 1 && b == 1) begin
        state <= ~state;  // Toggle state when both a and b are 1
    end else begin
        state <= state;   // Maintain current state otherwise
    end

    // Determine the output q based on inputs and current state
    if (a == 0 && b == 1) begin
        q <= 1;
    end else if (a == 1 && b == 0) begin
        q <= 1;
    end else if (a == 1 && b == 1) begin
        q <= ~q;          // Toggle q when both a and b are 1 regardless of state
    end else if (a == 0 && b == 0 && state == 1) begin
        q <= 1;
    end else begin
        q <= state;       // Default to current state otherwise
    end
end

endmodule
